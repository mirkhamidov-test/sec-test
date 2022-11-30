<?php

declare(strict_types=1);

namespace App\Tests\Module;

use Codeception\Module;
use DateTimeImmutable;

class AssertDateTimeModule extends Module
{
    private const PHP_ISO_8601_PATTERN = '/^' .
        '(?P<Y>\d{4})' .
        '-' .
        '(?P<m>\d{2})' .
        '-' .
        '(?P<d>\d{2})' .
        'T' .
        '(?P<H>\d{2})' .
        ':' .
        '(?P<i>\d{2})' .
        ':' .
        '(?P<s>\d{2})' .
        '(?P<P>[+-]\d{2}:\d{2})' .
        '$/';

    public function assertDateTimeIsIso8601(string $supposedDateTimeString): void
    {
        $parts = [];

        $this->assertEquals(1, preg_match(self::PHP_ISO_8601_PATTERN, $supposedDateTimeString, $parts), 'Detecting date-time string by pattern failed.');

        $partsFormat = array_filter($parts, static fn (int|string $key) => is_string($key), ARRAY_FILTER_USE_KEY);
        $parsedDateTime = DateTimeImmutable::createFromFormat(implode(' ', array_keys($partsFormat)), implode(' ', $partsFormat));

        $this->assertNotFalse($parsedDateTime, 'Create DateTime from format failed.');

        $this->assertEquals($supposedDateTimeString, $parsedDateTime->format('c'), 'Supposed and recreated Date-times did not match.');
    }

    public function assertIntIsTimestamp(int $supposedTimestamp): void
    {
        $this->assertEquals(
            strtotime(date('d-m-Y H:i:s', $supposedTimestamp)),
            $supposedTimestamp,
        );
    }
}
