<?php

declare(strict_types=1);

namespace App\Repository;

use Doctrine\DBAL\Connection;

abstract class AbstractNonEntityRepository
{
    public function __construct(private readonly Connection $connection)
    {
    }

    public function getConnection(): Connection
    {
        return $this->connection;
    }
}
