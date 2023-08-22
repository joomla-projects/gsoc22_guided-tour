<?php

/**
 * Joomla! Content Management System
 *
 * @copyright  (C) 2023 Open Source Matters, Inc. <https://www.joomla.org>
 * @license    GNU General Public License version 2 or later; see LICENSE.txt
 */

namespace Joomla\CMS\Event\Model;

// phpcs:disable PSR1.Files.SideEffects
\defined('_JEXEC') or die;
// phpcs:enable PSR1.Files.SideEffects

/**
 * Class for Model event.
 * Example:
 *  new AfterCategoryChangeStateEvent('onEventName', ['context' => $extension, 'subject' => $primaryKeys, 'value' => $newState]);
 *
 * @since  __DEPLOY_VERSION__
 */
class AfterCategoryChangeStateEvent extends ChangeStateEvent
{
    /**
     * Getter for the extension.
     *
     * @return  string
     *
     * @since  __DEPLOY_VERSION__
     */
    public function getExtension(): string
    {
        return $this->getContext();
    }
}
