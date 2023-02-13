<?php

/**
 * @package       Joomla.Administrator
 * @subpackage    com_guidedtours
 *
 * @copyright     (C) 2023 Open Source Matters, Inc. <https://www.joomla.org>
 * @license       GNU General Public License version 2 or later; see LICENSE.txt
 */

defined('_JEXEC') or die;

use Joomla\CMS\Factory;
use Joomla\CMS\HTML\Helpers\StringHelper;
use Joomla\CMS\HTML\HTMLHelper;
use Joomla\CMS\Language\Text;
use Joomla\CMS\Language\Multilanguage;
use Joomla\CMS\Layout\LayoutHelper;
use Joomla\CMS\Router\Route;
use Joomla\CMS\Session\Session;
use Joomla\Component\Guidedtours\Administrator\View\Tours\HtmlView;
use Joomla\String\Inflector;

/** @var  HtmlView  $this */

/** @var \Joomla\CMS\WebAsset\WebAssetManager $wa */
$wa = $this->document->getWebAssetManager();
$wa->useScript('table.columns')
    ->useScript('multiselect');

try {
    $app = Factory::getApplication();
} catch (Exception $e) {
    die('Failed to get app');
}

$user = $app->getIdentity();
$userId = $user->get('id');
$listOrder = $this->escape($this->state->get('list.ordering'));
$listDirn = $this->escape($this->state->get('list.direction'));
$saveOrder = $listOrder == 'a.ordering';
$section = null;
$mode = false;

if ($saveOrder && !empty($this->items)) {
    $saveOrderingUrl =
        'index.php?option=com_guidedtours&tour=tours.saveOrderAjax&tmpl=component&'
        . Session::getFormToken() . '=1';
    HTMLHelper::_('draggablelist.draggable');
}
?>

<form action="<?php echo Route::_('index.php?option=com_guidedtours&view=tours'); ?>"
      method="post" name="adminForm" id="adminForm">
    <div id="j-main-container" class="j-main-container">
        <?php
        // Search tools bar
        echo LayoutHelper::render('joomla.searchtools.default', array('view' => $this));
        ?>

        <!-- If no tours -->
        <?php if (empty($this->items)) :
            ?>
            <!-- No tours -->
            <div class="alert alert-info">
                <span class="icon-info-circle" aria-hidden="true">
                </span><span class="visually-hidden"><?php echo Text::_('INFO'); ?></span>
                <?php echo Text::_('JGLOBAL_NO_MATCHING_RESULTS'); ?>
            </div>
        <?php endif; ?>

        <!-- If there are tours, we start with the table -->
        <?php if (!empty($this->items)) :
            ?>
            <!-- Tours table starts here -->
            <table class="table" id="toursList">

                <caption class="visually-hidden">
                    <?php echo Text::_('COM_GUIDEDTOURS_TABLE_CAPTION'); ?>,
                    <span id="orderedBy"><?php echo Text::_('JGLOBAL_SORTED_BY'); ?> </span>,
                    <span id="filteredBy"><?php echo Text::_('JGLOBAL_FILTERED_BY'); ?></span>
                </caption>

                <!-- Tours table header -->
                <thead>
                <tr>
                    <td class="w-1 text-center d-none d-md-table-cell">
                        <?php echo HTMLHelper::_('grid.checkall'); ?>
                    </td>
                    <!-- Ordering?-->
                    <th scope="col" class="w-3 text-center d-none d-md-table-cell">
                        <?php echo HTMLHelper::_(
                            'searchtools.sort',
                            '',
                            'a.ordering',
                            $listDirn,
                            $listOrder,
                            null,
                            'asc',
                            'JGRID_HEADING_ORDERING',
                            'icon-sort'
                        ); ?>
                    </th>
                    <th scope="col" class="w-1 text-center">
                        <?php echo HTMLHelper::_(
                            'searchtools.sort',
                            'COM_GUIDEDTOURS_STATUS',
                            'a.published',
                            $listDirn,
                            $listOrder
                        ); ?>
                    </th>

                    <th scope="col">
                        <?php echo Text::_('COM_GUIDEDTOURS_TOUR_TITLE'); ?>
                    </th>
                    <th scope="col">
                        <?php echo Text::_('COM_GUIDEDTOURS_DESCRIPTION'); ?>
                    </th>
                    <th scope="col" class="text-center w-10 d-none d-md-table-cell">
                        <?php echo HTMLHelper::_('searchtools.sort', 'JGRID_HEADING_ACCESS', 'a.access', $listDirn, $listOrder); ?>
                    </th>
                    <th scope="col" class="w-10 text-center d-none d-md-table-cell">
                        <?php echo Text::_('COM_GUIDEDTOURS_STEPS'); ?>
                    </th>

                    <!-- Add language types if multi-language enabled -->
                    <?php if (Multilanguage::isEnabled()) : ?>
                        <th scope="col" class="text-center w-10 d-none d-md-table-cell">
                            <?php echo HTMLHelper::_('searchtools.sort', 'JGRID_HEADING_LANGUAGE', 'a.language', $this->state->get('list.direction'), $this->state->get('list.ordering')); ?>
                        </th>
                    <?php endif; ?>

                    <th scope="col" class="w-10 text-center d-none d-md-table-cell">
                        <?php echo HTMLHelper::_(
                            'searchtools.sort',
                            'COM_GUIDEDTOURS_TOUR_ID',
                            'a.id',
                            $listDirn,
                            $listOrder
                        ); ?>
                    </th>
                </tr>
                </thead>

                <!-- Table body begins -->
                <tbody <?php if ($saveOrder) :
                    ?> class="js-draggable" data-url="<?php echo $saveOrderingUrl; ?>
                    " data-direction="<?php echo strtolower($listDirn); ?>" data-nested="true" <?php
                       endif; ?>>
                <?php
                foreach ($this->items as $i => $item) :
                    $canCreate = $user->authorise('core.create', 'com_guidedtours');
                    $canEdit = $user->authorise('core.edit', 'com_guidedtours');
                    $canChange = $user->authorise('core.edit.state', 'com_guidedtours');
                    ?>

                    <!-- Row begins -->
                    <tr class="row<?php echo $i % 2; ?>" data-draggable-group="none">
                        <!-- Item Checkbox -->
                        <td class="text-center">
                            <?php echo HTMLHelper::_('grid.id', $i, $item->id, false, 'cid', 'cb', $item->title); ?>
                        </td>

                        <!-- Draggable handle -->
                        <td class="text-center d-none d-md-table-cell">
                            <?php
                            $iconClass = '';

                            if (!$canChange) {
                                $iconClass = ' inactive';
                            } elseif (!$saveOrder) {
                                $iconClass = ' inactive" title="' . Text::_('JORDERINGDISABLED');
                            }
                            ?>

                            <span class="sortable-handler <?php echo $iconClass ?>">
                                    <span class="icon-ellipsis-v"></span>
                                </span>

                            <?php if ($canChange && $saveOrder) :
                                ?>
                                <input type="text" class="hidden text-area-order"
                                       name="order[]" size="5" value="<?php echo $item->ordering; ?>">
                            <?php endif; ?>
                        </td>

                        <!-- Item State -->
                        <td class="text-center">
                            <?php echo HTMLHelper::_(
                                'jgrid.published',
                                $item->published,
                                $i,
                                'tours.',
                                $canChange
                            ); ?>
                        </td>

                        <th scope="row" class="has-context">
                            <div>
                                <?php if ($canEdit) : ?>
                                    <a href="<?php echo Route::_('index.php?option=com_guidedtours&task=tour.edit&id=' . $item->id); ?>" title="<?php echo Text::_('JACTION_EDIT'); ?> <?php echo $this->escape($item->title); ?>">
                                        <?php echo $this->escape($item->title); ?>
                                    </a>
                                <?php else : ?>
                                    <?php echo $this->escape($item->title); ?>
                                <?php endif; ?>
                                <div class="small break-word">
                                    <?php if ($item->note) : ?>
                                        <?php echo Text::sprintf('JGLOBAL_LIST_NOTE', $this->escape($item->note)); ?>
                                    <?php endif; ?>
                                </div>
                            </div>
                        </th>

                        <td class="">
                            <?php echo StringHelper::truncate($item->description, 200, true, false); ?>
                        </td>

                        <!-- Adds access labels -->
                        <td class="small text-center d-none d-md-table-cell">
                            <?php

                            if ($this->escape($item->access) == "1") {
                                echo Text::_('COM_GUIDEDTOURS_ACCESS_PUBLIC');
                            } elseif ($this->escape($item->access) == "2") {
                                echo Text::_('COM_GUIDEDTOURS_ACCESS_REGISTERED');
                            } elseif ($this->escape($item->access) == "3") {
                                echo Text::_('COM_GUIDEDTOURS_ACCESS_SPECIAL');
                            } elseif ($this->escape($item->access) == "6") {
                                echo Text::_('COM_GUIDEDTOURS_ACCESS_SUPER_USERS');
                            } else {
                                echo Text::_('COM_GUIDEDTOURS_ACCESS_GUEST');
                            }

                            ?>
                        </td>

                        <td class="text-center btns d-none d-md-table-cell itemnumber">
                            <a class="btn btn-info "
                               href="index.php?option=com_guidedtours&view=steps&tour_id=<?php echo $item->id; ?>">
                                <?php echo $item->steps; ?>
                            </a>
                        </td>

                        <?php if (Multilanguage::isEnabled()) : ?>
                            <td class="text-center small d-none d-md-table-cell">
                                <?php echo LayoutHelper::render('joomla.content.language', $item); ?>
                            </td>
                        <?php endif; ?>

                        <!-- Tour ID -->
                        <td class="d-none d-md-table-cell text-center">
                            <?php echo (int) $item->id; ?>
                        </td>
                    </tr>
                <?php endforeach; ?>
                </tbody>
            </table>

            <?php
            // Load the pagination.
            echo $this->pagination->getListFooter();
            ?>
        <?php endif; ?>

        <input type="hidden" name="task" value="">
        <input type="hidden" name="boxchecked" value="0">
        <?php echo HTMLHelper::_('form.token'); ?>
    </div>
</form>
