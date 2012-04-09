<?php

class Player_hq extends MY_Controller 
{
	function index() {

		$this->load->model('game_model');
		$game = $this->game_model->get_current_game();
		$this->render_header();
		$this->load->view('player_hq',array('game' => $game));
		$this->render_footer();

	}
}
