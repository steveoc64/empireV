<div id="menu">
<ul class="vmenu">
<?php


$menu = array('Order of Battle' => 'orbat','Scenarios' => 'scenarios','Nations' => 'nations','Units' => 'units','Cards' => 'cards','Data' => 'data','Charts' => 'charts', 'Rules' => 'rules');


foreach ($menu as $k => $v) {
	echo "<li><a href=\"/empire/$v\" ";
	if ($v == $this->uri->segment(1)) {
		echo "class=\"active\" ";
	}
	echo "<span>$k</span></a></li>\n";
}

?>
</ul>
</div>
