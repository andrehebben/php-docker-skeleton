<?php

declare(strict_types=1);

namespace App\Tests;

use App\Greeter;
use PHPUnit\Framework\TestCase;

final class GreeterTest extends TestCase
{
    public function testGreetReturnsGreeting(): void
    {
        $greeter = new Greeter();
        $this->assertSame('Hello, World', $greeter->greet('World'));
    }
}
