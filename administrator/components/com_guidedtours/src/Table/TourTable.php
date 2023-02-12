<?php

/**
 * @package       Joomla.Administrator
 * @subpackage    com_guidedtours
 *
 * @copyright     (C) 2023 Open Source Matters, Inc. <https://www.joomla.org>
 * @license       GNU General Public License version 2 or later; see LICENSE.txt
 */

namespace Joomla\Component\Guidedtours\Administrator\Table;

use Joomla\CMS\Factory;
use Joomla\CMS\Table\Table;
use Joomla\Database\DatabaseDriver;

// phpcs:disable PSR1.Files.SideEffects
\defined('_JEXEC') or die;
// phpcs:enable PSR1.Files.SideEffects

/**
 * Guidedtours table
 *
 * @since __DEPLOY_VERSION__
 */
class TourTable extends Table
{
    /**
     * Indicates that columns fully support the NULL value in the database
     *
     * @var    boolean
     * @since  __DEPLOY_VERSION__
     */

    // phpcs:disable PSR2.Classes.PropertyDeclaration.Underscore
    protected $_supportNullValue = true;

    /**
     * An array of key names to be json encoded in the bind function
     *
     * @var    array
     * @since  __DEPLOY_VERSION__
     */

    // phpcs:disable PSR2.Classes.PropertyDeclaration.Underscore
    protected $_jsonEncode = array('extensions');

    /**
     * Constructor
     *
     * @param   DatabaseDriver $db Database connector object
     *
     * @since __DEPLOY_VERSION__
     */
    public function __construct(DatabaseDriver $db)
    {
        parent::__construct('#__guidedtours', 'id', $db);
    }


    /**
     * Overloaded store function
     *
     * @param   boolean $updateNulls True to update extensions even if they are null.
     *
     * @return mixed  False on failure, positive integer on success.
     *
     * @see     Table::store()
     * @since   __DEPLOY_VERSION__
     */
    public function store($updateNulls = true)
    {
        $date = Factory::getDate();
        $user = Factory::getUser();

        $table = new TourTable($this->getDbo());

        if ($this->id) {
            // Existing item
            $this->modified_by = $user->id;
            $this->modified = $date->toSql();
        } else {
            $this->modified_by = 0;
        }

        if (!(int) $this->created) {
            $this->created = $date->toSql();
        }

        if (empty($this->created_by)) {
            $this->created_by = $user->id;
        }

        if (empty($this->extensions)) {
            $this->extensions = "*";
        }

        if (!(int) $this->modified) {
            $this->modified = $this->created;
        }

        if (empty($this->modified_by)) {
            $this->modified_by = $this->created_by;
        }

        return parent::store($updateNulls);
    }
}
