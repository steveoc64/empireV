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
		//echo "You may submit new orders for the following Maneuvre Elements<p>";

		echo "<input id=objective size=90>Enter a short objective the orders here.</input>";
		echo "<div id=orders>";
		echo "<div id=order order=1 class=ui-widget-content>Defend</div>";
		echo "<div id=order order=2 class=ui-widget-content>Attack</div>";
		echo "<div id=order order=3 class=ui-widget-content>March</div>";
		echo "<div id=order order=4 class=ui-widget-content>Withdraw</div>";
		echo "<div id=order order=5 class=ui-widget-content>ReDeploy</div>";
		echo "<div id=order order=6 class=ui-widget-content>Rally</div>";
		echo "<div id=order order=7 class=ui-widget-content>Support</div>";
		echo "<div id=order order=8 class=ui-widget-content>BreakOff</div>";
		echo "<div id=order order=9 class=ui-widget-content>Garrison</div>";
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
			if ($me->stats->player_id == $this->session->userdata('user_id')) {
			if ($me->parent_id != $last_parent) {
				if ($last_parent > -1) { echo "</div>"; }
				$parent_name = '';
				if ($me->parent_id) {
					$parent_name = $this->db->get_where('unit',array('id'=>$me->parent_id))->row()->name;
				}
				echo "<div id=set><font font-family=serif color='#51301f'><font size=12px>".$me->parent_id."</font><p>".$parent_name."</font>";
			}
			$last_parent = $me->parent_id;
			$x =(int)$me->stats->x;
			$y = (int)$me->stats->y;
			$style='';
			if ($x && $y) {
				$style = sprintf("style=\"left: %dpx; top: %dpx; position: absolute;\"",$x,$y);
			}
			echo "<div id=initid unitid=".$me->id." $style class=ui-widget-content>[".$me->id."]<br> ".$me->name."<br> (<font color=blue>".$me->current_order_type." ".$me->current_order->objective."</font>)</div>\n";
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
		echo "<div id=order order=7 class=ui-widget-content>Support</div>";
		echo "<div id=order order=8 class=ui-widget-content>BreakOff</div>";
		echo "<div id=order order=9 class=ui-widget-content>Garrison</div>";
		echo "<div id=order order=10 class=ui-widget-content>SauveQuiPeut</div>";
		echo "</div>";

	
		break;
	case PHASE_MORALE:
		echo "<h2>Morale Phase ~ ".$game->hrs."</h2>";
		break;
	case PHASE_LEADERS:
		echo "<h2>Leader Attachments Phase ~ ".$game->hrs."</h2>";
		break;
	case PHASE_BREAKOFF:
		echo "<h2>Breakoff Moves  ~ ".$game->hrs."</h2>";
		break;
	case PHASE_GT:
		echo "<h2>Grand Tactical Movement ~ ".$game->hrs."</h2>";
		break;
	case PHASE_ENGAGE:
		echo "<h2>Engagements ~ ".$game->hrs."</h2>";
		break;
	case PHASE_TACTICAL:
		echo "<h2>Tactical Combat Phase ~ ".$game->hrs."</h2>";
		break;
	case PHASE_LEADERCAS:
		echo "<h2>Leader Casualties ~ ".$game->hrs."</h2>";
		break;
	case PHASE_RALLY:
		echo "<h2>Rally ~ ".$game->hrs."</h2>";
		break;
	default:
		break;
	}
} else {

?>
	<div id="form">
	<center><img src=/empire/images/firing-squad.jpg></center>
	You are not currently logged in to a game<p>Ask the administrator to setup your<br>account to access a game in progress.
<?  } ?>
<center>
<img src=images/fancy-2.png>
</center>

<!-- </div> -->
</div>

<style>
#set div { width: 200px; height: 80px; border: 1px solid black; padding: 0.5em; float: left; margin: 0 10px 10px 0; background: #e7d6b5; }
#set { clear:both; float:top; width: 800px; height: 160px; border: 1px solid white; }

#orders { clear:both; float:top; width: 900px; height: 42px; border: 0px solid blue; }
#order {  font-size: 11px; float: left; width: 70px; height: 20px; border: 1px solid #002255; padding: 0.5em; background: #e7cea5; }
</style>

<script>
$.ajaxSetup ({  cache: false  });  
  
$(function() { 
	$("#menu").hide();
	//$('#main').animate({ left: "20px", top: "0px"}, 1000 );
	//$("#console").fadeIn(1000);
	$('#main').animate({ left: "20px", top: "0px"}, 100 );

	$("#console").fadeIn(100);
	$("#orders div").draggable({ stack: "#set div", revert: true });

	$("#set").tabs();
	$("#set div").draggable({  
		containment: 'parent', stack: "#set div", scroll: false
	}).mouseup(function(){  
		var coord = $(this).position();  
		var unitid = $(this).attr("unitid");
		var left = coord.left;
		var top = coord.top;
		$.post('update_unit_posn/index/'+unitid+'/'+left+'/'+top)
	}).droppable({
		accept: "#order",
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
});  
$("#hq").click(function () { 
	$("#console").hide(1000); 
	$("#hq").hide(800); 
	$("#main").hide(800);
	$("#menu").fadeIn(1000); 
});
$('#view_orders').click(function(){ document.location.href='/empire/orders'; });

</script>

