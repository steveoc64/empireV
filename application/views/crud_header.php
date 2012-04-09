<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8" />
	<title>Empire V - Electro Mechanical Apparatus for Combat Simulation</title>
	<link rel="stylesheet" href="http://15mm-madness.com/empire/css/style.css" type="text/css" media="screen">

<?php foreach($css_files as $file): ?>
	<link type="text/css" rel="stylesheet" href="<?php echo $file; ?>" />
<?php endforeach; ?>
<?php  if (!$js_files) {
?>
<script src="/empire/assets/jqui/js/jquery-1.7.1.min.js"></script>
<script src="/empire/assets/jqui/js/jquery-ui-1.8.18.custom.min.js"></script>
<?php } ?>

<?php foreach($js_files as $file): ?>
	<script src="<?php echo $file; ?>"></script>
<?php endforeach; ?>
</head>
<body>
<div id="menu">
<ul class="vmenu">
<?php
// Add in the menu
$menutitle = '';
switch ($this->session->userdata('role')) {
case 'A':
	$menutitle = 'Admin Menu';
	$menu = array('Game HQ' => 'umpire_console',
		'Order of Battle' => 'orbat',
		'Units' => 'units',
		'Scenario' => 'scenario',
		'Game' => 'game',
		'User Accounts' => 'user_account',
		'Orders' => 'orders',
		'Engagements' => 'engagements',
		'Combat Tests' => 'test',
		'Logout' => 'logout');
	break;
case 'U':
	$menutitle = 'Umpire Menu';
	$menu = array('Game HQ' => 'umpire_console',
		'Units' => 'units',
		'Orders' => 'orders',
		'Engagements' => 'engagements',
		'Logout' => 'logout'
	);
	break;
case 'P':
	$menutitle = 'Player Menu';
	$menu = array('HQ' => 'player_hq',
		'Parade' => 'units',
		'Orders' => 'orders',
		'Engagements' => 'engagements',
		'Logout' => 'logout'
	);
	break;
case 'S':
	$menutitle = 'Solo Menu';
	$menu = array('Reports' => 'status_report',
		'Units' => 'units',
		'Orders' => 'orders',
		'Engagements' => 'engagements',
		'Logout' => 'logout'
	);
	break;
default:
	$menu = array('Login' => 'login');

	break;
}

if (isset($menu)) {
	$u = $this->session->userdata('username');
	$u = ucfirst($u);
	echo "<center><b>$u</b><br>$menutitle</center>";
	foreach ($menu as $k => $v) {
		echo "<li><a href=\"/empire/$v\" ";
		if ($v == $this->uri->segment(1)) {
			echo "class=\"active\" ";
		}
		echo "<span>$k</span></a></li>\n";
	}
}
?>
</ul>
</div>
<div id="main">
