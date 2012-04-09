<?php

class Login extends CI_Controller {
	
	function index()
	{
		$data['main_content'] = 'login_form';
		$this->load->view('include/template', $data);		
	}
	
	function validate()
	{		
		$this->load->model('users_model');
		$query = $this->users_model->validate();
		
		if($query) // if the user's credentials validated...
		{
			$role = $query->role;
			$data = array(
				'username' => $this->input->post('username'),
				'is_logged_in' => true,
				'role' => $role
			);
			switch ($query->role) {
			case 'X':
				$this->session->set_userdata($data);
				redirect('not_yet_validated');
				break;
			case 'A':
				$this->session->set_userdata($data);
				redirect('admin_console');
				break;
			case 'U':
				$this->session->set_userdata($data);
				redirect('umpire_login');
				break;
			case 'P':
				$this->session->set_userdata($data);
				redirect('player_login');
				break;
			case 'S':
				$this->session->set_userdata($data);
				redirect('solo_console');
				break;
			default:
				$this->index();
				break;
			}
		}
		else // incorrect username or password
		{
			$this->index();
		}
	}	
	
	function signup()
	{
		$data['main_content'] = 'signup_form';
		$this->load->view('include/template', $data);
	}
	
	function create_user()
	{
		$this->load->library('form_validation');
		
		// field name, error message, validation rules
		$this->form_validation->set_rules('email_address', 'Email Address', 'trim|required|valid_email');
		$this->form_validation->set_rules('username', 'Username', 'trim|required|min_length[4]');
		$this->form_validation->set_rules('password', 'Password', 'trim|required|min_length[4]|max_length[32]');
		$this->form_validation->set_rules('password2', 'Password Confirmation', 'trim|required|matches[password]');
		
		
		if($this->form_validation->run() == FALSE)
		{
			$this->load->view('signup_form');
		}
		
		else
		{			
			$this->load->model('users_model');
			
			if($query = $this->users_model->create_user())
			{
				$data['main_content'] = 'signup_successful';
				$this->load->view('include/template', $data);
			}
			else
			{
				$this->load->view('signup_form');			
			}
		}
		
	}
	
	function logout()
	{
		$this->session->sess_destroy();
		$this->index();
	}

}
