<?php

class Admin_console extends MY_Controller 
{
	function index() {

		if ($this->check_role('A')) {
			$this->render('Welcome to the Admin Console<p><img src='.site_url().'mages/french-line.jpg>');
		}

	}
}
