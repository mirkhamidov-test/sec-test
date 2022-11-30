<?php

declare(strict_types=1);

namespace App\Model;

class FlagBitChangeResult
{
    private const CODE_SUCCESS = 0;

    public function __construct(
        private readonly int $code,
        private readonly string $statusMessage = '',
    ) {
    }

    public function isSuccess(): bool
    {
        return $this->code === self::CODE_SUCCESS;
    }

    public function getStatusMessage(): string
    {
        return $this->statusMessage;
    }
}
