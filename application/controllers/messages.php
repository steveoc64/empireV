<?php

class Messages extends MY_Controller 
{
	function index() {

		$this->load->model('game_model');
		$this->game = $this->game_model->get_current_game();
		if ($this->game) {
			// Create basic form
			$form = new grocery_CRUD();
			$form->set_theme('datatables');
			$form->set_table('game_message');
			$form->set_subject('Messages');
			$form->where(array('game_id'=>$this->game->id,'player_id'=>$this->game->user->id));
			$form->order_by("sent_turn","desc");
			
			$form->columns("sent_turn","turn_number","message","is_read");
			$form->unset_operations();
			$form->callback_column('sent_turn',array($this,'sent_turn'));
			$form->callback_column('turn_number',array($this,'turn_number'));
			$form->callback_column('message',array($this,'message'));
			$this->render($form->render());
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

