<?php

class Get_message extends MY_Controller {

	function index () {
		if ($this->game) {
			$turn = (int)$this->input->post('turn');
			$seq = (int)$this->input->post('seq');
			$query = $this->db->get_where('game_message',array('game_id'=>$this->game->id,'turn_number'=>$turn,'seq'=>$seq));
			foreach ($query->result() as $row) {
				// get the time of the message
				$hour = $this->game->start_hour + $turn - 1;
				$shour = $this->game->start_hour + $row->sent_turn - 1;
				$hr = sprintf("%d:00 hrs",$hour);
				$sent = sprintf("%d:00 hrs",$shour);
				echo "Message Sent : $sent<br>";
				echo "Received At  : $hr<br><hr>Message:<p>";
				echo $row->message;

				// If the unit affected belongs to us, add a link to let us go there
				$row = $this->db->get_where('game_unit_stats',array('game_id'=>$this->game->id,'unit_id'=>$row->unit_id))->row();
				if ($row && $row->player_id == $this->game->user->id) {
					echo "<hr><button onclick=\"location.href='units/status?id=".$row->unit_id."'\">Visit Unit</button>";
				}
				// Now stamp the message as read
				$query = $this->db->query("update game_message set is_read='T' where game_id=".$this->game->id." and turn_number=$turn and seq=$seq");

			}
		}
	}
}

?>
