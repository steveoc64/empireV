<?php

class Logout extends MY_Controller 
{
	function index() {

		$this->session->unset_userdata('role');
		$this->session->sess_destroy();
		$this->render('You are now logged out .... Thanks for using Empire, hope to see you again soon !<p><img src=images/french_retreat.jpg>');

	}
}
