<?php

class Messages extends MY_Controller 
{
	function index() {

		if ($this->game) {
			// Create basic form
			$form = new grocery_CRUD();
			$form->set_theme('datatables');
			$form->set_table('game_message');
			$form->set_subject('Messages');
			$extras = '';
			switch ($this->session->userdata('role')) {
			case 'A':
			case 'U':
				// Can see messages in transit, for all users
				$form->where(array('game_id'=>$this->game->id));
				$form->display_as('turn_number','Due');
				$form->columns("sent_turn","turn_number","message","player_id","is_read");
				$form->set_relation('player_id','user','username');
				$extras = "Includes all messages yet to be delivered to all players in this game";
				break;
			default:
				// Can only see delivered messages
				$form->where(array('game_id'=>$this->game->id,'player_id'=>$this->game->user->id,'turn_number <='=>$this->game->turn_number));
				$form->display_as('turn_number','Received');
				$form->columns("sent_turn","turn_number","message","is_read");
				break;
			}
			$form->order_by("timestamp","desc");
			
			$form->unset_operations();
			$form->callback_column('sent_turn',array($this,'sent_turn'));
			$form->callback_column('turn_number',array($this,'turn_number'));
			$form->callback_column('message',array($this,'message'));
			$form->display_as('sent_turn','Sent');
			$this->render($form->render(),"<h2>Messages Received from the Staff Officers</h2>$extras");
		} else {
			$this->oops('You need to be logged in to a game to be able to view messages');
		}
	}

	function sent_turn($primary_key,$row) {
		$hour = $this->game->start_hour + (int)$row->sent_turn - 1;
		return "$hour:00 hrs";
	}

	function turn_number($primary_key,$row) {
		$hour = $this->game->start_hour + (int)$row->turn_number - 1;
		return "$hour:00 hrs";
	}

	function message($primary_key,$row) {
		return $row->message;
	}

}

?>
