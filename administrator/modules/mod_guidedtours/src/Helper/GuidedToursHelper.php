<?php

/**
 * @package     Joomla.Administrator
 * @subpackage  mod_guidedtours
 *
 * @copyright   (C) 2023 Open Source Matters, Inc. <https://www.joomla.org>
 * @license     GNU General Public License version 2 or later; see LICENSE.txt
 */

namespace Joomla\Module\GuidedTours\Administrator\Helper;

use Joomla\CMS\Application\AdministratorApplication;
use Joomla\CMS\Language\Multilanguage;
use Joomla\Registry\Registry;
use Joomla\Uri\Uri;

// phpcs:disable PSR1.Files.SideEffects
\defined('_JEXEC') or die;
// phpcs:enable PSR1.Files.SideEffects

/**
 * Helper for mod_guidedtours
 *
 * @since  __DEPLOY_VERSION__
 */
class GuidedToursHelper
{
    /**
     * Get a list of tours from a specific context.
     *
     * @param   Registry                  $params  Object holding the module parameters
     * @param   AdministratorApplication  $app     The application
     *
     * @return  mixed
     *
     * @since   __DEPLOY_VERSION__
     */
    public function getTours(Registry $params, AdministratorApplication $app)
    {
        $factory = $app->bootComponent('com_guidedtours')->getMVCFactory();

        $user = $app->getIdentity();

        // Get an instance of the guided tour model
        $tours = $factory->createModel('Tours', 'Administrator', ['ignore_request' => true]);

        $tours->setState('filter.published', 1);
        $tours->setState('filter.access', $app->getIdentity()->getAuthorisedViewLevels());

        if (Multilanguage::isEnabled()) {
            $tours->setState('filter.language', array('*', $app->getLanguage()->getTag()));
        }

        $items = $tours->getItems();

        foreach ($items as $key => $item) {
            // The user can only see the tours of extensions that are allowed.
            $uri = new Uri($item->url);

            if ($extension = $uri->getVar('option')) {
                if (!$user->authorise('core.manage', $extension)) {
                    unset($items[$key]);
                }
            }
        }

        return $items;
    }
}
