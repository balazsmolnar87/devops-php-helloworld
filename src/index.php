<?php

require_once __DIR__ . '/./vendor/autoload.php';

use HelloWorld\SayHello;

echo json_encode([
  "success" => true,
  "message" => SayHello::world()
]);
