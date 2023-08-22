<?php

/**
 * Joomla! Content Management System
 *
 * @copyright  (C) 2023 Open Source Matters, Inc. <https://www.joomla.org>
 * @license    GNU General Public License version 2 or later; see LICENSE.txt
 */

namespace Joomla\CMS\Editor;

use Joomla\CMS\Editor\Exception\EditorNotFoundException;
use Joomla\CMS\Event\Editor\EditorSetupEvent;
use Joomla\Event\DispatcherAwareInterface;
use Joomla\Event\DispatcherAwareTrait;

// phpcs:disable PSR1.Files.SideEffects
\defined('JPATH_PLATFORM') or die;
// phpcs:enable PSR1.Files.SideEffects

/**
 * Editor Registry class
 * @since   __DEPLOY_VERSION__
 */
final class EditorsRegistry implements EditorsRegistryInterface, DispatcherAwareInterface
{
    use DispatcherAwareTrait;

    /**
     * List of registered elements
     *
     * @var    EditorProviderInterface[]
     * @since   __DEPLOY_VERSION__
     */
    private $registry = [];

    /**
     * Internal flag of initialisation
     *
     * @var    boolean
     * @since   __DEPLOY_VERSION__
     */
    private $initialised = false;

    /**
     * Return list of all registered elements
     *
     * @return EditorProviderInterface[]
     * @since    __DEPLOY_VERSION__
     */
    public function getAll(): array
    {
        return array_values($this->registry);
    }

    /**
     * Check whether the element exists in the registry.
     *
     * @param   string  $name  Element name
     *
     * @return  bool
     * @since    __DEPLOY_VERSION__
     */
    public function has(string $name): bool
    {
        return !empty($this->registry[$name]);
    }

    /**
     * Return element by name.
     *
     * @param   string  $name  Element name
     *
     * @return  EditorProviderInterface
     * @throws  EditorNotFoundException
     * @since    __DEPLOY_VERSION__
     */
    public function get(string $name): EditorProviderInterface
    {
        if (empty($this->registry[$name])) {
            throw new EditorNotFoundException(sprintf('Editor element "%s" not found in the registry.', $name));
        }

        return $this->registry[$name];
    }

    /**
     * Register element in registry, add new or override existing.
     *
     * @param   EditorProviderInterface $instance
     *
     * @return  EditorsRegistryInterface
     * @since    __DEPLOY_VERSION__
     */
    public function add(EditorProviderInterface $instance): EditorsRegistryInterface
    {
        $this->registry[$instance->getName()] = $instance;

        return $this;
    }

    /**
     * Trigger event to allow register the element through plugins.
     *
     * @return  EditorsRegistryInterface
     * @since   __DEPLOY_VERSION__
     */
    public function initRegistry(): EditorsRegistryInterface
    {
        if (!$this->initialised) {
            $this->initialised = true;

            $event = new EditorSetupEvent('onEditorSetup', ['subject' => $this]);
            $this->getDispatcher()->dispatch($event->getName(), $event);
        }

        return $this;
    }
}
