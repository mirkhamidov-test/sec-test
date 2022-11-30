<?php

declare(strict_types=1);

namespace App\Model;

class FlagBit
{
    private const NAMES = [
        1 => 'TRANSACTION_FLAG_CLEARING',
        2 => 'TRANSACTION_FLAG_GUARANTEE',
        3 => 'TRANSACTION_FLAG_3DSECURE',
        4 => 'TRANSACTION_FLAG_EXT_API',
        5 => 'TRANSACTION_FLAG_DEMO',
        6 => 'TRANSACTION_FLAG_AUTHORIZATION',
        7 => 'TRANSACTION_FLAG_ACCRUAL',
        8 => 'TRANSACTION_FLAG_STAKEHOLDER_EVALUATED',
        9 => 'TRANSACTION_FLAG_BASKET_EVALUATED',
        10 => 'TRANSACTION_FLAG_BASKET_ITEM_EVALUATED',
        11 => 'TRANSACTION_FLAG_SECUCORE',
        12 => 'TRANSACTION_FLAG_CHECKOUT',
        13 => 'TRANSACTION_FLAG_LVP',
        14 => 'TRANSACTION_FLAG_TRA',
        15 => 'TRANSACTION_FLAG_MIT',
    ];

    public function __construct(
        private readonly string $flagBit,
    ) {
    }

    public function getFlagBit(): string
    {
        return $this->flagBit;
    }

    public function getName(): string
    {
        return self::NAMES[$this->flagBit];
    }
}
