<?php

class Update_unit_posn extends CI_Controller {
	
	function index() {

		$this->load->model('game_model');
		$game = $this->game_model->get_current_game(false);
		if ($game) {
			$unit = (int)$this->uri->segment(3);
			$x = (int)$this->uri->segment(4);
			$y = (int)$this->uri->segment(5);
			if ($x < 200) { $x = 200; }
			if ($x > 1000) { $x = 1000; }
			if ($y < 100) { $y = 100; }
			if ($y > 2000) { $y = 2000; }
			$this->db->query("update game_unit_stats set x=$x,y=$y where game_id=".$game->id." and unit_id=$unit");
			$this->db->last_query();
		}
	}

}
