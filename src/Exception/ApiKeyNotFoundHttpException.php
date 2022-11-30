<?php

declare(strict_types=1);

namespace App\Exception;

use Symfony\Component\HttpKernel\Exception\AccessDeniedHttpException;

class ApiKeyNotFoundHttpException extends AccessDeniedHttpException
{
    public function __construct(string $apiKeyParameter)
    {
        parent::__construct(sprintf('The API key "%s" is not specified in the header.', $apiKeyParameter));
    }
}
