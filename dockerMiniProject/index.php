<?php
// The MySQL service named in the docker-compose.yml.
$host = 'db';

// Database use name
$user = 'user';

//database user password
$pass = 'abcd';

// check the MySQL connection status
$conn = new mysqli($host, $user, $pass);
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
} else {
    echo "Connected to MySQL server successfully! with version ";
    echo $conn->server_version;
}
?>
