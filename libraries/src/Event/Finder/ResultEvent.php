<?php

/**
 * Joomla! Content Management System
 *
 * @copyright  (C) 2023 Open Source Matters, Inc. <https://www.joomla.org>
 * @license    GNU General Public License version 2 or later; see LICENSE.txt
 */

namespace Joomla\CMS\Event\Finder;

use Joomla\Component\Finder\Administrator\Indexer\Query;
use Joomla\Component\Finder\Administrator\Indexer\Result;

// phpcs:disable PSR1.Files.SideEffects
\defined('_JEXEC') or die;
// phpcs:enable PSR1.Files.SideEffects

/**
 * Class for Finder events.
 * Example:
 *  new ResultEvent('onEventName', ['subject' => $item, 'query' => $query]);
 *
 * @since  __DEPLOY_VERSION__
 */
class ResultEvent extends AbstractFinderEvent
{
    /**
     * The argument names, in order expected by legacy plugins.
     *
     * @var array
     *
     * @since  __DEPLOY_VERSION__
     * @deprecated 5.0 will be removed in 6.0
     */
    protected $legacyArgumentsOrder = ['subject', 'query'];

    /**
     * Setter for the subject argument.
     *
     * @param   Result  $value  The value to set
     *
     * @return  Result
     *
     * @since  __DEPLOY_VERSION__
     */
    protected function setSubject(Result $value): Result
    {
        return $value;
    }

    /**
     * Setter for the query argument.
     *
     * @param   Query  $value  The value to set
     *
     * @return  Query
     *
     * @since  __DEPLOY_VERSION__
     */
    protected function setQuery(Query $value): Query
    {
        return $value;
    }

    /**
     * Getter for the item.
     *
     * @return  Result
     *
     * @since  __DEPLOY_VERSION__
     */
    public function getItem(): Result
    {
        return $this->arguments['subject'];
    }

    /**
     * Getter for the query.
     *
     * @return  Query
     *
     * @since  __DEPLOY_VERSION__
     */
    public function getQuery(): Query
    {
        return $this->arguments['query'];
    }
}
