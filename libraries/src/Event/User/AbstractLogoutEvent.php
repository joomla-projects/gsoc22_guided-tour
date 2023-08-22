<?php

/**
 * Joomla! Content Management System
 *
 * @copyright  (C) 2023 Open Source Matters, Inc. <https://www.joomla.org>
 * @license    GNU General Public License version 2 or later; see LICENSE.txt
 */

namespace Joomla\CMS\Event\User;

// phpcs:disable PSR1.Files.SideEffects
\defined('_JEXEC') or die;
// phpcs:enable PSR1.Files.SideEffects

/**
 * Base class for User logout event
 *
 * @since  __DEPLOY_VERSION__
 */
abstract class AbstractLogoutEvent extends UserEvent
{
    /**
     * The argument names, in order expected by legacy plugins.
     *
     * @var array
     *
     * @since  __DEPLOY_VERSION__
     * @deprecated 5.0 will be removed in 6.0
     */
    protected $legacyArgumentsOrder = ['subject', 'options'];

    /**
     * Setter for the subject argument.
     *
     * @param   array  $value  The value to set
     *
     * @return  array
     *
     * @since  __DEPLOY_VERSION__
     */
    protected function setSubject(array $value): array
    {
        return $value;
    }

    /**
     * Setter for the options argument.
     *
     * @param   array  $value  The value to set
     *
     * @return  array
     *
     * @since  __DEPLOY_VERSION__
     */
    protected function setOptions(array $value): array
    {
        return $value;
    }

    /**
     * Getter for the parameters.
     *
     * @return  array
     *
     * @since  __DEPLOY_VERSION__
     */
    public function getParameters(): array
    {
        return $this->arguments['subject'];
    }

    /**
     * Getter for the options.
     *
     * @return  array
     *
     * @since  __DEPLOY_VERSION__
     */
    public function getOptions(): array
    {
        return $this->arguments['options'] ?? [];
    }
}
