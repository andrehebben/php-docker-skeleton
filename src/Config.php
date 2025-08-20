<?php

declare(strict_types=1);

namespace App;

use Dotenv\Dotenv;

final class Config
{
    public static function load(string $directory = '/conf'): void
    {
        $envFile = rtrim($directory, '/') . '/' . '.env';
        if (is_readable($envFile)) {
            Dotenv::createImmutable($directory)->safeLoad();
        }
    }

    public static function get(string $key, ?string $default = null): ?string
    {
        return $_ENV[$key] ?? $_SERVER[$key] ?? $default;
    }
}
