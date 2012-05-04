<div id="console" style"top:40px">
<button id="hq">Return to HQ</button>
<button id="photo">Add Photo</button>

</td>
</div> <!-- console -->
<script>
// On load - setup all the buttons
//
<?
// get the actual elapsed seconds !!

$query = $this->db->query("select unix_timestamp(realtime) as start_of_turn from game_turn where game_id=".$game->id." and turn_number=".$game->turn_number);
foreach ($query->result() as $row) {
	$start_of_turn = (int)$row->start_of_turn;
	break;
}
echo "var start_of_turn = ".$start_of_turn.";\n";
?>

var attach_status_interval;
$(function() { 
	$("#menu").hide();
	$('#main').animate({ left: "20px", top: "0px"}, 2000 );
	$("#console").load('umpire_console/refresh');

	clearInterval(attach_status_interval);
	
	// Kick off the order refresh - every 10 seconds, it fades out, reloads and fades back in
	setInterval(function() {
		$("#orders").fadeOut(100).load('umpire_console/refresh_orders').fadeIn(3000);
	}, 10000);

	// Kick off the clock
	setInterval(function() {
		var d = new Date();
		var now = parseInt(d.getTime()/1000); // getTime returns milliseconds since the start of Unix Time
		var seconds = now - start_of_turn;
		var min = parseInt(seconds / 60);
		var sec = seconds % 60;
		var hours = parseInt(min / 60);
		min = min % 60;

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

		if (sec < 10) { sec = '0'+sec; }
		if (min < 10) { min = '0'+min; }
		$('#clock').html('<font size=+2 color='+color+'><b>'+hours+':'+min+':'+sec+'</b></font>');
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

// Add photo
$("#photo").click(function() {
	$('<div id=photo_upload></div>').load('photo_upload').dialog({modal:true, width:800, height:400});

});
</script>
