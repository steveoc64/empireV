<?php

class Umpire_login extends MY_Controller 
{
	function index() {

		$_ = <<<EOF
<h1>Welcome to the Empire V - Electro Mechanical Apparatus for Combat Simulation</h1><p>
<center>
You have been appointed to Umpire a Game !
<p>
<button id="hq">Report for duty at HQ</button>
<p>
<img src=images/french-line.jpg></center>
<script>
$(function() { 
	$("#menu").hide();
	$('#main').animate({ left: "20px", top: "0px", opacity: 1.0 }, 100 );
});
$("#hq").click(function () { 
	$('#main').animate({ left: "180px", top: "70px", opacity: 0.9 }, 500 );
	$('#main').fadeOut(5000);
	$("#menu").fadeIn(3000); 
});
</script>
EOF;

		$this->render($_);

	}
}
