<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed'); 

class MY_Controller extends CI_Controller {


	public function __construct() {
		parent::__construct();
		$this->is_logged_in();
		$sections = array(
			'benchmarks' => false,
			'config' => false,
			'controller_info' => false,
			'http_headers' => false,
			'memory_usage' => false,
			'post' => false,
			'get' => false,
			'queries' => false,
			'session_data' => false,
			'uri_string' => false
		);

		$this->output->set_profiler_sections($sections);
		$this->output->enable_profiler(false);
	}		

	function check_role($allowed_roles) {
		$role = $this->session->userdata('role');
		if (isset($allowed_roles)) {
			if (is_array($allowed_roles)) {
				// if current role is any of these roles
				foreach ($allowed_roles as $_) {
					if ($_ == $role) {
						return true;
					}
				}
			} else {
				if ($role == $allowed_roles) {
					return true;
				}
			}

			$this->render_header();
			$this->load->view('oops',array('message'=>'Unauthorised access attempt'));
			$this->render_footer();
			return false;
		}
		return true;
	}

	protected function is_logged_in()
	{
		$is_logged_in = $this->session->userdata('is_logged_in');
		if(!isset($is_logged_in) || $is_logged_in != true)
		{
			//echo 'You don\'t have permission to access this page. <a href="login">Login</a>';	
			//die();		
			redirect('login');
		}		

		// We are logged in, so load a few libs now
		$this->load->library('grocery_CRUD');	
	}	

	function render ($contents,$title='',$extras='') {
		$this->benchmark->mark('start_render');
		if (!is_object($contents)) {
			$new_contents->output = $contents;
			$new_contents->css_files = array();
			$new_contents->js_files = array();
			$contents = $new_contents;
		}
		$contents->title = $title;
		$contents->extras = $extras;
		$theme = 1;
		if ($uid = $this->session->userdata('user_id')) {
			$row = $this->db->get_where('user',array('id'=>$uid))->row();
			if ($row) {
				$theme = (int)$row->national_theme;
				if (!$theme) {
					$theme = 1;
				}
			}
		}
		$row = $this->db->get_where('national_theme',array('id'=>$theme))->row();
		if ($row) {
			$contents->background_img = $row->backdrop_img;
			$contents->main_css_file = $row->css;
		} else {
			$contents->main_css_file = 'css/style.css'; 	// cant find anything - hardcode it !
		}
	
		$this->load->view ('crud_header',$contents);
		$this->load->view ('crud_body', $contents);
		$this->load->view ('crud_footer');
		$this->benchmark->mark('end_render');
	}

	function render_header ($contents='') {
		if ($uid = (int)$this->session->userdata('user_id')) {
			$theme = (int)$this->db->get_where('user',array('id'=>$uid))->row()->national_theme;
		}
		if (!$theme) {
			$theme = 1;
		}
		$css = 'css/style.css';
		$row = $this->db->get_where('national_theme',array('id'=>$theme))->row();
		if (!$row) {
			$row = $this->db->get_where('national_theme',array('id'=>1))->row();
			if ($row) {
				$css = $row->css;
			}
			
		} else {
			$css = $row->css;
		}
		if (!is_object($contents)) {
			$new_contents->output = $contents;
			$new_contents->css_files = array();
			$new_contents->js_files = array();
			$contents = $new_contents;
		}
		$contents->background_img = $row->backdrop_img;
		$contents->main_css_file = $css;
		$bg = $row->backdrop_img;
		$this->load->view ('crud_header',$contents);
	}

	function render_body ($contents) {
		if (!is_object($contents)) {
			$new_contents->output = $contents;
			$new_contents->css_files = array();
			$new_contents->js_files = array();
			$contents = $new_contents;
		}
		$this->load->view ('crud_body', $contents);
	}

	function render_footer () {
		$this->load->view ('crud_footer');
	}

	function set_post_userid($post) {
		// set the user_id field in the POST data to the current user
		// Do this for all inserts to stamp the author
		$post['user_id'] = $this->session->userdata['user_id'];
		return $post;
	}

}

?>
