<?php

/**
 * @package     Joomla.Administrator
 * @subpackage  mod_guidedtours
 *
 * @copyright   (C) 2006 Open Source Matters, Inc. <https://www.joomla.org>
 * @license     GNU General Public License version 2 or later; see LICENSE.txt
 */

defined('_JEXEC') or die;

use Joomla\CMS\Helper\ModuleHelper;
use Joomla\CMS\Plugin\PluginHelper;
use Joomla\CMS\Uri\Uri;
use Joomla\Module\GuidedTours\Administrator\Helper\GuidedToursHelper;

if (!PluginHelper::isEnabled('system', 'tour')) {
    return;
}

$tours = GuidedToursHelper::getList($params);

if (empty($tours)) {
    return;
}

$wa = $app->getDocument()->getWebAssetManager();
$wa->addInlineScript('
    function tourWasSelected(element) {
        if (element.getAttribute("data-id") > 0) {
            fetch("' . Uri::root() . 'administrator/index.php?option=com_ajax&plugin=tour&group=system&format=raw&method=post&tour_id=" + element.getAttribute("data-id"), {
                method: "get"
            })
            .then(function(response) { return response.json(); })
			.then(function(json) {
                if (Object.keys(json).length > 0) {
                    document.dispatchEvent(new CustomEvent("GuidedTourLoaded", { bubbles: true, detail: json }));
                }
            })
            .catch(error => console.error(error));
        } else {
            console.log("no data-id");
        }
    }
');

require ModuleHelper::getLayoutPath('mod_guidedtours', $params->get('layout', 'default'));
