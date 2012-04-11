<?
if (isset($refresh_orders)) {
	echo "<table border=0 cellpadding=3>\n";
	$query = $this->db->query("select player_name,unit_id,order_type,objective from game_order where game_id=".$game->id." and activate_turn=0 order by timestamp desc");
	foreach ($query->result() as $row) {
		$unit_name = $this->db->get_where('unit',array('id'=>$row->unit_id))->row()->name;
		$order_name = $this->db->get_where('order_types',array('id'=>$row->order_type))->row()->name;
		echo "<tr><td>".$row->player_name."</td><td>[".$row->unit_id."] - ",$unit_name." has been ordered to ".$order_name." ".$row->objective."</td></tr>\n";
	}
	echo "</table>";

} else {
?>
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
		echo "<button id='view_orders'>Edit Orders</button><button id='close_orders'>Close Off Orders</button>\n";
		echo "<div id=results></div>";

		// A quick report in table format of the current orders
		echo "<img src=images/fancy-pants3.jpg><br><u>Orders outstanding :</u>\n";
		echo "<div id=orders>";
		echo "</div>";
		break;
	case PHASE_MORALE:
		echo "<h2>Morale Determination Phase ~ ".$game->hrs."</h2>\n";
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
	//echo '<button id=refresh>refresh</button><div id=spinner></div>';
} else {

?>
	<div id="form">
	<center><img src=/empire/images/firing-squad.jpg></center>
	You are not currently logged in to a game<p>Ask the administrator to setup your<br>account to access a game in progress.
<?  } ?>


<p>
<center>
<img src=images/fancy-2.png>
</center>

<!-- </div> -->
</div>
<script>
$("#refresh").on("click", function(){
	$("#orders").load('umpire_console/index/refresh_orders');
});
$(function() { 
	$("#menu").hide();
	$('#main').animate({ left: "20px", top: "0px"}, 500 );
	$("#console").fadeIn(500);
	$("#orders").load('umpire_console/index/refresh_orders');
	setInterval(function() {
		$("#orders").load('umpire_console/index/refresh_orders');
	}, 2000);
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
$("#hq").click(function () { 
	$("#console").hide(1000); 
	$("#hq").hide(800); 
	$("#main").hide(800);
	$("#menu").fadeIn(1000); 
});
var ajax_loader_img = "<img src='images/ajax-loader.gif' alt='loading...' />";  
$('#view_orders').click(function(){ document.location.href='/empire/orders'; })
$("#close_orders").click(function(){  
	if (confirm('This will close off all orders and advance the game to ME determination. Do you want to proceed ?')) {
		$("#results").load('umpire_console/close_orders', function() {location.reload();});
	}

	//$("#view_orders").hide(1000); 
	//$("#close_orders").hide(1000); 
	//$("#console").load('umpire_console/index/refresh');
	//$("#refresh").fadeIn(1000);
});  
</script>
<?}?>
