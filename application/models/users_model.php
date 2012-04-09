<?php

class Users_model extends CI_Model {

	function validate()
	{
		$username = $this->input->post('username');
		$this->db->where('username', $username);
		$this->db->where('password', md5($this->input->post('password')));
		$query = $this->db->get('user');
		
		if($query->num_rows == 1)
		{
			$row = $query->row();
			$this->session->set_userdata('user_id',$row->id);
			$this->db->query("update user set last_login=now() where username='$username'");
			$userdata = $this->session->all_userdata();
				$agent = $userdata['user_agent'];
				$ip_address = $userdata['ip_address'];
			$this->db->query("insert into logins (user_id,user_agent,ip_address) values ($row->id, '$agent','$ip_address')");
			return $row;
		}
	}
	
	function create_user()
	{
		$email = $this->input->post('email_address');
		$password = $this->input->post('password');
		$username = $this->input->post('username');
		$password2 = $this->input->post('password2');
		$comments = $this->input->post('comments');
		if ($password != $password2) {
			die('Passwords do not match - try again ...\n');
		}

		// check the username is not already in use
		$row = $this->db->query("select id from user where username='$username'")->row();
		if ($row &&  $row->id) {
			die ("Sorry, '$username' is already in use by someone else - try another username.\n");
		}

		$new_member_insert_data = array(
			'email' => $email,
			'username' => $this->input->post('username'),
			'password' => md5($this->input->post('password')),
			'role' => 'X',
			'admin' => 'F'						
		);
		
		$insert = $this->db->insert('user', $new_member_insert_data);
		$this->load->library('email');
		$this->email->from('steveoc@15mm-madness.com', 'Steve');
		$this->email->to($email);
		$this->email->bcc('steveoc64@gmail.com'); // CC login requests to me, which I will manually validate
		$this->email->subject('Welcome to Empire');
		$this->email->message("You have signed in to the Empire system with the following details -\n\nUsername: $username\nPassword: $password\n\nComments:\n$comments\n--------------------------------------------------------------\n\nPlease wait for the administrator to validate your account, and then you are good to go.\n\nWe will get back to you via email as soon as its ready.\n\nWhen its all setup, you can Login at http://15mm-madness.com/empire using these details, and you can play a game !!\n");
		$this->email->send();
		return $insert;
	}
}
