<?php

declare(strict_types=1);

namespace App\Exception;

use Symfony\Component\HttpKernel\Exception\AccessDeniedHttpException;

class ApiKeyAccessDeniedHttpException extends AccessDeniedHttpException
{
    public function __construct()
    {
        parent::__construct('Access denied with provided ApiKey.');
    }
}
