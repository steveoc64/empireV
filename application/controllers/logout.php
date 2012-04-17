<?php

class Logout extends MY_Controller 
{
	function index() {
		$img = "images/french_retreat.line.jpg";
		if ($this->game && $this->game->national_theme) {
			$img = "themes/".$this->game->national_theme->logout_img;
		} 

		$this->session->unset_userdata('role');
		$this->session->sess_destroy();
		$this->render('You are now logged out .... Thanks for using Empire, hope to see you again soon !<p><img src="'.$img.'">');

	}
}
