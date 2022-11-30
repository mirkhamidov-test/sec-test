<?php

declare(strict_types=1);

namespace App\Tests\functional;

use App\Tests\FunctionalTester;
use Codeception\Example;
use Doctrine\Common\Annotations\Annotation\IgnoreAnnotation;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;

/**
 * @IgnoreAnnotation("part"
 */
class PingControllerCest
{
    /**
     * @dataProvider dataProviderForPing
     */
    public function testPing(FunctionalTester $I, Example $data): void
    {
        $I->send($data['method'], $data['route']);

        $I->seeResponseCodeIs(Response::HTTP_OK);
        $I->seeResponseIsJson();

        $responseAsArray = json_decode($I->grabResponse(), true, 512, JSON_THROW_ON_ERROR);

        $I->assertTrue(array_key_exists('datetime', $responseAsArray));
        $I->assertTrue(array_key_exists('timestamp', $responseAsArray));
        $I->assertDateTimeIsIso8601($responseAsArray['datetime']);
        $I->assertIntIsTimestamp($responseAsArray['timestamp']);
    }

    /**
     * @dataProvider dataProviderForPingFailures
     */
    public function testPingWithNotAllowedHttpMethods(FunctionalTester $I, Example $data): void
    {
        $I->send($data['method'], $data['route']);
        $I->seeResponseIsJson();
        $I->seeResponseCodeIs(Response::HTTP_METHOD_NOT_ALLOWED);
    }

    protected function dataProviderForPingFailures(): array
    {
        return [
            'ping with PATCH request' => ['method' => Request::METHOD_PATCH, 'route' => '/ping'],
            'ping with DELETE request' => ['method' => Request::METHOD_DELETE, 'route' => '/ping'],
            'home with PUT request' => ['method' => Request::METHOD_PUT, 'route' => '/'],
            'home with DELETE request' => ['method' => Request::METHOD_DELETE, 'route' => '/'],
        ];
    }

    protected function dataProviderForPing(): array
    {
        return [
            'ping with GET request' => ['method' => Request::METHOD_GET, 'route' => '/ping'],
            'ping with POST request' => ['method' => Request::METHOD_POST, 'route' => '/ping'],
            'home with GET request' => ['method' => Request::METHOD_GET, 'route' => '/'],
            'home with POST request' => ['method' => Request::METHOD_POST, 'route' => '/'],
        ];
    }
}
