<?php

class User_account extends MY_Controller 
{
	function index() {

		if ($this->check_role('A')) {
			// Create basic form
			$form = new grocery_CRUD();
			$form->set_theme('datatables');
			$form->set_table('user');
			$form->set_subject('User Accounts');
			$form->unset_add();
	
			// Fields and Columns
    			$form->columns('username','last_login','email','current_game','role','commander_id');
    			$form->fields('username','last_login','email','current_game','role','commander_id');
			$form->set_relation('role','user_roles','name');
			$form->set_relation('current_game','game','{id} - {name}');
			//$form->set_relation('commander_id','unit','{id} - {name}',array('is_command' => 'T'));
			$form->callback_column('commander_id',array($this,'commander_link'));
			//$form->set_relation_n_n('games','game_users','game','user_id','game_id','name','side');
			//
			$form->callback_after_update(array($this,'set_unit_player_id'));

			$this->render($form->render());
		}
	}

	function commander_link ($primary_key, $row) {
		$commander = (int)$row->commander_id;
		if (!$commander) {
			if ($row->role == 'P') {
				// Player accounts MUST have a commander ID
				return "<font color=red>NONE</font>";
			} else {
				return '';
			}
		}
		$row = $this->db->get_where('unit',array('id'=>$commander))->row();
		$string = "$commander - ".$row->name;

		if ($commander) {
			return "<a href=".site_url("units/index/$commander").">$string</a>";
		}
		return $string;
	}

	// set the player ID on all units now controlled by this player
	function set_unit_player_id($post_array,$primary_key) {
		$current_game = (int)$post_array['current_game'];
		$commander_id = (int)$post_array['commander_id'];
		$player_id = (int)$primary_key;

		if ($current_game && $commander_id) {
			$where = $this->get_id_range($commander_id);
			$this->db->query("update game_unit_stats set player_id=$primary_key where game_id=$current_game and $where");

		} 
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
		return "(unit_id >= $start_id and unit_id <= $last_id)";
	}
}

?>

