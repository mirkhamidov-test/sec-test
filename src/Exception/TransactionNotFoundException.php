<?php

declare(strict_types=1);

namespace App\Exception;

use Exception;

class TransactionNotFoundException extends Exception
{
    public function __construct(int $transactionId)
    {
        parent::__construct(sprintf('Transaction "%d" not found.', $transactionId));
    }
}
