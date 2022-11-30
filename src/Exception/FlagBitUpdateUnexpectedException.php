<?php

declare(strict_types=1);

namespace App\Exception;

class FlagBitUpdateUnexpectedException extends \Exception
{
    public function __construct()
    {
        parent::__construct('While updating FitBit unexpected failure occurred.');
    }
}
