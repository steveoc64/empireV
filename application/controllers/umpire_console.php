<?php

class Umpire_Console extends MY_Controller 
{
	////////////////////////////////////////////////////////////////////////////////
	//  Umpire Console
	function __construct() {
		parent::__construct();
		if (!$this->check_role(array('A','U'))) {
			exit;
		}
	}

	function index() {
		if ($this->game) {
			$this->render($this->load->view('umpire_hq',array('game'=>$this->game),true));
		} else {
			$this->oops('You need to select a game first in order to umpire it ..');
		}
	}

	function refresh() {
		$this->load->view('umpire_hq_refresh',array('game'=>$this->game));
	}

	function close_orders() {
		$this->game->close_orders();
		echo "Orders are now closed ...";
	}

	function me_determination() {
		$this->game->me_determination();
	}

	function accept_me_determination() {
		$this->game->accept_me_determination();
	}

	function refresh_orders() {
		$this->game->get_orders();
	}

	function morale_test_form() {
		$this->game->morale_test_form();
	}

	function morale_test() {
		$this->game->morale_test();
	}

	function morale_test_done() {
		$this->game->morale_test_done();
	}

	function leader_attach_form() {
		$this->game->leader_attach_form();
	}

	function leader_attach_done() {
		$this->game->leader_attach_done();
	}

	function declare_orders_form() {
		$this->game->declare_orders_form();
	}

	function cancel_order() {
		$unit = $this->input->post('unit_id');
		$this->game->cancel_order($unit);
	}

	function accept_order() {
		$unit = $this->input->post('unit_id');
		$this->game->accept_order($unit);
	}

	function declare_orders_done() {
		$this->game->declare_orders_done();
	}

	function activate_orders_form() {
		$this->game->activate_orders_form();
	}

	function activate_orders_done() {
		$this->game->activate_orders_done();
	}

	function breakoff_form() {
		$this->game->breakoff_form();
	}

	function breakoff_done() {
		$this->game->breakoff_done();
	}

	function grand_tactical_form() {
		$this->game->grand_tactical_form();
	}

	function gt_done() {
		$this->game->gt_done();
	}

	function determine_bombardment_done() {
		$this->game->determine_bombardment_done();
	}

	function engage_done() {
		$this->game->engage_done();
	}

	function commander_cas_done() {
		$this->game->commander_cas_done();
	}

	function rally_done() {
		$this->game->rally_done();
	}

	function rest_done() {
		$this->game->rest_done();
	}

	function end_of_hour_done() {
		$this->game->end_of_hour_done();
	}

	function rewind() {
		$this->game->rewind();
	}

	function update_unit_formation() {
		$unit_id = $this->input->post('unit');
		$formation = $this->input->post('formation');
		if ($unit = $this->game->get_unit($unit_id)) {
			$this->game->update_unit_formation($unit,$formation);
		}
	}

}
