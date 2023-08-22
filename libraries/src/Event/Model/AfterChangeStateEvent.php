<?php

/**
 * Joomla! Content Management System
 *
 * @copyright  (C) 2023 Open Source Matters, Inc. <https://www.joomla.org>
 * @license    GNU General Public License version 2 or later; see LICENSE.txt
 */

namespace Joomla\CMS\Event\Model;

use Joomla\CMS\Event\Result\ResultAware;
use Joomla\CMS\Event\Result\ResultAwareInterface;
use Joomla\CMS\Event\Result\ResultTypeBooleanAware;

// phpcs:disable PSR1.Files.SideEffects
\defined('_JEXEC') or die;
// phpcs:enable PSR1.Files.SideEffects

/**
 * Class for Model event.
 * Example:
 *  new AfterChangeStateEvent('onEventName', ['context' => 'com_example.example', 'subject' => $primaryKeys, 'value' => $newState]);
 *
 * @since  __DEPLOY_VERSION__
 */
class AfterChangeStateEvent extends ChangeStateEvent implements ResultAwareInterface
{
    use ResultAware;
    use ResultTypeBooleanAware;
}
