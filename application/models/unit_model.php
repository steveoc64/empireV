<?php

define ('TYPE_ARMY',		1);
define ('TYPE_CORPS',		2);
define ('TYPE_WING',		3);
define ('TYPE_DIVISION',	4);
define ('TYPE_BRIGADE',		5);
define ('TYPE_CAV_BRIGADE',	6);
define ('TYPE_BATTALION',	10);
define ('TYPE_SQUADRON',	11);
define ('TYPE_BATTERY',		12);
define ('COLOR_1','#318f2f');
define ('COLOR_2','#655d19');
define ('COLOR_3','#856d19');
define ('COLOR_4','#d95717');
define ('COLOR_5','#ff3000');
define ('COLOR_6','#ff0000');

Class Unit_model extends CI_Model {

	function get($id, $game_id=0) {

		$unit_data = $this->db->get_where('unit', array('id' => $id))->row();
		if (!$unit_data) {
			return null;
		}
		$unit_data->game_id = $game_id;

		$unit_data->inspiration_descr = '<font color='.COLOR_3.'>Lacking appropriate class.</font>';
		$unit_data->skill_descr = '<font color='.COLOR_3.'>Not quite staff material.</font>';
		$unit_data->doctrine_descr = '<font color='.COLOR_3.'>As instructed by Commander.</font>';
		$unit_data->drill_descr = '<font color='.COLOR_3.'>As instructed by Commander.</font>';
		switch($unit_data->unit_type) {
		case TYPE_ARMY:
			$unit_data->army = $this->db->get_where('unit_army', array('id' => $unit_data->type_id))->row();
			$unit_data->inspiration_descr = $this->db->get_where('inspiration',array('id'=>$unit_data->army->inspiration))->row()->name;
			$unit_data->skill_descr = $this->db->get_where('professional_skill',array('id'=>$unit_data->army->professional_skill))->row()->name;
			$unit_data->doctrine_descr = $this->db->get_where('doctrine',array('id'=>$unit_data->army->doctrine))->row()->name;
			break;
		case TYPE_CORPS:
		case TYPE_WING:
			$unit_data->corps = $this->db->get_where('unit_corps', array('id' => $unit_data->type_id))->row();
			$unit_data->inspiration_descr = $this->db->get_where('inspiration',array('id'=>$unit_data->corps->inspiration))->row()->name;
			$unit_data->skill_descr = $this->db->get_where('professional_skill',array('id'=>$unit_data->corps->professional_skill))->row()->name;
			$unit_data->doctrine_descr = $this->db->get_where('doctrine',array('id'=>$unit_data->corps->doctrine))->row()->name;
			break;
		case TYPE_DIVISION:
			$unit_data->division = $this->db->get_where('unit_division', array('id' => $unit_data->type_id))->row();
			$unit_data->inspiration_descr = $this->db->get_where('inspiration',array('id'=>$unit_data->division->inspiration))->row()->name;
			$unit_data->skill_descr = $this->db->get_where('professional_skill',array('id'=>$unit_data->division->professional_skill))->row()->name;
			$unit_data->doctrine_descr = $this->db->get_where('doctrine',array('id'=>$unit_data->division->doctrine))->row()->name;
			break;
		case TYPE_BRIGADE:
			$unit_data->brigade = $this->db->get_where('unit_brigade', array('id' => $unit_data->type_id))->row();
			$unit_data->inspiration_descr = $this->db->get_where('inspiration',array('id'=>$unit_data->brigade->inspiration))->row()->name;
			$unit_data->drill_descr = $this->db->get_where('drill_type',array('id'=>$unit_data->brigade->drill))->row()->name;
			break;
		case TYPE_CAV_BRIGADE:
			$unit_data->cavbrigade = $this->db->get_where('unit_cavbrigade', array('id' => $unit_data->type_id))->row();
			$unit_data->inspiration_descr = $this->db->get_where('inspiration',array('id'=>$unit_data->cavbrigade->inspiration))->row()->name;
			break;
		case TYPE_BATTALION:
			$unit_data->battalion = $this->db->get_where('unit_battalion', array('id' => $unit_data->type_id))->row();
			break;
		case TYPE_SQUADRON:
			$unit_data->squadron = $this->db->get_where('unit_squadron', array('id' => $unit_data->type_id))->row();
			break;
		case TYPE_BATTERY:
			$unit_data->battery = $this->db->get_where('unit_battery', array('id' => $unit_data->type_id))->row();
			break;
		}

		$unit_data->current_morale_state = $unit_data->morale_state;
		$unit_data->current_fatigue = $unit_data->fatigue;
		$unit_data->current_disorder = $unit_data->disorder;
		if ($game_id) {
			// We are in a game, so dig deeper into the data to get the current status
			// of the unit for the current game turn
			$unit_data->stats = $this->db->get_where('game_unit_stats', array('game_id' => $game_id, 'unit_id' => $unit_data->id))->row();
			$game_data = $this->db->get_where('game', array('id' => $game_id))->row();
			$unit_data->current_morale_state = $unit_data->stats->morale_state;
			$unit_data->current_fatigue = $unit_data->stats->fatigue;
			$unit_data->current_disorder = $unit_data->stats->disorder;
			$hour = $game_data->start_hour + $game_data->turn_number -1;
			$unit_data->hrs = sprintf("%02d:00hrs", $hour);
			$unit_data->start_hour = $game_data->start_hour;

			// get the unit's current orders for this game turn
			$query = $this->db->query("select turn_number,activate_turn,player_name,order_type,objective,comments from game_order where game_id=$game_id and unit_id=$id and activate_turn > 0 order by activate_turn desc");
			$unit_data->orders = array();
			foreach ($query->result() as $row) {
				$unit_data->orders[] = $row;
				if ($row->activate_turn <= $game_data->turn_number) {
					$unit_data->current_order = $row;
					$unit_data->current_order_type = $this->db->get_where('order_types',array('id'=>$row->order_type))->row()->name;
				}
			}

		} else {
			$unit_data->stats = null;
			$game_data = null;
			$unit_data->current_morale_state = 1;
			$unit_data->current_fatigue = 0;
			$unit_data->current_disorder = 0;
		}

		// decode some elements
		if ($unit_data->unit_type >= TYPE_BATTALION) {
			$unit_data->morale_grade_descr = $this->db->get_where('morale_grade',array('id'=>$unit_data->morale_grade))->row()->name;
			$unit_data->small_arms_descr = $this->db->get_where('morale_grade',array('id'=>$unit_data->small_arms))->row()->name;
		}
		$msd = $this->db->get_where('morale_states',array('id'=>$unit_data->current_morale_state))->row()->name;
		switch($unit_data->current_morale_state) {
		case 1: $unit_data->morale_state_descr = "<font color=".COLOR_1.">$msd</font>"; break;
		case 2: $unit_data->morale_state_descr = "<font color=".COLOR_3.">$msd</font>"; break;
		case 3: $unit_data->morale_state_descr = "<font color=".COLOR_5.">$msd</font>"; break;
		case 4: $unit_data->morale_state_descr = "<font color=".COLOR_6."><b>$msd</b></font>"; break;
		}

		$fatigue = (int)$unit_data->current_fatigue;
		if ($fatigue == 0) {
			$unit_data->fatigue_descr = '<font color='.COLOR_1.'>The men are Fresh and full of Vigor.</font>';
		} elseif ($fatigue < 3) {
			$unit_data->fatigue_descr = '<font color='.COLOR_2.'>The men are Fit and ready for Battle.</font>';
		} elseif ($fatigue < 5) {
			$unit_data->fatigue_descr = '<font color='.COLOR_3.'>The men are Tiring.</font>';
		} elseif ($fatigue < 8) {
			$unit_data->fatigue_descr = '<font color='.COLOR_4.'>The men are nearing Exhaustion.</font>';
		} elseif ($fatigue < 10) {
			$unit_data->fatigue_descr = '<font color='.COLOR_5.'>The men Must Rest !.</font>';
		} elseif ($fatigue < 20) {
			$unit_data->fatigue_descr = '<font color='.COLOR_6.'>The men are Dead Tired, and no longer fit for battle.</font>';
		} else {
			$unit_data->fatigue_descr = '<font color='.COLOR_5.'><b>All is lost! the men are dropping from exhaustion.</b></font>';
		}

		// Pre calculate some derived values for convenience
		$unit_data->percent_lost = 0;
		$unit_data->percent_lost_this_hour = 0;
		$unit_data->current_strength = $unit_data->strength;
		if ($unit_data->stats) {
		     if  ($unit_data->stats->initial_strength > 0) {
			$unit_data->percent_lost = (100.0 * $unit_data->stats->casualties) / $unit_data->stats->initial_strength;
			$unit_data->percent_lost_this_hour = (100.0 * $unit_data->stats->casualties_this_hour) / $unit_data->stats->initial_strength;
		     }
		     $unit_data->current_strength = $unit_data->stats->initial_strength - $unit_data->stats->casualties;
		}

		// Get the game scale, and work out number of figures / bases
		$unit_data->scale = 60;
		if ($game_data) {
			$unit_data->scale = (int) $game_data->figure_scale;
			if ($unit_data->scale < 2) {
				$unit_data->scale = 60;
			}
		}

		// Work out the original number of bases depending on the game scale in use
		// If no game in in progress, use the default Empire scaling of 1:60
		switch($unit_data->unit_type) {
		case TYPE_BATTALION:
			$unit_data->initial_num_figures = (int) ($unit_data->strength / $unit_data->scale);
			$unit_data->initial_num_bases = (int) (($unit_data->initial_num_figures + 2) / 3);
			break;
		case TYPE_SQUADRON:
			$unit_data->initial_num_figures = (int) ($unit_data->strength / $unit_data->scale);
			$unit_data->initial_num_bases = (int) (($unit_data->initial_num_figures + 1) / 2);
			break;
		case TYPE_BATTERY:
			$unit_data->initial_num_figures = (int) $unit_data->battery->gun_models;
			$unit_data->initial_num_bases = $unit_data->initial_num_figures;
			break;
		default:
			$unit_data->initial_num_bases = $unit_data->initial_num_figures = 1;
		}


		// Get the game scale, and work out number of figures / bases
		if ($game_data) {
			switch($unit_data->unit_type) {
			case TYPE_BATTALION:
				$unit_data->num_figures = (int) ($unit_data->current_strength / $unit_data->scale);
				$unit_data->num_bases = (int) (($unit_data->num_figures + 2) / 3);
				break;
			case TYPE_SQUADRON:
				$unit_data->num_figures = (int) ($unit_data->current_strength / $unit_data->scale);
				$unit_data->num_bases = (int) (($unit_data->num_figures + 1) / 2);
				break;
			case TYPE_BATTERY:
				$crew = $unit_data->battery->crew_figures;
				if (!$crew) { $crew = 3; }
				$unit_data->num_figures = (int) $unit_data->current_strength;
				$unit_data->num_bases = $unit_data->num_figures / $crew;
				break;
			default:
				$unit_data->num_bases = $unit_data->num_figures = 1;
			}

		}


		return $unit_data;
	}

	function kills ($id, $kills) {

		$unit_data = $this->db->get_where('unit', array('id' => $id))->row();

		switch($unit_data->unit_type) {
		case 1:
		case 2:
		case 3:
		case 4:
		case 5:
		case 6:
		case 10:
			$this->db->query("update unit_battalion set casualties=casualties+'$kills' where id=$unit_data->type_id");
			break;
		case 11:
		case 12:
		}

		// Add an extra fatigue point to anyone that takes casualties
		$this->db->query("update unit set fatigue=fatigue+1 where id=$id");
	}

	function disorder ($id,$amount) {

		$unit_data = $this->db->get_where('unit', array('id' => $id))->row();
		$new_disorder = $unit_data->disorder + $amount;
		if ($new_disorder < 0) {
			$new_disorder = 0;
		} 
		if ($new_disorder > 75) {
			$new_disorder = 75;
		}
		$this->db->query("update unit set disorder=$new_disorder where id=$id");
	}

	function bad_morale ($id) {

		$unit_data = $this->db->get_where('unit', array('id' => $id))->row();
		$new_morale = $unit_data->morale_state + 1;
		if ($new_morale > 4) {
			$new_morale = 4;
		} 
		$this->db->query("update unit set morale_state=$new_morale where id=$id");
		$this->disorder($id,50);
	}

	function is_shaken ($game_id,$turn_number,$unit) {
		if (is_object($unit) && isset($unit->id)) {
			// Just add a fatigue point, and add a random amount of disorder to the unit
			// between 10-60% disorder 
			$d = rand(10,60);
			// Lets be nasty and allow a few of them to run away as well
			$c = rand(10,100);
			$this->db->query("update game_unit_stats set fatigue=fatigue+1,disorder=disorder+$d,morale_state=2,casualties=casualties+$c,casualties_this_hour=casualties_this_hour+$c,fled=fled+$c where game_id=".$game_id." and unit_id=".$unit->id);
			$this->cap_max($game_id,$unit->id);
			
			// Create a change of morale event
			$data = new stdClass;
				$data->game_id = $game_id;
				$data->turn_number = $turn_number;
				$data->unit_id = $unit->id;
				$data->event_type = 23;
				$data->value = 2;
				$data->descr = "Unit is shaken. Dozens of men have fled the ranks in fear.";
			$this->db->insert('game_event',$data);
		}
	}

	function is_retreating ($game_id,$turn_number,$unit) {
		if (is_object($unit) && isset($unit->id)) {
			// Just add 2 fatigue points, and add a random amount of disorder to the unit
			// between 30-90% disorder 
			$d = rand(30,90);
			// Lets be nasty and allow some of them to run away as well
			$c = rand(20,200);
			$this->db->query("update game_unit_stats set fatigue=fatigue+2,disorder=disorder+$d,morale_state=3,casualties=casualties+$c,casualties_this_hour=casualties_this_hour+$c,fled=fled+$c where game_id=".$game_id." and unit_id=".$unit->id);
			$this->cap_max($game_id,$unit->id);
			
			// Create a change of morale event
			$data = new stdClass;
				$data->game_id = $game_id;
				$data->turn_number = $turn_number;
				$data->unit_id = $unit->id;
				$data->event_type = 23;
				$data->value = 3;
				$data->descr = "Unit is in retreat. Scores of cowards have left the ranks in shame.";
			$this->db->insert('game_event',$data);
				
			// Create a Disgrace event
				$data->event_type = 22;
				$data->descr = "In disgrace for retreating without orders";
			$this->db->insert('game_event',$data);
		}
	}

	function is_broken ($game_id,$turn_number,$unit) {
		if (is_object($unit) && isset($unit->id)) {
			// Just add 6 fatigue points, and add a random amount of disorder to the unit
			// between 50-100% disorder 
			$d = rand(50,100);
			// Lets be nasty and allow lots of them to run away as well
			$c = rand(100,400);
			$this->db->query("update game_unit_stats set fatigue=fatigue+6,disorder=disorder+$d,morale_state=4,casualties=casualties+$c,casualties_this_hour=casualties_this_hour+$c,fled=fled+$c where game_id=".$game_id." and unit_id=".$unit->id);
			// Any unlimbered artillery in this unit abandon their guns - the utter cowards !
			$this->db->query("update game_unit_stats set guns_abandoned='T' where is_limbered='F' and game_id=".$game_id." and unit_id=".$unit->id);
			$this->cap_max($game_id,$unit->id);
	
			// Create a change of morale event
			$data = new stdClass;
				$data->game_id = $game_id;
				$data->turn_number = $turn_number;
				$data->unit_id = $unit->id;
				$data->event_type = 23;
				$data->value = 4;
				$data->descr = "Unit has broken. Great droves of the scoundrels have deserted the colours in disgrace.";
			$this->db->insert('game_event',$data);
				
			// Create a Disgrace event
				$data->event_type = 22;
				$data->descr = "In utter disgrace for having fallen apart in battle";
			$this->db->insert('game_event',$data);

		}
	}

	function cap_max($game_id,$unit_id) {
		$this->db->query("update game_unit_stats set casualties=initial_strength where game_id=".$game_id." and unit_id=".$unit_id." and casualties > initial_strength");
		$this->db->query("update game_unit_stats set casualties_this_hour=initial_strength where game_id=".$game_id." and unit_id=".$unit_id." and casualties_this_hour > initial_strength");
		$this->db->query("update game_unit_stats set fatigue=breakpoint where game_id=".$game_id." and unit_id=".$unit_id." and fatigue > breakpoint");
		$this->db->query("update game_unit_stats set fled=initial_strength where game_id=".$game_id." and unit_id=".$unit_id." and fled > initial_strength");
		$this->db->query("update game_unit_stats set disorder=100 where game_id=".$game_id." and unit_id=".$unit_id." and disorder > 100");
	}



}
