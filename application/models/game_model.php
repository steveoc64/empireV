<?php

define ('PHASE_ORDERS',1);
define ('PHASE_ME_DET',2);
define ('PHASE_ME_MORALE',3);
define ('PHASE_ATTACH_LEADER',4);
define ('PHASE_DECLARE_ORDERS',5);
define ('PHASE_ACTIVATE_ORDERS',6);
define ('PHASE_BREAKOFF',7);
define ('PHASE_GT',8);
define ('PHASE_DETERMINE_BOMBARDMENT',9);
define ('PHASE_ENGAGE',10);
define ('PHASE_COMMANDER_CAS',11);
define ('PHASE_RALLY',12);
define ('PHASE_REST',13);
define ('PHASE_END_OF_HOUR',14);

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
		$game_data->user = $user_data;

		// load the national theme into the game array
		$theme = (int)$user_data->national_theme;
		if (!$theme) {
			$theme = 1;
		}
		$row = $this->db->get_where('national_theme',array('id'=>$theme))->row();
		if ($row) {
			$game_data->national_theme = $row;
		}

		if (!$full_details) {
			return $game_data;
		}

		// We have a game, so accumulate some details into the return value
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

	// Across a given range of unit IDs, return an array of units that are MEs
	// Note that each unit in the array will include an array of subunits.
	// This function will also calulate the total strength, casualties and avg morale
	// grade for each top level ME
	function get_me_list ($game_id,$start_unit, $end_unit) {

		$this->load->model('unit_model');
		$retval = array();
		$query = $this->db->query("select id from unit where id >= $start_unit and id <= $end_unit and is_me='T' order by id");
		foreach ($query->result() as $row) {
			$unit = $this->unit_model->get($row->id,$game_id);
			$this->get_me_subunits($game_id,$unit);
			$retval[] = $unit;
		}
		return $retval;
	}

	// For a given unit (which is known to be an ME), attach an array of subunits to the ME
	// and calculate the total strength, casualties and avg morale grade for the ME
	function get_me_subunits ($game_id,$me_unit) {

		$this->load->model('unit_model');
		$me_id = $me_unit->id;
		$query = $this->db->query("select id from unit where parent_me = $me_id order by id");
		$me_unit->stats->initial_strength = 0;
		$me_unit->stats->casualties = 0;
	       	$me_unit->stats->did_close_combat = 0;
		$me_unit->stats->won_close_combat = 0;
		$me_unit->stats->casualties_this_hour = 0;
		$me_unit->num_subunits = 0;
		$me_unit->avg_morale = 0;
		foreach ($query->result() as $row) {
			$unit = $this->unit_model->get($row->id,$game_id);
			$me_unit->me_subunit[] = $unit;
			$me_unit->stats->initial_strength += $unit->stats->initial_strength;
			$me_unit->stats->casualties += $unit->stats->casualties;
			$me_unit->stats->did_close_combat += $unit->stats->did_close_combat;
			$me_unit->stats->won_close_combat += $unit->stats->won_close_combat;
			$me_unit->stats->casualties_this_hour += $unit->stats->casualties_this_hour;
			// For sub-units that drop to below 100 men in effective strength, then dont
			// bother counting them in the calculating average morale anymore.
			// If all the dross in the ME have run away, leaving a couple of elite
			// units, then the whole (remaining) ME is now elite.
			if ($unit->unit_type == 12 || ($unit->stats->initial_strength - $unit->stats->casualties) > 100) {
				$me_unit->num_subunits ++;
				$me_unit->avg_morale += $unit->morale_grade;
			}
		}

		// Based on the totals, calculate the average morale
		if ($me_unit->num_subunits) {
			//{ echo "id = ".$me_unit->id." am = ".$me_unit->avg_morale." ns = ".$me_unit->num_subunits; }
			$me_unit->avg_morale = (int)($me_unit->avg_morale / $me_unit->num_subunits);
			//{ echo " calced am = ".$me_unit->avg_morale."<br>"; }
			$query = $this->db->get_where('morale_grade',array('id'=>$me_unit->avg_morale));
			$me_unit->avg_morale_name = '';
			if ($row = $query->row()) {
				$me_unit->avg_morale_name = $row->name;
			}
		} else {
			$me_unit->avg_morale_name = '';
		}
		
		// Pre calculate some derived values (on the top level ME) for convenience
		$me_unit->percent_lost = 0;
		if  ($me_unit->stats->initial_strength > 0) {
			$me_unit->percent_lost = (int)((100.0 * $me_unit->stats->casualties) / $me_unit->stats->initial_strength);
			$me_unit->percent_lost_this_hour = (int)((100.0 * $me_unit->stats->casualties_this_hour) / $me_unit->stats->initial_strength);
		}
		$me_unit->current_strength = $me_unit->stats->initial_strength - $me_unit->stats->casualties;
	}

	function get_orders () {
		// Find which game the user is on
		$user = $this->db->get_where('user',array('username' => $this->session->userdata('username')))->row();
		$game_id = (int)$user->current_game;
		if (!$game_id) {
			die ("No game selected ... ?????");
		}
	
		echo "<center><img src=".site_url()."images/fancy-pants3.png><br><u>Orders outstanding :</u></center>\n";
		echo "<table border=0 cellpadding=3>\n";
		$query = $this->db->query("select player_name,unit_id,order_type,objective from game_order where game_id=".$game_id." and activate_turn=0 order by timestamp desc");
		foreach ($query->result() as $row) {
			$unit_name = $this->db->get_where('unit',array('id'=>$row->unit_id))->row()->name;
			$order_name = $this->db->get_where('order_types',array('id'=>$row->order_type))->row()->name;
			echo "<tr><td>".$row->player_name."</td><td>[".$row->unit_id."] - ",$unit_name." has been ordered to ".$order_name." ".$row->objective."</td></tr>\n";
		}
		echo "</table>";

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
	}

	function me_determination () {
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
		if ($phase != 2) {
			die ("We are in phase $phase of game $game_id .. need to be in phase 2 to run ME determination test");
		}


		if ($game->turn_number == 1) {
			die ("No need to check ME determination on turn 1");
		} 

		// Clear out the current results
		$this->db->query("delete from game_me_det where game_id=$game_id and turn_number=".$game->turn_number);

		echo "Entering ME determination check phase<br>";
				// For each player
		//   for each ME under their command
		//    - except cavalry brigades
		//    - except infantry units with garrison orders
		//    - has at least 20% losses in total
		//    - was in close combat last round
		//
		$query = $this->db->query("select id,username,commander_id from user where current_game=$game_id and commander_id != 0");
		$turn = $game->turn_number -1;
		foreach ($query->result() as $row) {
			echo "<br><b><u>Commander ".$row->username."</u></b><br>";
			$unit_range = $this->get_unit_id_range($row->commander_id);
			$me_list = $this->get_me_list($game_id,$unit_range->start_id,$unit_range->end_id);
			// we now have a list of the MEs for this user
			foreach ($me_list as $unit) {
				//echo "  Unit : [".$unit->id."] - ".$unit->name." : ";
				if ($unit->unit_type == 6) {	// Exclude cav brigades
					//echo "is a Cavalry Brigade, so they are OK<br>";
				} else {
					// Is an infantry brigade - so jump into the ME determination test
					echo "<ul>";
					if ($unit->percent_lost >= 20) {
						echo "<li>Unit : [".$unit->id."] - ".$unit->name." has ".$unit->percent_lost."% losses - starting ME test";
						echo "<font color=blue><ul>";
						if ($unit->stats->did_close_combat) {
							echo "<li>".$unit->stats->did_close_combat." Close combat(s) in the last hour, so they need to test";
							echo "<li>Avg morale grade for the ME is currently ".$unit->avg_morale_name;
							$diemod = -1*($unit->percent_lost - 20);
							echo "<li>Total losses for the ME = ".$unit->percent_lost."% so thats a $diemod modifier";
							if ($unit->stats->won_close_combat) {
								echo "<li>+10 since they won close combat in the last hour (".$unit->stats->won_close_combat." wins)";
								$diemod += 10;
							}
							if ($unit->percent_lost_this_hour >= 20) {
								$diemod2 = -1*($unit->percent_lost_this_hour - 20);
								echo "<li>Total losses for the ME in the last hour  ".$unit->percent_lost_this_hour."% so thats another $diemod2 modifer";
								$diemod += $diemod2;
							}
							echo "<li>TODO: +/- bonus for any number of leaders attached to the ME at the command level only";
							switch($unit->avg_morale) {
							case 1: $b = -60; $r = -44; $s = -27; break;
							case 2: $b = -60; $r = -44; $s = -27; break;
							case 3: $b = -50; $r = -34; $s = -17; break;
							case 4: $b = -39; $r = -22; $s = -5; break;
							case 5: $b = -25; $r = -9; $s = 8; break;
							case 6: $b = -13; $r = 3; $s = 20; break;
							case 7: $b = -1; $r = 16; $s = 33; break;
							case 8: $b = 15; $r = 31; $s = 48; break;
							case 9: $b = 32; $r = 48; $s = 65; break;
							case 10: $b = 47; $r = 65; $s = 80; break;
							}
							$b -= $diemod;
							$r -= $diemod;
							$s -= $diemod;
							echo "<li>On a D100, Break <= $b, Retreat <= $r, Shaken <= $s";
							$dieroll = d100();
							echo "<li><i>rolls dice</i> ... $dieroll";
							if ($dieroll <= $b) {
								echo "<li>The whole ME is BROKEN";
								$result = 4;
							} elseif ($dieroll <= $r) {
								echo "<li>The whole ME is in RETREAT";
								$distance = (int) (800 / $game->ground_scale);
								echo "<li>All units fall back 800 yds ($distance inches)";
								$result = 3;
							} elseif ($dieroll <= $s) {
								echo "<li>The whole ME is SHAKEN";
								$result = 2;
							} else {
								echo "<li>They PASS - carry on as per normal";
								$result = 1;
							}
							// Create a record of the ME determination test
							$data = new stdClass;
								$data->game_id = $game_id;
								$data->unit_id = $unit->id;
								$data->turn_number = $game->turn_number;
								$data->result = $result;
								$data->diemod = $diemod;
								$data->dieroll = $dieroll;
							$this->db->insert('game_me_det',$data);
						} else {
							echo "<li>No close combat in the last hour, so they are OK";
						}
						echo "</ul></font>"; // closing UL on the ME determination test
						
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
							if ($unit->percent_lost < 30) {
								$message .= "<br>".$unit->name." are taking some losses, but we are ready to carry on.";
							} elseif ($unit->percent_lost < 60) {
								$message .= "<br>".$unit->name." have sustained heavy losses - we must rest.";
							} elseif ($unit->percent_lost < 80) {
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
									$data->unit_id = $unit->id;
									$data->sent_turn = $game->turn_number;
									$data->message = $message;
									$data->letter_icon = rand(1,6);
								$this->db->insert('game_message',$data);
							}
						} // if send mesg
					} // has over 20% losses for this ME
					else {
						echo "<li>Unit : [".$unit->id."] - ".$unit->name." is in good condition";
					} // not over 20% losses for this ME
					echo "</ul>";
				} // is an infantry ME
			} // foreach ME
		} // for each player
	} // close me_determination function

	function accept_me_determination () {
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
		if ($phase != 2) {
			die ("We are in phase $phase of game $game_id .. need to be in phase 2 to accept ME determination test");
		}


		if ($game->turn_number == 1) {
			die ("No need to check ME determination on turn 1");
		} 

		// for each me determination test result in this turn ... apply it
		$this->load->model('unit_model');
		$query = $this->db->get_where('game_me_det',array('game_id'=>$game_id,'turn_number'=>$game->turn_number));
		foreach ($query->result() as $row) {
			switch ($row->result) {
			case 1:
				// they passed the test, nothing to do
				echo "Test passed";
				print_r($row);
				break;
			case 2:
				// they are shaken - set all units in the ME to shaken
				$unit = $this->unit_model->get($row->unit_id,$game_id);
				$this->unit_model->is_shaken($game_id,$game->turn_number,$unit);
				$this->get_me_subunits($game_id,$unit);
				foreach ($unit->me_subunit as $subunit) {
					$this->unit_model->is_shaken($game_id,$game->turn_number,$subunit);
				}
				$message = "the officers and men of ".$unit->name." are shamefully losing confidence !";
				// Now - send an immediate message to all players that this ME is losing confidence
				$query = $this->db->query("select id,username from user where current_game=$game_id");
				foreach ($query->result() as $row) {
					$data = new stdClass;
						$data->game_id = $game_id;
						$data->turn_number = $game->turn_number;
						$data->sent_turn = $game->turn_number;
						$data->player_id = $row->id;
						$data->unit_id = $unit->id;
						$data->message = "Sir, we have immediate news that $message";
						$data->letter_icon = rand(1,6);
					$this->db->insert('game_message',$data);
				}
				echo "$message <p>";
				break;
			case 3:
				// they are in retreat - set all units in the ME to retreat
				$unit = $this->unit_model->get($row->unit_id,$game_id);
				$this->unit_model->is_retreating($game_id,$game->turn_number,$unit);
				$this->get_me_subunits($game_id,$unit);
				foreach ($unit->me_subunit as $subunit) {
					$this->unit_model->is_retreating($game_id,$game->turn_number,$unit);
				}
				// Now - send an immediate message to all players that this ME is in retreat
				$message = "Sir, we have astounding news that ".$unit->name." are in cowardly retreat !";
				$query = $this->db->query("select id from user where current_game=$game_id");
				foreach ($query->result() as $row) {
					$data = new stdClass;
						$data->game_id = $game_id;
						$data->turn_number = $game->turn_number;
						$data->sent_turn = $game->turn_number;
						$data->player_id = $row->id;
						$data->message = $message;
						$data->unit_id = $unit->id;
						$data->letter_icon = rand(1,6);
					$this->db->insert('game_message',$data);
				}
				$distance = (int) (800 / $game->ground_scale);
				echo "The officers and men of ".$unit->name." are in retreat - they must fall back $distance inches immediately.<p>";
				echo "TODO: If any subunits of that ME are within engagement range of formed enemy cavalry, the owner of the cavalry may demand that retreating infantry units be pinned - which will cost the pinned unit an extra 2 fatigue points.<p>";
				break;
			case 4:
				// they are broken - set all units in the ME to retreat
				$unit = $this->unit_model->get($row->unit_id,$game_id);
				$this->unit_model->is_broken($game_id,$game->turn_number,$unit);
				$this->get_me_subunits($game_id,$unit);
				foreach ($unit->me_subunit as $subunit) {
					$this->unit_model->is_broken($game_id,$game->turn_number,$unit);
				}
				// Now - send an immediate message to all players that this ME is in retreat
				$message = "Sir, there are unconfirmed reports that ".$unit->name." may well have broken in disgraceful panic !";
				$query = $this->db->query("select id from user where current_game=$game_id");
				foreach ($query->result() as $row) {
					$data = new stdClass;
						$data->game_id = $game_id;
						$data->turn_number = $game->turn_number;
						$data->sent_turn = $game->turn_number;
						$data->player_id = $row->id;
						$data->unit_id = $unit->id;
						$data->message = "Sir, there are unconfirmed reports that $message";
						$data->letter_icon = rand(1,6);
					$this->db->insert('game_message',$data);
				}
				$distance = (int) (800 / $game->ground_scale);
				echo "Unit ".$unit->name." breaks in shameful panic - they must run away a total of $distance inches immediately, facing away from the enemy, and in a state of general disorder.<p>";
				break;
			}

		}

		// All good, bump the game to the next phase
		$this->db->query("update game set phase=3 where id=$game_id");
	}


}


