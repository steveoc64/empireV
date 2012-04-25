<?php

class Engines extends MY_Controller 
{
	function index() {

		$form = new grocery_CRUD();
		$form->set_table('code_engine');
		$form->set_subject('Code Engines');
	
		$form->columns('id','name','command','morale','movement','firepower','melee');
		$this->render($form->render(),'<h1>Code Engines</h1>');
	}
}
