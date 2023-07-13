<?php

/**
 * @package     Joomla.Plugin
 * @subpackage  System.guidedtours
 *
 * @copyright   (C) 2023 Open Source Matters, Inc. <https://www.joomla.org>
 * @license     GNU General Public License version 2 or later; see LICENSE.txt
 */

namespace Joomla\Plugin\System\GuidedTours\Extension;

use Joomla\CMS\Date\Date;
use Joomla\CMS\Factory;
use Joomla\CMS\Language\Text;
use Joomla\CMS\Object\CMSObject;
use Joomla\CMS\Plugin\CMSPlugin;
use Joomla\CMS\Session\Session;
use Joomla\Component\Guidedtours\Administrator\Extension\GuidedtoursComponent;
use Joomla\Event\DispatcherInterface;
use Joomla\Event\Event;
use Joomla\Event\SubscriberInterface;
use Joomla\Database\ParameterType;

// phpcs:disable PSR1.Files.SideEffects
\defined('_JEXEC') or die;
// phpcs:enable PSR1.Files.SideEffects

/**
 * Guided Tours plugin to add interactive tours to the administrator interface.
 *
 * @since  4.3.0
 */
final class GuidedTours extends CMSPlugin implements SubscriberInterface
{
    /**
     * A mapping for the step types
     *
     * @var    string[]
     * @since  4.3.0
     */
    protected $stepType = [
        GuidedtoursComponent::STEP_NEXT        => 'next',
        GuidedtoursComponent::STEP_REDIRECT    => 'redirect',
        GuidedtoursComponent::STEP_INTERACTIVE => 'interactive',
    ];

    /**
     * A mapping for the step interactive types
     *
     * @var    string[]
     * @since  4.3.0
     */
    protected $stepInteractiveType = [
        GuidedtoursComponent::STEP_INTERACTIVETYPE_FORM_SUBMIT    => 'submit',
        GuidedtoursComponent::STEP_INTERACTIVETYPE_TEXT           => 'text',
        GuidedtoursComponent::STEP_INTERACTIVETYPE_OTHER          => 'other',
        GuidedtoursComponent::STEP_INTERACTIVETYPE_BUTTON         => 'button',
        GuidedtoursComponent::STEP_INTERACTIVETYPE_CHECKBOX_RADIO => 'checkbox_radio',
        GuidedtoursComponent::STEP_INTERACTIVETYPE_SELECT         => 'select',
    ];

    /**
     * An internal flag whether plugin should listen any event.
     *
     * @var bool
     *
     * @since   4.3.0
     */
    protected static $enabled = false;

    /**
     * Constructor
     *
     * @param   DispatcherInterface  $dispatcher  The object to observe
     * @param   array                $config      An optional associative array of configuration settings.
     * @param   boolean              $enabled     An internal flag whether plugin should listen any event.
     *
     * @since   4.3.0
     */
    public function __construct(DispatcherInterface $dispatcher, array $config = [], bool $enabled = false)
    {
        $this->autoloadLanguage = $enabled;
        self::$enabled          = $enabled;

        parent::__construct($dispatcher, $config);
    }

    /**
     * function for getSubscribedEvents : new Joomla 4 feature
     *
     * @return array
     *
     * @since   4.3.0
     */
    public static function getSubscribedEvents(): array
    {
        return self::$enabled ? [
            'onAjaxGuidedtours'   => 'processAjax',
            'onBeforeCompileHead' => 'onBeforeCompileHead',
        ] : [];
    }

    /**
     * Decide which ajax response is appropriate
     *
     * @return null|object
     *
     * @since   __DEPLOY_VERSION__
     */
    public function processAjax(Event $event) {
        if ((int) $this->getApplication()->getInput()->getInt('step_id') > 0)
        {
            return $this->recordStep($event);
        } else {
            return $this->startTour($event);
        }
    }

    /**
     * Record that a step has been viewed
     *
     * @return null
     *
     * @since   __DEPLOY_VERSION__
     */
    public function recordStep(Event $event)
    {
        if (!Session::checkToken('get'))
        {
            return;
        }

        $app  = $this->getApplication();
        $user = $app->getIdentity();

        $step_id = (int) $app->getInput()->getInt('step_id');
        $tour_id = (int) $app->getInput()->getInt('tour_id');
        if ($step_id === 0 || $tour_id === 0 || $user->id === 0)
        {
            return;
        }

        try
        {
            $tour = $this->getTour( $tour_id );
        }
        catch (\Throwable $exception)
        {
            return;
        }

        if (!$tour)
        {
            return;
        }

        if (!isset($tour->params["tourhistory"]) || (int) $tour->params["tourhistory"] === 0)
        {
            return;
        }

        $date    = new Date('now');
        $viewed = $date->toSql();

        $db = Factory::getDbo();
        $query = $db->getQuery(true);
        $query->insert($db->quoteName('#__guidedtour_user_steps'))
              ->columns($db->quoteName(['tour_id', 'step_id', 'user_id', 'viewed']))
                ->values(':tour_id, :step_id, :user_id, :viewed');

        $query->bind(':tour_id', $tour_id, ParameterType::INTEGER);
        $query->bind(':step_id', $step_id, ParameterType::INTEGER);
        $query->bind(':user_id', $user->id, ParameterType::INTEGER);
        $query->bind(':viewed',  $viewed, ParameterType::STRING);

        try {
            $db->setQuery($query);
            $db->execute();
        } catch (\Exception $ex) {

        }

        $event->setArgument('result', new \stdClass());

        return $tour;
    }

    /**
     * Retrieve and starts a tour and its steps through Ajax.
     *
     * @return null|object
     *
     * @since   4.3.0
     */
    public function startTour(Event $event)
    {
        $tourId = (int) $this->getApplication()->getInput()->getInt('id');
        $tourAlias = $this->getApplication()->getInput()->getString('alias');
        $tourAlias = $tourAlias !== "" ? @urldecode($tourAlias) : $tourAlias;

        $activeTourId    = null;
        $activeTourAlias = null;
        $tour            = null;

        if ($tourId > 0) {
            $tour = $this->getTour($tourId);

            if (!empty($tour->id)) {
                $activeTourId = $tour->id;
            }
        } else if ($tourAlias !== "") {
            $tour = $this->getTourByAlias($tourAlias);

            if (!empty($tour->id)) {
                $activeTourId = $tour->id;
            }
        }

        $event->setArgument('result', $tour ?? new \stdClass());

        return $tour;
    }

    /**
     * Listener for the `onBeforeCompileHead` event
     *
     * @return  void
     *
     * @since   4.3.0
     */
    public function onBeforeCompileHead()
    {
        $app  = $this->getApplication();
        $doc  = $app->getDocument();
        $user = $app->getIdentity();

        if ($user != null && $user->id > 0) {
            Text::script('JCANCEL');
            Text::script('PLG_SYSTEM_GUIDEDTOURS_BACK');
            Text::script('PLG_SYSTEM_GUIDEDTOURS_COMPLETE');
            Text::script('PLG_SYSTEM_GUIDEDTOURS_COULD_NOT_LOAD_THE_TOUR');
            Text::script('PLG_SYSTEM_GUIDEDTOURS_NEXT');
            Text::script('PLG_SYSTEM_GUIDEDTOURS_START');
            Text::script('PLG_SYSTEM_GUIDEDTOURS_STEP_NUMBER_OF');
            Text::script('PLG_SYSTEM_GUIDEDTOURS_TOUR_ERROR');

            $doc->addScriptOptions('com_guidedtours.token', Session::getFormToken());

            // Load required assets
            $doc->getWebAssetManager()
                ->usePreset('plg_system_guidedtours.guidedtours');
        }
    }

    /**
     * Get a tour and its steps or null if not found
     *
     * @param   integer  $tourId  The ID of the tour to load
     *
     * @return null|object
     *
     * @since   4.3.0
     */
    private function getTour(int $tourId) {
        $app = $this->getApplication();

        $factory = $app->bootComponent( 'com_guidedtours' )->getMVCFactory();

        $tourModel = $factory->createModel(
            'Tour',
            'Administrator',
            [ 'ignore_request' => true ]
        );

        $item = $tourModel->getItem( $tourId );

        return $this->processTour($item);
    }

    /**
     * Get a tour and its steps or null if not found
     *
     * @param   integer  $tourId  The ID of the tour to load
     *
     * @return null|object
     *
     * @since   4.3.0
     */
    private function getTourByAlias(string $tourAlias) {
        $app = $this->getApplication();

        $factory = $app->bootComponent( 'com_guidedtours' )->getMVCFactory();

        $tourModel = $factory->createModel(
            'Tour',
            'Administrator',
            [ 'ignore_request' => true ]
        );

        $item = $tourModel->getItemByAlias( $tourAlias );

        return $this->processTour($item);
    }

    /**
     * Return  a tour and its steps or null if not found
     *
     * @param   TODO integer  $tourId  The ID of the tour to load
     *
     * @return null|object
     *
     * @since   5.0.0
     */
    private function processTour($item)
    {
        $app = $this->getApplication();

        $user = $app->getIdentity();
        $factory = $app->bootComponent( 'com_guidedtours' )->getMVCFactory();

        if (empty($item->id) || $item->published < 1 || !in_array($item->access, $user->getAuthorisedViewLevels())) {
            return null;
        }

        // We don't want to show all parameters, so take only a subset of the tour attributes
        $tour = new \stdClass();

        $tour->id = $item->id;

        $stepsModel = $factory->createModel(
            'Steps',
            'Administrator',
            ['ignore_request' => true]
        );

        $stepsModel->setState('filter.tour_id', $item->id);
        $stepsModel->setState('filter.published', 1);
        $stepsModel->setState('list.ordering', 'a.ordering');
        $stepsModel->setState('list.direction', 'ASC');

        $steps = $stepsModel->getItems();

        $tour->steps = [];

        $temp = new \stdClass();

        $temp->id          = 0;
        $temp->title       = $this->getApplication()->getLanguage()->_($item->title);
        $temp->description = $this->getApplication()->getLanguage()->_($item->description);
        $temp->url         = $item->url;

        // Replace 'images/' to '../images/' when using an image from /images in backend.
        $temp->description = preg_replace('*src\=\"(?!administrator\/)images/*', 'src="../images/', $temp->description);

        $tour->steps[] = $temp;

        foreach ($steps as $i => $step) {
            $temp = new \stdClass();

            $temp->id               = $i + 1;
            $temp->title            = $this->getApplication()->getLanguage()->_($step->title);
            $temp->description      = $this->getApplication()->getLanguage()->_($step->description);
            $temp->position         = $step->position;
            $temp->target           = $step->target;
            $temp->type             = $this->stepType[$step->type];
            $temp->interactive_type = $this->stepInteractiveType[$step->interactive_type];
            $temp->params           = $step->params;
            $temp->url              = $step->url;
            $temp->tour_id          = $step->tour_id;
            $temp->step_id          = $step->id;

            // Replace 'images/' to '../images/' when using an image from /images in backend.
            $temp->description = preg_replace('*src\=\"(?!administrator\/)images/*', 'src="../images/', $temp->description);

            $tour->steps[] = $temp;
        }

        $tour->params = $item->params;
        return $tour;
    }

}
