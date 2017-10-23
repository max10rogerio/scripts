<?php

  $con = mysqli_connect('','','', '');
  if(!$con) { echo "Cannot connect to the database ";die();}
  $result=mysqli_query($con, 'show tables');
  while($tables = mysqli_fetch_array($result)) {
          foreach ($tables as $key => $value) {
           mysqli_query($con, "ALTER TABLE $value CONVERT TO CHARACTER SET utf8 COLLATE utf8_general_ci");
     }}
  echo "The collation of your database has been successfully changed!";

?>
