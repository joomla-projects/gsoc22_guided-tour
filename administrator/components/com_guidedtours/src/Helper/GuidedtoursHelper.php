<?php

/**
 * @package       Joomla.Administrator
 * @subpackage    com_guidedtours
 *
 * @copyright     (C) 2023 Open Source Matters, Inc. <https://www.joomla.org>
 * @license       GNU General Public License version 2 or later; see LICENSE.txt
 */

namespace Joomla\Component\Guidedtours\Administrator\Helper;

use Joomla\CMS\Factory;

/**
 * guidedtours component helper.
 *
 * @since __DEPLOY_VERSION__
 */
class GuidedtoursHelper
{
    public static function getTourTitle($id)
    {
        if (empty($id)) {
            // Throw an error or ...
            return "";
        }

        $db = Factory::getDbo();
        $query = $db->getQuery(true);
        $query->select('title');
        $query->from('#__guidedtours');
        $query->where('id = ' . $id);
        $db->setQuery($query);

        return $db->loadObject();
    }
}
