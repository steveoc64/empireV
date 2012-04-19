<?php

class Player_console extends MY_Controller 
{
	function index() {
		if ($this->game) {
			$this->render($this->load->view('player_hq',array('game'=>$this->game),true));
		} else {
			$this->oops('You are not currently assigned to a game. Please ask the admin to set this up for you');
		}

	}

	function refresh() {
		$this->load->view('player_hq_refresh',array('game'=>$this->game));
	}

	function leader_attach_form() {
		$this->game->leader_attach_form();
	}
}
