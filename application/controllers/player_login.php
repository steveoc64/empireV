<?php

class Player_login extends MY_Controller 
{
	function index() {

		$this->load->model('game_model');
		$game = $this->game_model->get_current_game(false);
		$img = "images/french-line.jpg";
		if ($game && $game->national_theme) {
			$img = "themes/".$game->national_theme->login_img;
		} 
		$_ = <<<EOF
<h1>Welcome to the Empire V - Electro Mechanical Apparatus for Combat Simulation</h1><p>
You have been appointed to take command of a unit in the game.
<p>
<button id="hq">Report for duty at HQ</button>
<p>
<center><img src=
EOF;
		$_ .= $img;
		$_ .= <<<EOF
></center>
<script>
$(function() { 
	$("#menu").hide();
	$('#main').animate({ left: "20px", top: "0px" }, 100 );
});
$("#hq").click(function () { 
	$('#main').animate({ left: "180px", top: "70px" }, 2000 );
	$("#menu").fadeIn(5000); 
});
</script>
EOF;

		$this->render($_);

	}
}
