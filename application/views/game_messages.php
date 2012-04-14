<script>
function get_message(turn,seq) {
	//$(this).fadeOut(3000);
	//$.ajax({
  		//type: 'POST',
  		//url: 'get_message',
  		//data: {turn:turn,seq:seq},
	//}).done(function(msg) { alert(msg) })
	
	$('<div id=message_dialog></div>').load('get_message',{turn:turn,seq:seq}).dialog({modal:true, width:600});
	$(this).fadeOut(1000);
}

</script>
<style>
.msg_img:hover { opacity: 0.7; }
</style>

<?
if (isset($game)) {
	if ($game->user->id) {
		echo "<div id=message_array style='width:100%; height:100px; float:left; position:relative; text-align:top; align:center; clear:both;'>";
		$this->db->order_by('turn_number,seq');
		$query = $this->db->get_where('game_message',array('game_id'=>$game->id,'player_id'=>$game->user->id,'is_read'=>'F'));
		foreach ($query->result() as $row) {
			//echo "<div id=msg-".$row->turn_number."-".$row->seq."><img src=images/letter".$row->letter_icon.".png></div>";
			echo "&nbsp;&nbsp<img class=\"msg_img\" onclick=\"\$(this).fadeOut(2000); get_message(".$row->turn_number.",".$row->seq.")\" src=".site_url()."images/letter".$row->letter_icon.".png>";
		}
		echo "</div>\n";
	}
}
?>
