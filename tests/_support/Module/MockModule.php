<?php

declare(strict_types=1);

namespace App\Tests\Module;

use Codeception\Module;
use Codeception\Module\Symfony;

class MockModule extends Module
{
    public function replaceSymfonyServiceWithMock(string $serviceClassName, object $mockedService): void
    {
        /** @var Symfony $symfonyModule */
        $symfonyModule = $this->getModule('Symfony');
        $symfonyModule->_getContainer()->set($serviceClassName, $mockedService);
        $symfonyModule->unpersistService($serviceClassName);
    }
}
