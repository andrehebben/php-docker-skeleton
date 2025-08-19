<?php

declare(strict_types=1);

namespace App\Tests;

use PHPUnit\Framework\TestCase;

final class IndexTest extends TestCase
{
    public function testIndexOutputsGreeting(): void
    {
        $_ENV['NAME'] = 'World';
        ob_start();
        require __DIR__ . '/../public/index.php';
        $output = trim(ob_get_clean() ?: '');
        $this->assertSame('Hello, World', $output);
    }
}
