<?php

class Not_yet_validated extends MY_Controller 
{
	function index() {

		$this->render('<h1>Welcome to Empire</h1>We are just waiting on your account to be validated and assigned a role ... please wait till the administrator gets around to doing this.<p>You will get an email as soon as that is done, in the meatime, it might be an idea to paint up some more troops -<p>Because no matter how many you have a the moment, you will probably be needing more ;)<p><img src=/empire/images/french-line.jpg>');

	}
}
