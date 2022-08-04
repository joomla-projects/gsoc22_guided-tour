<?php

/**
 * @package       Joomla.Administrator
 * @subpackage    com_guidedtours
 * 
 * @copyright     (C) 2022 Open Source Matters, Inc. <https://www.joomla.org>
 * @license       GNU General Public License version 2 or later; see LICENSE.txt
 */

namespace Joomla\Component\Guidedtours\Administrator\View\Tours;

use Joomla\CMS\Helper\ContentHelper;
use Joomla\CMS\Language\Text;
use Joomla\CMS\MVC\View\GenericDataException;
use Joomla\CMS\MVC\View\HtmlView as BaseHtmlView;
use Joomla\CMS\Toolbar\Toolbar;
use Joomla\CMS\Toolbar\ToolbarHelper;

/**
 * View class for a list of guidedtours.
 *
 * @since __DEPLOY_VERSION__
 */
class HtmlView extends BaseHtmlView
{
    /**
     * An array of items
     *
     * @var array
     */
    protected $items;

    /**
     * The pagination object
     *
     * @var \JPagination
     */
    protected $pagination;

    /**
     * The model state
     *
     * @var \JObject
     */
    protected $state;

    /**
     * Form object for search filters
     *
     * @var \JForm
     */
    public $filterForm;

    /**
     * The active search filters
     *
     * @var array
     */
    public $activeFilters;

    /**
     * Display the view.
     *
     * @param   string $tpl The name of the template file to parse; automatically searches through the template paths.
     *
     * @return mixed  A string if successful, otherwise an Error object.
     */
    public function display($tpl = null)
    {
        $this->items         = $this->get('Items');
        $this->pagination    = $this->get('Pagination');
        $this->state         = $this->get('State');
        $this->filterForm    = $this->get('FilterForm');
        $this->activeFilters = $this->get('ActiveFilters');

        // Check for errors.
        if (count($errors = $this->get('Errors'))) {
            throw new GenericDataException(implode("\n", $errors), 500);
        }

        $this->addToolbar();

        return parent::display($tpl);
    }

    /**
     * Add the page title and toolbar.
     *
     * @return void
     *
     * @since __DEPLOY_VERSION__
     */
    protected function addToolbar()
    {
        // Get the toolbar object instance
        $toolbar = Toolbar::getInstance('toolbar');

        ToolbarHelper::title(Text::_('Guided Tour - List of Tours'), 'tours');

        $canDo = ContentHelper::getActions('com_guidedtours');

        if ($canDo->get('core.create')) {
            $toolbar->addNew('tour.add');
        }

        if ($canDo->get('core.edit.state')) {
            $dropdown = $toolbar->dropdownButton('status-group')
                ->text('JTOOLBAR_CHANGE_STATUS')
                ->toggleSplit(false)
                ->icon('icon-ellipsis-h')
                ->buttonClass('btn btn-action')
                ->listCheck(true);

            $childBar = $dropdown->getChildToolbar();

            $childBar->publish('tours.publish')->listCheck(true);

            $childBar->unpublish('tours.unpublish')->listCheck(true);

            $childBar->archive('tours.archive')->listCheck(true);

            if ($this->state->get('filter.published') != -2) {
                $childBar->trash('tours.trash')->listCheck(true);
            }
        }

        if ($this->state->get('filter.published') == -2 && $canDo->get('core.delete')) {
            $toolbar->delete('tours.delete')
                ->text('JTOOLBAR_EMPTY_TRASH')
                ->message('JGLOBAL_CONFIRM_DELETE')
                ->listCheck(true);
        }
    }
}
