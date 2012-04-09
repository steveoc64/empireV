<?php

class Player_login extends MY_Controller 
{
	function index() {

		$_ = <<<EOF
<h1>Welcome to the Empire V - Electro Mechanical Apparatus for Combat Simulation</h1><p>
You have been appointed to take command of a unit in the game.
<p>
<button id="hq">Report for duty at HQ</button>
<p>
<center><img src=images/french-line.jpg></center>
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
