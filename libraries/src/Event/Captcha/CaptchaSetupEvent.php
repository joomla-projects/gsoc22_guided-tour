<?php

/**
 * Joomla! Content Management System
 *
 * @copyright  (C) 2023 Open Source Matters, Inc. <https://www.joomla.org>
 * @license    GNU General Public License version 2 or later; see LICENSE.txt
 */

namespace Joomla\CMS\Event\Captcha;

use Joomla\CMS\Captcha\CaptchaRegistry;
use Joomla\CMS\Event\AbstractImmutableEvent;

/**
 * Captcha setup event
 *
 * @since   __DEPLOY_VERSION__
 */
class CaptchaSetupEvent extends AbstractImmutableEvent
{
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
        if (!\array_key_exists('subject', $arguments)) {
            throw new \BadMethodCallException("Argument 'subject' of event {$name} is required but has not been provided");
        }

        parent::__construct($name, $arguments);
    }

    /**
     * Setter for the subject argument
     *
     * @param   CaptchaRegistry  $value  The value to set
     *
     * @return  CaptchaRegistry
     *
     * @since  __DEPLOY_VERSION__
     */
    protected function setSubject(CaptchaRegistry $value): CaptchaRegistry
    {
        return $value;
    }

    /**
     * Returns Captcha Registry instance.
     *
     * @return  CaptchaRegistry
     *
     * @since  __DEPLOY_VERSION__
     */
    public function getCaptchaRegistry(): CaptchaRegistry
    {
        return $this->getArgument('subject');
    }
}
