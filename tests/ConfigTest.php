<?php

declare(strict_types=1);

namespace App\Tests;

use App\Config;
use PHPUnit\Framework\TestCase;

final class ConfigTest extends TestCase
{
    public function testLoadReadsEnvFile(): void
    {
        $tempDir = sys_get_temp_dir() . '/dotenv-test-' . uniqid();
        mkdir($tempDir);
        file_put_contents($tempDir . '/.env', "FOO=bar\n");

        Config::load($tempDir);

        $this->assertSame('bar', Config::get('FOO'));

        unlink($tempDir . '/.env');
        rmdir($tempDir);
    }

    public function testGetReturnsDefaultWhenMissing(): void
    {
        $this->assertSame('default', Config::get('MISSING', 'default'));
    }
}
