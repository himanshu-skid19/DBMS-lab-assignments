<?php
// Allow requests from any origin - Be cautious with this in production
header('Access-Control-Allow-Origin: *');
header('Content-Type: application/json');

// A simple array to return as JSON
$response = ['status' => 'success', 'message' => 'Connection successful.'];

// Encode the array into JSON and return it
echo json_encode($response);
