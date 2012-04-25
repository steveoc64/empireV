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

	function declare_orders_form() {
		$this->game->declare_orders_form();
	}

	function breakoff_form() {
		$this->game->breakoff_form();
	}

	function update_unit_formation() {
		$unit_id = $this->input->post('unit');
		$formation = $this->input->post('formation');
		if ($unit = $this->game->get_unit($unit_id)) {
			$this->game->update_unit_formation($unit,$formation);
		}
	}

	function grand_tactical_form() {
		$this->game->grand_tactical_form();
	}
}
