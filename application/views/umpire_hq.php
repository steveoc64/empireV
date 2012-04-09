<?
if ($this->uri->segment(3) == 'refresh') {
} else {
?>
<button id="hq">Return to HQ</button>
<div id="console">
<?
}

// Show game stats

if (isset($game)) {
	echo '<br><br>(Turn: '.$game->turn_number.'). ';
	echo '<i>Weather Report: '.$game->weather_report.'</i>';
	echo "<br>";

	switch ($game->phase) {
	case PHASE_ORDERS:
		echo "<h2>Orders Phase ~ ".$game->hrs."</h2>";
		echo "Players may currently submit new orders.<p>\n";
		echo "<button id='view_orders'>View Orders</button><button id='close_orders'>Close Off Orders</button>\n";
		echo "<div id=results></div>";
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
	echo '<button id=refresh>refresh</button><div id=spinner></div>';
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

<?
if ($this->uri->segment(3) == 'refresh') {
} else {
?>
<!-- </div> -->
</div>
<script>
$("#refresh").on("click", function(){
	$("#console").load('umpire_console/index/refresh'); 
});
$(function() { 
	$("#menu").hide();
	$('#main').animate({ left: "20px", top: "0px"}, 1000 );
	$("#console").fadeIn(1000);
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
	$("#results").load('umpire_console/close_orders');
	$("#view_orders").hide(1000); 
	$("#close_orders").hide(1000); 
	//$("#console").load('umpire_console/index/refresh');
	$("#refresh").fadeIn(1000);
});  
</script>
<?}?>
