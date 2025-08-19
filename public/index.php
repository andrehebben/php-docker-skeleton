<?php

declare(strict_types=1);

use App\Config;
use App\Greeter;

require dirname(__DIR__) . '/vendor/autoload.php';

Config::load(dirname(__DIR__) . '/conf');

$greeter = new Greeter();
$name = Config::get('NAME', 'World');

echo $greeter->greet($name);
