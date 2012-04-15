<?php

class Umpire_Console extends MY_Controller 
{
	////////////////////////////////////////////////////////////////////////////////
	//  Cards maintenance
	function index() {

		if ($this->check_role(array('A','U'))) {

			$this->load->model('game_model');
			$this->load->model('unit_model');
			$game = $this->game_model->get_current_game();
			if ($this->uri->segment(2) != '') { 
				// Ajax refresh of the console - dont sent all the header stuff, just the console content
				$this->load->view('umpire_hq',array('game'=>$game,$this->uri->segment(3)=>true,'game_model'=>$this->game_model),false);
			} else {
				$this->render($this->load->view('umpire_hq',array('game'=>$game,'game_model'=>$this->game_model),true));
			}
		}
	}

	function close_orders() {
		if ($this->check_role(array('A','U'))) {
			$this->load->model('game_model');
			$this->game_model->close_orders();
			echo "Orders are now closed ...";
		}
	}

	function me_determination() {
		if ($this->check_role(array('A','U'))) {
			$this->load->model('game_model');
			$this->game_model->me_determination();
		}
	}

	function accept_me_determination() {
		if ($this->check_role(array('A','U'))) {
			$this->load->model('game_model');
			$this->game_model->accept_me_determination();
		}
	}

	function refresh_orders() {
		if ($this->check_role(array('A','U'))) {
			$this->load->model('game_model');
			$this->game_model->get_orders();
		}
	}

	function morale_test_form() {
		if ($this->check_role(array('A','U'))) {
			$this->load->model('game_model');
			$this->game_model->morale_test_form();
		}
	}

	function morale_test() {
		if ($this->check_role(array('A','U'))) {
			$this->load->model('game_model');
			$this->game_model->morale_test();
		}
	}

}
