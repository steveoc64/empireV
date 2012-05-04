<?php

class Photo_upload extends MY_Controller 
{
	function index() {
		if ($this->game) {
			$this->load->view('photo_upload');
		}
	}

	function do_upload()
	{
		if (!$this->game) {
			$this->oops('You are not currently in a game, so no uploads for you :(');
			die();
		}

		$config['upload_path'] = './photos/';
		$config['allowed_types'] = 'gif|jpg|png';
		$config['max_size']	= '4096';
		$config['max_width']  = '6000';
		$config['max_height']  = '4000';

		$this->load->library('upload', $config);

		if ( ! $this->upload->do_upload())
		{
			$error = array('error' => $this->upload->display_errors());
			var_dump ($error);
			die ($error);

			$this->load->view('photo_upload', $error);
		}
		else
		{
			//var_dump ($this->upload->data());
			$udata = $this->upload->data();
			$config['image_library'] = 'gd2';
			$config['source_image'] = $udata['full_path'];
			$config['create_thumb'] = FALSE;
			$config['maintain_ratio'] = TRUE;
			$config['width'] = 800;
			$config['height'] = 600;
			$this->load->library('image_lib', $config);
			$this->image_lib->resize();
			echo $this->image_lib->display_errors();
			echo "<img src=".site_url()."photos/".$udata['file_name'].">";
			echo "<br>";
			echo $this->game->hrs;
			echo "<br>";
			$caption = $this->input->post('caption');
			echo $caption;

			// Create a photo record
			$data = new stdClass;
				$data->game_id = $this->game->id;
				$data->turn_number = $this->game->turn_number;
				$data->filename = $udata['file_name'];
				$data->player_id = $this->game->user->id;
				$data->caption = $caption;
			$this->db->insert('game_photo',$data);

			// Send a message to all players in the game
			$query = $this->db->query("select id from user where current_game=".$this->game->id." and id != ".$this->game->user->id);
			foreach ($query->result() as $row) {
				$data = new stdClass;
				$data->game_id = $this->game->id;;
				$data->turn_number = $this->game->turn_number;
				$data->player_id = $row->id;
				$data->unit_id = 0;
				$data->sent_turn = $this->game->turn_number;
				$data->message = '<img src='.site_url().'photos/'.$udata['file_name'].'><br>'.$caption;
				$data->letter_icon = rand(1,6);
				$this->db->insert('game_message',$data);
			}

			echo '<br><button onclick="history.go(-1)">OK</button>';
		}
	}
}

?>

