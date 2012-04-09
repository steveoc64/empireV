<?php

class Scenario_model extends CI_Model {

	function clear_orbats($id) {
		$this->load->model('orbat_model');
		$scenario_data = $this->db->get_where('scenario',array('id' => $id))->row();
		if ($scenario_data) {
			echo "Resetting all casualties for Orbats $scenario_data->orbat_a and $scenario_data->orbat_b<br>\n";
			$this->orbat_model->clear_casualties($scenario_data->orbat_a);
			$this->orbat_model->clear_casualties($scenario_data->orbat_b);
		}
	}
}
