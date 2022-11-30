<?php

declare(strict_types=1);

namespace App\Tests\functional;

use App\Collection\FlagBitCollection;
use App\Model\Period;
use App\Repository\SpecificationPeriodRepository;
use App\Repository\TransactionsRepository;
use App\Tests\FunctionalTester;
use DateTimeImmutable;
use Mockery;
use Symfony\Component\HttpFoundation\Response;

class FlagBitsControllerCest
{
    public function testFlagBitCollectionValidationFailure(FunctionalTester $I): void
    {
        $I->sendGet('/api/flag_bits/2');
        $I->seeResponseIsJson();
        $I->seeResponseCodeIs(Response::HTTP_FORBIDDEN);
    }

    public function testFlagBitCollection(FunctionalTester $I): void
    {
        $token = 'someToken';
        $transactionId = 78;
        $flagBits = [1, 15];

        $this->mockSpecificationPeriodRepository($I, $token);
        $this->mockTransactionsRepository($I, $transactionId, $flagBits);

        $I->haveHttpHeader('x-api-key', $token);
        $response = $I->sendGet('/api/flag_bits/' . $transactionId);

        $I->assertEquals(
            '[{"flagBit":"1","name":"TRANSACTION_FLAG_CLEARING"},{"flagBit":"15","name":"TRANSACTION_FLAG_MIT"}]',
            $response,
        );
    }

    private function mockTransactionsRepository(FunctionalTester $I, int $transactionId, array $flagBits = []): void
    {
        $collection = new FlagBitCollection();
        foreach ($flagBits as $flagBit) {
            $collection->add((string) $flagBit);
        }

        $repository = Mockery::mock(TransactionsRepository::class);
        $repository->shouldReceive('findFlagBitsByTransId')
            ->with($transactionId)
            ->andReturn($collection);

        $I->replaceSymfonyServiceWithMock(TransactionsRepository::class, $repository);
    }

    private function mockSpecificationPeriodRepository(FunctionalTester $I, string $token): void
    {
        $repository = Mockery::mock(SpecificationPeriodRepository::class);
        $repository->shouldReceive('findPeriodByApiKey')
            ->with($token)
            ->andReturn(new Period(
                new DateTimeImmutable('now -1 year'),
                new DateTimeImmutable('now +1 year'),
            ));

        $I->replaceSymfonyServiceWithMock(SpecificationPeriodRepository::class, $repository);
    }
}
