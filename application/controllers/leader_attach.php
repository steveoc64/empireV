<?php

class Leader_attach extends MY_Controller {
	
	function index() {

		if ($this->game) {
			// Check that we are in phase 1 only !!
			if ($this->game->phase != 4) {
				die("Wrong game phase - can no longer attach leaders to units");
			}
			$leader = (int)$this->input->post('leader');
			$unit_id = (int)$this->input->post('unit');

			// Clear out any existing attachment record for this leader
			$this->db->query('delete from game_attach where game_id='.$this->game->id.' and commander_id='.$leader);

			if ($unit_id) {
				$data = array('game_id' => $this->game->id,
					'unit_id' => $unit_id,
					'commander_id' => $leader);
				$this->db->insert('game_attach',$data);
			}
			echo "Commander ".$leader." attached to unit ".$unit_id;
		}
	}

	function player_done() {
		if ($this->game && $this->game->user->id && $this->game->phase = PHASE_LEADER_ATTACH) {
			$data = new stdClass;
				$data->game_id = $this->game->id;
				$data->player_id = $this->game->user->id;
			$this->db->insert('game_attach_done',$data);
		}
	}

	function player_not_done() {
		if ($this->game && $this->game->user->id && $this->game->phase = PHASE_LEADER_ATTACH) {
			$this->db->delete('game_attach_done', array('game_id' => $this->game->id,'player_id' => $this->game->user->id));

		}
	}


	function get_status() {

		// Tricky bit - A bit of Ajax madness follows.
		// This function returns some jquery that sets the various dropdowns to the correct value.
		// Call this function from a timer, and execute the results to get realtime updates on the
		// leader attachment display from across the network !!
		if ($this->game->user->commander_id) {
			$commanders = $this->game->commanders;
			foreach ($commanders as $commander) {
				$row = $this->db->query("select unit_id from game_attach where game_id=".$this->game->id." and commander_id=".$commander->id)->row();
				$u = 0;
				if ($row) {
					$u = (int)$row->unit_id;
				}
				echo "$('#leader_attach_form select[name=".$commander->id."]').val(".$u.");\n";
			}
		} else {
			// Do it for ALL commanders
			$query = $this->db->query("select id,commander_id,username from user where commander_id != 0 and current_game=".$this->game->id);
			foreach ($query->result() as $commanding_user) {
				$range = $this->game->get_unit_id_range($commanding_user->commander_id);
				$commanders = $this->game->get_commander_list($range->start_id,$range->end_id);
				foreach ($commanders as $commander) {
					$row = $this->db->query("select unit_id from game_attach where game_id=".$this->game->id." and commander_id=".$commander->id)->row();
					$u = 0;
					if ($row) {
						$u = (int)$row->unit_id;
					}
					//echo "$('#leader_attach_form').find(\"name:".$commander->id.").val(".$u.");\n";
					echo "$('#leader_attach_form select[name=".$commander->id."]').val(".$u.");\n";
				}
				// And get the done status for this user
				$query2 = $this->db->query("select * from game_attach_done where game_id=".$this->game->id." and player_id=".$commanding_user->id);
				//echo $this->db->last_query();
				$is_active = false;
				foreach ($query2->result() as $row) {
					$is_active = true;
					break;
				}

				// highlight the image to mark them as done
				foreach ($commanders as $commander) {
					if ($commander->player_id == $commanding_user->id) {
						if ($is_active) {
							echo "$('#unit-picture-".$commander->id."').fadeTo('slow',0.2);\n";
						} else {
							echo "$('#unit-picture-".$commander->id."').fadeTo('slow',1.0);\n";
						}
					}
				}
			}
		}


		// Makes sense ?   Maybe not ;)
	}


}
