<?php

class Engagements extends MY_Controller 
{
	function index() {

		$form = new grocery_CRUD();
		$form->set_table('game_engagement');
		$form->set_subject('Current Engagements');
		$form->where(array('game_id'=>$this->game->id));
	
		$form->columns('descr','turn_start','turn_end');
		//$form->set_relation('game_id','game','id');
		//$form->set_relation_n_n('units','game_engagement_unit','unit','unit_id','game_id','{id} - {name}');
		$form->unset_operations();
		$this->render($form->render(),'<h1>Current Engagements</h1>');
	}
}
