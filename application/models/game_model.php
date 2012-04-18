<?php

define ('PHASE_ORDERS',1);
define ('PHASE_ME_DET',2);
define ('PHASE_ME_MORALE',3);
define ('PHASE_LEADER_ATTACH',4);
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

	function yards_to_inches ($yards) {
		if ($this->id) {
			if (!$this->ground_scale) {
				$this->ground_scale = 40;	// Default 40 yards to the inch in Empire
			}
			return (int)($yards / $this->ground_scale);
		}
		return 0;
	}

	function troops_to_figures ($troops) {
		if ($this->id) {
			if (!$this->figure_scale) {
				$this->figure_scale = 60;	// Default 60 troops to the figure
			}
			return (int)($troops / $this->figure_scale);
		}
		return 0;
	}

	function troops_to_bases ($troops) {
		if ($this->id) {
			if (!$this->infantry_base) {
				$this->infantry_base = 3;	// Default 3 infantry figs to a base
			}
			$figs = $this->troops_to_figures($troops);
			return (int)($figs / $this->infantry_base);
		}
		return 0;
	}

	function horses_to_bases ($horses) {
		if ($this->id) {
			if (!$this->cavalry_base) {
				$this->cavalry_base = 2;	// Default 2 horsey figs to a base
			}
			$figs = $this->troops_to_figures($horses);
			return (int)($figs / $this->cavalry_base);
		}
		return 0;
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
		$game = $this->db->get_where('game',array('id' => $game_id))->row();
		if (!$game) {
			return null;
		}
		// The user is in a game, and we found the game, so fill in this object
		// (longhand hack, till I find an elegant way that works the way I want it to)
		$this->user = $user_data;
		$this->id = $game->id;
			$this->name = $game->name;
			$this->scenario_id = $game->scenario_id;
			$this->playing = $game->playing;
			$this->turn_number = $game->turn_number;
			$this->start_hour = $game->start_hour;
			$this->phase = $game->phase;
			$this->orbat_attacker = $game->orbat_attacker;
			$this->orbat_defender = $game->orbat_defender;
			$this->situation = $game->situation;
			$this->attacker_briefing = $game->attacker_briefing;
			$this->defender_briefing = $game->defender_briefing;
			$this->latitude = $game->latitude;
			$this->longitude = $game->longitude;
			$this->ground_scale = $game->ground_scale;
			$this->figure_scale = $game->figure_scale;
			$this->infantry_base = $game->infantry_base;
			$this->cavalry_base = $game->cavalry_base;
			$this->video_intro = $game->video_intro;
			$this->rain_factor = $game->rain_factor;
		if ($this->ground_scale == 0) { $this->ground_scale = 40; }	// Empire default
		if ($this->figure_scale == 0) { $this->figure_scale = 60; }	// Empire default
		if ($this->infantry_base == 0) { $this->infantry_base = 3; }	// Empire default
		if ($this->cavalry_base == 0) { $this->cavalry_base = 2; }	// Empire default

		// load the national theme into the game array
		$theme = (int)$this->user->national_theme;
		if (!$theme) {
			$theme = 1;
		}
		$row = $this->db->get_where('national_theme',array('id'=>$theme))->row();
		if ($row) {
			$this->national_theme = $row;
		} else {
			$this->national_theme = null;
		}

		if (!$full_details) {
			return $game;
		}

		// We have a game, so accumulate some details into the return value
		if ($this->user->commander_id) {
			$this->unit_id_range = $this->get_unit_id_range($this->user->commander_id);
			$this->unit_where_range = "(unit.id >= ".$this->unit_id_range->start_id." and unit.id <= ".$this->unit_id_range->end_id.")";
			// Get a list of the top level commands, and their current orders
			$this->me = $this->get_me_list($game_id,$this->unit_id_range->start_id,$this->unit_id_range->end_id);
		} else {
			$this->unit_id_range = new stdClass;
			$this->unit_id_range->start_id = $this->unit_id_range->end_id = 0;
			$this->unit_where_range = '';
		}

		// Get the weather details in a nice format
		$this->game_turn = $this->db->get_where('game_turn',array('game_id'=>$game_id,'turn_number'=>$this->turn_number))->row();
		if ((int)$this->game_turn->wind_speed) {
			$wind_dir = $this->db->get_where('direction',array('id'=>$this->game_turn->wind_direction))->row();
			$wind = sprintf("%dkm/h %s winds", $this->game_turn->wind_speed,$wind_dir->name);
		} else {
			$wind = 'No wind';
		}
		if ((int)$this->game_turn->rain) {
			$rain = sprintf("%dmm rain", $this->game_turn->rain);
		} else {
			$rain = 'Dry';
		}
	
		$vinches = $this->yards_to_inches($this->game_turn->visibility);
		$this->weather_report = sprintf("%s %dC %s, %s, gound condition %d, visibility %dyd ($vinches inches)",
			$this->game_turn->weather_conditions,
			$this->game_turn->temperature,
			$wind, $rain,
			$this->game_turn->ground_conditions,
			$this->game_turn->visibility);

		// Get the hour in a nice format
		$this->hour = $this->start_hour + $this->turn_number -1;
		$this->day = 1;
		while ($this->hour > 24) {
			$this->hour -= 24;
			$this->day ++;
		}
		$this->hrs = sprintf("Day %d ~ %02d:00hrs", $this->day, $this->hour);

		return $this;
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
			// Army level ?
			$last_id = $row->last_child;
			$row = $this->db->query("select max(id) as last_child from unit where parent_id=".$row->last_child)->row();
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
			} // add an extra army level above corps

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
		$me_unit->me_subunit = array();
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
			$me_unit->avg_morale = 7;
			echo "<hr><font color=red>WARNING: ME Unit ".$me_unit->id." - ".$me_unit->name." has no subunits .. that wont work very well.<p>You really should fix the ORBAT file for this unit, or turn off the 'is ME' flag for this unit.</font><p>First deselect the current game from the <a href=".site_url()."game target=_blank>Game List</a>, and then Click <a href=".site_url()."units/index/edit/".$me_unit->id.">HERE</a> to fix this unit.<p>In the meantime, I am going to have to treat this unit as Conscript morale grade for Average ME morale. So the ME wont last long on the battlefield until the data is fixed :)<hr>";
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
		if (!$this->id) {
			die ("No game selected ... ?????");
		}
		
		// Check that we are the first phase (allowing orders to be set)
		$phase = (int) $this->phase;
		if ($phase > 1) {
			die ("We are already in phase $phase of game $game_id .. cannot close orders");
		}

		// on Turn 1, skip morale tests and go straight to phase 4
		$turn = (int) $this->turn_number;
		$next_phase = 2;
		if ($turn == 1) {
			$next_phase = 4;
		}
		
		// All good, bump the game to the next phase
		$this->db->query("update game set phase=$next_phase where id=".$this->id);
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
					if ($unit->stats->morale_state >= 4) {
						echo "<li><font color=#880000>Unit : [".$unit->id."] - ".$unit->name." is already BROKEN</font>";
						$distance = $this->yards_to_inches(640);
						echo "<ul><b><font color=#880000>Unit must fall back 640 yds ($distance inches)</font></b></ul>";
					} elseif ($unit->percent_lost >= 20) {
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
								echo "<ul><font color=#880000>All units in this ME fall back 640 yds ($distance inches)</font></ul>";
								$result = 4;
							} elseif ($dieroll <= $r) {
								echo "<li>The whole ME is in RETREAT";
								$distance = $this->yards_to_inches(640);
								echo "<ul><font color=#880000>All units in this ME fall back 640 yds ($distance inches)</font>";
								echo "<li>Formed enemy cavalry within engagement range may choose to pin the unit in place.";
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
		$game_id = (int)$this->id;
		if (!$game_id) {
			die ("No game selected ... ?????");
		}
		
		// Check that we are the first phase (allowing orders to be set)
		$phase = (int) $this->phase;
		if ($phase != 2) {
			die ("We are in phase $phase of game $game_id .. need to be in phase 2 to accept ME determination test");
		}

		// for each me determination test result in this turn ... apply it
		$query = $this->db->get_where('game_me_det',array('game_id'=>$game_id,'turn_number'=>$this->turn_number));
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
				$this->unit_model->is_shaken($game_id,$this->turn_number,$unit);
				$this->get_me_subunits($game_id,$unit);
				if ($unit->me_subunit) {
				foreach ($unit->me_subunit as $subunit) {
					$this->unit_model->is_shaken($game_id,$this->turn_number,$subunit);
				}
				}
				$message = "the officers and men of ".$unit->name." are shamefully losing confidence !";
				// Now - send an immediate message to all players that this ME is losing confidence
				$query = $this->db->query("select id,username from user where current_game=$game_id");
				foreach ($query->result() as $row) {
					$data = new stdClass;
						$data->game_id = $game_id;
						$data->turn_number = $this->turn_number;
						$data->sent_turn = $this->turn_number;
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
				$this->unit_model->is_retreating($game_id,$this->turn_number,$unit);
				$this->get_me_subunits($game_id,$unit);
				if ($unit->me_subunit) {
				foreach ($unit->me_subunit as $subunit) {
					$this->unit_model->is_retreating($game_id,$this->turn_number,$unit);
				}
				}
				// Now - send an immediate message to all players that this ME is in retreat
				$message = "Sir, we have astounding news that ".$unit->name." are in cowardly retreat !";
				$query = $this->db->query("select id from user where current_game=$game_id");
				foreach ($query->result() as $row) {
					$data = new stdClass;
						$data->game_id = $game_id;
						$data->turn_number = $this->turn_number;
						$data->sent_turn = $this->turn_number;
						$data->player_id = $row->id;
						$data->message = $message;
						$data->unit_id = $unit->id;
						$data->letter_icon = rand(1,6);
					$this->db->insert('game_message',$data);
				}
				$distance = $this->yards_to_inches(640);
				echo "The officers and men of ".$unit->name." are in retreat - they must fall back $distance inches immediately.<p>";
				echo "TODO: If any subunits of that ME are within engagement range of formed enemy cavalry, the owner of the cavalry may demand that retreating infantry units be pinned - which will cost the pinned unit an extra 2 fatigue points.<p>";
				break;
			case 4:
				// they are broken - set all units in the ME to retreat
				$unit = $this->unit_model->get($row->unit_id,$game_id);
				$this->unit_model->is_broken($game_id,$this->turn_number,$unit);
				$this->get_me_subunits($game_id,$unit);
				if ($unit->me_subunit) {
				foreach ($unit->me_subunit as $subunit) {
					$this->unit_model->is_broken($game_id,$this->turn_number,$unit);
				}
				}
				// Now - send an immediate message to all players that this ME is in retreat
				$message = "Sir, there are unconfirmed reports that ".$unit->name." may well have broken in disgraceful panic !";
				$query = $this->db->query("select id from user where current_game=$game_id");
				foreach ($query->result() as $row) {
					$data = new stdClass;
						$data->game_id = $game_id;
						$data->turn_number = $this->turn_number;
						$data->sent_turn = $this->turn_number;
						$data->player_id = $row->id;
						$data->unit_id = $unit->id;
						$data->message = $message;
						$data->letter_icon = rand(1,6);
					$this->db->insert('game_message',$data);
				}
				$distance = $this->yards_to_inches(640);
				echo "Unit ".$unit->name." breaks in shameful panic - they must run away a total of $distance inches immediately, facing away from the enemy, and in a state of general disorder.<p>";
				break;
			}

		}

		// All good, bump the game to the next phase
		$this->db->query("update game set phase=3 where id=$game_id");
	}

	function morale_test_form() {
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
		if ($phase != 3) {
			die ("We are in phase $phase of game $game_id .. need to be in phase 3 to run morale tests");
		}

		if ($game->turn_number == 1) {
			die ("No need to check Morale on turn 1 - that would be a terrible thing if troops failed before the game starts");
		} 

		$distance = $this->yards_to_inches(400);
		echo "<i>NOTE: Testing Proximity = $distance inches at 1\"=".$game->ground_scale."yds current game scale</i><p>";

		echo "<b><u>Players and their units</u></b>";
		echo form_open(site_url()."umpire_console/do_morale_test");
		echo "<table width=100% border=1>";
		$query = $this->db->get_where('user',array('current_game'=>$game_id));
		foreach ($query->result() as $row) {
			// For each user in this game - get their commander ID
			if ($row->commander_id != 0) {
				echo "<tr><td colspan=8><b>Player $row->username in command of unit [".$row->commander_id."]</td></tr>";
				echo "<tr><td>ID</td><td>ME Name</td><td>Orders</td><td>Tests</td><td>Grade</td><td>Current State</td><td>Losses<br>(This Hour)</td></tr>";
				$range = $this->get_unit_id_range($row->commander_id);
				$me_list = $this->get_me_list($game_id,$range->start_id,$range->end_id);
				foreach ($me_list as $me_unit) {
				if ($me_unit->stats->player_id == $row->id) { // not all MEs under this commander belong to the same player

					$exempt = false;
					$highlight = '';

					$_ = $this->db->query("select count(*) as count from game_me_det where game_id=$game_id and unit_id=".$me_unit->id." and turn_number=".$game->turn_number." and result >= 2")->row();
					if ($_->count > 0) {
						$exempt = true;
						$highlight = ' bgcolor=#ff8888';
					}
					// If they are already broken, they dont need to test
					if ($me_unit->stats->morale_state >= 4) {
						$exempt = true;
					}

					echo "<tr$highlight><td>".$me_unit->id."</td><td>".$me_unit->name."</td>";
					if ($me_unit->current_order->order_type == 9) {
						$exempt = true;
						echo "<td><font color=red>".$me_unit->current_order_type."</font></td>";
					} else {
						echo "<td>".$me_unit->current_order_type."</td>";
					}
					// Add test checkboxen - unless they were affected by an ME det failure
					echo "<td>";
					if ($exempt) {
						echo "<font color=red>Exempt</font>";
					} else {
						echo form_checkbox($me_unit->id,'Retreated into');
					}
					echo "</td>";

					echo "<td>".$me_unit->avg_morale_name."</td>";
					echo "<td>".$me_unit->morale_state_descr."</td>";
					if ($me_unit->percent_lost) {
						echo "<td>".$me_unit->percent_lost."% (".$me_unit->percent_lost_this_hour."%)</td></tr>";
					} else {
						echo "<td></td></tr>";
					}
				} // that belongs to this player
				} // foreach ME under this commander

			}
		}
		echo "</table>";
		echo form_close();
	}

	function morale_test() {
		$units = $this->input->post('units');
		if (!$units) {
			die ("No units selected for morale test ...");
		}
		
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
		if ($phase != 3) {
			die ("We are in phase $phase of game $game_id .. need to be in phase 3 to run morale tests");
		}

		if ($game->turn_number == 1) {
			die ("No need to check Morale on turn 1 - that would be a terrible thing if troops failed before the game starts");
		} 

		$this->load->model('unit_model');
		$i = 0;
		foreach ($units as $unit_id) {
			$unit = $this->unit_model->get($unit_id,$game_id);
			if ($unit->is_me == 'T') {
				if ($i) {
					echo "<hr>";
				}
				$i++;

				$this->get_me_subunits($game_id,$unit);
				// Morale breaks for ME morale test - pp 47 of EmpireV rulebook
				switch ($unit->avg_morale) {
				case 1: // OldGuard
				case 2: // Guard
					$s=3; $b=-1; $grp='I';
					break;
				case 3: // Grenadiers
				case 4: // Elites
					$s=9; $b=-3; $grp='II';
					break;
				case 5: // Crack Line
				case 6: // Veterans
					$s=19; $b=-6; $grp='III';
					break;
				case 7: // Conscripts
				case 8: // Landwehr
					$s=38; $b=-15; $grp='IV';
					break;
				case 9: // Trained Militia
					$s=48; $b=-29; $grp='V';
					break;
				case 10: // Untrained rabble
					$s=68; $b=-45; $grp='VI';
					break;
				}
				echo "Unit [$unit_id] ".$unit->name." of Avg Morale: ".$unit->avg_morale_name." ($grp)<br>";
				$dieroll = d100();
				echo "<i>dieroll = $dieroll</i>: ";
				if ($dieroll <= $b) {
					echo "<font color=red>BROKEN</font><br>";
					$this->unit_model->is_broken($game_id,$game->turn_number,$unit);
					if ($unit->me_subunit) {
					foreach ($unit->me_subunit as $sub) {
						$this->unit_model->is_broken($game_id,$game->turn_number,$sub);
					}
					}
					switch ($unit->unit_type) {
					case TYPE_DIVISION:
						$message = "From Division [".$unit->id."] Commander ".$unit->division->commander."<br>";
						break;
					case TYPE_BRIGADE:
						$message = "From Brigade [".$unit->id."] Commander ".$unit->brigade->commander."<br>";
						break;
					default:
						$message = '';
						break;
					}
					$message .= "Terrible rumours suggest that ".$unit->name." may have broken, and are fleeing for their lives.";
					$data = new stdClass;
						$data->game_id = $game_id;
						$data->turn_number = $game->turn_number + 1;
						$data->player_id = $unit->stats->player_id;
						$data->unit_id = $unit->id;
						$data->sent_turn = $game->turn_number;
						$data->message = $message;
						$data->letter_icon = rand(1,6);
					$this->db->insert('game_message',$data);

				} elseif ($dieroll <= $s) {
					echo "<font color=orange>SHAKEN</font><br>";
					$this->unit_model->is_shaken($game_id,$game->turn_number,$unit);
					if ($unit->me_subunit) {
					foreach ($unit->me_subunit as $sub) {
						$this->unit_model->is_shaken($game_id,$game->turn_number,$sub);
					}
					}
					switch ($unit->unit_type) {
					case TYPE_DIVISION:
						$message = "From Division [".$unit->id."] Commander ".$unit->division->commander."<br>";
						break;
					case TYPE_BRIGADE:
						$message = "From Brigade [".$unit->id."] Commander ".$unit->brigade->commander."<br>";
						break;
					default:
						$message = '';
						break;
					}
					$message .= "The junior officers of ".$unit->name." are losing confidence, and may disgrace the good name of the regiment before long. Stern measures are being undertaken to stop the rot.";
					$data = new stdClass;
						$data->game_id = $game_id;
						$data->turn_number = $game->turn_number + 1;
						$data->player_id = $unit->stats->player_id;
						$data->unit_id = $unit->id;
						$data->sent_turn = $game->turn_number;
						$data->message = $message;
						$data->letter_icon = rand(1,6);
					$this->db->insert('game_message',$data);


				} else {
					echo "<font color=green>PASS</font><br>";
				}
			} else {
				die ("Unit $unit_id ".$unit->name." is not an ME");
			}
		}
		// print the morale check table
		echo "<table border=0 width=100%><tr bgcolor=#33cc33><td>Group I</td><td>3% to become shaken</td></tr>";
		echo "<tr bgcolor=#99ff33><td>Group II</td><td>9% to become shaken<br>3% to break</td></tr>";
		echo "<tr bgcolor=#ccff33><td>Group III</td><td>19% to become shaken<br>6% to break</td></tr>";
		echo "<tr bgcolor=#ffff00><td>Group IV</td><td>38% to become shaken<br>15% to break</td></tr>";
		echo "<tr bgcolor=#ff9900><td>Group V</td><td>48% to become shaken<br>29% to break</td></tr>";
		echo "<tr bgcolor=#cc3300><td>Group VI</td><td>68% to become shaken<br>45% to break</td></tr>";
		echo "</table>";
	}

	function morale_test_done() {
		if (!$this->id) {
			die ("No game selected ... ?????");
		}
		$game_id = (int)$this->id;
		
		// check that we are in the right phase
		$phase = (int) $this->phase;
		if ($phase != PHASE_ME_MORALE) {
			die ("We are already in phase $phase of game $game_id .. cannot close morale test");
		}

		// All good, bump the game to the next phase
		$this->db->query("update game set phase=4 where id=".$this->id);
	}

	function leader_attach_done() {
		if (!$this->id) {
			die ("no game selected ... ?????");
		}
		$game_id = (int)$this->id;
		
		// check that we are in the right phase
		$phase = (int) $this->phase;
		if ($phase != PHASE_LEADER_ATTACH) {
			die ("we are already in phase $phase of game $game_id .. cannot close leader attachments");
		}

		// all good, bump the game to the next phase
		$this->db->query("update game set phase=5 where id=".$this->id);
	}

	function declare_orders_done() {
		if (!$this->id) {
			die ("no game selected ... ?????");
		}
		$game_id = (int)$this->id;
		
		// check that we are in the right phase
		$phase = (int) $this->phase;
		if ($phase != PHASE_DECLARE_ORDERS) {
			die ("we are already in phase $phase of game $game_id .. cannot close leader attachments");
		}

		// all good, bump the game to the next phase
		$this->db->query("update game set phase=6 where id=".$this->id);
	}


	function activate_orders_done() {
		if (!$this->id) {
			die ("no game selected ... ?????");
		}
		$game_id = (int)$this->id;
		
		// check that we are in the right phase
		$phase = (int) $this->phase;
		if ($phase != PHASE_ACTIVATE_ORDERS) {
			die ("we are already in phase $phase of game $game_id .. cannot close leader attachments");
		}

		// all good, bump the game to the next phase
		$this->db->query("update game set phase=7 where id=".$this->id);
	}


	function get_briefing () {
		switch ($this->session->userdata('role')) {
		case 'A':
		case 'U':
			// Get both briefings for this game
			return '<h4>Situation</h4>'.$this->situation.'<hr><h4>Attacker Briefing :</h4>'.$this->attacker_briefing.'<hr><h4>Defender Briefing</h4>'.$this->defender_briefing;
			break;
		case 'P':
			// Are we attacker or defender ?
			$b = '';
			$got_briefing = false;
			$query = $this->db->get_where('orbat',array('id'=>$this->orbat_attacker));
			$commander_id = (int)$this->user->commander_id;
			foreach ($query->result() as $orbat) {
				$start = (int)$orbat->starting_id;
				$end = (int)$orbat->ending_id;
				if ($commander_id >= $start && $commander_id <= $end) {
					$b = $this->attacker_briefing;
					$got_briefing = true;
				}
			}
			if (!$got_briefing) {
				$query = $this->db->get_where('orbat',array('id'=>$this->orbat_defender));
				foreach ($query->result() as $orbat) {
					$start = (int)$orbat->starting_id;
					$end = (int)$orbat->ending_id;
					if ($commander_id >= $start && $commander_id <= $end) {
						$b = $this->defender_briefing;
						$got_briefing = true;
					}
				}
			}
			if (!$got_briefing) {
				echo "Commander = $commander_id<br>";
				return '<h4>Situation</h4>'.$this->situation.'<hr>The unit you are commanding in this game is in neither the attacker or the defender force ... no briefing possible';
			}

			return '<h4>Situation</h4>'.$this->situation.'<hr><h4>Briefing :</h4>'.$b;
			break;
		}
	}

	function breakoff_done() {
		if (!$this->id) {
			die ("No game selected ... ?????");
		}
		$game_id = (int)$this->id;
		
		// check that we are in the right phase
		$phase = (int) $this->phase;
		if ($phase != PHASE_BREAKOFF) {
			die ("We are already in phase $phase of game $game_id .. cannot close morale test");
		}

		// All good, bump the game to the next phase
		$this->db->query("update game set phase=8 where id=".$this->id);

	}

	function gt_done() {
		if (!$this->id) {
			die ("No game selected ... ?????");
		}
		$game_id = (int)$this->id;
		
		// check that we are in the right phase
		$phase = (int) $this->phase;
		if ($phase != PHASE_GT) {
			die ("We are already in phase $phase of game $game_id .. cannot close morale test");
		}

		// All good, bump the game to the next phase
		$this->db->query("update game set phase=9 where id=".$this->id);
	}

	function determine_bombardment_done() {
		if (!$this->id) {
			die ("No game selected ... ?????");
		}
		$game_id = (int)$this->id;
		
		// check that we are in the right phase
		$phase = (int) $this->phase;
		if ($phase != PHASE_DETERMINE_BOMBARDMENT) {
			die ("We are already in phase $phase of game $game_id .. cannot close morale test");
		}

		// All good, bump the game to the next phase
		$this->db->query("update game set phase=10 where id=".$this->id);
	}

	function engage_done() {
		if (!$this->id) {
			die ("No game selected ... ?????");
		}
		$game_id = (int)$this->id;
		
		// check that we are in the right phase
		$phase = (int) $this->phase;
		if ($phase != PHASE_ENGAGE) {
			die ("We are already in phase $phase of game $game_id .. cannot close morale test");
		}

		// All good, bump the game to the next phase
		$this->db->query("update game set phase=11 where id=".$this->id);
	}

	function commander_cas_done() {
		if (!$this->id) {
			die ("No game selected ... ?????");
		}
		$game_id = (int)$this->id;
		
		// check that we are in the right phase
		$phase = (int) $this->phase;
		if ($phase != PHASE_COMMANDER_CAS) {
			die ("We are already in phase $phase of game $game_id .. cannot close morale test");
		}

		// All good, bump the game to the next phase
		$this->db->query("update game set phase=12 where id=".$this->id);
	}

	function rally_done() {
		if (!$this->id) {
			die ("No game selected ... ?????");
		}
		$game_id = (int)$this->id;
		
		// check that we are in the right phase
		$phase = (int) $this->phase;
		if ($phase != PHASE_RALLY) {
			die ("We are already in phase $phase of game $game_id .. cannot close morale test");
		}

		// All good, bump the game to the next phase
		$this->db->query("update game set phase=13 where id=".$this->id);
	}

	function rest_done() {
		if (!$this->id) {
			die ("No game selected ... ?????");
		}
		$game_id = (int)$this->id;
		
		// check that we are in the right phase
		$phase = (int) $this->phase;
		if ($phase != PHASE_REST) {
			die ("We are already in phase $phase of game $game_id .. cannot close morale test");
		}

		// All good, bump the game to the next phase
		$this->db->query("update game set phase=14 where id=".$this->id);
	}

	function rewind() {
		if (!$this->id) {
			die ("No game selected ... ?????");
		}
		$game_id = (int)$this->id;
		
		// check that we are in the right phase
		$phase = (int) $this->phase;
		if ($phase <= PHASE_ME_MORALE) {
			die ("We cannot rewind from  phase $phase of game $game_id .. too late for that");
		}

		// All good, bump the game to the next phase
		$this->db->query("update game set phase=phase-1 where id=".$this->id);
	}


	function end_of_hour_done() {
		if (!$this->id) {
			die ("No game selected ... ?????");
		}
		$game_id = (int)$this->id;
		
		// check that we are in the right phase
		$phase = (int) $this->phase;
		if ($phase != PHASE_END_OF_HOUR) {
			die ("We are already in phase $phase of game $game_id .. cannot close morale test");
		}

		// Create a new game turn record
		$data = new stdClass;
			$data->game_id = $this->id;
			$data->turn_number = $this->turn_number + 1;
			$data->initiative = 1;
			$data->temperature = $this->game_turn->temperature + rand(-2,4);
			$data->wind_direction = $this->game_turn->wind_direction + rand(-1,1); 
			if ($data->wind_direction < 1) {
				$data->wind_direction = 1;
			}
			if ($data->wind_direction > 8) {
				$data->wind_direction = 8;
			}

			$data->wind_speed = $this->game_turn->wind_speed + rand(-2,2);
			if ($data->game_turn->wind_speed < 0) {
				$data->game_turn->wind_speed = 0;
			}
			// Calculate amount of rain using the rain factor in the game.
			// Note that if rain factor is 0, then it cannot rain at all in the game
			// tendency towards no rain, it may rain for a little for an hour or 2, but will tend to no rain
			if ($this->rain_factor) {
				$low_rain = (int)($this->rain_factor * -1) - 1;
				$hi_rain = (int)$this->rain_factor;
				$data->rain = $this->game_turn->rain + rand($low_rain,$hi_rain);
				if ($data->rain < 0) {
					$data->rain = 0;
				}
			} else {
				$this->rain = 0;
			}
			// Visibility generally gets worse as the battle continues, as smoke fills the area
			$data->visibility = $this->game_turn->visibility + rand(-50,40) - ($data->rain * 20);

			// calculate ground conditions depending on the last hours weather
			$data->ground_conditions = $this->game_turn->ground_conditions;
			if ($this->game_turn->rain > 2) {
				$data->ground_conditions++;
			} else {
				// No rain and warm - improve ground conditions
				if ($this->game_turn->temperature > 28) {
					$data->ground_conditions--;
				}
			}
			if ($data->ground_conditions < 1) {
				$data->ground_conditions = 1;
			}
			if ($data->ground_conditions > 10) {
				$data->ground_conditions = 10;
			}
		$this->db->insert('game_turn',$data);

		// All good, bump the game to the next phase
		$this->db->query("update game set phase=1,turn_number=turn_number+1 where id=".$this->id);

	}


}


