<?php

class Umpire_Console extends MY_Controller 
{
	////////////////////////////////////////////////////////////////////////////////
	//  Cards maintenance
	function index() {

		if ($this->check_role(array('A','U'))) {

			$this->load->model('game_model');
			$this->load->model('unit_model');
			$game = $this->game_model->get_current_game();
			if ($this->uri->segment(3) != '') { 
				// Ajax refresh of the console - dont sent all the header stuff, just the console content
				$this->load->view('umpire_hq',array('game'=>$game,$this->uri->segment(3)=>true,'game_model'=>$this->game_model),false);
			} else {
				$this->render($this->load->view('umpire_hq',array('game'=>$game,'game_model'=>$this->game_model),true));
			}
		}
	}

	function close_orders() {
		if ($this->check_role(array('A','U'))) {
			$this->load->model('game_model');
			$this->game_model->close_orders();
			echo "Orders are now closed ...";
		}
	}

}
