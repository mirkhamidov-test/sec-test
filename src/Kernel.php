<?php

namespace App;

use Symfony\Bundle\FrameworkBundle\Kernel\MicroKernelTrait;
use Symfony\Component\DependencyInjection\Loader\Configurator\ContainerConfigurator;
use Symfony\Component\HttpKernel\Kernel as BaseKernel;

class Kernel extends BaseKernel
{
    use MicroKernelTrait;

    protected function configureContainer(ContainerConfigurator $container): void
    {
        $container->import('../config/{packages}/*.yaml');
        /** @psalm-suppress MixedArgument */
        $container->import(sprintf('../config/{packages}/%s/*.yaml', $this->environment));
        $container->import('../config/{services}.yaml');
        /** @psalm-suppress MixedArgument */
        $container->import(sprintf('../config/{services}_%s.yaml', $this->environment));
    }
}
