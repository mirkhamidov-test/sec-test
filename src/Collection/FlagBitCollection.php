<?php

declare(strict_types=1);

namespace App\Collection;

use App\Model\FlagBit;
use ArrayIterator;
use IteratorAggregate;
use Traversable;

class FlagBitCollection implements IteratorAggregate
{
    /** @var FlagBit[] */
    private array $stack = [];

    public function add(string $flagBit): self
    {
        $this->stack[] = new FlagBit($flagBit);

        return $this;
    }

    public function getIterator(): Traversable
    {
        return new ArrayIterator($this->stack);
    }
}
