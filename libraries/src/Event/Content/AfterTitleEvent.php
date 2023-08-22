<?php

/**
 * Joomla! Content Management System
 *
 * @copyright  (C) 2023 Open Source Matters, Inc. <https://www.joomla.org>
 * @license    GNU General Public License version 2 or later; see LICENSE.txt
 */

namespace Joomla\CMS\Event\Content;

use Joomla\CMS\Event\Result\ResultAware;
use Joomla\CMS\Event\Result\ResultAwareInterface;
use Joomla\CMS\Event\Result\ResultTypeStringAware;

// phpcs:disable PSR1.Files.SideEffects
\defined('_JEXEC') or die;
// phpcs:enable PSR1.Files.SideEffects

/**
 * Class for Content event.
 * Example:
 *  new AfterTitleEvent('onEventName', ['context' => 'com_example.example', 'subject' => $contentObject, 'params' => $params, 'page' => $pageNum]);
 *
 * @since  __DEPLOY_VERSION__
 */
class AfterTitleEvent extends ContentPrepareEvent implements ResultAwareInterface
{
    use ResultAware;
    use ResultTypeStringAware;
}
