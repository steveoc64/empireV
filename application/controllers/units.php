<?php

class Units extends MY_Controller 
{
	function index() {

		$form = new grocery_CRUD();
		$form->set_table('unit');
		$form->set_subject('All Units');
		$form->unset_add();
		$form->unset_delete();
	
		$form->columns('parent_id','id','name','unit_type','is_me','strength','ace');
		$form->display_as('is_me','ME');
		$form->callback_column('is_me',array($this,'convert_me'));

		// Apply restrictions
		$title = '';
		$this->load->model('game_model');
		$game = $this->game_model->get_current_game();
		
		switch($this->session->userdata('role')) {
		case 'A':

			// Admin can see all units, unless he has selected a game to play, in which case he can 
			// only see units that are part of the current game.

			$id = (int) $this->uri->segment(3);
			if ($id) {
				// only looking at the subtree for this commander
				$form->where($this->game_model->get_unit_where_range($id));
				$title .= "showing unit $id, and subordinate units only";
				$form->columns('parent_id','id','name','unit_type','is_me','strength','ace','orbat_id');
				$form->display_as('orbat_id','ORBAT');
				$form->callback_column('unit.name',array($this,'indent_name2'));
				$form->callback_after_update(array($this,'cascade_me'));
			} else {
				if ($game) {
					$form->where('unit.orbat_id',$game->orbat_attacker);
					$form->or_where('unit.orbat_id',$game->orbat_defender);
					$title .= "Only showing attacker and defender forces for current game (#".$game->id." - ".$game->name.")";
					// Add some buttons - dont show them if there is no game selected for admin
					$form->add_action('Status', '', '','ui-icon-clipboard',array($this,'status_report'));
					$form->unset_edit();
				} else {
					// Admin gets to see the ORBAT file that the unit was loaded from
					$title .= "Showing all units for all games";
					$form->columns('parent_id','id','name','unit_type','is_me','strength','ace','orbat_id');
					$form->display_as('orbat_id','ORBAT');
					$form->callback_after_update(array($this,'cascade_me'));
				}
				$form->callback_column('unit.name',array($this,'indent_name2'));
			}
			break;
		case 'U':
			$form->set_theme('datatables');
			$id = (int) $this->uri->segment(3);
			if ($id) {
				// only looking at the subtree for this commander
				$form->where($this->game_model->get_unit_where_range($id));
				$title .= "showing unit $id, and subordinate units only";
			} else {
				// Umpire can only see units that are part of a game that he is playing
				$form->where('unit.orbat_id',$game->orbat_attacker);
				$form->or_where('unit.orbat_id',$game->orbat_defender);
				$title .= "Only showing attacker and defender forces for current game";
			}
			$form->unset_edit();
			// Add some buttons
			$form->add_action('Visit', '', '','ui-icon-clipboard',array($this,'status_report'));
			$form->callback_column('unit.name',array($this,'indent_name2'));
			break;
		case 'P':
			// Player can only see their own units, which are subordinate to their command
			$form->set_theme('datatables');
			if (! $game->user->commander_id) {
				$this->load->view('oops',array('message','Your player account is not associated with any on-table commander.<br>Ask the admin staff to fix this please ...'));
				exit;


			}
			$form->where($this->game_model->get_unit_where_range($game->user->commander_id));
			$title .= "<h1>Inspect the Troops</h1><img src=images/inspect-troops.jpg>";
			$form->unset_edit();
			// Add some buttons
			$form->add_action('Visit', '', '','ui-icon-clipboard',array($this,'status_report'));
			$form->callback_column('unit.name',array($this,'indent_name'));
			break;
		}

		$form->callback_column('unit_type',array($this,'convert_unit_type'));
		$form->display_as('id','UnitID');
		$form->display_as('parent_id','ParentID');
		$form->set_relation('orbat_id','orbat','filename');
		$form->set_relation('morale_grade','morale_grade','name');
		$form->set_relation('morale_state','morale_states','name');
		$form->order_by('id');
	
		$this->render($form->render(),$title);
	}

	function status_report($primary_key,$row) {
		return site_url('units/status?id='.$row->id);
	}

	function status() {
		$this->render_header('');
		$id = $this->input->get('id');
		if (!$id) {
			redirect('units');
		}
		
		// Get game data
		$this->load->model('game_model');
		$game = $this->game_model->get_current_game();

		// So far so good, now get the unit and associated game data
		$this->load->model('unit_model');
		$unit = $this->unit_model->get($id,$game->id);
		if (!$unit) {
			redirect('units');
		}
		$form_data['unit'] = $unit;

		$fail = false;

		// Do different things depending on what role the user has
		switch($this->session->userdata('role')) {
		case 'A':
			// Admin can view this record regardless
			$this->load->view('unit_status_report',$form_data);
			break;
		case 'U':
			if (!$fail) {
				// Umpire can only view report for units in this game
				if ($unit->orbat_id == $game->orbat_attacker || $unit->orbat_id == $game->orbat_defender) {
					$this->load->view('unit_status_report',$form_data);
				} else {
					$fail = true;
				}
			}
			break;
		case 'P':
			if (!$fail) {
				if (! $game->user->commander_id) {
					$this->load->view('oops',array('message',"Your player account is not associated with any on-table commander. Ask the admin to fix this problem please ..."));
				}
				// Player can only view units subordinate to their command
				$min = (int)$game->unit_id_range['start_unit'];
				$max = (int)$game->unit_id_range['end_unit'];
				$uid = (int)$unit->id;
				if ($uid >= $min && $uid <= $max) {
					$this->load->view('unit_status_report',$form_data);
				} else {
					$fail = true;
				}
			}
			break;
		}
		if ($fail) {
			$this->load->view('oops',array('message' => 'Unauthorised access to unit data.<br>Report to the system admin immediately !'));
		}
		$this->render_footer();
	}

	function indent_name($primary_key,$row) {

		//echo "Padding $name with $indents";
		$name = $row->name;
		$indents = $row->unit_type;
		$pad = '';
		for ($i = 1; $i <= $indents; $i++) {
			$pad .= '&nbsp;';
		}
		return $pad.$name;
	}

	function indent_name2($primary_key,$row) {

		//echo "Padding $name with $indents";
		$name = $row->name;
		$indents = $row->unit_type;
		$pad = '';
		for ($i = 1; $i <= $indents; $i++) {
			$pad .= '&nbsp;';
		}

		if ($indents < 5) {
			// Can have subordinates, so make it a lnk
			$id = (int)$row->id;
			return "<a href=".site_url("units/index/$id").">$pad$name</a>";
		}
		return $pad.$name;
	}


	function convert_unit_type($primary_key,$row) {

		$indents = $row->unit_type;
		$name = $this->db->query("select name from unit_type where id=$indents")->row()->name;
		$pad = '';
		for ($i = 1; $i <= $indents; $i++) {
			$pad .= '&nbsp;';
		}
		return $pad.$name;
	}

	function get_id_range ($id) {
		$start_id = $id; // this is the lowest value
		$last_id = $id; // this is the lowest value
		//echo "ID range is $start_id to $last_id<br>";

		$row = $this->db->query("select max(id) as last_child from unit where parent_id=$id")->row();
		if ($row && $row->last_child) {
			// Last Corps level
			//echo "last Corps of that one is ".$row->last_child."<br>";
			$last_id = $row->last_child;
			$row = $this->db->query("select max(id) as last_child from unit where parent_id=".$row->last_child)->row();
			if ($row && $row->last_child) {
				// Last Division level
				//echo "last Division of that one is ".$row->last_child."<br>";
				$last_id = $row->last_child;
				$row = $this->db->query("select max(id) as last_child from unit where parent_id=".$row->last_child)->row();
				if ($row && $row->last_child) {
					// Last Brigade level
					//echo "last Brigade of that one is ".$row->last_child."<br>";
					$last_id = $row->last_child;
					$row = $this->db->query("select max(id) as last_child from unit where parent_id=".$row->last_child)->row();
					if ($row && $row->last_child) {
						// Last Battalion level - cant go any lower !
						$this->load->view('oops',array('message',"Seem to be too deeply nested on the command structure.<br>Ask the admin staff to fix this problem please ..."));
						exit;
					}
					//echo "ID range is $start_id to $last_id<br>";
				}
				//echo "ID range is $start_id to $last_id<br>";
			}
			//echo "ID range is $start_id to $last_id<br>";

		}
		return "(unit.id >= $start_id and unit.id <= $last_id)";
	}

	function convert_me($primary_key,$row) {
		if ($row->is_me == 'T') {
			return '*';
		} else {
			return '';
		}
	}

	function cascade_me($post_array,$primary_key) {
		$range = $this->get_id_range($primary_key);
		if ($post_array['is_me'] =='T') {
			$query = $this->db->query("update unit set parent_me=$primary_key where $range");
		} else {
			$query = $this->db->query("update unit set parent_me=0 where $range");
		}
		// Last but not least, make sure our parent ME is clear !
		$query = $this->db->query("update unit set parent_me=0 where id=$primary_key");
	}

}
