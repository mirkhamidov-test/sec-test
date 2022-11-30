<?php

declare(strict_types=1);

namespace App\Model;

use DateTimeImmutable;

class Period
{
    public function __construct(
        private readonly DateTimeImmutable $from,
        private readonly DateTimeImmutable $to,
    ) {
    }

    public function dateIsNotBetween(DateTimeImmutable $date): bool
    {
        return !($date->getTimestamp() > $this->from->getTimestamp()
            && $date->getTimestamp() < $this->to->getTimestamp());
    }
}
