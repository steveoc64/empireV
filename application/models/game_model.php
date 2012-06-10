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

define ('OPEN_GROUND','#EDFFC0');
define ('LIGHT_WOODS','#C4FFC2');
define ('HEAVY_WOODS','#A8FF85');
define ('TOWNS','#D0B280');
define ('SWAMP','#5DD0B3');


function d100 () {
	return rand(1,100);
}

function d10 () {
	return rand(1,10);
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
	
	function __construct() {
		parent::__construct();

		// Get various lookup data
		$query = $this->db->get('order_types');
		$this->order_types = array();
		foreach ($query->result() as $row) {
			$this->order_types[] = $row;
		}
		$query = $this->db->get('professional_skill');
		$this->professional_skill = array();
		foreach ($query->result() as $row) {
			$this->professional_skill[] = $row;
		}
		$query = $this->db->get('doctrine');
		$this->doctrine = array();
		foreach ($query->result() as $row) {
			$this->doctrine[] = $row;
		}
		$query = $this->db->get('inspiration');
		$this->inspiration = array();
		foreach ($query->result() as $row) {
			$this->inspiration[] = $row;
		}
		$query = $this->db->get('drill_type');
		$this->drill = array();
		foreach ($query->result() as $row) {
			$this->drill[] = $row;
		}
		$query = $this->db->get('morale_states');
		$this->morale_state = array();
		foreach ($query->result() as $row) {
			$this->morale_state[] = $row;
		}
		$query = $this->db->get('morale_grade');
		$this->morale_grade = array();
		foreach ($query->result() as $row) {
			$this->morale_grade[] = $row;
		}

		$this->unit_cache = array();
	}

	function cache_all_units() {

		// Create a cache of units already
		$this->db->select('*');
		$this->db->from('game_unit_stats');
		$this->db->where('game_id',$this->id);
		$this->db->join('unit','unit.id=game_unit_stats.unit_id','left');
		$query = $this->db->get();
		foreach ($query->result() as $row)
		{
			$row->expanded = false;
			$this->unit_cache[] = $row;
		}
	}

	function cache_player_units($player_id) {

		// Create a cache of units already
		$this->db->select('*');
		$this->db->from('game_unit_stats');
		$this->db->where('game_id',$this->id);
		$this->db->where('player_id',$player_id);
		$this->db->join('unit','unit.id=game_unit_stats.unit_id','left');
		$query = $this->db->get();
		foreach ($query->result() as $row)
		{
			$row->expanded = false;
			$this->unit_cache[] = $row;
		}
	}


	function get_unit_cache($id) {

		foreach ($this->unit_cache as $_) {
			if ($_->id == $id) {
				//echo "$id is cached, expanded = ".$_->expanded."<br>\n";
				return $_;
			}
		}
		//echo "$id is not cached<br>\n";
		return null;
	}

	function get_unit($id) {

		$unit_data = $this->get_unit_cache($id);
		if (!$unit_data) {
			// Dont have this unit in the cache yet, so grab it from the database
			$this->db->select('*');
			$this->db->from('unit');
			$this->db->where('unit.id',$id);
			// CI backquoteing work-around !
			$this->db->join('game_unit_stats','game_unit_stats.game_id in('.$this->id.') and game_unit_stats.unit_id=unit.id','left');
			$unit_data = $this->db->get()->row();
			$unit_data->expanded = false;

			// Add it to the cache now, as an non-expanded record
			$this->unit_cache[] = $unit_data;
		}


		if (!$unit_data) {
			return null;
		}
		// If we have already gone through and expanded the unit details out, then return now, save us
		// doing a pile more lookups
		if ($unit_data->expanded) {
			return $unit_data;
		}
		$unit_data->game_id = $this->id;

		$unit_data->inspiration_descr = '<font color='.COLOR_3.'>Lacking appropriate class.</font>';
		$unit_data->skill_descr = '<font color='.COLOR_3.'>Not quite staff material.</font>';
		$unit_data->doctrine_descr = '<font color='.COLOR_3.'>As instructed by Commander.</font>';
		$unit_data->drill_descr = '<font color='.COLOR_3.'>As instructed by Commander.</font>';
		$unit_data->skill = null;
		$unit_data->doctrine = null;
		$unit_data->commander = null;
		$unit_data->undistinguished = false;

		switch($unit_data->unit_type) {
		case TYPE_ARMY:
			$unit_data->army = $this->db->get_where('unit_army', array('id' => $unit_data->type_id))->row();
			$unit_data->inspiration = $this->get_inspiration($unit_data->army->inspiration);
			$unit_data->skill = $this->get_professional_skill($unit_data->army->professional_skill);
			$unit_data->doctrine = $this->get_doctrine($unit_data->army->doctrine);
			$unit_data->commander = $unit_data->army->commander;
			break;
		case TYPE_CORPS:
		case TYPE_WING:
			$unit_data->corps = $this->db->get_where('unit_corps', array('id' => $unit_data->type_id))->row();
			$unit_data->inspiration = $this->get_inspiration($unit_data->corps->inspiration);
			$unit_data->skill = $this->get_professional_skill($unit_data->corps->professional_skill);
			$unit_data->doctrine = $this->get_doctrine($unit_data->corps->doctrine);
			$unit_data->commander = $unit_data->corps->commander;
			break;
		case TYPE_DIVISION:
			$unit_data->division = $this->db->get_where('unit_division', array('id' => $unit_data->type_id))->row();
			$unit_data->inspiration = $this->get_inspiration($unit_data->division->inspiration);
			$unit_data->skill = $this->get_professional_skill($unit_data->division->professional_skill);
			$unit_data->doctrine = $this->get_doctrine($unit_data->division->doctrine);
			$unit_data->commander = $unit_data->division->commander;
			break;
		case TYPE_BRIGADE:
			$unit_data->brigade = $this->db->get_where('unit_brigade', array('id' => $unit_data->type_id))->row();
			$unit_data->inspiration = $this->get_inspiration($unit_data->brigade->inspiration);
			$unit_data->commander = $unit_data->brigade->commander;
			break;
		case TYPE_CAV_BRIGADE:
			$unit_data->cavbrigade = $this->db->get_where('unit_cavbrigade', array('id' => $unit_data->type_id))->row();
			$unit_data->inspiration = $this->get_inspiration($unit_data->cavbrigade->inspiration);
			$unit_data->commander = $unit_data->cavbrigade->commander;
			break;
		case TYPE_BATTALION:
			$unit_data->battalion = $this->db->get_where('unit_battalion', array('id' => $unit_data->type_id))->row();
			break;
		case TYPE_SQUADRON:
			$unit_data->squadron = $this->db->get_where('unit_squadron', array('id' => $unit_data->type_id))->row();
			if ($unit_data->squadron->undistinguished == 'T') {
				$unit_data->undistinguished = true;
			}
			break;
		case TYPE_BATTERY:
			$unit_data->battery = $this->db->get_where('unit_battery', array('id' => $unit_data->type_id))->row();
			break;
		}

		$unit_data->current_morale_state = $unit_data->morale_state;
		$unit_data->current_fatigue = $unit_data->fatigue;
		$unit_data->current_disorder = $unit_data->disorder;
		
		// Dig deeper into the data to get the current status
		// of the unit for the current game turn
		//$unit_data = $this->db->get_where('game_unit_stats', array('game_id' => $this->id, 'unit_id' => $unit_data->id))->row();
		$unit_data->current_morale_state = $unit_data->morale_state;
		$unit_data->current_fatigue = $unit_data->fatigue;
		$unit_data->current_disorder = $unit_data->disorder;

		// get the unit's current orders for this game turn
		$query = $this->db->query("select turn_number,activate_turn,player_name,order_type,objective,comments from game_order where game_id=".$this->id." and unit_id=$id and activate_turn > 0 order by activate_turn desc");
		$unit_data->orders = array();
		$got_current = false;
		foreach ($query->result() as $row) {
			$unit_data->orders[] = $row;
			if (!$got_current && ($row->activate_turn <= $this->turn_number)) {
				$unit_data->current_order = $row;
				$unit_data->current_order_type = $this->get_order_type($row->order_type);
				$got_current = true;
			}
		}

		// decode some elements
		if ($unit_data->unit_type >= TYPE_BATTALION) {
			$unit_data->morale_grade_descr = $this->get_morale_grade($unit_data->morale_grade)->name;
			$unit_data->small_arms_descr = $this->get_morale_grade($unit_data->small_arms)->name;
		}
		$msd = $this->get_morale_state($unit_data->current_morale_state)->name;
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
		if  ($unit_data->initial_strength > 0) {
			$unit_data->percent_lost = (100.0 * $unit_data->casualties) / $unit_data->initial_strength;
			$unit_data->percent_lost_this_hour = (100.0 * $unit_data->casualties_this_hour) / $unit_data->initial_strength;
		}
		$unit_data->current_strength = $unit_data->initial_strength - $unit_data->casualties;

		// Get the game scale, and work out number of figures / bases
		$unit_data->scale = 60;
		$figs_per_inf_base = 3;
		$figs_per_cav_base = 2;
		$unit_data->scale = (int) $this->figure_scale;
		if ($unit_data->scale < 2) {
			$unit_data->scale = 60;
		}
		$figs_per_inf_base = (int)$this->infantry_base;
		$figs_per_cav_base = (int)$this->cavalry_base;
		
		// ensure no DIV0
		if (!$figs_per_inf_base) {
			$figs_per_inf_base = 3;
		}
		if (!$figs_per_cav_base) {
			$figs_per_cav_base = 2;
		}

		// Work out the original number of bases depending on the game scale in use
		// If no game in in progress, use the default Empire scaling of 1:60
		switch($unit_data->unit_type) {
		case TYPE_BATTALION:
			$unit_data->initial_num_figures = (int) ($unit_data->strength / $unit_data->scale);
			$unit_data->initial_num_bases = (int) (($unit_data->initial_num_figures + $figs_per_inf_base - 1) / $figs_per_inf_base);
			break;
		case TYPE_SQUADRON:
			$unit_data->initial_num_figures = (int) ($unit_data->strength / $unit_data->scale);
			$unit_data->initial_num_bases = (int) (($unit_data->initial_num_figures + $figs_per_cav_base - 1) / $figs_per_cav_base);
			break;
		case TYPE_BATTERY:
			$unit_data->initial_num_figures = (int) $unit_data->battery->gun_models;
			$unit_data->initial_num_bases = $unit_data->initial_num_figures;
			break;
		default:
			$unit_data->initial_num_bases = $unit_data->initial_num_figures = 1;
		}


		// Get the game scale, and work out number of figures / bases
		switch($unit_data->unit_type) {
		case TYPE_BATTALION:
			$unit_data->num_figures = (int) ($unit_data->current_strength / $unit_data->scale);
			$unit_data->num_bases = (int) (($unit_data->num_figures + $figs_per_inf_base - 1) / $figs_per_inf_base);
			break;
		case TYPE_SQUADRON:
			$unit_data->num_figures = (int) ($unit_data->current_strength / $unit_data->scale);
			$unit_data->num_bases = (int) (($unit_data->num_figures + $figs_per_cav_base - 1) / $figs_per_cav_base);
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

		// Are we part of an engagement ?
		$unit_data->engagement = 0;
		$query = $this->db->get_where('game_engagement_unit',array('game_id'=>$this->id,'unit_id'=>$unit_data->id));
		foreach ($query->result() as $row) {
			$unit_data->engagement = $row->engagement_id;
			$engagement = $this->db->get_where('game_engagement',array('game_id'=>$this->id,'id'=>$row->engagement_id))->row();
			$unit_data->engagement_name = $engagement->descr;
		}

		$unit_data->expanded = true;
		return $unit_data;
	}


	// Add a few helper functions to use lookup cached lookup tables for database queries on static
	// lookup data, rather than hammering the mysql server with endless little queries !
	function get_order_type ($order_type) {

		foreach ($this->order_types as $_) {
			if ($_->id == $order_type) return $_;
		}
		$_ = new stdClass;
		$_->name = "Unknown Order ".$order_type;
		return $_;
	}

	function get_professional_skill ($skill) {

		foreach ($this->professional_skill as $_) {
			if ($_->id == $skill) return $_;
		}
		$_ = new stdClass;
		$_->name = "Unknown Skill ".$skill;
		return $_;
	}

	function get_doctrine ($doctrine) {

		foreach ($this->doctrine as $_) {
			if ($_->id == $doctrine) return $_;
		}
		$_ = new stdClass;
		$_->name = "Unknown Doctrine ".$doctrine;
		return $_;
	}

	function get_inspiration ($inspiration) {

		foreach ($this->inspiration as $_) {
			if ($_->id == $inspiration) return $_;
		}
		$_ = new stdClass;
		$_->name = "Unknown Inspiration ".$inspiration;
		return $_;
	}

	function get_drill ($drill) {

		foreach ($this->drill as $_) {
			if ($_->id == $drill) return $_;
		}
		$_ = new stdClass;
		$_->name = "Unknown Drill ".$drill;
		return $_;
	}

	function get_morale_state ($ms) {

		foreach ($this->morale_state as $_) {
			if ($_->id == $ms) return $_;
		}
		$_ = new stdClass;
		$_->name = "Unknown Morale State ".$ms;
		return $_;
	}

	function get_morale_grade ($mg) {

		foreach ($this->morale_grade as $_) {
			if ($_->id == $mg) return $_;
		}
		$_ = new stdClass;
		$_->name = "Unknown Morale Grade ".$mg;
		return $_;
	}





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
			$this->attacker_commander = $game->attacker_commander;
			$this->defender_commander = $game->defender_commander;
			$this->attacker_characteristics = $game->attacker_characteristics;
			$this->defender_characteristics = $game->defender_characteristics;
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
		
		// Now load the various code engines associated with this game
		$this->code_engine = $this->db->get_where('code_engine',array('id' => $game->code_engine_id))->row();
		if (!$this->code_engine) {
			die ("Cannot find Code Engine for ID ".$this->game->code_engine_id);
		}
		$this->load->model($this->code_engine->command,'command_model');
		$this->load->model($this->code_engine->movement,'movement_model'); $this->movement_model->init($this);
		$this->load->model($this->code_engine->morale,'morale_model');
		$this->load->model($this->code_engine->firepower,'firepower_model');
		$this->load->model($this->code_engine->melee,'melee_model');


		if (!$full_details) {
			return $game;
		}

		// We have a game, so accumulate some details into the return value
		// accumulate the ME list, as well as the commanders list
		if ($this->user->commander_id) {
			$this->unit_id_range = $this->get_unit_id_range($this->user->commander_id);
			$this->unit_where_range = "(unit.id >= ".$this->unit_id_range->start_id." and unit.id <= ".$this->unit_id_range->end_id.")";
			// Get a list of the top level commands, and their current orders
			$this->me = $this->get_me_list($this->unit_id_range->start_id,$this->unit_id_range->end_id);
			$this->commanders = $this->get_commander_list($this->unit_id_range->start_id,$this->unit_id_range->end_id);
		} else {
			$this->unit_id_range = new stdClass;
			$this->unit_id_range->start_id = $this->unit_id_range->end_id = 0;
			$this->unit_where_range = '';
			$this->me = array();
			$this->commanders = array();
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
	
	// Across a given range of unit IDs, return an array of units that are commanders (which can be attached to other units)
	// Note that each unit in the array will include an array of subunits that the commander can attach to.
	// This function will also calulate the total strength, casualties and avg morale
	// grade for each top level commander
	function get_commander_list ($start_unit, $end_unit) {

		$retval = array();
		$query = $this->db->query("select id from unit where id >= $start_unit and id <= $end_unit and is_command='T' order by id");
		foreach ($query->result() as $row) {
			$unit = $this->get_unit($row->id);
			$this->get_commander_subunits($unit);
			$retval[] = $unit;
		}
		return $retval;
	}

	// For a given unit (which is known to be a commander), attach an array of subunits to the commander
	// and calculate the total strength, casualties and avg morale grade for the commander
	function get_commander_subunits ($commander) {

		$range = $this->get_unit_id_range($commander->id);
		$query = $this->db->query("select id from unit where id > ".$range->start_id." and id <= ".$range->end_id);
		$commander->initial_strength = 0;
		$commander->casualties = 0;
	       	$commander->did_close_combat = 0;
		$commander->won_close_combat = 0;
		$commander->casualties_this_hour = 0;
		$commander->num_subunits = 0;
		$commander->avg_morale = 0;
		$commander->me_subunit = array();
		foreach ($query->result() as $row) {
			$unit = $this->get_unit($row->id);
			$commander->commander_subunit[] = $unit;
			$commander->initial_strength += $unit->initial_strength;
			$commander->casualties += $unit->casualties;
			$commander->did_close_combat += $unit->did_close_combat;
			$commander->won_close_combat += $unit->won_close_combat;
			$commander->casualties_this_hour += $unit->casualties_this_hour;
			// For sub-units that drop to below 100 men in effective strength, then dont
			// bother counting them in the calculating average morale anymore.
			// If all the dross in the ME have run away, leaving a couple of elite
			// units, then the whole (remaining) ME is now elite.
			if ($unit->unit_type == 12 || ($unit->initial_strength - $unit->casualties) > 100) {
				$commander->num_subunits ++;
				$commander->avg_morale += $unit->morale_grade;
			}
		}

		// Based on the totals, calculate the average morale
		if ($commander->num_subunits) {
			$commander->avg_morale = (int)($commander->avg_morale / $commander->num_subunits);
			$commander->avg_morale_name = $this->get_morale_grade($commander->avg_morale)->name;
		} else {
			$commander->avg_morale_name = '';
			$commander->avg_morale = 7;
			echo "<hr><font color=red>WARNING: ME Unit ".$commander->id." - ".$commander->name." has no subunits .. that wont work very well.<p>You really should fix the ORBAT file for this unit, or turn off the 'is ME' flag for this unit.</font><p>First deselect the current game from the <a href=".site_url()."game target=_blank>Game List</a>, and then Click <a href=".site_url()."units/index/edit/".$commander->id.">HERE</a> to fix this unit.<p>In the meantime, I am going to have to treat this unit as Conscript morale grade for Average ME morale. So the ME wont last long on the battlefield until the data is fixed :)<hr>";
		}
		
		// Pre calculate some derived values (on the top level ME) for convenience
		$commander->percent_lost = 0;
		if  ($commander->initial_strength > 0) {
			$commander->percent_lost = (int)((100.0 * $commander->casualties) / $commander->initial_strength);
			$commander->percent_lost_this_hour = (int)((100.0 * $commander->casualties_this_hour) / $commander->initial_strength);
		}
		$commander->current_strength = $commander->initial_strength - $commander->casualties;
	}



	// Across a given range of unit IDs, return an array of units that are MEs
	// Note that each unit in the array will include an array of subunits.
	// This function will also calulate the total strength, casualties and avg morale
	// grade for each top level ME
	function get_me_list ($start_unit, $end_unit) {

		$retval = array();
		$query = $this->db->query("select id from unit where id >= $start_unit and id <= $end_unit and is_me='T' order by id");
		foreach ($query->result() as $row) {
			$unit = $this->get_unit($row->id);
			$this->get_me_subunits($unit);
			$retval[] = $unit;
		}
		return $retval;
	}

	// For a given unit (which is known to be an ME), attach an array of subunits to the ME
	// and calculate the total strength, casualties and avg morale grade for the ME
	function get_me_subunits ($me_unit) {

		$me_id = $me_unit->id;
		$query = $this->db->query("select id from unit where parent_me = $me_id order by id");
		$me_unit->initial_strength = 0;
		$me_unit->casualties = 0;
	       	$me_unit->did_close_combat = 0;
		$me_unit->won_close_combat = 0;
		$me_unit->casualties_this_hour = 0;
		$me_unit->num_subunits = 0;
		$me_unit->avg_morale = 0;
		$me_unit->me_subunit = array();
		foreach ($query->result() as $row) {
			$unit = $this->get_unit($row->id);
			$me_unit->me_subunit[] = $unit;
			$me_unit->initial_strength += $unit->initial_strength;
			$me_unit->casualties += $unit->casualties;
			$me_unit->did_close_combat += $unit->did_close_combat;
			$me_unit->won_close_combat += $unit->won_close_combat;
			$me_unit->casualties_this_hour += $unit->casualties_this_hour;
			// For sub-units that drop to below 100 men in effective strength, then dont
			// bother counting them in the calculating average morale anymore.
			// If all the dross in the ME have run away, leaving a couple of elite
			// units, then the whole (remaining) ME is now elite.
			if ($unit->unit_type == 12 || ($unit->initial_strength - $unit->casualties) > 100) {
				$me_unit->num_subunits ++;
				$me_unit->avg_morale += $unit->morale_grade;
			}
		}

		// Based on the totals, calculate the average morale
		if ($me_unit->num_subunits) {
			//{ echo "id = ".$me_unit->id." am = ".$me_unit->avg_morale." ns = ".$me_unit->num_subunits; }
			$me_unit->avg_morale = (int)($me_unit->avg_morale / $me_unit->num_subunits);
			$me_unit->avg_morale_name = $this->get_morale_grade($me_unit->avg_morale)->name;
		} else {
			$me_unit->avg_morale_name = '';
			$me_unit->avg_morale = 7;
			echo "<hr><font color=red>WARNING: ME Unit ".$me_unit->id." - ".$me_unit->name." has no subunits .. that wont work very well.<p>You really should fix the ORBAT file for this unit, or turn off the 'is ME' flag for this unit.</font><p>First deselect the current game from the <a href=".site_url()."game target=_blank>Game List</a>, and then Click <a href=".site_url()."units/index/edit/".$me_unit->id.">HERE</a> to fix this unit.<p>In the meantime, I am going to have to treat this unit as Conscript morale grade for Average ME morale. So the ME wont last long on the battlefield until the data is fixed :)<hr>";
		}
		
		// Pre calculate some derived values (on the top level ME) for convenience
		$me_unit->percent_lost = 0;
		if  ($me_unit->initial_strength > 0) {
			$me_unit->percent_lost = (int)((100.0 * $me_unit->casualties) / $me_unit->initial_strength);
			$me_unit->percent_lost_this_hour = (int)((100.0 * $me_unit->casualties_this_hour) / $me_unit->initial_strength);
		}
		$me_unit->current_strength = $me_unit->initial_strength - $me_unit->casualties;
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

		$this->cache_all_units();

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
			$me_list = $this->get_me_list($unit_range->start_id,$unit_range->end_id);
			// we now have a list of the MEs for this user
			foreach ($me_list as $unit) {
				//echo "  Unit : [".$unit->id."] - ".$unit->name." : ";
				if ($unit->unit_type == 6) {	// Exclude cav brigades
					//echo "is a Cavalry Brigade, so they are OK<br>";
				} else {
					// Is an infantry brigade - so jump into the ME determination test
					echo "<ul>";
					if ($unit->morale_state >= 4) {
						echo "<li><font color=#880000>Unit : [".$unit->id."] - ".$unit->name." is already BROKEN</font>";
						$distance = $this->yards_to_inches(640);
						echo "<ul><b><font color=#880000>Unit must fall back 640 yds ($distance inches)</font></b></ul>";
					} elseif ($unit->percent_lost >= 20) {
						echo "<li>Unit : [".$unit->id."] - ".$unit->name." has ".$unit->percent_lost."% losses - starting ME test";
						echo "<font color=blue><ul>";
						if ($unit->did_close_combat) {
							echo "<li>".$unit->did_close_combat." Close combat(s) in the last hour, so they need to test";
							echo "<li>Avg morale grade for the ME is currently ".$unit->avg_morale_name;
							$diemod = -1*($unit->percent_lost - 20);
							echo "<li>Total losses for the ME = ".$unit->percent_lost."% so thats a $diemod modifier";
							if ($unit->won_close_combat) {
								echo "<li>+10 since they won close combat in the last hour (".$unit->won_close_combat." wins)";
								$diemod += 10;
							}
							if ($unit->percent_lost_this_hour >= 20) {
								$diemod2 = -1*($unit->percent_lost_this_hour - 20);
								echo "<li>Total losses for the ME in the last hour  ".$unit->percent_lost_this_hour."% so thats another $diemod2 modifer";
								$diemod += $diemod2;
							}
							$query = $this->db->query("select commander_id from game_attach where game_id=".$this->id." and unit_id=".$unit->id);
							foreach ($query->result() as $row) {
								// We have an attached commander, look them up
								if ($attached_commander = $this->get_unit($row->commander_id)) {
								if ($inspiration = $this->get_inspiration($attached_commander->inspiration->id)) {
									echo "<li>[".$attached_commander->id."] - ".$attached_commander->name;
									echo " is attached. Inspiration Bonus = ".$inspiration->me_det_bonus.'%';
									$diemod += (int)$inspiration->me_det_bonus;
								}}

							}

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
							$distance = $this->yards_to_inches(640);
							if ($dieroll <= $b) {
								echo "<li>The whole ME is BROKEN";
								echo "<ul><font color=#880000>All units in this ME fall back 640 yds ($distance inches)</font></ul>";
								$result = 4;
							} elseif ($dieroll <= $r) {
								echo "<li>The whole ME is in RETREAT";
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
							$query = $this->db->query("select count(*) as count from game_message where game_id=$game_id and player_id=".$unit->player_id." and message='$message'")->row();
							if ($query->count == 0) {
								$data = new stdClass;
									$data->game_id = $game_id;
									$data->turn_number = $game->turn_number + 1;
									$data->player_id = $unit->player_id;
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
				$unit = $this->get_unit($row->unit_id);
				$this->unit_model->is_shaken($game_id,$this->turn_number,$unit);
				$this->get_me_subunits($unit);
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
				$unit = $this->get_unit($row->unit_id);
				$this->unit_model->is_retreating($game_id,$this->turn_number,$unit);
				$this->get_me_subunits($unit);
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
				$unit = $this->get_unit($row->unit_id);
				$this->unit_model->is_broken($game_id,$this->turn_number,$unit);
				$this->get_me_subunits($unit);
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

		$distance = $this->yards_to_inches(320);
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
				$me_list = $this->get_me_list($range->start_id,$range->end_id);
				foreach ($me_list as $me_unit) {
				if ($me_unit->player_id == $row->id) { // not all MEs under this commander belong to the same player

					$exempt = false;
					$highlight = '';

					$_ = $this->db->query("select count(*) as count from game_me_det where game_id=$game_id and unit_id=".$me_unit->id." and turn_number=".$game->turn_number." and result >= 2")->row();
					if ($_->count > 0) {
						$exempt = true;
						$highlight = ' bgcolor=#ff8888';
					}
					// If they are already broken, they dont need to test
					if ($me_unit->morale_state >= 4) {
						$exempt = true;
					}

					echo "<tr$highlight><td>".$me_unit->id."</td><td>".$me_unit->name."</td>";
					if ($me_unit->current_order->order_type == 9) {
						$exempt = true;
						echo "<td><font color=red>".$me_unit->current_order_type->name."</font></td>";
					} else {
						echo "<td>".$me_unit->current_order_type->name."</td>";
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

		$this->cache_all_units();

		$i = 0;
		foreach ($units as $unit_id) {
			$unit = $this->get_unit($unit_id);
			if ($unit->is_me == 'T') {
				if ($i) {
					echo "<hr>";
				}
				$i++;

				$this->get_me_subunits($unit);
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
						$data->player_id = $unit->player_id;
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
						$data->player_id = $unit->player_id;
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

		// And clear the leader attach array
		$this->db->query("delete from game_attach_done where game_id=".$this->id);
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
		echo $this->db->last_query();
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

		// Now calculate whether orders are activated
		$query = $this->db->get_where('game_order',array('game_id'=>$this->id,'activate_turn'=>0));
		foreach ($query->result() as $row) {
			echo "Order for unit ".$row->unit_id." has a chance of ".$row->activation_chance."<br>";
		}
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

	function leader_attach_form () {

		$player_id = 0;
		switch($this->session->userdata('role')) {
		case 'A':
		case 'U':
			$this->cache_all_units();
			break;
		case 'P':
			$player_id = $this->session->userdata('user_id');
			$this->cache_player_units($player_id);
			break;
		}


		echo "<table border=1>";

		if (!$player_id) {
			// do a set for all players
			$query = $this->db->query("select id,commander_id,username from user where commander_id != 0 and current_game=".$this->id);
			foreach ($query->result() as $commanding_user) {
				$range = $this->get_unit_id_range($commanding_user->commander_id);
				$commanders = $this->get_commander_list($range->start_id,$range->end_id);
				echo "<tr><td colspan=2><h2>".$commanding_user->username."</h2></td></tr>\n";
				$this->leader_attach_form_set($commanders, $commanding_user->id);
			}
		} else {
			// do a set for 1 player
			$this->leader_attach_form_set($this->commanders, $player_id);
		}

		echo "</table>";
		// Now dump some script to handle selecting an item

?>
<script>
$("#leader_attach_form select").change(function() {
	var commander = $(this).attr('name');
	var unit = $(this).find("option:selected").text();
	$.post('leader_attach',{'leader': commander,'unit': unit});
    	// alert('Commander '+$(this).attr('name')+' is now attached to '+$(this).find("option:selected").text());
});
$.getScript("leader_attach/get_status");

$(function() { 
	clearInterval (attach_status_interval);
	attach_status_interval = setInterval(function() {
		$.getScript("leader_attach/get_status");
	}, 3000);

});

</script>
<?
	}

	function leader_attach_form_set ($commanders, $player_id) {

		foreach ($commanders as $commander) {

			// check that we own this Commander first - it could be under a subcommander !
			if ($commander->player_id == $player_id) {
				echo "<tr><td><i>[".$commander->id."] - <b>".$commander->name."</b><br>";
				if (file_exists('unit-pictures/'.$commander->id.'.jpg')) {
					echo '<img id=unit-picture-'.$commander->id.' src=unit-pictures/'.$commander->id.'.jpg height=128><br>';
				}
				switch ($commander->unit_type) {
				case TYPE_ARMY:
					echo $commander->army->commander;
					break;
				case TYPE_CORPS:
				case TYPE_WING:
					echo $commander->corps->commander;
					break;
				case TYPE_DIVISION:
					echo $commander->division->commander;
					break;
				case TYPE_BRIGADE:
					echo $commander->brigade->commander;
					break;
				}
				echo "</td><td valign=top>\n";
				// Find out who this commander is currently attached to
				$query = $this->db->query('select * from game_attach where game_id='.$this->id.' and commander_id='.$commander->id);
				$attached_to = 0;
				foreach ($query->result() as $row) {
					$attached_to = (int)$row->unit_id;
					break;	// Got the most recent one, that will do
				}
				// Create a drop down list of sub-units for this commander
				$subcommands = array();
				$subcommands['0'] = '-- Select Unit to Attach To --';
				foreach ($commander->commander_subunit as $subunit) {
					$pad = '';
					for ($i = 0; $i < $subunit->unit_type; $i++) {
						$pad .= '&nbsp;';
					}
					$subcommands[$subunit->id] = $subunit->id.' -'.$pad.$subunit->name;
				}
				echo form_dropdown($commander->id, $subcommands,$attached_to );
				echo "</td></tr>\n";
			} // if the current player owns the unit
		} // for each commander in the set
	}

	function activate_orders_form() {
		$this->declare_orders_form(true);
	}

	function declare_orders_form($calculate = false) {

		$player_id = 0;
		switch($this->session->userdata('role')) {
		case 'A':
		case 'U':
			$this->cache_all_units();
			break;
		case 'P':
			$player_id = $this->session->userdata('user_id');
			$this->cache_player_units($player_id);
			break;
		}


		echo "<table border=1 width=90%>";

		$god_mode = false;
		if (!$player_id) {
			$god_mode = true;
			// do a set for all players
			$query = $this->db->query("select id,commander_id,username from user where commander_id != 0 and current_game=".$this->id);
			foreach ($query->result() as $commanding_user) {
				$range = $this->get_unit_id_range($commanding_user->commander_id);
				$me_list = $this->get_me_list($range->start_id,$range->end_id);
				echo "<tr bgcolor=#ffffee><td colspan=4><h2>".$commanding_user->username."</h2></td></tr>\n";
				$this->declare_orders_form_set($me_list, $commanding_user->id,$god_mode,$calculate);
			}
		} else {
			// do a set for 1 player
			$this->declare_orders_form_set($this->me, $player_id,$god_mode,false);
		}

		echo "</table>";
		// Add some script to handle the buttons
		if ($god_mode) {
?>
<script>
$("#declare_orders_form button").click(function() {
	var action = $(this).attr('action');
	var unit_id = $(this).attr('unit_id');
	var reason = $(this).attr('reason');
	if (confirm("Do you want to "+action+" for unit "+unit_id+" immediately ?")) {
		$(this).fadeOut(2000);
		$.post('umpire_console/'+action,{'unit': unit_id, 'reason': reason}, function() {
			$("#declare_orders_form").load("umpire_console/declare_orders_form",function(){
				$("#activate_orders").fadeIn(4000);
			});
		});
	}
});
</script>

<?
		}
	}

	function declare_orders_form_set ($me_list, $player_id,$god_mode,$calculate) {

		$last_parent_id = 0;
	
		foreach ($me_list as $me_unit) {

			// check that we own this ME Unit first - it could be under a subcommander !
			if ($me_unit->player_id == $player_id) {

				if ($me_unit->parent_id != $last_parent_id) {
					// Get the parent unit for this ME, to work out the activation chance based
					// on the professional skill of the immediate superior
					$parent_unit = $this->get_unit($me_unit->parent_id);
					$skill = null;
					$attached_unit = 0;
					if ($parent_unit && $parent_unit->skill) {
						$skill = $parent_unit->skill;
					}
					if ($parent_unit) {
						echo '<tr bgcolor=#eeeecc><td colspan=4>Leader: ['.$parent_unit->id.'] - '.$parent_unit->commander;

						if (file_exists('unit-pictures/'.$parent_unit->id.'.jpg')) {
							echo '<br><img id=unit-picture-'.$parent_unit->id.' src=unit-pictures/'.$parent_unit->id.'.jpg height=128>';
						}
	
						// Who is the parent commander attached to ?
						if ($attachment = $this->db->get_where('game_attach',array('game_id'=>$this->id,'commander_id'=>$parent_unit->id))->row()) {
							$attached_unit = $attachment->unit_id;
							echo ' ~ Attached to ['.$attached_unit.']';
						} else {
							echo ' ~ Not Attached';
						}
					echo '</td></tr>';
						echo "<tr bgcolor=#ddddcc><td>Name of ME</td><td>Current Orders</td><td>New Orders</td><td>% Activate</td></tr>";
					}
					$last_parent_id = $parent_unit->id;
				}

				echo "<tr><td><b>[".$me_unit->id."] - <b>".$me_unit->name."</b><br>";
				if (file_exists('unit-pictures/'.$me_unit->id.'.jpg')) {
					echo '<img id=unit-picture-'.$me_unit->id.' src=unit-pictures/'.$me_unit->id.'.jpg height=64><br>';
				}
				switch ($me_unit->unit_type) {
				case TYPE_ARMY:
					echo $me_unit->army->commander;
					break;
				case TYPE_CORPS:
				case TYPE_WING:
					echo $me_unit->corps->commander;
					break;
				case TYPE_DIVISION:
					echo $me_unit->division->commander;
					break;
				case TYPE_BRIGADE:
					echo $me_unit->brigade->commander;
					break;
				}
				echo '<hr>Morale State: '.$me_unit->morale_state_descr;

				echo "</td><td valign=top>\n";
				if ($me_unit->current_order) {
					echo $me_unit->current_order_type->name.' '.$me_unit->current_order->objective;

					if ($god_mode) {
					switch ($me_unit->current_order->order_type) {
					case 2: // Attack
						echo '<button action=convert_to_defend unit_id='.$me_unit->id.' reason="Objective Taken">Objective Taken ?</button>';
						break;
					case 3: // march
						echo '<button action=convert_to_defend unit_id='.$me_unit->id.' reason="March objective reached">Objective Reached ?</button>';
						break;
					case 4: // withdraw 
					case 8: // break off
						echo '<button action=convert_to_defend unit_id='.$me_unit->id.' reason="Withdraw objective reached">Objective Reached ?</button>';
						echo '<button action=convert_to_defend_posn unit_id='.$me_unit->id.' reason="Engaged during withdrawal">Engaged during withdrawal ?</button>';
						break;
					case 5: // redeploy
					case 6: // rest and rally
						echo '<button action=convert_to_defend_posn unit_id='.$me_unit->id.' reason="Engaged during redeployment">Engaged during re-reployment ?</button>';
						break;
					}
					}
				}
				echo "</td><td valign=top>";
				// Now get the latest unactivated order
				$query = $this->db->query("select * from game_order where game_id=".$this->id." and activate_turn=0 and unit_id=".$me_unit->id);
				foreach ($query->result() as $row) {
					$order_type = $this->get_order_type($row->order_type);
					echo $order_type->name.' '.$row->objective;

					// Umpire and Admin get God-Mode, which allows them to force the acceptance
					// of an order in the game, or to reject an order outright, for whatever reason.
					// This can be due to the order being invalid, or some other event on the tabletop
					// which is not modelled in the computer.
					if ($god_mode && !$calculate) {
						echo '<hr><button action=cancel_order unit_id='.$me_unit->id.' reason="Manual override">Delete Order</button>';
						echo '<button action=accept_order unit_id='.$me_unit->id.' reason="Manual override">Accept Order</button>';
					}
					echo "</td><td>";
					// Base activation chance
					$activation_chance = 0;
					if ($skill) {
						if ($attached_unit == $me_unit->id) {
							echo 'Leader Attached ';
							$activation_chance = 100;
						} elseif ($attached_unit == 0) {
							echo "Base ";
							$activation_chance = $skill->base_activation;
						} else {
							echo "Leader Elsewhere ";
							$activation_chance = $skill->attached_elsewhere;
						}
						echo $activation_chance.'%';
					} else {
						echo "Unknown Parent / Commander";
					}
	
					switch ($order_type->id) {
					case 8: // Breakoff
						$activation_chance -= 20;
						echo '<hr>-20% for Breakoff';
						break;
					case 5: // Redeploy
					case 6: // Rest and Rally
						$activation_chance = 100;
						echo '<hr>Automatic Activation for ReDeploy / Rally';
						break;
					case 2: // Attack
						// If DUB Cavalry, then -20% to activate
						if ($me_unit->unit_type == TYPE_CAV_BRIGADE) {
							foreach ($me_unit->me_subunit as $sqn) {
								if ($sqn->unit_type == TYPE_SQUADRON) {
									if ($sqn->undistinguished) {
										echo 'Cav Brigade includes DUB Cavalry -20%';
										$activation_chance -= 20;
										break;
									}
								}
							}
						}
						break;
					}
					echo '<hr><font color=blue>Final Chance = '.$activation_chance.'%</font>';
					if ($calculate) {
						$dice = d100();
						echo "<hr><i>Rolling .... $dice</i> ";
						if ($dice <= $activation_chance) {
							echo "<hr><font color=green size=+1><b>PASS</b></font>";
							$this->accept_order($me_unit->id);
						} else {
							echo "<hr><font color=red size=+1><b>FAIL</b></font>";
							$this->cancel_order($me_unit->id);
						}
						
					} else {
						if ($god_mode) {
							// we now need to stamp the calculated chance of activating the order against the order
							$this->db->query("update game_order set activation_chance=".$activation_chance." where game_id=".$this->id." and unit_id=".$me_unit->id." and activate_turn=0");
						}
					}

					break;
				} // for each order

				echo "</td></tr>\n";
			} // if the current player owns the unit
		} // for each commander in the set
	}

	function accept_order($unit_id) {

		// Get the order
		$query = $this->db->query("select * from game_order where game_id=".$this->id." and unit_id=".$unit_id." and activate_turn=0");
		$order = null;
		foreach ($query->result() as $order) {
			break;
		}
		if (!$order) {
			return;
		}
		$order_type = $this->get_order_type($order->order_type);


		$this->db->query("delete from game_order where activate_turn=".$this->turn_number." and game_id=".$this->id." and unit_id=".$unit_id);
		$this->db->query("update game_order set activate_turn=".$this->turn_number." where game_id=".$this->id." and unit_id=".$unit_id." and activate_turn=0");
		//echo "Orders for unit ".$unit_id." have been accepted for this turn";

		// Send a message from the commander of this ME, acknowledging the new order
		$unit = $this->get_unit($unit_id);
		$message = "From: ".$unit->commander."<br>[".$unit_id."] - ".$unit->name." will ".$order_type->name." ".$order->objective;
		$data = new stdClass;
			$data->game_id = $this->id;
			$data->turn_number = $this->turn_number;
			$data->player_id = $unit->player_id;
			$data->unit_id = $unit->id;
			$data->sent_turn = $this->turn_number;
			$data->message = $message;
			$data->letter_icon = rand(1,6);
		$this->db->insert('game_message',$data);
	}

	function cancel_order($unit_id) {

		$this->db->query("delete from game_order where game_id=".$this->id." and unit_id=".$unit_id." and activate_turn=0");
		//echo "Orders for unit ".$unit_id." have been cancelled for this turn";
	}

	function breakoff_form() {

		// Check if there are any BreakOff orders to be exectued this turn
		$query = $this->db->query("select * from game_order where game_id=".$this->id." and activate_turn=".$this->turn_number." and order_type=8");
		$breakoffs = array();
		foreach ($query->result() as $row) {
			$breakoffs[] = $row;
		}

		$filter_user = 0;
		$got_some = false;
		if ($this->session->userdata('role') == 'P') {
			$filter_user = $this->user->id;
		}

		if (count($breakoffs)) {
			foreach ($breakoffs as $order) {
				$unit = $this->get_unit($order->unit_id);
				if (!$filter_user || ($unit->player_id == $filter_user)) {

				if (!$got_some) {
					echo "<center><b><u>The following units can now perform Break Off moves to extract themselves from engagements :</b></u><p>";
					echo "<table border=1 width=80% cellpadding=2>";
					$got_some = true;
				}

				echo "<tr><td><i>[".$unit->id."]</i> - <b>".$unit->name."</b><br>";
				if (file_exists('unit-pictures/'.$unit->id.'.jpg')) {
					echo '<img id=unit-picture-'.$unit->id.' src=unit-pictures/'.$unit->id.'.jpg height=64><br>';
				}
				$distance = $this->yards_to_inches(320);
				echo "Objective of Break Off Order : ".$order->objective;
				echo "<br>Unit retires from Engagement, the outer limit of Engagement Range (320 yd ~ $distance inches)<br>";
				if (!$filter_user) {
					// Only umpire can declare this
					echo "<button unit_id=".$unit->id." action=end_engagement>Click Here if this ends the Engagement</button>";
				}

				// Now draw up a table of units in this ME and how far they can move
				$move = $this->movement_model->grand_tactical_move($unit);
				echo "<table border=2 width=100%>";
				echo "<tr bgcolor=#C09E6E>";
				echo "<th>Unit</th><th>Formation</th><th>Column</th><th>Line</th><th>Square</th><th>Light Woods</th><th>Heavy Woods</th><th>Town</th><th>Swamp</th>";
				echo "</tr>\n";
				echo "<tr><td><b>Leader</b></td>";
				echo "<td></td>";
				echo "<td align=center bgcolor=".OPEN_GROUND."><b>".$this->yards_to_inches($move['Column']['Open'])."</td>";
				echo "<td></td><td></td>"; // Line and Square - does not apply
				echo "<td align=center bgcolor=".LIGHT_WOODS.">".$this->yards_to_inches($move['Column']['LightWoods'])."</td>";
				echo "<td align=center bgcolor=".HEAVY_WOODS.">".$this->yards_to_inches($move['Column']['HeavyWoods'])."</td>";
				echo "<td align=center bgcolor=".TOWNS.">".$this->yards_to_inches($move['Column']['Town'])."</td>";
				echo "<td align=center bgcolor=".SWAMP.">".$this->yards_to_inches($move['Column']['Swamp'])."</td></tr>\n";

				// Repeat for all sub-units of the ME
				$this->get_me_subunits($unit);
				foreach ($unit->me_subunit as $subunit) {
					echo "<tr><td>[".$subunit->id."]<br>".$subunit->name."</td>";
					echo "<td align=center>".$this->get_formation_graphic($subunit);
					// Add a selector for a new formation

					echo "<br><select unit_id=".$subunit->id.">";
					echo '<option value=LN';
						if ($subunit->formation == 'LN') echo ' selected';
					echo '>Line</option>';
					echo '<option value=CL';
						if ($subunit->formation == 'CL') echo ' selected';
					echo '>Column</option>';
					echo '<option value=CC';
						if ($subunit->formation == 'CC') echo ' selected';
					echo '>Closed Col</option>';
					echo '<option value=RC';
						if ($subunit->formation == 'RC') echo ' selected';
					echo '>Road Col</option>';
					echo '<option value=SQ';
						if ($subunit->formation == 'SQ') echo ' selected';
					echo '>Square</option>';
					echo '<option value=HS';
						if ($subunit->formation == 'HS') echo ' selected';
					echo '>Hasty Square</option>';
					echo '<option value=OO';
						if ($subunit->formation == 'OO') echo ' selected';
					echo '>Open Order</option>';
					echo "</select>";
					echo "</td>";

					$move = $this->movement_model->grand_tactical_move($subunit);
					if (array_key_exists('Prolong',$move)) {
					echo "<td align=center bgcolor=".OPEN_GROUND."><b>".$this->yards_to_inches($move['Prolong']['Open'])."</b></td>";
					echo "<td></td><td></td>";
					echo "<td align=center bgcolor=".LIGHT_WOODS.">".$this->yards_to_inches($move['Prolong']['LightWoods'])."</td>";
					echo "<td></td>";
					echo "<td align=center bgcolor=".TOWNS.">".$this->yards_to_inches($move['Prolong']['Town'])."</td>";
					echo "<td></td>";
					echo "</tr>\n";
					} else {
					switch ($subunit->formation) {
					case 'CL':
					case 'CC':
					case 'RC':
					case 'OO':
						echo "<td align=center bgcolor=".OPEN_GROUND."><b>".$this->yards_to_inches($move['Column']['Open'])."</b></td>";
						echo "<td></td><td></td>"; // line and square
						echo "<td align=center bgcolor=".LIGHT_WOODS.">".$this->yards_to_inches($move['Column']['LightWoods'])."</td>";
						echo "<td align=center bgcolor=".HEAVY_WOODS.">".$this->yards_to_inches($move['Column']['HeavyWoods'])."</td>";
						echo "<td align=center bgcolor=".TOWNS.">".$this->yards_to_inches($move['Column']['Town'])."</td>";
						echo "<td align=center bgcolor=".SWAMP.">".$this->yards_to_inches($move['Column']['Swamp'])."</td></tr>\n";
						break;
					case 'LN':
						echo "<td></td>"; // Col
						echo "<td align=center bgcolor=".OPEN_GROUND."><b>".$this->yards_to_inches($move['Line']['Open'])."</b></td>";
						echo "<td></td>"; // square
						echo "<td align=center bgcolor=".LIGHT_WOODS.">".$this->yards_to_inches($move['Line']['LightWoods'])."</td>";
						echo "<td align=center bgcolor=".HEAVY_WOODS.">".$this->yards_to_inches($move['Line']['HeavyWoods'])."</td>";
						echo "<td align=center bgcolor=".TOWNS.">".$this->yards_to_inches($move['Line']['Town'])."</td>";
						echo "<td align=center bgcolor=".SWAMP.">".$this->yards_to_inches($move['Line']['Swamp'])."</td></tr>\n";
						break;
					case 'SQ':
					case 'HS':
					default:
						echo "<td></td><td></td>"; // column and line
						echo "<td align=center bgcolor=".OPEN_GROUND."><b>".$this->yards_to_inches($move['Square']['Open'])."</b></td>";
						echo "<td align=center bgcolor=".LIGHT_WOODS.">".$this->yards_to_inches($move['Square']['LightWoods'])."</td>";
						echo "<td align=center bgcolor=".HEAVY_WOODS.">".$this->yards_to_inches($move['Square']['HeavyWoods'])."</td>";
						echo "<td align=center bgcolor=".TOWNS.">".$this->yards_to_inches($move['Square']['Town'])."</td>";
						echo "<td align=center bgcolor=".SWAMP.">".$this->yards_to_inches($move['Square']['Swamp'])."</td></tr>\n";
						break;
					} // end switch
					} // else !artillery
				}

				echo "</table>\n";

				} // if user filter
			} // foreach breakoff
			if ($got_some) {
				echo "</table></center>";
			}
		}   // count breakoff is 0
		if ($got_some) {
			if ($filter_user) {
				$console = 'player_console';
			} else {
				$console = 'umpire_console';
			}
?>
<script>
$("#breakoff_form select").change(function() {
	var unit_id = $(this).attr('unit_id');
	var new_formation = $(this).val();
	var data = {unit: unit_id, formation: new_formation};
		$.ajax({ type: 'POST',
			url: '<?=$console?>/update_unit_formation',
  			data: data,
		}).done(function(msg) { 
			$("#breakoff_form").load("<?=$console?>/breakoff_form",function(){ $("#breakoff_done").fadeIn(4000); });
		})
});
</script>
<?
		} else {
			echo "No BreakOff orders to be executed this turn ...";
		}
	}

	function get_formation_graphic ($unit) {
		switch ($unit->num_bases) {
		case 0:
			return "<img src=".site_url()."images/formation/0.jpg>"; break;
		case 1:
			return "<img src=".site_url()."images/formation/1.jpg>"; break;
		case 2:
			switch ($unit->formation) {
			case 'CL':
			case 'CC':
				return "<img src=".site_url()."images/formation/2C.jpg>";
				break;
			case 'RC':
				return "<img src=".site_url()."images/formation/2C.jpg>RC";
				break;
			case 'LN':
			case 'SQ':
			case 'HS':
				return "<img src=".site_url()."images/formation/2L.jpg>";
				break;
			case 'OO':
				return "2x <img src=".site_url()."images/formation/SS.jpg>";
				break;
			}
			break;

		case 3:
			switch ($unit->formation) {
			case 'CL':
			case 'CC':
				return "<img src=".site_url()."images/formation/3C.jpg>";
				break;
			case 'RC':
				return "<img src=".site_url()."images/formation/3C.jpg>RC";
				break;
			case 'LN':
			case 'SQ':
			case 'HS':
				return "<img src=".site_url()."images/formation/3L.jpg>";
				break;
			case 'OO':
				return "3x <img src=".site_url()."images/formation/SS.jpg>";
				break;
			}
			break;

		default:	// 4 or more !
			switch ($unit->formation) {
			case 'CL':
				return $unit->num_bases."x <img src=".site_url()."images/formation/4C.jpg>";
				break;
			case 'RC':
				return $unit->num_bases."x <img src=".site_url()."images/formation/4C.jpg>RC";
				break;
			case 'CC':
			case 'SQ':
			case 'HS':
				return $unit->num_bases."x <img src=".site_url()."images/formation/4CC.jpg>";
				break;
			case 'LN':
				return $unit->num_bases."x <img src=".site_url()."images/formation/4L.jpg>";
				break;
			case 'OO':
				return $unit->num_bases."x <img src=".site_url()."images/formation/SS.jpg>";
				break;
			}
			break;
		}
		return '?';
	}

	function update_unit_formation ($unit, $formation) {

		switch ($formation) {
		case 'CL':
		case 'CC':
		case 'LN':
		case 'RC':
		case 'SQ':
		case 'HS':
		case 'OO':
			break;
		default:
			die("Invalid formation ".$formation." for unit ".$unit->id);
		}

		$this->db->query("update game_unit_stats set formation='$formation' where game_id=".$this->id." and unit_id=".$unit->id);

		// Create an audit record for the unit
		$data = new stdClass;
			$data->game_id = $this->id;
			$data->turn_number = $this->turn_number;
			$data->unit_id = $unit->id;
			$data->event_type = 8;
			$data->descr = 'Formation change from '.$unit->formation.' to '.$formation;
		$this->db->insert('game_event',$data);

		// Now update the unit passed by reference
		$unit->formation = $formation;

	}

	function grand_tactical_form() {

		echo "<b><u>The following units may now perform Grand Tactical Movement :</b></u><p>";

		$player_id = 0;
		switch($this->session->userdata('role')) {
		case 'A':
		case 'U':
			$this->cache_all_units();
			break;
		case 'P':
			$player_id = $this->session->userdata('user_id');
			$this->cache_player_units($player_id);
			break;
		}


		echo "<div id=gt_players style=\"width:100%;\">";
		$god_mode = false;
		if ($this->session->userdata('role') == 'P') {
			$this->grand_tactical_form_set($this->me, $player_id,$god_mode);
		} else {
			// Do a form for all players
			$god_mode = true;
			$query = $this->db->query("select id,commander_id,username from user where commander_id != 0 and current_game=".$this->id);
			foreach ($query->result() as $commanding_user) {
				echo "<h1>".$commanding_user->username."</h1>";
				$range = $this->get_unit_id_range($commanding_user->commander_id);
				$me_list = $this->get_me_list($range->start_id,$range->end_id);
				$this->grand_tactical_form_set($me_list, $commanding_user->id,$god_mode);
			}
		}
		echo "</div>";
		if ($god_mode) {
			$console = 'umpire_console';
		} else {
			$console = 'player_console';
		}
?>
<script> 
$(function() {
	$("#gt_players").accordion({collapsible: true, active: false, autoHeight: false });
});
$("#grand_tactical_form select").change(function() {
	var unit_id = $(this).attr('unit_id');
	var new_formation = $(this).val();
	var data = {unit: unit_id, formation: new_formation};
		$.ajax({ type: 'POST',
			url: '<?=$console?>/update_unit_formation',
  			data: data,
		}).done(function(msg) { 
			$("#grand_tactical_form").load("<?=$console?>/grand_tactical_form",function(){ $("#gt_done").fadeIn(4000); });
		})
});

$("#grand_tactical_form button").click(function() {
	var unit_id = $(this).attr('unit_id');
	var action = $(this).attr('action');
	//if (confirm('Attempt intercept with unit '+unit_id+' ?')) {
	if (action == 'attempt_intercept') {
		$.ajax({type: 'POST',
			url: '<?=$console?>/attempt_intercept',
			data: {unit: unit_id},
		}).done(function(msg) {
			$('<div id=intercept_result></div>').html(msg).dialog({modal:true, width:800, height:400});
			$("#grand_tactical_form").load("<?=$console?>/grand_tactical_form",function(){ $("#gt_done").fadeIn(4000); });
		});
	}
	if (action == 'create_engagement') {
		$('<div id=create_engagement></div>').load('<?=$console?>/create_engagement_form',{'unit': unit_id}).dialog({modal:true, width:800, height:600 });
	};
	
});

</script>
<?
	}

	function grand_tactical_form_set($me_list, $player_id,$god_mode) {

		echo "<div id=gt_player_".$player_id." style=\"width:100%; background:rgba(255,255,255,0.1);\">";

		foreach ($me_list as $unit) {

			// Check that this player owns the ME
			if ($unit->player_id == $player_id) {

			echo "<h2>[".$unit->id."] - ".$unit->name."<br>";
			// Include current orders in the header
			echo "Current Orders : ".$unit->current_order_type->name;
			echo "</h2>";

			echo "<div style=\"width:100%; background:rgba(255,255,255,0.1);\">";
			if (file_exists('unit-pictures/'.$unit->id.'.jpg')) {
				echo '<img id=unit-picture-'.$unit->id.' src=unit-pictures/'.$unit->id.'.jpg height=64><br>';
			}

			$can_move = false;
			switch ($unit->current_order_type->name) {
			case 'Withdraw':
				echo "This unit is to <font color=red>".$unit->current_order_type->name."</font> ".$unit->current_order->objective;
				$this->movement_model->multiplier = 1.0;
				$can_move = true;
				if ($god_mode && $unit->engagement) {
					echo '<br><button action=withdraw_engagement unit_id='.$unit->id.'>Withdraws from engagement</button>';
				}
				if ($unit->engagement) {
					echo '<br>This unit is currently engaged at '.$unit->engagement_name;
				}
				break;
			case 'Attack':
				echo "This unit is to <font color=red>".$unit->current_order_type->name."</font> ".$unit->current_order->objective;
				$this->movement_model->multiplier = 1.0;
				if ($unit->engagement) {
					echo '<br>This unit is already engaged at '.$unit->engagement_name;
				} else {
					$can_move = true;
					if ($god_mode) {
						$distance_i = $this->yards_to_inches(320);
						$distance_c = $this->yards_to_inches(480);
						echo '<br><button action=create_engagement unit_id='.$unit->id.'>Attack creates a NEW engagement (320yds / '.$distance_i.' inches)</button>';
					}
				}
				break;
			case 'Support':
				echo "This unit is to <font color=red>".$unit->current_order_type->name."</font> ".$unit->current_order->objective;
				$this->movement_model->multiplier = 1.0;
				if ($unit->engagement) {
					echo '<br>This unit is already engaged at '.$unit->engagement_name;
				} else {
					$can_move = true;
					$distance = $this->yards_to_inches(800);
					echo '<br><button action=attempt_intercept unit_id='.$unit->id.'>Attempt intercept of enemy within 800yds ('.$distance.' inches) to this units front</button>';
				}
				break;
			case 'March':
				echo "This unit is to <font color=blue>".$unit->current_order_type->name."</font> ".$unit->current_order->objective;
				echo "<br>Movement rates below apply to units that are greater than ".$this->yards_to_inches(1600)."inches from the enemy, otherwise move at half this rate.";
				$this->movement_model->multiplier = 1.5;
				if ($unit->engagement) {
					echo '<br>This unit is already engaged at '.$unit->engagement_name;
				} else {
					$can_move = true;
					if ($god_mode && !$unit->engagement) {
						$distance = $this->yards_to_inches(320);
						echo '<br><button action=create_engagement unit_id='.$unit->id.'>Marches into a NEW engagement (320yds / '.$distance.' inches)</button>';
					}
				}
				break;
			case 'Defend':
			case 'Garrison':
				echo "This unit is to remain in a <font color=green>Defensive Posture</font> at the current objective of ".$unit->current_order->objective;
				if ($unit->engagement) {
					echo '<br>This unit is engaged at '.$unit->engagement_name;
				}
				break;
			case 'Redeploy':
				echo "This unit is to <font color=green>Re-Deploy</font> ".$unit->current_order->objective;
				if ($unit->engagement) {
					echo '<br>This unit is engaged at '.$unit->engagement_name;
				}
				break;
			case 'Rest and Rally':
				echo "This unit is to <font color=yellow>Rest and Rally</font> ".$unit->current_order->objective;
				if ($unit->engagement) {
					echo '<br>This unit is engaged at '.$unit->engagement_name;
				}
				break;
			case 'Break Off':
				echo "This unit has already moved, breaking off from contact ".$unit->current_order->objective;
				if ($unit->engagement) {
					echo '<br>This unit is still engaged at '.$unit->engagement_name;
				}
				break;
			case 'Sauve qui peut':
				echo "This unit is to <font color=red size=+1><b><u>Sauve Qui Peut !</u></b></font>";
				break;
			}

			if ($can_move) {
			// Now draw up a table of units in this ME and how far they can move
			$move = $this->movement_model->grand_tactical_move($unit);
			echo "<table border=1 width=90%>";
			echo "<tr bgcolor=#C09E6E>";
			echo "<th>Unit</th><th>Formation</th><th>Open</th><th>LtWoods</th><th>HvWoods</th><th>Town</th><th>Swamp</th>";
			echo "</tr>\n";
			echo "<tr><td><b>Leader</b></td>";
			echo "<td></td>";
			echo "<td align=center bgcolor=".OPEN_GROUND."><b>".$this->yards_to_inches($move['Column']['Open'])."</td>";
			echo "<td align=center bgcolor=".LIGHT_WOODS.">".$this->yards_to_inches($move['Column']['LightWoods'])."</td>";
			echo "<td align=center bgcolor=".HEAVY_WOODS.">".$this->yards_to_inches($move['Column']['HeavyWoods'])."</td>";
			echo "<td align=center bgcolor=".TOWNS.">".$this->yards_to_inches($move['Column']['Town'])."</td>";
			echo "<td align=center bgcolor=".SWAMP.">".$this->yards_to_inches($move['Column']['Swamp'])."</td></tr>\n";

			// Repeat for all sub-units of the ME
			$this->get_me_subunits($unit);
			foreach ($unit->me_subunit as $subunit) {
				echo "<tr><td><a target=unit-".$subunit->id." href=".site_url()."units/status?id=".$subunit->id."><small>[".$subunit->id."]<br>".$subunit->name."</small></a></td>";
				echo "<td align=center>".$this->get_formation_graphic($subunit);
				// Add a selector for a new formation

				echo "<br><select unit_id=".$subunit->id.">";
				echo '<option value=LN';
					if ($subunit->formation == 'LN') echo ' selected';
				echo '>Line</option>';
				echo '<option value=CL';
					if ($subunit->formation == 'CL') echo ' selected';
				echo '>Column</option>';
				echo '<option value=CC';
					if ($subunit->formation == 'CC') echo ' selected';
				echo '>Closed Col</option>';
				echo '<option value=RC';
					if ($subunit->formation == 'RC') echo ' selected';
				echo '>Road Col</option>';
				echo '<option value=SQ';
					if ($subunit->formation == 'SQ') echo ' selected';
				echo '>Square</option>';
				echo '<option value=HS';
					if ($subunit->formation == 'HS') echo ' selected';
				echo '>Hasty Square</option>';
				echo '<option value=OO';
					if ($subunit->formation == 'OO') echo ' selected';
				echo '>Open Order</option>';
				echo "</select>";
				echo "</td>";

				$move = $this->movement_model->grand_tactical_move($subunit);
				if (array_key_exists('Prolong',$move)) {
				echo "<td align=center bgcolor=".OPEN_GROUND."><b>".$this->yards_to_inches($move['Prolong']['Open'])."</b></td>";
				echo "<td align=center bgcolor=".LIGHT_WOODS.">".$this->yards_to_inches($move['Prolong']['LightWoods'])."</td>";
				echo "<td></td>";
				echo "<td align=center bgcolor=".TOWNS.">".$this->yards_to_inches($move['Prolong']['Town'])."</td>";
				echo "<td></td>";
				echo "</tr>\n";
				} else {
				switch ($subunit->formation) {
				case 'CL':
				case 'CC':
				case 'RC':
				case 'OO':
					echo "<td align=center bgcolor=".OPEN_GROUND."><b>".$this->yards_to_inches($move['Column']['Open'])."</b></td>";
					echo "<td align=center bgcolor=".LIGHT_WOODS.">".$this->yards_to_inches($move['Column']['LightWoods'])."</td>";
					echo "<td align=center bgcolor=".HEAVY_WOODS.">".$this->yards_to_inches($move['Column']['HeavyWoods'])."</td>";
					echo "<td align=center bgcolor=".TOWNS.">".$this->yards_to_inches($move['Column']['Town'])."</td>";
					echo "<td align=center bgcolor=".SWAMP.">".$this->yards_to_inches($move['Column']['Swamp'])."</td></tr>\n";
					break;
				case 'LN':
					echo "<td align=center bgcolor=".OPEN_GROUND."><b>".$this->yards_to_inches($move['Line']['Open'])."</b></td>";
					echo "<td align=center bgcolor=".LIGHT_WOODS.">".$this->yards_to_inches($move['Line']['LightWoods'])."</td>";
					echo "<td align=center bgcolor=".HEAVY_WOODS.">".$this->yards_to_inches($move['Line']['HeavyWoods'])."</td>";
					echo "<td align=center bgcolor=".TOWNS.">".$this->yards_to_inches($move['Line']['Town'])."</td>";
					echo "<td align=center bgcolor=".SWAMP.">".$this->yards_to_inches($move['Line']['Swamp'])."</td></tr>\n";
					break;
				case 'SQ':
				case 'HS':
				default:
					echo "<td align=center bgcolor=".OPEN_GROUND."><b>".$this->yards_to_inches($move['Square']['Open'])."</b></td>";
					echo "<td align=center bgcolor=".LIGHT_WOODS.">".$this->yards_to_inches($move['Square']['LightWoods'])."</td>";
					echo "<td align=center bgcolor=".HEAVY_WOODS.">".$this->yards_to_inches($move['Square']['HeavyWoods'])."</td>";
					echo "<td align=center bgcolor=".TOWNS.">".$this->yards_to_inches($move['Square']['Town'])."</td>";
					echo "<td align=center bgcolor=".SWAMP.">".$this->yards_to_inches($move['Square']['Swamp'])."</td></tr>\n";
					break;
				} // end switch
				} // else !artillery
			}

			echo "</table>\n";
			} // can move
			echo "</div>";
			} // Player owns this ME
		} // Foreach ME unit
		echo "</div>";

?>
<script> 
$.fn.togglepanels = function(){
  return this.each(function(){
    $(this).addClass("ui-accordion ui-accordion-icons ui-widget ui-helper-reset")
  .find("h2")
    .addClass("ui-accordion-header ui-helper-reset ui-state-default ui-corner-top ui-corner-bottom")
    .hover(function() { $(this).toggleClass("ui-state-hover"); })
    .prepend('<span class="ui-icon ui-icon-triangle-1-e"></span>')
    .click(function() {
      $(this)
        .toggleClass("ui-accordion-header-active ui-state-active ui-state-default ui-corner-bottom")
        .find("> .ui-icon").toggleClass("ui-icon-triangle-1-e ui-icon-triangle-1-s").end()
        .next().slideToggle();
      return false;
    })
    .next()
      .addClass("ui-accordion-content ui-helper-reset ui-widget-content ui-corner-bottom")
      .hide();
  });
};
$(function() {
	$("#gt_player_<?=$player_id?>").togglepanels();
//({collapsible: true, active: false, autoHeight: false});
});
</script>
<?
	}

	function attempt_intercept ($unit) {
		
		if ($unit->parent_id) {
			// Get the parent unit for this ME, to work out the activation chance based
			// on the professional skill of the immediate superior
			$parent_unit = $this->get_unit($unit->parent_id);
			$skill = null;
			$attached_unit = 0;
			if ($parent_unit && $parent_unit->skill) {
				$skill = $parent_unit->skill;
			}
			if ($parent_unit) {
				echo 'Leader: ['.$parent_unit->id.'] - '.$parent_unit->commander;

				if (file_exists('unit-pictures/'.$parent_unit->id.'.jpg')) {
					echo '<br><img id=unit-picture-'.$parent_unit->id.' src=unit-pictures/'.$parent_unit->id.'.jpg height=128>';
				}

				// Who is the parent commander attached to ?
				if ($attachment = $this->db->get_where('game_attach',array('game_id'=>$this->id,'commander_id'=>$parent_unit->id))->row()) {
					$attached_unit = $attachment->unit_id;
					echo ' ~ Attached to ['.$attached_unit.']';
				} else {
					echo ' ~ Not Attached';
				}
			echo '<hr>';
			}

			echo "<b>[".$unit->id."] - <b>".$unit->name."</b><br>";
			if (file_exists('unit-pictures/'.$unit->id.'.jpg')) {
				echo '<img id=unit-picture-'.$unit->id.' src=unit-pictures/'.$unit->id.'.jpg height=64><br>';
			}
			switch ($unit->unit_type) {
			case TYPE_ARMY:
				echo $unit->army->commander;
				break;
			case TYPE_CORPS:
			case TYPE_WING:
				echo $unit->corps->commander;
				break;
			case TYPE_DIVISION:
				echo $unit->division->commander;
				break;
			case TYPE_BRIGADE:
				echo $unit->brigade->commander;
				break;
			}
			echo '<hr>Morale State: '.$unit->morale_state_descr;

			echo "<hr>\n";
		} // if has a parent unit

		// Base activation chance
		$activation_chance = 0;
		if ($skill) {
			if ($attached_unit == $unit->id) {
				echo 'Leader Attached ';
				$activation_chance = 100;
			} elseif ($attached_unit == 0) {
				echo "Base ";
				$activation_chance = $skill->base_activation;
			} else {
				echo "Leader Elsewhere ";
				$activation_chance = $skill->attached_elsewhere;
			}
			echo $activation_chance.'%';
		} else {
			echo "Unknown Parent / Commander";
		}

		// If DUB Cavalry, then -20% to activate
		if ($unit->unit_type == TYPE_CAV_BRIGADE) {
			$this->get_me_subunits($unit);
			foreach ($unit->me_subunit as $sqn) {
				if ($sqn->unit_type == TYPE_SQUADRON) {
					if ($sqn->undistinguished) {
						echo 'Cav Brigade includes DUB Cavalry -20%';
						$activation_chance -= 20;
						break;
					}
				}
			}
		}
		echo '<hr><font color=blue>Final Chance = '.$activation_chance.'%</font>';
		$dice = d100();
		echo "<hr><i>Rolling .... $dice</i> ";
		if ($dice <= $activation_chance) {
			echo "<hr><font color=green size=+1><b>PASS</b></font><br>";
			echo "Intercept ! - the unit now Attacks the enemy to their front";
			//$this->accept_order($unit->id);

			// Delete current orders for this turn
			// Create a new order for this turn to attack the enemy to the front
			$this->db->query("delete from game_order where game_id=".$this->id." and activate_turn=".$this->turn_number." and unit_id=".$unit->id);
			$data = new stdClass;
				$data->game_id = $this->id;
				$data->turn_number = $this->turn_number;
				$data->activate_turn = $this->turn_number;
				$data->unit_id =  $unit->id;
				$data->player_name = $this->game->user->username;
				$data->order_type = 2; // attack
				$data->objective = 'Enemy to the front';
				$data->activation_chance = $activation_chance;
			$this->db->insert('game_order',$data);

			// Create an event for the unit, and each subunit
			$data = new stdClass;
				$data->game_id = $this->id;
				$data->turn_number = $this->turn_number;
				$data->unit_id = $unit->id;
				$data->event_type = 2;
				$data->descr = 'Unit attacks enemy to their front under an intercept order';
				$data->value = 2; // attack
			$this->db->insert('game_event',$data);
				foreach ($unit->me_subunit as $sqn) {
					$data = new stdClass;
						$data->game_id = $this->id;
						$data->turn_number = $this->turn_number;
						$data->unit_id = $sqn->id;
						$data->event_type = 2;
						$data->descr = 'Unit attacks enemy to their front under an intercept order';
						$data->value = 2; // attack
					$this->db->insert('game_event',$data);
				}

		} else {
			echo "<hr><font color=red size=+1><b>FAIL</b></font><br>";
			echo "Incompetence ! - the unit does not attack the enemy to their front";
			//$this->cancel_order($unit->id);
		}
	}

	function engagement_range_inches () {
		return $this->yards_to_inches(320);
	}

	function convert_to_defend ($unit,$reason,$objective='') {
		// get the current objective
		if ($objective == '') {
			$row = $this->db->get_where('game_order',array('game_id'=>$this->id,'activate_turn'=>$this->turn_number,'unit_id'=>$unit->id))->row();
			$objective = $row->objective;
		}

		// Zap current order for this turn, and create a new order for defend.
		$this->db->query("delete from game_order where game_id=".$this->id." and activate_turn=".$this->turn_number." and unit_id=".$unit->id);

		$data = new stdClass;
			$data->game_id = $this->id;
			$data->turn_number = $this->turn_number;
			$data->activate_turn = $this->turn_number;
			$data->unit_id = $unit->id;
			$data->player_name = 'umpire';
			$data->order_type = 1; // defend
			$data->objective = $objective;
			$data->comments = $reason;
			$data->activation_chance = 100;
		$this->db->insert('game_order',$data);

		// Create an event for change of orders, and create message to commander to the effect that the orders have changed
		$data = new stdClass;
			$data->game_id = $this->id;
			$data->turn_number = $this->turn_number;
			$data->unit_id = $unit->id;
			$data->event_type = 2;
			$data->descr = $reason;
			$data->value = 1;
		$this->db->insert('game_event',$data);

		$data = new stdClass;
			$data->game_id = $this->id;
			$data->turn_number = $this->turn_number + 1;
			$data->player_id = $unit->player_id;
			$data->unit_id = $unit->id;
			$data->sent_turn = $this->turn_number;
			$data->message = 'Unit has converted to defend order due to '.$reason;
			$data->letter_icon = rand(1,6);
		$this->db->insert('game_message',$data);
	}

	function determine_bombardment_form() {

		echo form_open('umpire_console/determine_bombardment_calculate',array('id'=>'bombardment_form'));
		// For each player
		// 	open a fieldset
		// 	For each battery
		// 		add a line, with checkboxes for movement
		// 	close fieldset

		$query = $this->db->query("select id,username,commander_id from user where current_game=".$this->id." and commander_id != 0");
		foreach ($query->result() as $row) {
			echo "<br><b><u>Commander ".$row->username."</u></b><br>";

			// TODO - display initiative score
			
			$unit_range = $this->get_unit_id_range($row->commander_id);
			$me_list = $this->get_me_list($unit_range->start_id,$unit_range->end_id);
			// we now have a list of the MEs for this user
			foreach ($me_list as $unit) {
				if ($unit->player_id == $row->id) {
					echo form_fieldset('[#'.$unit->id.'] - '.$unit->name);
					// Find out if parent ME engaged
					$parent_engaged = $this->db->get_where('game_engagement_unit',array('game_id'=>$this->id,'unit_id'=>$unit->id))->row();
					if ($parent_engaged) {

						if ($unit->unit_type == TYPE_CAV_BRIGADE) {
							echo "<img src=images/cav-brigade.jpg>";
						} else {
							echo "<img src=images/inf-brigade.jpg>";
						}

						$engagement = $this->db->get_where('game_engagement',array('game_id'=>$this->id,'id'=>$parent_engaged->engagement_id))->row();
						echo "<br><font color=red>Engaged at - ".$engagement->descr."</font>";

						// are there any leaders attached to any unit in this ME ?
						$leaders = $this->get_leaders_attached($unit);
						foreach ($leaders as $leader) {
							$leader_unit = $this->get_unit($leader);
							switch ($leader_unit->unit_type) {
							case TYPE_ARMY:
							case TYPE_WING:
								echo "<br><font color=green>Army Commander ".$leader_unit->name." attached</font>";
								break;
							case TYPE_CORPS:
								echo "<br><font color=green>Corps Commander ".$leader_unit->name." attached</font>";
								break;
							case TYPE_DIVISION:
								// TODO - if Div commander is superior, add +2
								break;
							}
						}

						// Show impulses active
						$initiative = $this->db->get_where('game_engagement_initiative',array('game_id'=>$this->id,'engagement_id'=>$engagement->id,'unit_id'=>$unit->id))->row();
						if ($initiative) {
							$moved = $initiative->moved;
							echo "<br><font color=blue>Active impulses = ".$initiative->impulses." (die roll = ".$initiative->die_roll." + ".$initiative->modifiers.")</font>";
						} else {
							$moved = '0';
?><script>
$(function() { $("#determine_bombardment_done").fadeOut(4000); });
</script><?
						}


						// add radio buttons for last movement for the whole ME
						$range1 = $this->yards_to_inches(600);
						$range2 = $this->yards_to_inches(1200);

						echo "<br>ME moved last Grand Tactical Round : ";
						//echo '<table border=0 width=800 cellpadding=5><tr><td>None</td><td>up to '.$range1.'"</td><td>up to '.$range2.'"</td><td>over '.$range2.'"</td></r>';

							$_ = $unit->id;
							echo "<div id=\"$_\" style=\"width:800px;\">";
							echo '<input type="radio" id="'.$_.'-0" name="'.$_.'"';
							if ($moved == '0') { echo " checked=\"checked\""; }
							echo '><label for="'.$_.'-0">No Move</label>';
							echo '<input type="radio" id="'.$_.'-600" name="'.$_.'"';
							if ($moved == '600') { echo " checked=\"checked\""; }
							echo '><label for="'.$_.'-600">Up to '.$range1.'"</label>';
							echo '<input type="radio" id="'.$_.'-1200" name="'.$_.'"';
							if ($moved == '1200') { echo " checked=\"checked\""; }
							echo '><label for="'.$_.'-1200">Up to '.$range2.'"</label>';
							echo '<input type="radio" id="'.$_.'-2400" name="'.$_.'"';
							if ($moved == '2400') { echo " checked=\"checked\""; }
							echo '><label for="'.$_.'-2400">Over '.$range3.'"</label>';
							echo "</div>";

?>
<script> $(function() { $("#<?echo "$_";?>").buttonset();}); </script>
<?

							//echo '<tr><td>'.form_radio($unit->id,'0',$moved == '0').'</td>';
							//echo '<td>'.form_radio($unit->id,'600',$moved == '600').'</td>';
							//echo '<td>'.form_radio($unit->id,'1200',$moved == '1200').'</td>';
							//echo '<td>'.form_radio($unit->id,'1200+',$moved == '2400').'</td>';
							//echo "</tr></table><hr>";

					} else {
						echo "<br><font color=green>Not Engaged</font>";
					}

					$done_gun = false;
					foreach ($unit->me_subunit as $subunit) {
						if ($subunit->unit_type == TYPE_BATTERY) {

							if (!$done_gun) {
								if ($parent_engaged) {
									echo "<hr>";
								}

								echo "<img src=images/gunnery.gif>";
								$done_gun = true;
							}

							echo "<br>[#".$subunit->id."] - ".$subunit->name;


							// get the current setting for this unit
							$bombard = $this->db->get_where('game_bombardment_unit',array('game_id'=>$this->id,'turn_number'=>$this->turn_number,'unit_id'=>$subunit->id))->row();
							if ($bombard) {
								//echo '<br>Modifiers = '.$bombard->modifiers;
								//echo '<br>Bombard Turns = '.$bombard->rounds;
								echo '<br><font color=blue>Fires in '.$bombard->descr.'</font>';
								$moved = $bombard->moved;
							} else {
								echo '<br><font color=red>No calculation yet</font>';
								$moved = '800+';
							}

							// add radio buttons for last movement
							$range1 = $this->yards_to_inches(200);
							$range2 = $this->yards_to_inches(400);
							$range3 = $this->yards_to_inches(800);

							$_ = $subunit->id;
							echo "<br>Battery moved last Grand Tactical Round : ";
							echo "<div id=\"battery-$_\" style=\"width:800px;\">";
							echo '<input type="radio" id="'.$_.'-0" name="'.$subunit->id.'"';
							if ($moved == '0') { echo " checked=\"checked\""; }
							echo '><label for="'.$_.'-0">No Move</label>';
							echo '<input type="radio" id="'.$_.'-200" name="'.$subunit->id.'"';
							if ($moved == '200') { echo " checked=\"checked\""; }
							echo '><label for="'.$_.'-200">Up to '.$range1.'"</label>';
							echo '<input type="radio" id="'.$_.'-400" name="'.$subunit->id.'"';
							if ($moved == '400') { echo " checked=\"checked\""; }
							echo '><label for="'.$_.'-400">Up to '.$range2.'"</label>';
							echo '<input type="radio" id="'.$_.'-800" name="'.$subunit->id.'"';
							if ($moved == '800') { echo " checked=\"checked\""; }
							echo '><label for="'.$_.'-800">Up to '.$range3.'"</label>';
							echo '<input type="radio" id="'.$_.'-800+" name="'.$subunit->id.'"';
							if ($moved == '800+') { echo " checked=\"checked\""; }
							echo '><label for="'.$_.'-800+">Over '.$range3.'"</label>';

							//echo '<tr><td>'.form_radio($subunit->id,'0',$moved == '0').'</td>';
							//echo '<td>'.form_radio($subunit->id,'200',$moved == '200').'</td>';
							//echo '<td>'.form_radio($subunit->id,'400',$moved == '400').'</td>';
							//echo '<td>'.form_radio($subunit->id,'800',$moved == '800').'</td>';
							//echo '<td>'.form_radio($subunit->id,'800+',$moved == '1600').'</td>';
							echo "</div>";
?>
<script> $(function() { $("#<?echo "battery-$_";?>").buttonset();}); </script>
<?
							
						}
					}
					echo form_fieldset_close();
				}
			}
		}

		echo form_submit('submit','Calculate Bombardment Rounds');
		echo form_close();
?>
<script> 
$(function() { 
	$('#bombardment_form').ajaxForm(function() { 
		$("#determine_bombardment_form").load("umpire_console/determine_bombardment_form",function(){
			$("#determine_bombardment_done").fadeIn(4000);
		});
	}); 
}); 
</script> 
<?
	
	}

	function get_leaders_attached ($me_unit) {
		$retval = array();

		// The ME itself has a leader anyway, so add that
		$retval[] = $me_unit->id;

		// Are there higher level leaders attached to this ME ?
		$query = $this->db->query('select commander_id from game_attach where game_id='.$this->id.' and unit_id='.$me_unit->id);
		foreach ($query->result() as $row) {
			if (!in_array($row->commander_id,$retval)) { $retval[] = $row->commander_id; }
		}

		// Do the same for any subunits
		foreach ($me_unit->me_subunit as $subunit) {
			$query = $this->db->query('select commander_id from game_attach where game_id='.$this->id.' and unit_id='.$subunit->id);
			foreach ($query->result() as $row) {
				if (!in_array($row->commander_id,$retval)) { $retval[] = $row->commander_id; }
			}
		}

		//echo "<br><hr>Leaders attached to ".$me_unit->id.':<br>';
		//var_dump($retval);
		return $retval;
	}

	function determine_bombardment_calculate() {

		$query = $this->db->query("select id,username,commander_id from user where current_game=".$this->id." and commander_id != 0");
		foreach ($query->result() as $row) {
			echo "<br><b><u>Commander ".$row->username."</u></b><br>";

			// TODO - calculate initiative for the commander at this point

			$activity = d10() + d10();
			echo "<font color=blue>Base Activity Number = $activity</font><br>";

			$unit_range = $this->get_unit_id_range($row->commander_id);
			$me_list = $this->get_me_list($unit_range->start_id,$unit_range->end_id);
			// we now have a list of the MEs for this user
			foreach ($me_list as $unit) {
				if ($unit->player_id == $row->id) {
					echo form_fieldset('[#'.$unit->id.'] - '.$unit->name);
					// Find out if parent ME engaged
					$parent_engaged = $this->db->get_where('game_engagement_unit',array('game_id'=>$this->id,'unit_id'=>$unit->id))->row();
					$me_activity = 0;
					$engagement = null;
					if ($parent_engaged) {
						$engagement = $this->db->get_where('game_engagement',array('game_id'=>$this->id,'id'=>$parent_engaged->engagement_id))->row();
						echo "<br><font color=red>Engaged at - ".$engagement->descr."</font>";
						$me_activity = d10() + d10();
						// Now calculate the tactical phase impulses for this ME

						// are there any leaders attached to any unit in this ME ?
						$leaders = $this->get_leaders_attached($unit);
						$me_activity_modifier = 0;
						foreach ($leaders as $leader) {
							$leader_unit = $this->get_unit($leader);
							switch ($leader_unit->unit_type) {
							case TYPE_ARMY:
							case TYPE_WING:
								$me_activity_modifier = $leader_unit->inspiration->me_activity_bonus * 2;
								break;
							case TYPE_CORPS:
								$me_activity_modifier = $leader_unit->inspiration->me_activity_bonus;
								break;
							case TYPE_DIVISION:
								// TODO - if Div commander is superior, add +2
								break;
							}
						}

						// Now apply national characteristics
						if ($this->orbat_defender == $unit->orbat_id) {
							$army_ch = $this->db->get_where('army_characteristics',array('id'=>$this->defender_characteristics))->row();
						} elseif ($this->orbat_attacker == $unit->orbat_id) {
							$army_ch = $this->db->get_where('army_characteristics',array('id'=>$this->attacker_characteristics))->row();
						} else {
							echo "ERROR: Unit ".$unit->id." is from orbat ".$unit->orbat_id." - dont know whether this attacker or defender";
						}
						$me_activity_modifier += $army_ch->me_activity_bonus;

						// Modifiy for whatever orders the ME has activated
						switch ($unit->current_order->order_type) {
						case '2': // attack
							$me_activity_modifier += 3;
							$me_activity_modifier += $army_ch->me_attack_bonus;
							break;
						case '1': // defend
							// TODO - some of these bonuses are only for infantry MEs !!
							$me_activity_modifier += $army_ch->me_defend_bonus;
							break;
						case '6': // rest and rally
							$me_activity_modifier -= 9;
							break;
						case '5': // redeploy
							$me_activity_modifier -= 6;
							break;
						}

						// Modify for amount of GT movement this hour
						$moved = $this->input->post($unit->id);
						switch ($moved) {
						case '0':
							break;
						case '600':
							$me_activity_modifier -= 1;
							break;
						case '1200':
							$me_activity_modifier -= 2;
							break;
						case '1200+':
							$me_activity_modifier -= 3;
							break;
						}

						// calculate the impulses for this ME
						$total = $me_activity + $me_activity_modifier;
						if ($total <= 9) {
							$impulses = 1;
						} elseif ($total <= 19) {
							$impulses = 2;
						} else {
							$impulses = 3;
						}

						// Create an acitivy record for this ME
						$data = new stdClass;
							$data->game_id = $this->id;
							$data->engagement_id = $engagement->id;
							$data->turn_number = $this->turn_number;
							$data->unit_id = $unit->id;
							$data->modifiers = $me_activity_modifier;
							$data->die_roll = $me_activity;
							$data->impulses = $impulses;
							if ($moved == '1200+') {
								$data->moved = 2400;
							} else {
								$data->moved = $moved;
							}
						$this->db->delete('game_engagement_initiative',array('game_id'=>$data->game_id,'engagement_id'=>$data->engagement_id,'unit_id'=>$data->unit_id));
						$this->db->insert('game_engagement_initiative',$data);


					} else {
						echo "<br><font color=green>Not Engaged</font>";
					}

					foreach ($unit->me_subunit as $subunit) {
						if ($subunit->unit_type == TYPE_BATTERY) {
							echo "<br>[#".$subunit->id."] - ".$subunit->name;

							$modifier = 0;
							$moved = $this->input->post($subunit->id);
							switch ($moved) {
							case '0':
								$modifier = +6;
								if ($parent_engagement->start_turn < $this->turn_number) {
									echo "<br><font color=red>Did not move, but parent ME was engaged last turn !</font>";
									$modifier = 0;
								}
								break;
							case '200':
								$modifier = 0;
								break;
							case '400':
								$modifier = -4;
								break;
							case '800':
								$modifier = -8;
								break;
							case '800+':
								$modifier = -12;
								break;
							}
							$total = $activity + $modifier;
							echo "<br><font color=blue>Modifier = $modifier, Total = $total</font>";

							// work out the turns
							if ($total < 1) {
								$turns = 0;
								$tdesc = '1/2 Effect in Phase 3 only';
							} elseif ($total < 6) {
								$turns = 1;
								$tdesc = 'Phase 3 only';
							} elseif ($total < 17) {
								$turns = 2;
								$tdesc = 'Phase 2 and 3';
							} else {
								$turns = 3;
								$tdesc = 'all Phases';
							}

							// Create the bombardment record
							$data = new stdClass;
								$data->game_id = $this->id;
								$data->turn_number  = $this->turn_number;
								$data->unit_id = $subunit->id;
								if ($moved == '800+') {
									$data->moved = 1600;
								} else {
									$data->moved = $moved;
								}
								$data->modifiers = $modifier;
								$data->die_roll = $activity;
								$data->rounds = $turns;
								$data->descr = $tdesc;
							$this->db->delete('game_bombardment_unit',array('game_id'=>$this->id,'turn_number'=>$this->turn_number,'unit_id'=>$subunit->id));
							$this->db->insert('game_bombardment_unit',$data);

							// get the current setting for this unit
							echo '<br>Modifiers = '.$modifier;
							echo '<br>Bombard Turns = '.$turns;
							echo '<br><font color=blue>Fires in '.$tdesc.'</font>';

							// add radio buttons for last movement
							$range1 = $this->yards_to_inches(200);
							$range2 = $this->yards_to_inches(400);
							$range3 = $this->yards_to_inches(800);

							// add radio buttons for last movement
							echo "<br>Move last Grand Tactical Round : ";
							echo '<table border=0 width=600 cellpadding=10><tr><td>None</td><td>up to '.$range1.'"</td><td>up to '.$range2.'"</td><td>up to '.$range3.'"</td><td>over '.$range3.'"</td></r>';
							echo '<tr><td>'.form_radio($subunit->id,'0',$moved == '0').'</td>';
							echo '<td>'.form_radio($subunit->id,'200',$moved == '200').'</td>';
							echo '<td>'.form_radio($subunit->id,'400',$moved == '400').'</td>';
							echo '<td>'.form_radio($subunit->id,'800',$moved == '800').'</td>';
							echo '<td>'.form_radio($subunit->id,'800+',$moved == '800+').'</td>';
							echo "</tr></table>";
						}
					}
					echo form_fieldset_close();
				}
			}
		}

		echo form_submit('submit','Calculate Bombardment Rounds');
		echo form_close();
	}
}

?>
