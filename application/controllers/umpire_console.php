<?php

class Umpire_Console extends MY_Controller 
{
	////////////////////////////////////////////////////////////////////////////////
	//  Umpire Console
	function index() {

		if ($this->check_role(array('A','U'))) {
			$this->render($this->load->view('umpire_hq',array('game'=>$this->game),true));
		}
	}

	function close_orders() {
		if ($this->check_role(array('A','U'))) {
			$this->game->close_orders();
			echo "Orders are now closed ...";
		}
	}

	function me_determination() {
		if ($this->check_role(array('A','U'))) {
			$this->game->me_determination();
		}
	}

	function accept_me_determination() {
		if ($this->check_role(array('A','U'))) {
			$this->game->accept_me_determination();
		}
	}

	function refresh_orders() {
		if ($this->check_role(array('A','U'))) {
			$this->game->get_orders();
		}
	}

	function morale_test_form() {
		if ($this->check_role(array('A','U'))) {
			$this->game->morale_test_form();
		}
	}

	function morale_test() {
		if ($this->check_role(array('A','U'))) {
			$this->game->morale_test();
		}
	}

}
