<?php

/**
 * Joomla! Content Management System
 *
 * @copyright  (C) 2023 Open Source Matters, Inc. <https://www.joomla.org>
 * @license    GNU General Public License version 2 or later; see LICENSE.txt
 */

namespace Joomla\CMS\Event\Extension;

use Joomla\CMS\Installer\Installer;

// phpcs:disable PSR1.Files.SideEffects
\defined('_JEXEC') or die;
// phpcs:enable PSR1.Files.SideEffects

/**
 * Class for Extension events
 *
 * @since  __DEPLOY_VERSION__
 */
class AfterUpdateEvent extends AbstractExtensionEvent
{
    /**
     * The argument names, in order expected by legacy plugins.
     *
     * @var array
     *
     * @since  __DEPLOY_VERSION__
     * @deprecated 5.0 will be removed in 6.0
     */
    protected $legacyArgumentsOrder = ['installer', 'eid'];

    /**
     * Constructor.
     *
     * @param   string  $name       The event name.
     * @param   array   $arguments  The event arguments.
     *
     * @throws  \BadMethodCallException
     *
     * @since   __DEPLOY_VERSION__
     */
    public function __construct($name, array $arguments = [])
    {
        parent::__construct($name, $arguments);

        if (!\array_key_exists('installer', $this->arguments)) {
            throw new \BadMethodCallException("Argument 'method' of event {$name} is required but has not been provided");
        }

        if (!\array_key_exists('eid', $this->arguments)) {
            throw new \BadMethodCallException("Argument 'eid' of event {$name} is required but has not been provided");
        }
    }

    /**
     * Setter for the installer argument.
     *
     * @param   Installer  $value  The value to set
     *
     * @return  Installer
     *
     * @since  __DEPLOY_VERSION__
     */
    protected function setInstaller(Installer $value): Installer
    {
        return $value;
    }

    /**
     * Setter for the eid argument.
     *
     * @param   int|bool  $value  The value to set
     *
     * @return  int|bool
     *
     * @since  __DEPLOY_VERSION__
     */
    protected function setEid(int|bool $value): int|bool
    {
        return $value;
    }

    /**
     * Getter for the installer.
     *
     * @return  Installer
     *
     * @since  __DEPLOY_VERSION__
     */
    public function getInstaller(): Installer
    {
        return $this->arguments['installer'];
    }

    /**
     * Getter for the eid.
     *
     * @return  int|bool
     *
     * @since  __DEPLOY_VERSION__
     */
    public function getEid(): int|bool
    {
        return $this->arguments['eid'];
    }
}
