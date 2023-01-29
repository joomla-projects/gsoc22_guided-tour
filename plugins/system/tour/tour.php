<?php

/**
 * @package     Joomla.Plugin
 * @subpackage  System.tour
 *
 * @copyright   (C) 2022 Open Source Matters, Inc. <https://www.joomla.org>
 * @license     GNU General Public License version 2 or later; see LICENSE.txt

 * @phpcs:disable PSR1.Classes.ClassDeclaration.MissingNamespace
 */

use Joomla\CMS\Plugin\CMSPlugin;
use Joomla\Event\SubscriberInterface;

/**
 * PlgSystemTour
 *
 * @since  __DEPLOY_VERSION__
 */
class PlgSystemTour extends CMSPlugin implements SubscriberInterface
{
    /**
     * Load the language file on instantiation
     *
     * @var    boolean
     * @since  __DEPLOY_VERSION__
     */
    protected $autoloadLanguage = true;

    /**
     * Application object.
     *
     * @var    JApplicationCms
     * @since  __DEPLOY_VERSION__
     */
    protected $app;

    /**
     * Application object.
     *
     * @var    JApplicationCms
     * @since  __DEPLOY_VERSION__
     */
    protected $guide;
    /**
     * function for getSubscribedEvents : new Joomla 4 feature
     *
     * @return array
     */
    public static function getSubscribedEvents(): array
    {
        return [
            'onAjaxTour' => 'onAjaxTour',
            'onBeforeRender' => 'onBeforeRender',
            'onBeforeCompileHead' => 'onBeforeCompileHead'
        ];
    }

    /**
     * Retrieve a tour and its steps through Ajax
     *
     * @since   __DEPLOY_VERSION__
     */
    public function onAjaxTour()
    {
        $tour_id = $this->app->getInput()->getString('tour_id', -1);
        if ($tour_id < 0) {
            echo json_encode(new stdClass());
        } else {
            $json_tour = $this->getJsonTour($tour_id);
            if (!$json_tour) {
                $this->app->setUserState('com_guidedtours.tour.id', -1);

                echo json_encode(new stdClass());
            } else {
                $this->app->setUserState('com_guidedtours.tour.id', $tour_id);

                echo $json_tour;
            }
        }
    }

    /**
     * Listener for the `onBeforeRender` event
     *
     * @return  void
     *
     * @since   __DEPLOY_VERSION__
     */
    public function onBeforeRender()
    {
        // Run in backend
        if ($this->app->isClient('administrator')) {
            $tour_id = $this->app->getUserState('com_guidedtours.tour.id', -1);
            if ($tour_id < 0) {
                return;
            }

            $json_tour = $this->getJsonTour($tour_id);
            if (!$json_tour) {
                $this->app->setUserState('com_guidedtours.tour.id', -1);
                return;
            }

            $this->app->setUserState('com_guidedtours.tour.id', $tour_id);
            $this->app->getDocument()->addScriptOptions('myTour', $json_tour);
        }
    }

    /**
     * Get a tour and its steps in Json format
     *
     * @return  false|string
     *
     * @since   __DEPLOY_VERSION__
     */
    protected function getJsonTour($tour_id)
    {
        $factory = $this->app->bootComponent('com_guidedtours')->getMVCFactory();

        $myTour = $factory->createModel(
            'Tour',
            'Administrator',
            ['ignore_request' => true]
        );

        $tour = $myTour->getItem($tour_id);

        $mySteps = $factory->createModel(
            'Steps',
            'Administrator',
            ['ignore_request' => true]
        );

        $mySteps->setState('filter.tour_id', $tour_id);

        $tour->steps = $mySteps->getItems();

        return json_encode($tour);
    }

    /**
     * Listener for the `onBeforeCompileHead` event
     *
     * @return  void
     *
     * @since   __DEPLOY_VERSION__
     */
    public function onBeforeCompileHead()
    {
        if ($this->app->isClient('administrator')) {
            $tour_id = $this->app->getUserState('com_guidedtours.tour.id', -1);
            if ($tour_id < 0) {
                return;
            }

            // Load required assets
            $assets = $this->app->getDocument()->getWebAssetManager();
            $assets->usePreset('shepherdjs');
            $assets->registerAndUseScript(
                'plg_system_tour.script',
                'plg_system_tour/guide.min.js',
                [],
                ['defer' => true],
                ['core']
            );
            $assets->registerAndUseStyle(
                'plg_system_tour.style',
                'plg_system_tour/guide.min.css'
            );
        }
    }
}
