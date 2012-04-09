<?php

class Orbat_model extends CI_Model {

	function clear_casualties($id) {

		$orbat_data = $this->db->get_where('orbat', array('id' => $id))->row();
		if ($orbat_data) {
			$query = $this->db->get_where('unit',array('orbat_id' => $orbat_data->id));
			foreach ($query->result() as $row) {
				$this->db->query("update unit set morale_state=1,disorder=0,fatigue=0 where id=$row->id");
				switch($row->unit_type) {
				case 10:
					$this->db->query("update unit_battalion set casualties=0 where id=$row->type_id");
					break;
				}
			}
		}
	}
}
