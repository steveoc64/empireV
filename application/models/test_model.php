<?php

class Test_model extends CI_Model {

	function get_battalion() {

		$res = $this->db->get('unit_battalion');
		return $res;
	}

}
