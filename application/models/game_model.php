<?php

define ('PHASE_ORDERS',1);
define ('PHASE_MORALE',2);
define ('PHASE_LEADERS',3);
define ('PHASE_BREAKOFF',4);
define ('PHASE_GT',5);
define ('PHASE_ENGAGE',6);
define ('PHASE_TACTICAL',7);
define ('PHASE_LEADERCAS',8);
define ('PHASE_RALLY',9);

function d100 () {
	return rand(1,100);
}

function roll_dice ($fractional) {

	$dice = rand(1,100);
	$result = (int) ((($fractional * 100) + (100 - $dice)) / 100);
	//echo "<br>Test fractional value of $fractional, die roll = $dice, <b><font color=red>result = $result KILL</font></b><br>\n";
	return $result;
}

$ace_values = array(0.7,0.8,0.9,1.0,2.0,2.1,2.2,2.3,2.4,3.0,
	3.1,4.0,4.1,5.0,5.1,6,6,7,8,9,
	10,11,12,14,16,18,20,22,24,27,
	30,35,40,45,50,55,62,70,80,90,
	100,110,120,140,160,180,200,220,240,270,
	300,350,400,450,500,550,620,700,800,900);

function ace_adjust($start_ace,$add) {
	global $ace_values;

	for ($i = 0; $i < sizeof($ace_values); $i++) {
		if ($ace_values[$i] == $start_ace) {
			//echo "<br>Found value of $start_ace at index $i<br>";
			$i += $add;
			if ($i >= 0) {
				//echo "<br>Returning value at index $i<br>";
				return ($ace_values[$i]);
			} elseif ($i >= 60) {
				return 900;
			} else
				return 0;
		}
	}

}


class Game_model extends CI_Model {

	function start_game($scenario_id) {
		$this->db->query("insert into game (scenario_id,start_hour,current_hour) values ($scenario_id,5,5)");
		$this->game_id = $this->db->insert_id();
		echo "Started new game $this->game_id with a start time of 0500hrs<br>\n";
	}

	function get_current_game($full_details = true) {
		// Find which game the user is on
		$user_data = $this->db->get_where('user',array('username' => $this->session->userdata('username')))->row();
		if (!$user_data) {
			return null;
		}
		$game_id = $user_data->current_game;
		if (!$game_id) {
			return null;
		}
			
		// get the game details
		$game_data = $this->db->get_where('game',array('id' => $game_id))->row();
		if (!$game_data) {
			return null;
		}

		if (!$full_details) {
			return $game_data;
		}

		// We have a game, so accumulate some details into the return value
		$game_data->user = $user_data;
		if ($user_data->commander_id) {
			$game_data->unit_id_range = $this->get_unit_id_range($user_data->commander_id);
			$game_data->unit_where_range = "(unit.id >= ".$game_data->unit_id_range['start_unit']." and unit.id <= ".$game_data->unit_id_range['end_unit'].")";
			// Get a list of the top level commands, and their current orders
			$game_data->me = $this->get_me_list($game_id,$game_data->unit_id_range['start_unit'],$game_data->unit_id_range['end_unit']);
		}

		// Get the weather details in a nice format
		$game_data->turn = $this->db->get_where('game_turn',array('game_id'=>$game_id,'turn_number'=>$game_data->turn_number))->row();
		if ((int)$game_data->turn->wind_speed) {
			$wind_dir = $this->db->get_where('direction',array('id'=>$game_data->turn->wind_direction))->row();
			$wind = sprintf("%dkm/h %s winds", $game_data->turn->wind_speed,$wind_dir);
		} else {
			$wind = 'No wind';
		}
		if ((int)$game_data->turn->rain) {
			$rain = sprintf("%dmm rain", $game_data->turn->rain);
		} else {
			$rain = 'Dry';
		}
	
		$game_data->weather_report = sprintf("%s %dC %s, %s, gound condition %d, visibility %dm",
			$game_data->turn->weather_conditions,
			$game_data->turn->temperature,
			$wind, $rain,
			$game_data->turn->ground_conditions,
			$game_data->turn->visibility);

		// Get the hour in a nice format
		$hour = $game_data->start_hour + $game_data->turn_number -1;
		$game_data->hrs = sprintf("%02d:00hrs", $hour);

		return $game_data;
	}

	function get_unit_where_range ($id) {
		$id_range = $this->get_unit_id_range($id);
		return "(unit.id >= ".$id_range['start_unit']." and unit.id <= ".$id_range['end_unit'].")";
	}

	function get_unit_id_range ($id) {
		$start_id = $id; // this is the lowest value
		$last_id = $id; // this is the lowest value

		$row = $this->db->query("select max(id) as last_child from unit where parent_id=$id")->row();
		if ($row && $row->last_child) {
			// Last Corps level
			$last_id = $row->last_child;
			$row = $this->db->query("select max(id) as last_child from unit where parent_id=".$row->last_child)->row();
			if ($row && $row->last_child) {
				// Last Division level
				$last_id = $row->last_child;
				$row = $this->db->query("select max(id) as last_child from unit where parent_id=".$row->last_child)->row();
				if ($row && $row->last_child) {
					// Last Brigade level
					$last_id = $row->last_child;
					$row = $this->db->query("select max(id) as last_child from unit where parent_id=".$row->last_child)->row();
					if ($row && $row->last_child) {
						// Last Battalion level - cant go any lower !
						die ("Seem to be too deeply nested on the command structure !");
					}
				}
			}

		}
		return array('start_unit'=>$start_id,'end_unit'=>$last_id);
	}

	function get_me_list ($game_id,$start_unit, $end_unit) {

		$this->load->model('unit_model');
		$retval = array();
		$query = $this->db->query("select id from unit where id >= $start_unit and id <= $end_unit and is_me='T' order by id");
		foreach ($query->result() as $row) {
			$unit = $this->unit_model->get($row->id,$game_id);
			$retval[] = $unit;
		}
		return $retval;
	}

	function close_orders () {
		// Find which game the user is on
		$user = $this->db->get_where('user',array('username' => $this->session->userdata('username')))->row();
		$game_id = (int)$user->current_game;
		if (!$game_id) {
			die ("No game selected ... ?????");
		}
		
		// get the game details
		$game = $this->db->get_where('game',array('id' => $game_id))->row();
		if (!$game) {
			die ("Cannot find game ID $game_id ... ?????");
		}

		// Check that we are the first phase (allowing orders to be set)
		$phase = (int) $game->phase;
		if ($phase > 1) {
			die ("We are already in phase $phase of game $game_id .. cannot close orders");
		}

		// All good, bump the game to the next phase
		$this->db->query("update game set phase=2 where id=$game_id");

		// Which kicks off the ME determination and morale check phase
		echo "Entering ME determination check phase<br>";
		$query = $this->db->query("select unit_id,initial_strength,casualties from game_unit_stats where game_id=$game_id");
		foreach ($query->result() as $row) {
			if ((int)$row->initial_strength) {
				if ((int)$row->casualties * 5 > (int)$row->initial_strength) {
					// More than 20% casualties so far
					// Check to see if they were in close combat in the last hour
					echo "Unit ".$row->unit_id." has at least 20% casualties<br>";
					$last_turn = (int)$game->turn_number - 1;
					$combat = $this->db->query("select value from game_event where game_id=$game_id and turn_number=$last_turn and unit_id=".$row->unit_id." and event_type=7")->row();
					if ($combat) {
						echo "and they were in close combat in the last hour<br>";
					}
				}
			} else {
				// This is probably 
			}
		}

	}

}


