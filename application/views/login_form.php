<div id="form">
	<h1>Login</h1>
<fieldset>
<?php
	echo form_open('login/validate');
	echo form_input('username','Username');
	echo form_password('password','Password');
	echo form_submit('submit','Submit');
	echo anchor('login/signup','Create Account');


?>
</fieldset>
</div>
<div id="formimg"><img src=/empire/images/french-commander.jpg height=234></div>
