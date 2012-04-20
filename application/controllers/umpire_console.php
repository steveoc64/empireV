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

	function refresh() {
		if ($this->check_role(array('A','U'))) {
			$this->load->view('umpire_hq_refresh',array('game'=>$this->game));
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

	function morale_test_done() {
		if ($this->check_role(array('A','U'))) {
			$this->game->morale_test_done();
		}
	}

	function leader_attach_form() {
		if ($this->check_role(array('A','U'))) {
			$this->game->leader_attach_form();
		}
	}

	function leader_attach_done() {
		if ($this->check_role(array('A','U'))) {
			$this->game->leader_attach_done();
		}
	}

	function declare_orders_form() {
		if ($this->check_role(array('A','U'))) {
			$this->game->declare_orders_form();
		}
	}

	function cancel_order() {
		if ($this->check_role(array('A','U'))) {
			$unit = $this->input->post('unit_id');
			$this->game->cancel_order($unit);
		}
	}

	function accept_order() {
		if ($this->check_role(array('A','U'))) {
			$unit = $this->input->post('unit_id');
			$this->game->accept_order($unit);
		}
	}

	function declare_orders_done() {
		if ($this->check_role(array('A','U'))) {
			$this->game->declare_orders_done();
		}
	}

	function activate_orders_form() {
		if ($this->check_role(array('A','U'))) {
			$this->game->activate_orders_form();
		}
	}

	function activate_orders_done() {
		if ($this->check_role(array('A','U'))) {
			$this->game->activate_orders_done();
		}
	}

	function breakoff_done() {
		if ($this->check_role(array('A','U'))) {
			$this->game->breakoff_done();
		}
	}

	function gt_done() {
		if ($this->check_role(array('A','U'))) {
			$this->game->gt_done();
		}
	}

	function determine_bombardment_done() {
		if ($this->check_role(array('A','U'))) {
			$this->game->determine_bombardment_done();
		}
	}

	function engage_done() {
		if ($this->check_role(array('A','U'))) {
			$this->game->engage_done();
		}
	}

	function commander_cas_done() {
		if ($this->check_role(array('A','U'))) {
			$this->game->commander_cas_done();
		}
	}

	function rally_done() {
		if ($this->check_role(array('A','U'))) {
			$this->game->rally_done();
		}
	}

	function rest_done() {
		if ($this->check_role(array('A','U'))) {
			$this->game->rest_done();
		}
	}

	function end_of_hour_done() {
		if ($this->check_role(array('A','U'))) {
			$this->game->end_of_hour_done();
		}
	}

	function rewind() {
		if ($this->check_role(array('A','U'))) {
			$this->game->rewind();
		}
	}

}
