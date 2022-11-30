<?php

declare(strict_types=1);

namespace App\Security;

use App\Exception\ApiKeyAccessDeniedHttpException;
use App\Exception\ApiKeyNotFoundHttpException;
use App\Exception\PeriodByApiKeyNotFoundException;
use App\Model\Period;
use App\Repository\SpecificationPeriodRepository;
use DateTimeImmutable;
use Symfony\Component\HttpFoundation\Request;

class AccessTokenValidator
{
    public function __construct(
        private readonly SpecificationPeriodRepository $repository,
        private readonly string $apiKeyParam = 'x-api-key',
    ) {
    }

    public function validate(Request $request): void
    {
        $apiKey = $request->headers->get($this->apiKeyParam);
        if (null === $apiKey) {
            throw new ApiKeyNotFoundHttpException($this->apiKeyParam);
        }

        $this->authenticate($apiKey);
    }

    private function authenticate(string $apiKey): void
    {
        if ($this->getPeriod($apiKey)->dateIsNotBetween(new DateTimeImmutable())) {
            throw new ApiKeyAccessDeniedHttpException();
        }
    }

    private function getPeriod(string $apiKey): Period
    {
        try {
            return $this->repository->findPeriodByApiKey($apiKey);
        } catch (PeriodByApiKeyNotFoundException) {
            throw new ApiKeyAccessDeniedHttpException();
        }
    }
}
