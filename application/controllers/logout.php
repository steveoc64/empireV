<?php

class Logout extends MY_Controller 
{
	function index() {
		$this->load->model('game_model');
		$game = $this->game_model->get_current_game(false);
		$img = "images/french_retreat.line.jpg";
		if ($game && $game->national_theme) {
			$img = "themes/".$game->national_theme->logout_img;
		} 

		$this->session->unset_userdata('role');
		$this->session->sess_destroy();
		$this->render('You are now logged out .... Thanks for using Empire, hope to see you again soon !<p><img src="'.$img.'">');

	}
}
