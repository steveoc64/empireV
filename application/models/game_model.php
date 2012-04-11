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
			$game_data->unit_where_range = "(unit.id >= ".$game_data->unit_id_range->start_id." and unit.id <= ".$game_data->unit_id_range->end_id.")";
			// Get a list of the top level commands, and their current orders
			$game_data->me = $this->get_me_list($game_id,$game_data->unit_id_range->start_id,$game_data->unit_id_range->end_id);
		}

		// Get the weather details in a nice format
		$game_data->turn = $this->db->get_where('game_turn',array('game_id'=>$game_id,'turn_number'=>$game_data->turn_number))->row();
		if ((int)$game_data->turn->wind_speed) {
			$wind_dir = $this->db->get_where('direction',array('id'=>$game_data->turn->wind_direction))->row();
			$wind = sprintf("%dkm/h %s winds", $game_data->turn->wind_speed,$wind_dir->name);
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
		return "(unit.id >= ".$id_range->start_id." and unit.id <= ".$id_range->end_id.")";
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

		$retval = new stdClass;
		$retval->start_id = $start_id;
		$retval->end_id =  $last_id;
		return $retval;
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

	function get_me_subunits ($game_id,$me_id) {

		$this->load->model('unit_model');
		$retval = array();
		$query = $this->db->query("select id from unit where parent_me = $me_id order by id");
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
		//$this->db->query("update game set phase=2 where id=$game_id");

		if ($game->turn_number == 1) {
			die ("No need to check ME determination on turn 1");
		}

		// Which kicks off the ME determination and morale check phase
		echo "Entering ME determination check phase<br>";
				// For each player
		//   for each ME under their command
		//    - except cavalry brigades
		//    - except infantry units with garrison orders
		//    - has at least 20% losses in total
		//    - was in close combat last round
		//
		$query = $this->db->query("select id,username,commander_id from user where current_game=$game_id and commander_id != 0");
		foreach ($query->result() as $row) {
			echo "<br><b><u>Commander ".$row->username."</u></b><br>";
			$unit_range = $this->get_unit_id_range($row->commander_id);
			$me_list = $this->get_me_list($game_id,$unit_range->start_id,$unit_range->end_id);
			// we now have a list of the MEs for this user, so for each one, calculate
			// the total strength, total losses, percentage losses in total, and the 
			// average morale grade of the ME as a whole
			$needs_test = array();
			foreach ($me_list as $unit) {
				//echo "  Unit : [".$unit->id."] - ".$unit->name." : ";
				if ($unit->unit_type == 6) {	// Exclude cav brigades
					//echo "is a Cavalry Brigade, so they are OK<br>";
				} else {
					// get the casualty count
					$total_strength = $total_casualties =  $total_morale_grade = $num_subunits = $avg_morale = 0;
					$sub_units = $this->get_me_subunits($game_id,$unit->id);
					foreach ($sub_units as $_) {
						$total_strength += $_->stats->initial_strength;
						$total_casualties += $_->stats->casualties;
						if ($_->morale_grade) {
							$total_morale_grade += $_->morale_grade;
							$num_subunits++;
						}
					}
					if ($num_subunits) {
						$avg_morale = (int) ($total_morale_grade / $num_subunits);
						$unit->avg_morale = $avg_morale;
					}
					if ($total_strength > 0) {
						$percent_loss = (int) (100 * $total_casualties / $total_strength);
						if ($percent_loss >= 20) {
							//echo "$total_casualties casualties from initial strength of $total_strength = $percent_loss% loss. Checking ...<br>";
							$unit->percent_loss = $percent_loss;
							$needs_test[] = $unit;

						} else {
							//echo "$total_casualties casualties from initial strength of $total_strength = $percent_loss% loss. OK<br>";
						}
					} else {
						//echo "has no troops, therefore no casualties<br>";
					}
				}
			}

			if (sizeof($needs_test)) {
				$turn = $game->turn_number -1;
				echo "Testing suspect units with over 20% losses<br>";
				foreach ($needs_test as $unit) {
					echo "  Unit : [".$unit->id."] - ".$unit->name." last turn they had :<br><ul>";
					// Were ANY units from this ME in close combat in the last hour ?
					// Read the above twice in order to comprehend this database query
					$query = $this->db->query("select u.id,u.name,e.event_type,e.descr from game_event e left join event_type t on t.id=e.event_type join unit u on u.id=e.unit_id where e.game_id=$game_id and u.parent_me=".$unit->id." and e.turn_number=$turn and e.event_type in (7,17,18)");
					$run_test = false;
					foreach ($query->result() as $row) {
						//print_r($row);
						echo "<li> [".$row->id."] - ".$row->name.': '.$row->descr.'<br>';
						$run_test = true;
					}
					if ($run_test) {
						echo "They MUST test for ME determination<br>";
						$query = $this->db->get_where('morale_grade',array('id'=>$unit->avg_morale))->row();
						if ($query) {
							echo "Average morale for this ME = ".$query->name." (".$unit->avg_morale.")<br>";
						} else {
							echo "ERROR: avg morale for this ME = ".$unit->avg_morale." !!!<br>";
						}
						if ($unit->avg_morale) {
							$diemod = -1*($unit->percent_loss - 20);
							echo "Total losses for the ME = ".$unit->percent_loss."% so thats a $diemod modifier<br>";
							echo "TODO: +10 if they won any close actions in the last hour<br>";
							echo "TODO: additional -10 for every 10% in excess of 20% loss in the last hour<br>";
							echo "TODO: +/- bonus for any number of leaders attached to the ME at the command level only<br>";

							switch($unit->avg_morale) {
							case 1:
								$b = -60; $r = -44; $s = -27; break;
							case 2:
								$b = -60; $r = -44; $s = -27; break;
							case 3:
								$b = -50; $r = -34; $s = -17; break;
							case 4:
								$b = -39; $r = -22; $s = -5; break;
							case 5:
								$b = -25; $r = -9; $s = 8; break;
							case 6:
								$b = -13; $r = 3; $s = 20; break;
							case 7:
								$b = -1; $r = 16; $s = 33; break;
							case 8:
								$b = 15; $r = 31; $s = 48; break;
							case 9:
								$b = 32; $r = 48; $s = 65; break;
							case 10:
								$b = 47; $r = 65; $s = 80; break;
							}
							$b -= $diemod;
							$r -= $diemod;
							$s -= $diemod;
							echo "On a D100, Break <= $b, Retreat <= $r, Shaken <= $s<br>";
							$dieroll = d100();
							echo "<i>rolls dice</i> ... $dieroll<br>";
							if ($dieroll <= $b) {
								echo "The whole ME is BROKEN<br>";
							} elseif ($dieroll <= $r) {
								echo "The whole ME is in RETREAT<br>";
							} elseif ($dieroll <= $s) {
								echo "The whole ME is SHAKEN<br>";
							} else {
								echo "They PASS - carry on as per normal<br>";
							}

						} else {
							echo "ERROR: avg morale for this ME = 0 !!!<br>";
						}
						// calculate the modifiers to the die roll
						// -10 for every 10% unit losses in excess of 20%
						// +10 if any units of the ME won a close combat last hour
						// +/- leader attached
					} else {
						echo "<li>They kept out of trouble last hour, so they are OK";
					}
					echo "</ul>";

				}
				// if we are here, then generate a dispatch message for the player from the commander of 
				// the fragile ME, informing the player that the ME is in some trouble. It arrives next turn
				$send_msg = true;
				switch ($unit->unit_type) {
				case TYPE_DIVISION:
					$message = "From Division [".$unit->id."] Commander ".$unit->division->commander;
					break;
				case TYPE_BRIGADE:
					$message = "From Brigade [".$unit->id."] Commander ".$unit->brigade->commander;
					break;
				default:
					$send_msg = false;
					break;
				}
				$delay=1;
				if ($send_msg) {
					if ($unit->percent_loss < 30) {
						$message .= "<br>".$unit->name." are taking some losses, but we are ready to carry on.";
					} elseif ($unit->percent_loss < 60) {
						$message .= "<br>".$unit->name." have sustained heavy losses - we must rest.";
					} elseif ($unit->percent_loss < 80) {
						$message .= "<br>All is lost for ".$unit->name.", but we shall fight to the end.";
						$delay=2;
					} else {
						$message .= "<br>Farewell - It has been an honour serving under your command.";
						$delay=3;
					}
					// make sure the same message is not repeated over and over again each turn
					$query = $this->db->query("select count(*) as count from game_message where game_id=$game_id and player_id=".$unit->stats->player_id." and message='$message'")->row();
					if ($query->count == 0) {
						$data = new stdClass;
							$data->game_id = $game_id;
							$data->turn_number = $game->turn_number + 1;
							$data->player_id = $unit->stats->player_id;
							$data->sent_turn = $game->turn_number;
							$data->message = $message;
						$this->db->insert('game_message',$data);
					}
				}
			} else {
				echo "  All units are OK<br>";
			}
		}
		echo "<br>";
	}

}


