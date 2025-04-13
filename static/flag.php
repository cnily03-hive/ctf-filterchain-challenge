<?php

if (isset($_GET['0r4c111e'])) {
    highlight_file(__FILE__);
}

# Try to RCE

if (isset($_GET['cat']) && strlen($_GET['cat']) < 255) {
    $contents = file_get_contents($_GET['cat']);
    file_put_contents($_GET['cat'], $contents);
}
