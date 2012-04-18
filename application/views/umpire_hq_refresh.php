<button id="hq">Return to HQ</button></td>
<?

// Calculate 400yds in inches, based on the current game scale
if ($game->ground_scale != 0) {
	$distance400 = sprintf("400yds (%d inches)",(int)(400/$game->ground_scale));;
} else {
	$distance400 = "400yds (10 inches)";
}
// Show game stats

if (isset($game)) {
	echo '<br><br>(Turn: '.$game->turn_number.'). ';
	echo '<i>Weather Report: '.$game->weather_report.'</i>';
	echo "<br>";
	$t = '<font size=+2><b>0:00</b></font>';

	switch ($game->phase) {
	case PHASE_ORDERS:
		echo "<h2>Orders Phase ~ ".$game->hrs."</h2>";
		echo "<center><div id=clock>$t</div></center>";
		echo "<b>Commanders may currently submit new orders.</b><p><i>The orders appear on this screen in real time as they are entered. Once commanders have had a fair opportunity to dispatch orders, click the Close Off Orders button to move along to the next phase.<p>Note that in standard Empire V, the players get strictly 2 minutes to perform these orders.</i><br>\n";

		echo "<button id='view_orders'>Edit Orders</button><button id='close_orders'>Close Off Orders</button>";

		// A quick report in table format of the current orders
		echo "<div id=orders></div>";
		echo "<div id=results></div>";
		break;
	case PHASE_ME_DET:
		echo "<h2>Morale Determination Phase ~ ".$game->hrs."</h2>\n";
		echo "<center><div id=clock>$t</div></center>";
		echo "<table border=0 width=90%><tr><td align=left>";
		echo "<button id=me_determination>Re-Roll Determination Test</button>";
		echo "</td><td align=right>";
		echo "<button id=accept_me_determination>Accept ME Determination Test &gt;</button>\n";
		echo "</td></tr></table>";
		echo "<div id=me_determination_results></div>";
		//echo "<button id=me_morale>Accept ME Determination Test</button>\n";
		break;
	case PHASE_ME_MORALE:
		echo "<h2>ME Morale Phase ~ ".$game->hrs."</h2>\n";
		echo "<center><div id=clock>$t</div></center>";
		echo "<table border=0 width=90%><tr><td align=left>";
		echo "<button id=morale_test>Run Selected Morale Tests</button>";
		echo "<button id=morale_help>Morale Test Help Notes</button>";
		echo "</td><td align=right>";
		echo "<button id=morale_test_done>Leader Attach &gt;</button>";
		echo "</td></tr></table>";
		echo "<div id=morale_test_form></div>";
		echo "<div id=results></div>";
		break;
	case PHASE_LEADER_ATTACH:
		echo "<h2>Leader Attach Phase ~ ".$game->hrs."</h2>\n";
		echo "<center><div id=clock>$t</div></center>";
		echo "<table border=0 width=90%><tr><td align=left><button id=rewind>&lt; ME Morale</button></td>";
		echo "<td align=right><button id=leader_attach_done>Declare Orders &gt;</button></td></tr></table>";
		echo "<div id=results></div>";
		break;
	case PHASE_DECLARE_ORDERS:
		echo "<h2>Declare Orders Phase ~ ".$game->hrs."</h2>\n";
		echo "<center><div id=clock>$t</div></center>";
		echo "<table border=0 width=90%><tr><td align=left>";
		echo "<button id=rewind>&lt; Leader Attach</button>";
		echo "</td><td align=right>";
		echo "<button id=declare_orders_done>Activate Orders &gt;</button>";
		echo "</td></tr></table>";
		echo "<div id=results></div>";
		break;
	case PHASE_ACTIVATE_ORDERS:
		echo "<h2>Activate Orders Phase ~ ".$game->hrs."</h2>\n";
		echo "<center><div id=clock>$t</div></center>";
		echo "<table border=0 width=90%><tr><td align=left>";
		echo "<button id=rewind>&lt; Declare Orders</button>";
		echo "</td><td align=right>";
		echo "<button id=activate_orders_done>BreakOff Movement &gt;</button>";
		echo "</td></tr></table>";
		echo "<div id=results></div>";
		break;
	case PHASE_BREAKOFF:
		echo "<h2>Units on BreakOff Orders Disengage ~ ".$game->hrs."</h2>\n";
		echo "<center><div id=clock>$t</div></center>";
		echo "<table border=0 width=90%><tr><td align=left>";
		echo "<button id=rewind>&lt; Activate Orders</button>";
		echo "</td><td align=right>";
		echo "<button id=breakoff_done>Grand Tactical Movement &gt;</button>";
		echo "</td></tr></table>";
		echo "<div id=results></div>";
		break;
	case PHASE_GT:
		echo "<h2>Grand Tactical Movement Phase ~ ".$game->hrs."</h2>\n";
		echo "<center><div id=clock>$t</div></center>";
		echo "<table border=0 width=90%><tr><td align=left>";
		echo "<button id=rewind>&lt; BreakOff</button>";
		echo "</td><td align=right>";
		echo "<button id=gt_done>Determine Bombardment &gt;</button>";
		echo "</td></tr></table>";
		echo "<div id=results></div>";
		break;
	case PHASE_DETERMINE_BOMBARDMENT:
		echo "<h2>Deetermine Bombardment Phase ~ ".$game->hrs."</h2>\n";
		echo "<center><div id=clock>$t</div></center>";
		echo "<table border=0 width=90%><tr><td align=left>";
		echo "<button id=rewind>&lt; Grand Tactical</button>";
		echo "</td><td align=right>";
		echo "<button id=determine_bombardment_done>Tactical Movement &gt;</button>";
		echo "</td></tr></table>";
		echo "<div id=results></div>";
		break;
	case PHASE_ENGAGE:
		echo "<h2>Run Engagements (Tactical Movement) Phase ~ ".$game->hrs."</h2>\n";
		echo "<center><div id=clock>$t</div></center>";
		echo "<table border=0 width=90%><tr><td align=left>";
		echo "<button id=rewind>&lt; Determine Bombardment</button>";
		echo "</td><td align=right>";
		echo "<button id=engage_done>Commander Casualty &gt;</button>";
		echo "</td></tr></table>";
		echo "<div id=results></div>";
		break;
	case PHASE_COMMANDER_CAS:
		echo "<h2>Commander Casualties Phase ~ ".$game->hrs."</h2>\n";
		echo "<center><div id=clock>$t</div></center>";
		echo "<table border=0 width=90%><tr><td align=left>";
		echo "<button id=rewind>&lt; Tactical Movement</button>";
		echo "</td><td align=right>";
		echo "<button id=commander_cas_done>Rally &gt;</button>";
		echo "</td></tr></table>";
		echo "<div id=results></div>";
		break;
	case PHASE_RALLY:
		echo "<h2>Rally Phase ~ ".$game->hrs."</h2>\n";
		echo "<center><div id=clock>$t</div></center>";
		echo "<table border=0 width=90%><tr><td align=left>";
		echo "<button id=rewind>&lt; Commander Casualites</button>";
		echo "</td><td align=right>";
		echo "<button id=rally_done>Rest &gt;</button>";
		echo "</td></tr></table>";
		echo "<div id=results></div>";
		break;
	case PHASE_REST:
		echo "<h2>Rest Phase ~ ".$game->hrs."</h2>\n";
		echo "<center><div id=clock>$t</div></center>";
		echo "<table border=0 width=90%><tr><td align=left>";
		echo "<button id=rewind>&lt; Rally</button>";
		echo "</td><td align=right>";
		echo "<button id=rest_done>End of Hour &gt;</button>";
		echo "</td></tr></table>";
		echo "<div id=results></div>";
		break;
	case PHASE_END_OF_HOUR:
		echo "<h2>End of Hour ~ ".$game->hrs."</h2>\n";
		echo "<center><div id=clock>$t</div></center>";
		echo "<table border=0 width=90%><tr><td align=left>";
		echo "<button id=rewind>&lt; Rest</button>";
		echo "</td><td align=right>";
		echo "<button id=end_of_hour_done>Move to the Next Hour &gt;</button>";
		echo "</td></tr></table>";
		echo "<div id=results></div>";
		break;
	default:
		break;
	}
} else {

?>
	<div id="form">
	<center><img src=<?site_url()?>images/firing-squad.jpg></center>
<? if ($this->session->userdata('role') == 'A') {
	echo "You need to select which game to Umpire.<p>Please go to the <a href=game>Game List</a> and select the game by hitting the 'Play' button. Thanks.";
} else {
	echo "You are not currently logged in to a game<p>Ask the administrator to setup your<br>account to access a game in progress.";
}?>
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
	$('#main').animate({ left: "20px", top: "0px"}, 10 );
	$("#console").fadeIn(100);
	$("#orders").load('umpire_console/refresh_orders');

	// Kick off the order refresh - every 10 seconds, it fades out, reloads and fades back in
	//setInterval(function() {
		//$("#orders").hide().load('umpire_console/refresh_orders').fadeIn(3000);
	//}, 10000);

	// Phase 2 buttons init and kick off tests
	$("#accept_me_determination").hide();
	$("#me_morale").hide();
	$("#me_determination_results").load("umpire_console/me_determination");
	$("#accept_me_determination").fadeIn(5000);

	// Phase 3 buttons init and kick off tests
	$("#morale_test_done").hide();
	$("#morale_test").fadeIn(3000);
	$("#morale_test_form").load("umpire_console/morale_test_form",function(){ 
		$("#morale_test_done").fadeIn(4000);
	});


	/*
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
	 */
});

// Return to HQ
$("#hq").click(function () { 
	$("#console").hide(1000); 
	$("#hq").hide(800); 
	$("#main").hide(800);
	$("#menu").fadeIn(1000); 
});

// Jump to order maintenance
$('#view_orders').click(function(){ document.location.href='<?site_url()?>orders'; })

// PHASE 1 : Close off orders and proceed to ME determination
$("#close_orders").click(function(){  
	// Hide widgets we dont need no more
	$("#view_orders").hide(1000); 
	$("#close_orders").hide(1000); 

	if (confirm('This will close off all orders and advance the game to ME determination. Do you want to proceed ?')) {
		$("#orders").hide();
		$("#results").load('umpire_console/close_orders', function() {
			//alert($('#results').text().replace('<br>',"\n"));
			$("#console").load('umpire_console/refresh');
		});

	}
});  

// PHASE 2 - re-roll the determination test in case not happy with the results !
$("#me_determination").click(function(){
	$("#me_determination_results").hide().load('umpire_console/me_determination').fadeIn(3000);
});

// PHASE 2 - accept the determination test and proceed to ME morale test
$("#accept_me_determination").click(function(){
	$("#accept_me_determination").hide();
	$("#me_determination").hide();
	$("#me_determination_results").hide().load('umpire_console/accept_me_determination',function(){ $("#console").load('umpire_console/refresh') });
});

// PHASE 3 - Run Morale Tests
$("#morale_help").click(function() {
	$('<div id=help_dialog></div>').load('morale_help').dialog({modal:true, width:800, height:400});
});
$("#morale_test").click(function() {
	var units = new Array();
	$(':checkbox').map(function() {
		if (this.checked) {
			units.push(this.name);
		}
	});
	if (units.length == 0) {
		alert("No units selected ... :(");
	} else {
		if (confirm("Do you want to run a morale check for "+units+"\n\nYou are sure that these units are within <?=$distance400?> of an ME which failed in some way,\nand these units are not 2 or more morale grades above them ?")) {
			$('<div></div>').load('umpire_console/morale_test',{'units[]': units}).dialog({modal:true, width:900, height:600});
			$("#morale_test_form").load("umpire_console/morale_test_form",function(){ $("#morale_test_done").fadeIn(2000);});
			//$(':checkbox').map(function() {
				//this.checked = false;
			//});
		}
	}

});

$("#morale_test_done").click(function() {

	var has_any = false;
	$(':checkbox').map(function() {
		if (this.checked) {
			has_any=true;
		}
	});
	if (has_any) {
		alert('You still have un-processed Morale Checks selected');
	} else {
		//if (confirm('Are you all finished with Morale Tests then ?\nOnly proceed if you are absolutely sure that all ME morale checks are complete, which will advance the game to the next phase')) {
			$("#morale_test_form").fadeOut(3000).load('umpire_console/morale_test_done',function() { $("#console").load('umpire_console/refresh')});
		//}
	}
});

$("#leader_attach_done").click(function() { $("<div></div>").load('umpire_console/leader_attach_done',function() { $("#console").load('umpire_console/refresh')})});
$("#declare_orders_done").click(function() { $("<div></div>").load('umpire_console/declare_orders_done',function() { $("#console").load('umpire_console/refresh')})});
$("#activate_orders_done").click(function() { $("<div></div>").load('umpire_console/activate_orders_done',function() { $("#console").load('umpire_console/refresh')})});
$("#breakoff_done").click(function() { $("<div></div>").load('umpire_console/breakoff_done',function() { $("#console").load('umpire_console/refresh')})});
$("#gt_done").click(function() { $("<div></div>").load('umpire_console/gt_done',function() { $("#console").load('umpire_console/refresh')})});
$("#determine_bombardment_done").click(function() { $("<div></div>").load('umpire_console/determine_bombardment_done',function() { $("#console").load('umpire_console/refresh')})});
$("#engage_done").click(function() { $("<div></div>").load('umpire_console/engage_done',function() { $("#console").load('umpire_console/refresh')})});
$("#commander_cas_done").click(function() { $("<div></div>").load('umpire_console/commander_cas_done',function() { $("#console").load('umpire_console/refresh')})});
$("#rally_done").click(function() { $("<div></div>").load('umpire_console/rally_done',function() { $("#console").load('umpire_console/refresh')})});
$("#rest_done").click(function() { $("<div></div>").load('umpire_console/rest_done',function() { $("#console").load('umpire_console/refresh')})});
$("#end_of_hour_done").click(function() { $("<div></div>").load('umpire_console/end_of_hour_done', function() { $("#console").load('umpire_console/refresh') })});

$("#rewind").click(function() { $("<div></div>").load('umpire_console/rewind',function() { $("#console").load('umpire_console/refresh')})});

</script>
