<?php

/**
 * @package       Joomla.Administrator
 * @subpackage    com_guidedtours
 *
 * @copyright     (C) 2023 Open Source Matters, Inc. <https://www.joomla.org>
 * @license       GNU General Public License version 2 or later; see LICENSE.txt
 */

namespace Joomla\Component\Guidedtours\Administrator\Model;

use Joomla\CMS\Application\ApplicationHelper;
use Joomla\CMS\Factory;
use Joomla\CMS\Filter\OutputFilter;
use Joomla\CMS\Language\Text;
use Joomla\CMS\Log\Log;
use Joomla\CMS\MVC\Model\AdminModel;
use Joomla\CMS\Object\CMSObject;
use Joomla\CMS\Plugin\PluginHelper;
use Joomla\CMS\Uri\Uri;
use Joomla\Database\ParameterType;
use Joomla\String\StringHelper;
use Joomla\Utilities\ArrayHelper;

// phpcs:disable PSR1.Files.SideEffects
\defined('_JEXEC') or die;
// phpcs:enable PSR1.Files.SideEffects

/**
 * Model class for tour
 *
 * @since  4.3.0
 */
class TourModel extends AdminModel
{
    /**
     * The prefix to use with controller messages.
     *
     * @var   string
     * @since 4.3.0
     */
    protected $text_prefix = 'COM_GUIDEDTOURS';

    /**
     * Type alias for content type
     *
     * @var string
     * @since 4.3.0
     */
    public $typeAlias = 'com_guidedtours.tour';

    /**
     * Method to save the form data.
     *
     * @param   array  $data  The form data.
     *
     * @return  boolean True on success.
     *
     * @since  4.3.0
     */
    public function save($data)
    {
        $input = Factory::getApplication()->getInput();

        // Language keys must include GUIDEDTOUR to prevent save issues
        if (strpos($data['description'], 'GUIDEDTOUR') !== false) {
            $data['description'] = strip_tags($data['description']);
        }

        if ($input->get('task') == 'save2copy') {
            $origTable = clone $this->getTable();
            $origTable->load($input->getInt('id'));

            $data['published'] = 0;
        }

        // Set step language to parent tour language on save.
        $id   = $data['id'];
        $lang = $data['language'];

        $this->setStepsLanguage($id, $lang);

        if (empty($data['alias'])) {
            $app        = Factory::getApplication();
            $uri        = Uri::getInstance();
            $host       = $uri->toString(['host']);
            $aliasTitle = $host . ' ' . str_replace('COM_GUIDEDTOURS_TOUR_', '', $data['title']);
            // Remove the last _TITLE part
            if (str_ends_with($aliasTitle, '_TITLE')) {
                $pos        = strrpos($aliasTitle, '_TITLE');
                $aliasTitle = substr($aliasTitle, 0, $pos);
            }
            if ($app->get('unicodeslugs') == 1) {
                $data['alias'] = OutputFilter::stringUrlUnicodeSlug($aliasTitle);
            } else {
                $data['alias'] = OutputFilter::stringURLSafe($aliasTitle);
            }
        } else {
            $data['alias'] = ApplicationHelper::stringURLSafe($data['alias']);
        }

        // make sure the alias is unique
        $data['alias'] = $this->generateNewAlias($data['alias'], $id);

        return parent::save($data);
    }

    /**
     * Prepare and sanitise the table prior to saving.
     *
     * @param   \Joomla\CMS\Table\Table  $table  The Table object
     *
     * @return  void
     *
     * @since  4.3.0
     */
    protected function prepareTable($table)
    {
        $date = Factory::getDate()->toSql();

        $table->title = htmlspecialchars_decode($table->title, ENT_QUOTES);

        if (empty($table->id)) {
            // Set the values
            $table->created = $date;

            // Set ordering to the last item if not set
            if (empty($table->ordering)) {
                $db    = $this->getDatabase();
                $query = $db->getQuery(true)
                    ->select('MAX(ordering)')
                    ->from($db->quoteName('#__guidedtours'));
                $db->setQuery($query);
                $max = $db->loadResult();

                $table->ordering = $max + 1;
            }
        } else {
            // Set the values
            $table->modified    = $date;
            $table->modified_by = $this->getCurrentUser()->id;
        }
    }

    /**
     * Abstract method for getting the form from the model.
     *
     * @param   array    $data      Data for the form.
     * @param   boolean  $loadData  True if the form is to load its own data (default case), false if not.
     *
     * @return \JForm|boolean  A JForm object on success, false on failure
     *
     * @since  4.3.0
     */
    public function getForm($data = [], $loadData = true)
    {
        // Get the form.
        $form = $this->loadForm(
            'com_guidedtours.tour',
            'tour',
            [
                'control'   => 'jform',
                'load_data' => $loadData,
            ]
        );

        if (empty($form)) {
            return false;
        }

        $id = $data['id'] ?? $form->getValue('id');

        $item = $this->getItem($id);

        // Modify the form based on access controls.
        if (!$this->canEditState((object) $item)) {
            $form->setFieldAttribute('published', 'disabled', 'true');
            $form->setFieldAttribute('published', 'required', 'false');
            $form->setFieldAttribute('published', 'filter', 'unset');
        }

        $currentDate = Factory::getDate()->toSql();

        $form->setFieldAttribute('created', 'default', $currentDate);
        $form->setFieldAttribute('modified', 'default', $currentDate);

        return $form;
    }

    /**
     * Method to get the data that should be injected in the form.
     *
     * @return mixed  The data for the form.
     *
     * @since  4.3.0
     */
    protected function loadFormData()
    {
        // Check the session for previously entered form data.
        $data = Factory::getApplication()->getUserState(
            'com_guidedtours.edit.tour.data',
            []
        );

        if (empty($data)) {
            $data = $this->getItem();
        }

        return $data;
    }

    /**
     * Method to get a single record.
     *
     * @param   integer  $pk  The id of the primary key.
     *
     * @return  CMSObject|boolean  Object on success, false on failure.
     *
     * @since   4.3.0
     */
    public function getItem($pk = null)
    {
        $lang = Factory::getLanguage();
        $lang->load('com_guidedtours.sys', JPATH_ADMINISTRATOR);

        $result = parent::getItem($pk);

        if (!empty($result->alias)) {
            $lang->load('com_guidedtours_' . str_replace('-', '_', $result->alias), JPATH_ADMINISTRATOR);
            $lang->load('com_guidedtours_' . str_replace('-', '_', $result->alias) . '_steps', JPATH_ADMINISTRATOR);
        }

        if (!empty($result->id)) {
            $result->title_translation       = Text::_($result->title);
            $result->description_translation = Text::_($result->description);
        }

        if (empty($result->alias) && (int) $pk > 0) {
            $app        = Factory::getApplication();
            $uri        = Uri::getInstance();
            $host       = $uri->toString(['host']);
            $aliasTitle = $host . ' ' . str_replace('COM_GUIDEDTOURS_TOUR_', '', $result->title);
            // Remove the last _TITLE part
            if (str_ends_with($aliasTitle, '_TITLE')) {
                $pos        = strrpos($aliasTitle, '_TITLE');
                $aliasTitle = substr($aliasTitle, 0, $pos);
            }
            if ($app->get('unicodeslugs') == 1) {
                $result->alias = OutputFilter::stringUrlUnicodeSlug($aliasTitle);
            } else {
                $result->alias = OutputFilter::stringURLSafe($aliasTitle);
            }
        }

        return $result;
    }

    /**
     * Method to get a single record by alias
     *
     * @param   string  $alias  The alias of the tour.
     *
     * @return  CMSObject|boolean  Object on success, false on failure.
     *
     * @since   5.0.0
     */
    public function getItemByAlias($alias = '')
    {
        Factory::getLanguage()->load('com_guidedtours.sys', JPATH_ADMINISTRATOR);

        $db     = $this->getDatabase();
        $query  = $db->getQuery(true)
        ->select($db->quoteName('id'))
        ->from($db->quoteName('#__guidedtours'))
        ->where($db->quoteName('alias') . ' = :alias')
        ->bind(':alias', $alias, ParameterType::STRING);

        $db->setQuery($query);
        $pk = (int) $db->loadResult();

        $result = parent::getItem($pk);

        if (!empty($result->alias)) {
            Factory::getLanguage()->load('com_guidedtours_' . str_replace('-', '_', $result->alias), JPATH_ADMINISTRATOR);
        }

        if (!empty($result->id)) {
            $result->title_translation       = Text::_($result->title);
            $result->description_translation = Text::_($result->description);
        }

        if (empty($result->alias) && (int) $pk > 0) {
            $app        = Factory::getApplication();
            $uri        = Uri::getInstance();
            $host       = $uri->toString(['host']);

            $aliasTitle = $host . ' ' . str_replace('COM_GUIDEDTOURS_TOUR_', '', $result->title);
            // Remove the last _TITLE part
            if (str_ends_with($result->title, '_TITLE')) {
                $pos        = strrpos($aliasTitle, '_TITLE');
                $aliasTitle = substr($aliasTitle, 0, $pos);
            }
            if ($app->get('unicodeslugs') == 1) {
                $result->alias = OutputFilter::stringUrlUnicodeSlug($aliasTitle);
            } else {
                $result->alias = OutputFilter::stringURLSafe($aliasTitle);
            }
        }

        return $result;
    }

    /**
     * Delete all steps if a tour is deleted
     *
     * @param   object  $pks  The primary key related to the tours.
     *
     * @return  boolean
     *
     * @since   4.3.0
     */
    public function delete(&$pks)
    {
        $pks   = ArrayHelper::toInteger((array) $pks);
        $table = $this->getTable();

        // Include the plugins for the delete events.
        PluginHelper::importPlugin($this->events_map['delete']);

        // Iterate the items to delete each one.
        foreach ($pks as $i => $pk) {
            if ($table->load($pk)) {
                if ($this->canDelete($table)) {
                    $context = $this->option . '.' . $this->name;

                    // Trigger the before delete event.
                    $result = Factory::getApplication()->triggerEvent($this->event_before_delete, [$context, $table]);

                    if (\in_array(false, $result, true)) {
                        $this->setError($table->getError());

                        return false;
                    }

                    $tourId = $table->id;

                    if (!$table->delete($pk)) {
                        $this->setError($table->getError());

                        return false;
                    }

                    // Delete of the tour has been successful, now delete the steps
                    $db    = $this->getDatabase();
                    $query = $db->getQuery(true)
                        ->delete($db->quoteName('#__guidedtour_steps'))
                        ->where($db->quoteName('tour_id') . '=' . $tourId);
                    $db->setQuery($query);
                    $db->execute();

                    // Trigger the after event.
                    Factory::getApplication()->triggerEvent($this->event_after_delete, [$context, $table]);
                } else {
                    // Prune items that you can't change.
                    unset($pks[$i]);
                    $error = $this->getError();

                    if ($error) {
                        Log::add($error, Log::WARNING, 'jerror');

                        return false;
                    } else {
                        Log::add(Text::_('JLIB_APPLICATION_ERROR_DELETE_NOT_PERMITTED'), Log::WARNING, 'jerror');

                        return false;
                    }
                }
            } else {
                $this->setError($table->getError());

                return false;
            }
        }

        // Clear the component's cache
        $this->cleanCache();

        return true;
    }

    /**
     * Duplicate all steps if a tour is duplicated
     *
     * @param   object  $pks  The primary key related to the tours.
     *
     * @return  boolean
     *
     * @since   4.3.0
     */
    public function duplicate(&$pks)
    {
        $user = $this->getCurrentUser();
        $db   = $this->getDatabase();

        // Access checks.
        if (!$user->authorise('core.create', 'com_guidedtours')) {
            throw new \Exception(Text::_('JERROR_CORE_CREATE_NOT_PERMITTED'));
        }

        $table = $this->getTable();

        $date = Factory::getDate()->toSql();

        foreach ($pks as $pk) {
            if ($table->load($pk, true)) {
                // Reset the id to create a new record.
                $table->id = 0;

                $table->published   = 0;
                $table->alias       = '';

                if (!$table->check() || !$table->store()) {
                    throw new \Exception($table->getError());
                }

                $pk = (int) $pk;

                $query = $db->getQuery(true)
                    ->select(
                        $db->quoteName(
                            [
                                'title',
                                'description',
                                'ordering',
                                'position',
                                'target',
                                'type',
                                'interactive_type',
                                'url',
                                'created',
                                'modified',
                                'checked_out_time',
                                'checked_out',
                                'language',
                                'note',
                            ]
                        )
                    )
                    ->from($db->quoteName('#__guidedtour_steps'))
                    ->where($db->quoteName('tour_id') . ' = :id')
                    ->bind(':id', $pk, ParameterType::INTEGER);

                $db->setQuery($query);
                $rows = $db->loadObjectList();

                $query = $db->getQuery(true)
                    ->insert($db->quoteName('#__guidedtour_steps'))
                    ->columns(
                        [
                            $db->quoteName('tour_id'),
                            $db->quoteName('title'),
                            $db->quoteName('description'),
                            $db->quoteName('ordering'),
                            $db->quoteName('position'),
                            $db->quoteName('target'),
                            $db->quoteName('type'),
                            $db->quoteName('interactive_type'),
                            $db->quoteName('url'),
                            $db->quoteName('created'),
                            $db->quoteName('created_by'),
                            $db->quoteName('modified'),
                            $db->quoteName('modified_by'),
                            $db->quoteName('language'),
                            $db->quoteName('note'),
                        ]
                    );

                foreach ($rows as $step) {
                    $dataTypes = [
                        ParameterType::INTEGER,
                        ParameterType::STRING,
                        ParameterType::STRING,
                        ParameterType::INTEGER,
                        ParameterType::STRING,
                        ParameterType::STRING,
                        ParameterType::INTEGER,
                        ParameterType::INTEGER,
                        ParameterType::STRING,
                        ParameterType::STRING,
                        ParameterType::INTEGER,
                        ParameterType::STRING,
                        ParameterType::INTEGER,
                        ParameterType::STRING,
                        ParameterType::STRING,
                    ];

                    $query->values(
                        implode(
                            ',',
                            $query->bindArray(
                                [
                                    $table->id,
                                    $step->title,
                                    $step->description,
                                    $step->ordering,
                                    $step->position,
                                    $step->target,
                                    $step->type,
                                    $step->interactive_type,
                                    $step->url,
                                    $date,
                                    $user->id,
                                    $date,
                                    $user->id,
                                    $step->language,
                                    $step->note,
                                ],
                                $dataTypes
                            )
                        )
                    );
                }

                $db->setQuery($query);

                try {
                    $db->execute();
                } catch (\RuntimeException $e) {
                    Factory::getApplication()->enqueueMessage($e->getMessage(), 'error');

                    return false;
                }
            } else {
                throw new \Exception($table->getError());
            }
        }

        // Clear tours cache
        $this->cleanCache();

        return true;
    }

    /**
     * Import json data
     *
     * @param   string  $data  The data as a json string.
     *
     * @return  boolean|integer returns the tour count or false on error
     *
     * @since   __DEPLOY_VERSION__
     */
    public function import($data)
    {
        if (empty($data)) {
            return false;
        }

        $data = json_decode($data, true);

        $user = $this->getCurrentUser();
        $db   = $this->getDatabase();
        $date = Factory::getDate()->toSql();

        if (!isset($data['tours'])) {
            return false;
        }

        foreach ($data['tours'] as $tour) {
            // Insert a tour

            $isValid =
                array_key_exists('title', $tour) &&
                array_key_exists('url', $tour) &&
                array_key_exists('extensions', $tour);

            if (!$isValid) {
                continue;
            }

            $query = $db->getQuery(true);

            $columns = [
                'title',
                'description',
                'extensions',
                'url',
                'created',
                'created_by',
                'modified',
                'modified_by',
                'published',
                'language',
                'ordering',
                'note',
                'access',
            ];

            $values = [
                $tour['title'],
                $tour['description'] ?? '',
                $tour['extensions'],
                $tour['url'],
                $date,
                $user->id,
                $date,
                $user->id,
                $tour['published'] ?? 0,
                $tour['language'] ?? '*',
                1,
                $tour['note'] ?? '',
                $tour['access'] ?? 1,
            ];

            $dataTypes = [
                ParameterType::STRING,
                ParameterType::STRING,
                ParameterType::STRING,
                ParameterType::STRING,
                ParameterType::STRING,
                ParameterType::INTEGER,
                ParameterType::STRING,
                ParameterType::INTEGER,
                ParameterType::INTEGER,
                ParameterType::STRING,
                ParameterType::INTEGER,
                ParameterType::STRING,
                ParameterType::INTEGER,
            ];

            $query->insert($db->quoteName('#__guidedtours'), 'id');
            $query->columns($db->quoteName($columns));
            $query->values(implode(',', $query->bindArray($values, $dataTypes)));

            $db->setQuery($query);

            try {
                $result = $db->execute();
                if ($result && !empty($tour['steps'])) {
                    $tourId = $db->insertid();

                    // Insert steps for the tour

                    $columns = [
                        'tour_id',
                        'title',
                        'description',
                        'position',
                        'target',
                        'type',
                        'interactive_type',
                        'url',
                        'created',
                        'created_by',
                        'modified',
                        'modified_by',
                        'published',
                        'language',
                        'ordering',
                        'note',
                    ];

                    $step_values = [];

                    foreach ($tour['steps'] as $step) {
                        $isValid = array_key_exists('title', $step);

                        if (!$isValid) {
                            continue;
                        }

                        $step_values[] = [
                            $tourId,
                            $step['title'],
                            $step['description'] ?? '',
                            $step['position'] ?? 'center',
                            $step['target'] ?? '',
                            $step['type'] ?? 0,
                            $step['interactive_type'] ?? 1,
                            $step['url'] ?? '',
                            $date,
                            $user->id,
                            $date,
                            $user->id,
                            $step['published'] ?? 0,
                            $step['language'] ?? '*',
                            1,
                            $step['note'] ?? '',
                        ];
                    }

                    $dataTypes = [
                        ParameterType::INTEGER,
                        ParameterType::STRING,
                        ParameterType::STRING,
                        ParameterType::STRING,
                        ParameterType::STRING,
                        ParameterType::INTEGER,
                        ParameterType::INTEGER,
                        ParameterType::STRING,
                        ParameterType::STRING,
                        ParameterType::INTEGER,
                        ParameterType::STRING,
                        ParameterType::INTEGER,
                        ParameterType::INTEGER,
                        ParameterType::STRING,
                        ParameterType::INTEGER,
                        ParameterType::STRING,
                    ];

                    $query->clear();

                    $query->insert($db->quoteName('#__guidedtour_steps'), 'id');
                    $query->columns($db->quoteName($columns));

                    foreach ($step_values as $values) {
                        $query->values(implode(',', $query->bindArray($values, $dataTypes)));
                    }

                    $db->setQuery($query);

                    $result = $db->execute();
                }
            } catch (\RuntimeException $e) {
                Factory::getApplication()->enqueueMessage($e->getQuery());
                return false;
            }
        }

        return count($data['tours']);
    }

    /**
     * Get steps data for a tour
     *
     * @param   integer  $pk  The primary key of a tour.
     *
     * @return  boolean
     *
     * @since   __DEPLOY_VERSION__
     */
    public function getSteps($pk)
    {
        $db = $this->getDatabase();

        $query = $db->getQuery(true)
            ->select(
                $db->quoteName(
                    [
                        'title',
                        'description',
                        'ordering',
                        'position',
                        'target',
                        'type',
                        'interactive_type',
                        'url',
                        'created',
                        'modified',
                        'published',
                        'checked_out_time',
                        'checked_out',
                        'language',
                        'note',
                    ]
                )
            )
            ->from($db->quoteName('#__guidedtour_steps'))
            ->where($db->quoteName('tour_id') . ' = :id')
            ->bind(':id', $pk, ParameterType::INTEGER);

        $db->setQuery($query);
        return $db->loadObjectList();
    }

    /**
     * Sets a tour's steps language
     *
     * @param   int     $id        Id of a tour
     * @param   string  $language  The language to apply to the steps belong the tour
     *
     * @return  boolean
     *
     * @since  4.3.0
     */
    protected function setStepsLanguage(int $id, string $language = '*'): bool
    {
        if ($id <= 0) {
            return false;
        }

        $db    = $this->getDatabase();
        $query = $db->getQuery(true)
            ->update($db->quoteName('#__guidedtour_steps'))
            ->set($db->quoteName('language') . ' = :language')
            ->where($db->quoteName('tour_id') . ' = :tourId')
            ->bind(':language', $language)
            ->bind(':tourId', $id, ParameterType::INTEGER);

        return $db->setQuery($query)
            ->execute();
    }

    /**
     * Method to change the alias when not unique.
     *
     * @param   string   $alias           The alias.
     * @param   integer  $currentItemId   The id of the current tour.
     *
     * @return  string $alias  Contains the modified alias.
     *
     * @since   __DEPLOY_VERSION__
     */
    protected function generateNewAlias($alias, $currentItemId)
    {
        $unique = false;
        // Alter the title & alias
        while (!$unique) {
            $aliasItem = $this->getItemByAlias($alias);
            if ($aliasItem->id > 0 && $aliasItem->id != $currentItemId) {
                $alias = StringHelper::increment($alias, 'dash');
            } else {
                $unique = true;
            }
        }

        return $alias;
    }
}
