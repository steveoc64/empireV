<?php

$this->load->view('include/header.php');

if (isset($menu)) {
	// Include menu on side panel, and split page into DIVs by area
	$this->load->view($menu);
	echo "<div id=\"main\">\n";
	$this->load->view($main_content);
	echo "</div>\n";
} else {
	echo "<div id=\"main\">\n";
	$this->load->view($main_content);
	echo "</div>\n";
}

$this->load->view('include/footer.php');

?>
