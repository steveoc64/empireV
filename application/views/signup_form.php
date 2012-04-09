<div id="form">
<h1>Create an Account</h1>
<fieldset>
<legend>Login Info</legend>
<?php
   
echo form_open('login/create_user');

echo form_input('email_address', set_value('email_address', 'Email Address'));
echo form_input('username', set_value('username', 'Username'));
echo form_input('password', set_value('password', 'Password'));
echo form_input('password2', 'Password Confirm');
echo form_textarea('comments', 'Enter a description here to help the administrator determine what role to assign this account to.',6,200);

echo form_submit('submit', 'Create Acccount');
echo form_close();
?>

<?php echo validation_errors('<p class="error">'); ?>
</fieldset>
</div>
<div id="formimg"><img src=/empire/images/french-commander.jpg height=440></div>
