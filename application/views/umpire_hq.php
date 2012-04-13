<button id="hq">Return to HQ</button>
<div id="console">
<?

// Show game stats

if (isset($game)) {
	echo '<br><br>(Turn: '.$game->turn_number.'). ';
	echo '<i>Weather Report: '.$game->weather_report.'</i>';
	echo "<br>";

	switch ($game->phase) {
	case PHASE_ORDERS:
		echo "<h2>Orders Phase ~ ".$game->hrs."</h2>";
		echo "<center><div id=clock></div></center>";
		echo "<b>Commanders may currently submit new orders.</b><p><i>The orders appear on this screen in real time as they are entered. Once commanders have had a fair opportunity to dispatch orders, click the Close Off Orders button to move along to the next phase.<p>Note that in standard Empire V, the players get strictly 2 minutes to perform these orders.</i><br>\n";

		echo "<button id='view_orders'>Edit Orders</button><button id='close_orders'>Close Off Orders</button>";

		// A quick report in table format of the current orders
		echo "<div id=orders></div>";
		echo "<div id=results></div>";
		break;
	case PHASE_MORALE:
		echo "<h2>Morale Determination Phase ~ ".$game->hrs."</h2>\n";
		echo "<button id=me_determination>Re-Roll Determination Test</button>";
		echo "<div id=me_determination_results></div>";
		echo "<button id=me_morale>Accept ME Determination Test</button>\n";
		break;
	case PHASE_LEADERS:
		break;
	case PHASE_BREAKOFF:
		break;
	case PHASE_GT:
		break;
	case PHASE_ENGAGE:
		break;
	case PHASE_TACTICAL:
		break;
	case PHASE_LEADERCAS:
		break;
	case PHASE_RALLY:
		break;
	default:
		break;
	}
} else {

?>
	<div id="form">
	<center><img src=/empire/images/firing-squad.jpg></center>
	You are not currently logged in to a game<p>Ask the administrator to setup your<br>account to access a game in progress.
	</div>
<?  } ?>


<p>
<center>
<img src=images/fancy-2.png>
</center>

</div> <!-- console -->
<script>
// On load - setup all the buttons
$(function() { 
	$("#menu").hide();
	$('#main').animate({ left: "20px", top: "0px"}, 500 );
	$("#console").fadeIn(500);
	$("#orders").load('umpire_console/refresh_orders');

	// Kick off the order refresh - every 10 seconds, it fades out, reloads and fades back in
	setInterval(function() {
		$("#orders").hide().load('umpire_console/refresh_orders').fadeIn(3000);
	}, 10000);

	$("#me_determination_results").load("umpire_console/me_determination");

	// Kick off the ME determination test

	// Kick off the clock
	var seconds = 0;
	setInterval(function() {
		if (seconds < 60) {
			color='green';
		} else if (seconds < 120) {
			color='blue';
		} else {
			color='red';
		}
		$('#clock').html('<font size=+2 color='+color+'><b>'+seconds+'s elapsed</b></font>');
		seconds ++;
	}, 1000);
});

// Return to HQ
$("#hq").click(function () { 
	$("#console").hide(1000); 
	$("#hq").hide(800); 
	$("#main").hide(800);
	$("#menu").fadeIn(1000); 
});

// Jump to order maintenance
$('#view_orders').click(function(){ document.location.href='/empire/orders'; })

// PHASE 1 : Close off orders and proceed to ME determination
$("#close_orders").click(function(){  
	// Hide widgets we dont need no more
	$("#view_orders").hide(1000); 
	$("#close_orders").hide(1000); 

	if (confirm('This will close off all orders and advance the game to ME determination. Do you want to proceed ?')) {
		$("#orders").hide();
		$("#results").load('umpire_console/close_orders', function() {
			//alert($('#results').text().replace('<br>',"\n"));
			location.reload();
		});

	}
});  

// PHASE 2 - re-roll the determination test in case not happy with the results !
$("#me_determination").click(function(){
	$("#me_determination_results").hide().load('umpire_console/me_determination').fadeIn(3000);
});

// PHASE 2 - accept the determination test and proceed to ME morale test
$("#me_moral").click(function(){
});
</script>
