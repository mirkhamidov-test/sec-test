<?php

declare(strict_types=1);

namespace App\Tests\unit\Security;

use App\Exception\ApiKeyAccessDeniedHttpException;
use App\Exception\ApiKeyNotFoundHttpException;
use App\Exception\PeriodByApiKeyNotFoundException;
use App\Model\Period;
use App\Repository\SpecificationPeriodRepository;
use App\Security\AccessTokenValidator;
use DateTimeImmutable;
use PHPUnit\Framework\TestCase;
use Symfony\Component\HttpFoundation\HeaderBag;
use Symfony\Component\HttpFoundation\Request;

class AccessTokenValidatorTest extends TestCase
{
    public function testValidPeriod(): void
    {
        $validator = new AccessTokenValidator($this->getMockedRepository());
        $request = Request::create('/', 'GET');
        $request->headers = new HeaderBag(['x-api-key' => 'AnyApiKey']);

        $validator->validate($request);
    }

    public function testHeaderApiKeyNotProvided(): void
    {
        $validator = new AccessTokenValidator($this->getMockedRepository());
        $request = Request::create('/', 'GET');

        $this->expectException(ApiKeyNotFoundHttpException::class);
        $validator->validate($request);
    }

    public function testInvalidPeriod(): void
    {
        $validator = new AccessTokenValidator($this->getMockedRepository('now -2 years', 'now -1 year'));
        $request = Request::create('/', 'GET');
        $request->headers = new HeaderBag(['x-api-key' => 'AnyApiKey']);

        $this->expectException(ApiKeyAccessDeniedHttpException::class);
        $validator->validate($request);
    }

    public function testApiKeyNotFound(): void
    {
        $repository = $this->createMock(SpecificationPeriodRepository::class);
        $repository->method('findPeriodByApiKey')->willThrowException(new PeriodByApiKeyNotFoundException());
        $validator = new AccessTokenValidator($repository);

        $request = Request::create('/', 'GET');
        $request->headers = new HeaderBag(['x-api-key' => 'AnyApiKey']);

        $this->expectException(ApiKeyAccessDeniedHttpException::class);
        $validator->validate($request);
    }

    private function getMockedRepository(string $dateFrom = 'now -1 year', string $dateTo = 'now +1 year'): SpecificationPeriodRepository
    {
        $repository = $this->createMock(SpecificationPeriodRepository::class);

        $repository->method('findPeriodByApiKey')
            ->willReturn(new Period(
                new DateTimeImmutable($dateFrom),
                new DateTimeImmutable($dateTo),
            ));

        return $repository;
    }
}
