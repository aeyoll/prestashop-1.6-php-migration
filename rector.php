<?php

declare(strict_types=1);

use Rector\Core\Configuration\Option;
use Rector\Php74\Rector\Property\TypedPropertyRector;
use Rector\Set\ValueObject\SetList;
use Symfony\Component\DependencyInjection\Loader\Configurator\ContainerConfigurator;

return static function (ContainerConfigurator $containerConfigurator): void {
    // get parameters
    $parameters = $containerConfigurator->parameters();

    // Directories
    $parameters->set(Option::PATHS, [
        __DIR__ . '/Adapter',
        __DIR__ . '/Core',
        __DIR__ . '/classes',
        __DIR__ . '/config',
        __DIR__ . '/controllers',
        __DIR__ . '/modules',
        __DIR__ . '/override',
        __DIR__ . '/pdf',
        __DIR__ . '/prestashop',
        __DIR__ . '/tools',
    ]);

    // Define what rule sets will be applied
    $containerConfigurator->import(SetList::PHP_73);
};
