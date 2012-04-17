<?php

class Update_unit_order extends MY_Controller {
	
	function index() {

		if ($this->game) {
			// Check that we are in phase 1 only !!
			if ($this->game->phase != 1) {
				die("Unfortunately, the time for dispatching orders has expired");
			}
			$unitid = (int)$this->input->post('unit');
			$order = (int)$this->input->post('order');
			$objective = mysql_escape_string($this->input->post('objective'));

			// check that we own this unit
			$unit = $this->unit_model->get($unitid,$this->game->id);
			if (!$unit) {
				die ("No such unit $unitid");
			}
			if ($unit && isset($unit->stats)) {
				if ($unit->stats->player_id != $this->session->userdata('user_id')) {
					die ("You cannot send orders to a unit that is not under your command");
				}
			}

			// Clear out any existing orders for this unit which are not yet activated
			$this->db->query("delete from game_order where activate_turn=0 and game_id=".$this->game->id." and unit_id=".$unitid);

			$data = array('game_id' => $this->game->id,
				'turn_number' => $this->game->turn_number,
				'activate_turn' => 0,   // Activate turn gets calculated when the umpire closes off orders
				'unit_id' => $unitid,
				'player_name' => $this->session->userdata('username'),
				'order_type' => $order,
				'objective' => $objective);
			$this->db->insert('game_order',$data);
			echo "Jolly Good Sir - The order has been dispatched in time..";
		}
	}

}
