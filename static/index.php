<?php

highlight_file(__FILE__);

# Try to read flag.php

if (isset($_POST['file'])){
  echo hash_file('md5', $_POST['file']);
}
