<?php

/**
 * Joomla! Content Management System
 *
 * @copyright  (C) 2023 Open Source Matters, Inc. <https://www.joomla.org>
 * @license    GNU General Public License version 2 or later; see LICENSE.txt
 */

namespace Joomla\CMS\Event\Editor;

use Joomla\CMS\Editor\Button\ButtonsRegistryInterface;
use Joomla\CMS\Event\AbstractImmutableEvent;

/**
 * Editor setup event
 *
 * @since   __DEPLOY_VERSION__
 */
final class EditorButtonsSetupEvent extends AbstractImmutableEvent
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

        if (!\array_key_exists('editorType', $arguments)) {
            throw new \BadMethodCallException("Argument 'editorType' of event {$name} is required but has not been provided");
        }

        if (!\array_key_exists('disabledButtons', $arguments)) {
            throw new \BadMethodCallException("Argument 'disabledButtons' of event {$name} is required but has not been provided");
        }

        parent::__construct($name, $arguments);
    }

    /**
     * Setter for the subject argument.
     *
     * @param   ButtonsRegistryInterface  $value  The value to set
     *
     * @return  ButtonsRegistryInterface
     *
     * @since  __DEPLOY_VERSION__
     */
    protected function setSubject(ButtonsRegistryInterface $value): ButtonsRegistryInterface
    {
        return $value;
    }

    /**
     * Returns Buttons Registry instance.
     *
     * @return  ButtonsRegistryInterface
     *
     * @since  __DEPLOY_VERSION__
     */
    public function getButtonsRegistry(): ButtonsRegistryInterface
    {
        return $this->getArgument('subject');
    }

    /**
     * Setter for the Editor Type argument.
     *
     * @param   string  $value  The value to set
     *
     * @return  string
     *
     * @since  __DEPLOY_VERSION__
     */
    protected function setEditorType(string $value): string
    {
        return $value;
    }

    /**
     * Getter for the Editor Type argument.
     *
     * @return  string
     *
     * @since  __DEPLOY_VERSION__
     */
    public function getEditorType(): string
    {
        return $this->arguments['editorType'];
    }

    /**
     * Setter for the disabled buttons argument.
     *
     * @param   array  $value  The value to set
     *
     * @return  array
     *
     * @since  __DEPLOY_VERSION__
     */
    protected function setDisabledButtons(array $value): array
    {
        return $value;
    }

    /**
     * Getter for the disabled buttons argument.
     *
     * @return  array
     *
     * @since  __DEPLOY_VERSION__
     */
    public function getDisabledButtons(): array
    {
        return $this->arguments['disabledButtons'];
    }

    /**
     * Setter for the Editor ID argument.
     *
     * @param   string  $value  The value to set
     *
     * @return  string
     *
     * @since  __DEPLOY_VERSION__
     */
    protected function setEditorId(string $value): string
    {
        return $value;
    }

    /**
     * Getter for the Editor ID argument.
     *
     * @return  string
     *
     * @since  __DEPLOY_VERSION__
     */
    public function getEditorId(): string
    {
        return $this->arguments['editorId'] ?? '';
    }

    /**
     * Setter for the asset argument.
     *
     * @param   int  $value  The value to set
     *
     * @return  int
     *
     * @since  __DEPLOY_VERSION__
     */
    protected function setAsset(int $value): int
    {
        return $value;
    }

    /**
     * Getter for the asset argument.
     *
     * @return  int
     *
     * @since  __DEPLOY_VERSION__
     */
    public function getAsset(): int
    {
        return $this->arguments['asset'] ?? 0;
    }

    /**
     * Setter for the author argument.
     *
     * @param   int  $value  The value to set
     *
     * @return  int
     *
     * @since  __DEPLOY_VERSION__
     */
    protected function setAuthor(int $value): int
    {
        return $value;
    }

    /**
     * Getter for the author argument.
     *
     * @return  int
     *
     * @since  __DEPLOY_VERSION__
     */
    public function getAuthor(): int
    {
        return $this->arguments['author'] ?? 0;
    }
}
