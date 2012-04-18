<?php

class Update_unit_posn extends CI_Controller {
	
	function index() {

		$this->load->model('game_model');
		$game = $this->game_model->get_current_game(false);
		if ($game) {
			$unit = (int)$this->input->post('unitid');
			$x = (int)$this->input->post('x');
			$y = (int)$this->input->post('y');
			if ($x < 0) { $x = 0; }
			if ($x > 2000) { $x = 2000; }
			if ($y < 0) { $y = 0; }
			if ($y > 2000) { $y = 2000; }
			$this->db->query("update game_unit_stats set x=$x,y=$y where game_id=".$game->id." and unit_id=$unit");
			$this->db->last_query();
		}
	}

}
