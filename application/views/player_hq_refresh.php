<button id="hq">Return to HQ</button></td>
<?
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
		//echo "You may submit new orders for the following Maneuvre Elements<p>";

		echo "<input id=objective size=100 value='Enter a short objective for the orders here.'></input>";
		echo "<div id=orders>";
		echo "<div id=order order=1 class=ui-widget-content>Defend</div>";
		echo "<div id=order order=2 class=ui-widget-content>Attack</div>";
		echo "<div id=order order=3 class=ui-widget-content>March</div>";
		echo "<div id=order order=4 class=ui-widget-content>Withdraw</div>";
		echo "<div id=order order=5 class=ui-widget-content>ReDeploy</div>";
		echo "<div id=order order=6 class=ui-widget-content>Rally</div>";
		echo "<div id=order_cav order=7 class=ui-widget-content>Support</div>";
		echo "<div id=order order=8 class=ui-widget-content>BreakOff</div>";
		echo "<div id=order_inf order=9 class=ui-widget-content>Garrison</div>";
		echo "<div id=order order=10 class=ui-widget-content>SauveQuiPeut</div>";
		echo "</div>";
		// Display all top level units owned by this player in a large box,
		// place a set of widgets inside each box representing the MEs for that
		// unit.  Each ME widget is draggable to display (roughly) the layout of the
		// formation. 
		//
		// Finally, the order buttons above can be dragged and dropped onto the MEs
		$last_parent = -1;

		foreach ($game->me as $me) {
			// check that we own this ME first - it could be under a subcommander !
			if ($me->player_id == $this->session->userdata('user_id')) {
			if ($me->parent_id != $last_parent) {
				if ($last_parent > -1) { echo "</div>"; }
				$parent_name = '';
				if ($me->parent_id) {
					$parent_name = $this->db->get_where('unit',array('id'=>$me->parent_id))->row()->name;
				}
				echo "<div id=corps><font font-family=serif color='#51301f'><font size=12px>".$me->parent_id."</font><p>".$parent_name."</font>";
			}
			$last_parent = $me->parent_id;
			$x =(int)$me->x;
			$y = (int)$me->y;
			$style='';
			if ($x && $y) {
				$style = sprintf("style=\"left: %dpx; top: %dpx; position: absolute;\"",$x,$y);
			}
			echo "<div id=me unitid=".$me->id." unittype=".$me->unit_type." $style class=ui-widget-content>[".$me->id."]<br> ".$me->name."<br> (<font color=blue>".$me->current_order_type->name." ".$me->current_order->objective."</font>)</div>\n";
			}
		}
		if ($last_parent > -1) {
			echo "</div>";
		}
		//echo "</div>";
		echo "<div id=orders>";
		echo "<div id=order order=1 class=ui-widget-content>Defend</div>";
		echo "<div id=order order=2 class=ui-widget-content>Attack</div>";
		echo "<div id=order order=3 class=ui-widget-content>March</div>";
		echo "<div id=order order=4 class=ui-widget-content>Withdraw</div>";
		echo "<div id=order order=5 class=ui-widget-content>ReDeploy</div>";
		echo "<div id=order order=6 class=ui-widget-content>Rally</div>";
		echo "<div id=order_cav order=7 class=ui-widget-content>Support</div>";
		echo "<div id=order order=8 class=ui-widget-content>BreakOff</div>";
		echo "<div id=order_inf order=9 class=ui-widget-content>Garrison</div>";
		echo "<div id=order order=10 class=ui-widget-content>SauveQuiPeut</div>";
		echo "</div>";

	
		break;
	case PHASE_ME_DET:
	case PHASE_ME_MORALE:
		echo "<h2>Morale Phase ~ ".$game->hrs."</h2>";
		echo "<center><div id=clock>$t</div></center>";
		echo "Umpire is just working out morale tests .. try again soon ";
		echo "<button id=refresh_page>Refresh Page</button>";
		break;
	case PHASE_LEADER_ATTACH:
		echo "<h2>Leader Attach Phase ~ ".$game->hrs."</h2>\n";
		echo "<center><div id=clock>$t</div></center>";
		echo "<button id=leader_attach_done>DONE</button>";
		echo "<button id=leader_attach_not_done>Not Done</button>";
		$distance = $game->yards_to_inches(800);
		echo "<div id=leader_attach_form></div>";
		echo "<table border=1>";
		echo "</div>";
		echo "<br><br><i>Leaders may move up to 800 yards ($distance inches) to attach to any unit. Move the leader figures on the table, and update the lists on this screen when you are done. It is important for the computer to know which units leaders are attached to, as this provides a number of bonuses for both combat and morale.</i>";
		break;
	case PHASE_DECLARE_ORDERS:
		echo "<h2>Declare Orders Phase ~ ".$game->hrs."</h2>\n";
		echo "<center><div id=clock>$t</div></center>";
		echo "<button id=refresh_page>Refresh Page</button>";
		echo "<div id=declare_orders_form><div>";
		break;
	case PHASE_ACTIVATE_ORDERS:
		echo "<h2>Activate Orders Phase ~ ".$game->hrs."</h2>\n";
		echo "<center><div id=clock>$t</div></center>";
		echo "<button id=refresh_page>Refresh Page</button>";
		break;
	case PHASE_BREAKOFF:
		echo "<h2>Units on BreakOff Orders Disengage ~ ".$game->hrs."</h2>\n";
		echo "<center><div id=clock>$t</div></center>";
		echo "<button id=refresh_page>Refresh Page</button>";
		echo "<div id=breakoff_form><div>";
		break;
	case PHASE_GT:
		echo "<h2>Grand Tactical Movement Phase ~ ".$game->hrs."</h2>\n";
		echo "<center><div id=clock>$t</div></center>";
		echo "<button id=refresh_page>Refresh Page</button>";
		echo "<div id=grand_tactical_form><div>";
		break;
	case PHASE_DETERMINE_BOMBARDMENT:
		echo "<h2>Determine Bombardment Phase ~ ".$game->hrs."</h2>\n";
		echo "<center><div id=clock>$t</div></center>";
		echo "<button id=refresh_page>Refresh Page</button>";
		break;
	case PHASE_ENGAGE:
		echo "<h2>Run Engagements (Tactical Movement) Phase ~ ".$game->hrs."</h2>\n";
		echo "<center><div id=clock>$t</div></center>";
		echo "<button id=refresh_page>Refresh Page</button>";
		break;
	case PHASE_COMMANDER_CAS:
		echo "<h2>Commander Casualties Phase ~ ".$game->hrs."</h2>\n";
		echo "<center><div id=clock>$t</div></center>";
		echo "<button id=refresh_page>Refresh Page</button>";
		break;
	case PHASE_RALLY:
		echo "<h2>Rally Phase ~ ".$game->hrs."</h2>\n";
		echo "<center><div id=clock>$t</div></center>";
		echo "<button id=refresh_page>Refresh Page</button>";
		break;
	case PHASE_REST:
		echo "<h2>Rest Phase ~ ".$game->hrs."</h2>\n";
		echo "<center><div id=clock>$t</div></center>";
		echo "<button id=refresh_page>Refresh Page</button>";
		break;
	case PHASE_END_OF_HOUR:
		echo "<h2>End of Hour ~ ".$game->hrs."</h2>\n";
		echo "<center><div id=clock>$t</div></center>";
		echo "<button id=refresh_page>Refresh Page</button>";
		break;

	default:
		break;
	}
} else {

?>
	<div id="form">
	<center><img src=<?site_url()?>images/firing-squad.jpg></center>
	You are not currently logged in to a game<p>Ask the administrator to setup your<br>account to access a game in progress.
<?  } ?>
<center>
<img src=images/fancy-2.png>
</center>


<style>
#corps div { width: 200px; height: 80px; border: 1px solid black; padding: 0.5em; float: left; margin: 0 10px 10px 0; background: #e7d6b5; }
#corps { clear:both; float:top; width: 800px; height: 160px; border: 1px solid white; }

#orders { clear:both; float:top; width: 900px; height: 42px; border: 0px solid blue; }
#order {  font-size: 11px; float: left; width: 70px; height: 20px; border: 1px solid #002255; padding: 0.5em; background: #e7cea5; }
#order_inf {  font-size: 11px; float: left; width: 70px; height: 20px; border: 1px solid #002255; padding: 0.5em; background: #e7cea5; }
#order_cav {  font-size: 11px; float: left; width: 70px; height: 20px; border: 1px solid #002255; padding: 0.5em; background: #e7cea5; }
</style>

<script>
$.ajaxSetup ({  cache: false  });  
  
$(function() { 

	clearInterval(attach_status_interval);
	$("#orders div").draggable({ stack: "#corps div", revert: true });

	$("#corps").tabs();
	$("#corps div").draggable({  
		containment: 'parent', stack: "#corps div", scroll: false
	}).mouseup(function(){  
		var coord = $(this).position();  
		var unitid = $(this).attr("unitid");
		var left = coord.left;
		var top = coord.top;
		$.post('update_unit_posn',{unitid: unitid, x:left, y:top})
	}).droppable({
		accept: function(d) { 
        		if(d.attr("id")=="order"){ 
            			return true;
			} else if (d.attr("id")=="order_inf" && $(this).attr("unittype") != 6) {
				return true;
			} else if (d.attr("id")=="order_cav" && $(this).attr("unittype") == 6) {
				return true;
			}},
		drop: function( event, ui ) {
			var orderid = $(ui.draggable).attr("order");
			var ordertxt = $(ui.draggable).text();
			var unitid = $(this).attr("unitid");
			var unittxt = $(this).text().replace("(","\nCurrent Orders - (");
			var objective = $("#objective").val();
			if (confirm('New orders have been prepared for:\n\n'+unittxt+'\n\nReading:\n.. you are to '+ordertxt+' '+objective+'\n\nDispatch this order ?')) {
				var data = {unit: unitid, order: orderid, objective: objective};
				$.ajax({
  					type: 'POST',
  					url: 'update_unit_order',
  					data: data,
				}).done(function(msg) { alert(msg) })
			}
		}
	});

	// Phase 4 - kick off the leader attachment display
	$("#leader_attach_done").fadeIn(5000).click(function() {
		$("#leader_attach_done").hide();
		$.ajax({ type: 'GET', url: 'leader_attach/player_done' });
		$("#leader_attach_not_done").fadeIn(1000);
	});
	$("#leader_attach_not_done").hide().click(function() {
		$("#leader_attach_not_done").hide();
		$.ajax({ type: 'GET', url: 'leader_attach/player_not_done' });
		$("#leader_attach_done").fadeIn(1000);
	});

	// Phase 7 - kick off breakoff movement display
	$("#breakoff_form").load("player_console/breakoff_form",function(){
		$("#breakoff_done").fadeIn(4000);
	});
	
	// Phase 8 - kick off grand tactical movement display
	$("#grand_tactical_form").load("player_console/grand_tactical_form",function(){
		$("#gt_done").fadeIn(4000);
	});



	$("#leader_attach_form").load("player_console/leader_attach_form");
	$("#declare_orders_form").load("player_console/declare_orders_form");
});  
$("#hq").click(function () { 
	$("#console").hide(1000); 
	$("#hq").hide(800); 
	$("#main").hide(800);
	$("#menu").fadeIn(1000); 
});
$('#view_orders').click(function(){ document.location.href='<?site_url()?>orders'; });
$('#refresh_page').click(function(){ $("#console").load('player_console/refresh')});

</script>

