<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8" />
	<title>Empire V - Electro Mechanical Apparatus for Combat Simulation</title>
	<link rel="stylesheet" href="<?echo site_url()."$main_css_file"; ?>" type="text/css" media="screen">

<?php
$gotjq = false;
foreach($css_files as $file): ?>
	<? if (strpos($file,'jquery-ui')) { $gotjq = true; } ?>
	<link type="text/css" rel="stylesheet" href="<?php echo $file; ?>" />
<?php endforeach; 
if (!$gotjq) {
?>
<? /*<link type="text/css" rel="stylesheet" href="<?=site_url()?>assets/jqui/css/ui-lightness/jquery-ui-1.8.18.custom.css">
<link type="text/css" rel="stylesheet" href="<?=site_url()?false>assets/jqui/css/custom-theme/jquery-ui-1.8.18.custom.css">*/?>
<link type="text/css" rel="stylesheet" href="<?site_url()?>assets/grocery_crud/themes/datatables/css/ui/simple/jquery-ui-1.8.10.custom.css" />
<?php  } ?>

<?php  
if (!$js_files) {
?>
	<script src="<?=site_url()?>assets/jqui/js/jquery-1.7.1.min.js"></script>
	<script src="<?=site_url()?>assets/jqui/js/jquery-ui-1.8.18.custom.min.js"></script>
<?php } else { ?>

<?php
$gotjq = false;
foreach($js_files as $file): ?>
	<? if (strpos($file,'jquery-ui')) { $gotjq = true; } ?>
	<script src="<?php echo $file; ?>"></script>
<?php endforeach;
if (true || !$gotjq) {
?>
<script src="<?=site_url()?>assets/jqui/js/jquery-ui-1.8.18.custom.min.js"></script>
<?php  } ?>

<?php } ?>

<?php
	/*
  <link type="text/css" rel="stylesheet" href="http://jqueryui.com/themes/base/ui.all.css" />
  
  <script>
  $(document).ready(function(){
    $('#switcher').themeswitcher();
  });
  </script>
	 */?>
</head>
  
</head>
<body>

<?php
	 /*
<script type="text/javascript"
  src="http://jqueryui.com/themeroller/themeswitchertool/">
</script>
<div id="switcher"></div>
	  */
?>

<div id="menu">
<ul class="vmenu">
<?php
// Add in the menu
$menutitle = '';
switch ($this->session->userdata('role')) {
case 'A':
	$menutitle = 'Admin Menu';
	$menu = array('Game HQ' => 'umpire_console',
		'Messages' => 'messages',
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
		'Messages' => 'messages',
		'Units' => 'units',
		'Orders' => 'orders',
		'Engagements' => 'engagements',
		'Logout' => 'logout'
	);
	break;
case 'P':
	$menutitle = 'Player Menu';
	$menu = array('HQ' => 'player_console',
		'Messages' => 'messages',
		'Parade' => 'units',
		'Orders' => 'orders',
		'Engagements' => 'engagements',
		'Dissmissed' => 'logout'
	);
	break;
case 'S':
	$menutitle = 'Solo Menu';
	$menu = array('Reports' => 'status_report',
		'Units' => 'units',
		'Orders' => 'orders',
		'Engagements' => 'engagements',
		'Dissmissed' => 'logout'
	);
	break;
default:
	$menu = array('Fall In' => 'login');

	break;
}

if (isset($menu)) {
	$u = $this->session->userdata('username');
	$u = ucfirst($u);
	echo "<center><b>$u</b><br>$menutitle</center>";
	foreach ($menu as $k => $v) {
		echo '<li><a href="'.site_url().$v.'" ';
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
