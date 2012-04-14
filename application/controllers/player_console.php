<?php

class Player_console extends MY_Controller 
{
	function index() {

		$this->load->model('game_model');
		$this->load->model('unit_model');
		$game = $this->game_model->get_current_game();
		$this->render($this->load->view('player_hq',array('game'=>$game,'game_model'=>$this->game_model),true));
	}
}
