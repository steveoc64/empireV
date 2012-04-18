<?php

class Briefing extends MY_Controller {

	function index ($offset = 0) {
		
		if (!$this->game) {
			$this->oops('You need to select a game to be able to access the briefing');
			exit;
		}

		$briefing = $this->game->get_briefing();
		$this->render("<h1>Game Briefing</h1>\n$briefing");
	}
}

?>
