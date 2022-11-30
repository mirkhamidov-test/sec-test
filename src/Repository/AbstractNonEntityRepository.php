<?php

declare(strict_types=1);

namespace App\Repository;

use Doctrine\DBAL\Connection;

abstract class AbstractNonEntityRepository
{
    public function __construct(private readonly Connection $connection)
    {
    }

    protected function getConnection(): Connection
    {
        return $this->connection;
    }
}
