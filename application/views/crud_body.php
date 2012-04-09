<?php 
if (isset($title)) { echo $title; }
echo $output;
if (isset($extras)) { echo $extras; }

if(isset($dropdown_setup)) {
	$this->load->view('dependant_dropdown', $dropdown_setup);
}
?>
