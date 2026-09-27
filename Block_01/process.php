<?php
$hostname = "localhost:8889";
$username = "root";
$password = "root";
$dbName = "mountain trekking";

$conn = mysqli_connect($hostname,$username, $password,$dbName);

$difficulty =$_POST["difficulty"];

$query = "SELECT TRIPS.`T#`, MOUNTAINS.Mname, MOUNTAINS.Mcountry, MOUNTAINS.Mdifficulty, TRIPS.Ttripdate, TRIPS.Tduration, TRIPS.Torganizername FROM TRIPS, MOUNTAINS";
$query = "$query WHERE MOUNTAINS.Mdifficulty = '$difficulty' AND";
$query = "$query TRIPS.`M#` = MOUNTAINS.`M#`";

$result = mysqli_query($conn,$query);

while ($row = mysqli_fetch_array($result)) {
    echo $row['T#'] . " " . $row['Mname'] . " " . $row['Mcountry'] . " " . $row['Mdifficulty'] . " " . $row['Ttripdate'] . " " . $row['Tduration'] . " " . $row['Torganizername'] . "<br>";
}
?>