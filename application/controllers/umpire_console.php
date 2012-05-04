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

	function convert_to_defend() {
		$unit_id = $this->input->post('unit');
		$reason = $this->input->post('reason');
		if ($unit = $this->game->get_unit($unit_id)) {
			$this->game->convert_to_defend($unit,$reason,'');
		}
	}

	function convert_to_defend_posn() {
		$unit_id = $this->input->post('unit');
		$reason = $this->input->post('reason');
		if ($unit = $this->game->get_unit($unit_id)) {
			$this->game->convert_to_defend($unit,$reason,'current position');
		}
	}

	function attempt_intercept() {
		$unit_id = $this->input->post('unit');
		if ($unit = $this->game->get_unit($unit_id)) {
			$this->game->attempt_intercept($unit);
		}
	}

	function create_engagement_form() {
		$unit_id = $this->input->post('unit');
		$this->load->helper('form');
		echo form_open('umpire_console/create_engagement');
		echo "Name for this engagement :";
		$data = array(
			'name'        => 'name',
			'id'          => 'name',
			'size'        => '40',
			'style'       => 'width:50%',
		);
		echo form_input($data);
		echo '<br>';
		// Create a list of ME's that might be part of this engagement
		echo "Units involved :<br>";
		$query = $this->db->query("select username,commander_id from user where current_game=".$this->game->id." and commander_id != 0");
		foreach ($query->result() as $row) {
			echo form_fieldset($row->username,array('width'=>'100%'));
			$unit_range = $this->game->get_unit_id_range($row->commander_id);
			$me_list = $this->game->get_me_list($unit_range->start_id,$unit_range->end_id);
			foreach ($me_list as $unit) {
				if ($unit->id == $unit_id) {
					$checked = true;
				} else {
					$checked = false;
				}
				echo  '['.$unit->id.']  ';
				echo form_checkbox (array(
					'name'=> 'unit-'.$unit->id,
					'value'=> $unit->id,
					'checked'=> $checked));
				echo  $unit->name,'<br>';
			}
			echo form_fieldset_close();
		}
		//echo form_fieldset_close();
		echo form_submit('submit','Add New Engagement');
	}

	function create_engagement() {
		$name = $this->input->post('name');
		$units = array();
		foreach ($this->input->post(NULL, TRUE) as $k=>$v) {
			if (!strncmp($k,'unit-',5)) {
				$units[] = $v;
			}
		}

		// Create the engagement record
		$data = new stdClass;
			$data->game_id = $this->game->id;
			$data->turn_start = $this->game->turn_number;
			$data->descr = $name;
		$this->db->insert('game_engagement',$data);
		$engagement_id = $this->db->insert_id();

		// Create the unit links
		foreach ($units as $_) {
			$data = new stdClass;
			$data->game_id = $this->game->id;
			$data->engagement_id = $engagement_id;
			$data->unit_id = $_;
			$this->db->insert('game_engagement_unit',$data);
		}
		echo "<script>window.location.href = 'umpire_console';</script>";
	}

}
