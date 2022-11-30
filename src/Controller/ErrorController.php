<?php

declare(strict_types=1);

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Throwable;

class ErrorController extends AbstractController
{
    private const ENV_TRACE_ALLOWED = ['dev', 'test'];

    public function __invoke(Throwable $exception): JsonResponse
    {
        $exceptionResponse = [
            'message' => $exception->getMessage(),
            'code' => $exception->getCode(),
        ];

        if (in_array($this->getParameter('kernel.environment'), self::ENV_TRACE_ALLOWED, true)) {
            $exceptionResponse['trace'] = $exception->getTraceAsString();
        }

        return $this->json([
            'content' => 'Exception occurred while execution',
            'exception' => $exceptionResponse,
        ]);
    }
}
