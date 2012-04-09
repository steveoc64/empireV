<?php

class Rules extends MY_Controller 
{
	function index()
	{
		$data['main_content'] = 'rules';
		$data['menu'] = 'menu';
		$this->load->view('include/template', $data);		
	}
}
