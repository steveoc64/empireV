<div id="console" style"top:40px">
</div>

<style>
#corps div { width: 200px; height: 80px; border: 1px solid black; padding: 0.5em; float: left; margin: 0 10px 10px 0; background: #e7d6b5; }
#corps { clear:both; float:top; width: 800px; height: 160px; border: 1px solid white; }

#orders { clear:both; float:top; width: 900px; height: 42px; border: 0px solid blue; }
#order {  font-size: 11px; float: left; width: 70px; height: 20px; border: 1px solid #002255; padding: 0.5em; background: #e7cea5; }
#order_inf {  font-size: 11px; float: left; width: 70px; height: 20px; border: 1px solid #002255; padding: 0.5em; background: #e7cea5; }
#order_cav {  font-size: 11px; float: left; width: 70px; height: 20px; border: 1px solid #002255; padding: 0.5em; background: #e7cea5; }
</style>

<script>
<?
// get the actual elapsed seconds !!

$query = $this->db->query("select now()-realtime as elapsed from game_turn where game_id=".$game->id." and turn_number=".$game->turn_number);
foreach ($query->result() as $row) {
	$elapsed = (int)$row->elapsed;
	break;
}
echo "var seconds = ".$elapsed.";\n";
?>

$.ajaxSetup ({  cache: false  });  
  
$(function() { 
	$("#menu").hide();
	//$('#main').animate({ left: "20px", top: "0px"}, 1000 );
	$("#console").load('player_console/refresh');
	$('#main').animate({ left: "20px", top: "0px"}, 10 );

	$("#console").fadeIn(100);
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

	// If the reloader is defined, then re-load the page every 10 seconds
	//setInterval(function() {
		//if ($("#reloader").length != 0) {
			//$('#console').fadeOut(4000);
			//location.reload();
		//}
	//}, 10000);

	// Kick off the clock
	setInterval(function() {
		if (seconds < 60) {
			color='green';
		} else if (seconds < 120) {
			color='blue';
		} else if (seconds < 600) {
			color='#880000';
		} else if (seconds < 1200) {
			color='#aa0000';
		} else {
			color='red';
		}
		var min = parseInt(seconds / 60);
		var sec = seconds % 60;
		if (sec < 10) { sec = '0'+sec; }
		if (min < 10) { min = '0'+min; }
		$('#clock').html('<font size=+2 color='+color+'><b>'+min+':'+sec+'</b></font>');
		seconds ++;
	}, 1000);

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

