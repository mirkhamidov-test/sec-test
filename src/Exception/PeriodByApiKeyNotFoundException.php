<?php

declare(strict_types=1);

namespace App\Exception;

class PeriodByApiKeyNotFoundException extends \Exception
{
    public function __construct()
    {
        parent::__construct('Specification Period not found for provided ApiKey.');
    }
}
