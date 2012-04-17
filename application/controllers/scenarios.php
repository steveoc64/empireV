<?php

class Scenarios extends MY_Controller {

	function index ($offset = 0) {
		
		if ($this->check_role('A')) {

			///////////////////////////////////////////
			// Create basic form
			$form = new grocery_CRUD();
			$form->set_theme('datatables');
			$form->set_table('scenario');
			$form->set_subject('Battle Scenario');
	
			// Fields and Columns
    			$form->columns('descr','orbat_attacker','orbat_defender');
			$form->fields('descr','orbat_attacker','attacker_briefing','orbat_defender','defender_briefing','latitude','longitude','start_hour','video_intro');
	
			// relations
			$form->set_relation('orbat_attacker','orbat','{id} {filename}'); 
			$form->set_relation('orbat_defender','orbat','{id} {filename}'); 
			$form->unset_texteditor('latitude','longitude','descr','video_intro');
	
			$this->render($form->render(),'<h1>Scenarios Database</h1>');
		}

	}
}


?>
