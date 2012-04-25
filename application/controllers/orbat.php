<?php

class Orbat extends MY_Controller 
{
	////////////////////////////////////////////////////////////////////////////////
	//  ORBAT maintenance
	function index() {

		if ($this->check_role('A')) {
			// Create basic form
			$form = new grocery_CRUD();
			$form->set_theme('datatables');
			$form->set_table('orbat');
			$form->set_subject('Order of Battle');
			$form->unset_add();
			//$form->unset_delete();
			//$form->unset_edit();
			$form->unset_texteditor('xml_content','side');
			$form->set_field_upload('xml_content');

			$form->add_action('XML', '', '','ui-icon-image',array($this,'export_xml'));
	
			// Fields and Columns
    			$form->columns('side','filename','descr','date_loaded','starting_id','ending_id','num_commands','num_units','num_bases','total_strength');
			$form->fields('side','filename','descr','date_loaded','starting_id','ending_id','num_commands','num_units','num_bases','total_strength');
	
			$form->callback_delete(array($this,'delete_orbat'));

			// Add a button to add a new orbat
			$_ = $form->render();

			$extras  = '<form method="post" enctype="multipart/form-data" action="/empire/orbat/load" />';
			$extras .= "Load a new ORBAT from an XML file : <input type=file name=file>";
			$extras .= " Starting ID <input name=startid size=3 id=startid> ";
			$extras .= "<input type=submit value=Load>";
			$extras .= '</form>';
			$_->extras = $extras;

			$this->render($_,'<h1>ORBAT files that are currently loaded</h1>',$extras);


		}
	}

	function delete_orbat($primary_key) {
		if ($this->check_role('A')) {
			$query = $this->db->query("select id,unit_type,type_id from unit where orbat_id='$primary_key'");
			foreach ($query->result() as $row) {
				$unit_id = (int) $row->id;
				$unit_type = (int) $row->unit_type;
				$type_id = (int) $row->type_id;
				switch($unit_type) {
				case 1: $kill = 'army'; break;
				case 2: $kill = 'corps'; break;
				case 3: $kill = 'corps'; break;
				case 4: $kill = 'division'; break;
				case 5: $kill = 'brigade'; break;
				case 6: $kill = 'cavbrigade'; break;
				case 10: $kill = 'battalion'; break;
				case 11: $kill = 'squadron'; break;
				case 12: $kill = 'battery'; break;
				default: die("Unknown unit type $unit_type\n");
				}
				$this->db->query("delete from unit_$kill where id=$type_id");
				$this->db->query("delete from unit where id=$unit_id");
			}
			$this->db->query("delete from orbat where id=$primary_key");
		}
		return true;
	}

	function load() {
		$starting_id = (int)$_POST['startid'];
		if (!$starting_id) {
			die("Please enter a starting ID");
		}
		if ($_FILES["file"]["error"] > 0) {
			die ("Error: " . $_FILES["file"]["error"] . "<br />");
		} else {
			$this->load->model('Xml_loader_model');
			$id = $this->Xml_loader_model->load_xml($_FILES['file']['name'], $_FILES['file']['tmp_name'], $starting_id);

			echo "</pre>";
			echo "<hr>";
			echo "That all seemed to work ... <input type=button value='Edit the Details of this Orbat' onclick=\"window.location='/empire/orbat/index/edit/$id'\">";
		}

	}

	function export_xml($primary_key, $row) {
		return site_url('orbat/xml?id='.$row->id);
	}

	function xml() {
		$id = $this->input->get('id');
		$this->db->where('id', $id);
		$query = $this->db->get('orbat');
		
		if($query->num_rows == 1)
		{
			$row = $query->row();
			$_ = str_replace('<','&lt;',$row->xml_content);
			$_ = str_replace('>','&gt;',$_);
			echo "XML content for file <b>$row->filename</b>\n<br><table border=1 width=80%><tr><td bgcolor=white><pre>$_</pre></td></tr></table>";
			echo "You can copy and paste this into a text file, and edit it with <a href=http://treeline.bellz.org/download.html>TreeLine</a>";
		}
	}
}

?>

