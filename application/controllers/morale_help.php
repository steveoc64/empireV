<?php

class Morale_help extends MY_Controller 
{
	function index() {
		$this->load->view('morale_help',array('game'=>$this->game));
	}
}

?>

