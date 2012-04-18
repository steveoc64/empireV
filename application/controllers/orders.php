<?php

class Orders extends MY_Controller 
{
	function index() {

		// Access requires that the user belong to a game
		$this->load->model('game_model');
		$game = $this->game_model->get_current_game();
		if (!$game) {
			$this->render($this->load->view('oops',array('message','You are not logged into a game.<br>Ask the Administrator to fix this problem for you')));
			exit;
		}

		$this->start_hour = $game->start_hour;
		$form = new grocery_CRUD();
		$form->set_theme('datatables');
		$form->set_table('game_order');
		$form->set_subject('Queue of Unit Orders');
		$form->columns('turn_number','unit_id','order_type','objective','comments');
		$form->set_relation('unit_id','unit','{id} - {name}');
		$form->set_relation('order_type','order_types','name');
		$form->display_as('turn_number','Hour');
		$form->callback_column('turn_number',array($this,'display_hour'));
		$form->callback_column('objective',array($this,'display_objective'));

		switch ($this->session->userdata('role')) {
		case 'A':
		case 'U':
			// all orders in the current game, including the activation turn
			$form->columns('game_id','turn_number','activate_turn','player_name','unit_id','order_type','objective','comments');
			$form->where(array('game_id'=>$game->id));
			$form->callback_column('activate_turn',array($this,'display_turn'));
			$form->unset_delete();
			$form->set_theme('flexigrid');
			$form->unset_texteditor('objective');
			$form->unset_texteditor('comments');
			$form->set_relation('game_id','game','{id} - {name}');
			$extras = '<a href=orders><button>Refresh</button></a>';
			break;
		default:
			// see only your own orders, and no idea when they will be activated
			$form->where(array('game_id'=>$game->id,'player_name'=>$this->session->userdata('username')));
			$form->unset_operations();
			$extras = '';
			break;
		}

		$this->render($form->render(),'<h1>Orders</h1>',$extras);
	}

	function display_hour($primary_key,$row) {
		return sprintf("%02d:00 hrs", (int)$this->start_hour + (int)$row->turn_number - 1);
	}

	function display_turn($primary_key,$row) {
		return "Turn ".$row->activate_turn;
	}

	// Hack to show the full length objective, otherwise it gets truncated by the CRUD library
	function display_objective($primary_key,$row) {
		return $row->objective;
	}


}

?>

