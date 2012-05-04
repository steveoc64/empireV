<?php

class Photo_upload extends MY_Controller 
{
	function index() {
		$this->load->view('photo_upload');
	}

	function do_upload()
	{
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
			var_dump ($this->upload->data());
			$data = array('upload_data' => $this->upload->data());

			$this->load->view('photo_upload_success', $data);
		}
	}
}

?>

