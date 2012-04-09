<?php

class Game extends MY_Controller {

	function index ($offset = 0) {
		
		if ($this->check_role('A')) {

			$form = new grocery_CRUD();
			$form->set_theme('datatables');
			$form->set_table('game');
			$form->set_subject('Games in Progress');
	
			// Fields and Columns
    			$form->columns('playing','id','name','scenario_id','start_hour','turn_number','orbat_attacker','orbat_defender','ground_scale','figure_scale');
    			$form->edit_fields('scenario_id','name','situation','players','start_hour','turn_number','orbat_attacker','attacker_briefing','orbat_defender','defender_briefing','ground_scale','figure_scale');
			$form->add_fields('scenario_id','ground_scale','figure_scale');
			//$form->display_as ('ground_scale','Ground Scale<br>1" = paces');
			//$form->display_as ('figure_scale','Figure Scale<br>1 figure = actual troops');
	
			// relations
			$form->set_relation('scenario_id','scenario','{id} {descr}'); 
			$form->set_relation('orbat_attacker','orbat','{id} {filename}'); 
			$form->set_relation('orbat_defender','orbat','{id} {filename}'); 
			$form->set_relation_n_n('players','game_users','user','game_id','user_id','username','side');
			$form->unset_texteditor('latitude','longitude','descr','video_intro');
	
			// Add actions and callbacks
			$form->add_action('PLAY', '', '','ui-icon-image',array($this,'select_game'));
			$form->callback_after_insert(array($this,'create_new_game'));
			$form->callback_column('playing',array($this,'is_playing'));
			$form->order_by('playing','desc');

			$this->render($form->render());
		}

	}

	function is_playing ($primary_key,$row) {
		$username = $this->session->userdata('username');
		$user = $this->db->query("select * from user where username='$username'")->row();
		if ((int)$user->current_game == (int)$row->id) {
			return '***';
		} 
		return '';
	}

	function select_game ($primary_ley,$row) {
		return site_url('game/play?id='.$row->id);
	}

	function play() {
		$id = $this->input->get('id');
		$username = $this->session->userdata('username');
		$user = $this->db->get_where('user',array('username' => $username))->row();
		if ($user->current_game == $id) {
			$id = 0;	// Allows the user to toggle playing the game or not !
		}
		$this->db->query("update user set current_game=$id,role='A' where username='$username'");
		redirect('game');
	}

	function create_new_game ($post_array,$primary_key) {

		print_r($post_array);
		// Lookup the scenario the game is based on
		$scenid = $post_array['scenario_id'];
		$scenario = $this->db->query("select descr,start_hour,latitude,longitude,attacker_briefing,defender_briefing,orbat_attacker,orbat_defender,video_intro from scenario where id=$scenid")->row();
		$descr = $scenario->descr;
		$descr = mysql_escape_string($descr);
		if ($scenario) {
			$data = array(
               			'start_hour' => $scenario->start_hour,
               			'turn_number' => 1,
               			'latitude' => $scenario->latitude,
               			'longitude' => $scenario->longitude,
               			'attacker_briefing' => $scenario->attacker_briefing,
               			'defender_briefing' => $scenario->defender_briefing,
               			'orbat_attacker' => $scenario->orbat_attacker,
               			'orbat_defender' => $scenario->orbat_defender,
				'video_intro' => $scenario->video_intro,
				'situation' => $scenario->descr
            		);
			$this->db->where('id',$primary_key);
			$this->db->update('game',$data);
		}

		// create the first game turn
		$data = array('game_id' => $primary_key,
			'turn_number' => 1,
			'initiative' => 1,
			'temperature' => 25,
			'wind_direction' => 1,
			'wind_speed' => 0,
			'rain' => 0,
			'visibility' => 1000,
			'ground_conditions' => 1,
			'weather_conditions' => 'Fine');
		$this->db->insert('game_turn',$data);
		
		// Now create a game_unit record for all units in the scenario
		// ... AND .. issue the unit their initial orders of Defend
		// ... AND .. create a spawn event for the unit
		$this->load->model('Unit_model');

		$attacker_orbat = $scenario->orbat_attacker;
		$units = $this->db->query("select * from unit where orbat_id=$attacker_orbat order by id");
		foreach ($units->result() as $unit) {
			// Add the unit to the game
			$data = array('game_id' => $primary_key,
				'unit_id' => $unit->id,
				'initial_strength' => $unit->strength,
				'initial_officers' => $unit->officers,
				'morale_state' => 1,
				'fatigue' => 0,
				'breakpoint' => $unit->breakpoint,
				'casualties' => 0,
				'dead' => 0,
				'officers_killed' => 0,
				'disabling_wounds' => 0,
				'light_wounds' => 0,
				'fled' => 0,
				'surrendered' => 0,
				'mutineers' => 0,
				'ammo' => 80,
				'food' => 80,
				'disorder' => 25,
				'cover' => '',
				'formation' => 'CL');
			$this->db->insert('game_unit_stats',$data);

			// Set the orders
			$data = array('game_id' => $primary_key,
				'turn_number' => 1,
				'activate_turn' => 1,
				'unit_id' => $unit->id,
				'player_name' => $this->session->userdata('username'),
				'order_type' => 1,  // Defend
				'comments' => 'Initial deployment');
			$this->db->insert('game_order',$data);

			// Create the spawn event
			$data = array('game_id' => $primary_key,
				'turn_number' => 1,
				'unit_id' => $unit->id,
				'event_type' => 2,	// Order Activated
				'descr' => "Unit joins scenario $descr",
				'value' => 1); // Defend
			$this->db->insert('game_event',$data);


		}

		$defender_orbat = $scenario->orbat_defender;
		$units = $this->db->query("select * from unit where orbat_id=$defender_orbat order by id");
		foreach ($units->result() as $unit) {
			// Add the unit to the game
			$data = array('game_id' => $primary_key,
				'unit_id' => $unit->id,
				'initial_strength' => $unit->strength,
				'initial_officers' => $unit->officers,
				'morale_state' => 1,
				'fatigue' => 0,
				'breakpoint' => $unit->breakpoint,
				'casualties' => 0,
				'dead' => 0,
				'officers_killed' => 0,
				'disabling_wounds' => 0,
				'light_wounds' => 0,
				'fled' => 0,
				'surrendered' => 0,
				'mutineers' => 0,
				'ammo' => 80,
				'food' => 80,
				'disorder' => 25,
				'cover' => '',
				'formation' => 'CL');
			$this->db->insert('game_unit_stats',$data);

			// Set the orders
			$data = array('game_id' => $primary_key,
				'turn_number' => 1,
				'activate_turn' => 1,
				'unit_id' => $unit->id,
				'player_name' => $this->session->userdata('username'),
				'order_type' => 1, // Defend
				'comments' => 'Initial deployment');
			$this->db->insert('game_order',$data);

			// Create the spawn event
			$data = array('game_id' => $primary_key,
				'turn_number' => 1,
				'unit_id' => $unit->id,
				'event_type' => 2,	// Order Activated
				'descr' => "Unit joins scenario $descr",
				'value' => 0);
			$this->db->insert('game_event',$data);
		}
		return true;


	}
}

?>
