<h1><? echo $unit->name ?></h1>

<button id="closereports">Return to HQ</button>
<button id="statusreport">Status Report</button>
<button id="unitjournal">Read Unit Journal</button>
</div>
<?php

switch ($this->session->userdata('role')) {
case 'A':
case 'U': ?>
<script>
	$(function(){
	});
    $("#statusreport").click(function () { $("#menu").fadeOut(500); $("#eventreport").hide("fast"); $("#report").show(500); });
    $("#unitjournal").click(function () { $("#menu").fadeOut(500); $("#report").hide("fast"); $("#eventreport").show(500); });
    $("#closereports").click(function () { $("#report").hide(500); $("#eventreport").hide("fast"); $("#menu").fadeIn(800);  });
</script>
<? break;
default: ?>
<script>
$(function(){
});
    $("#statusreport").click(function () { $("#menu").fadeOut(2000); $("#eventreport").hide(1200); $("#report").show(2000); });
    $("#unitjournal").click(function () { $("#menu").fadeOut(2000); $("#report").hide(1200); $("#eventreport").show(2000); });
    $("#closereports").click(function () { $("#report").hide(2000); $("#eventreport").hide(2000); $("#menu").fadeIn(4000);  });
</script>
<? break;
}
?>

<div id="report">
<center>
<?

$cmd = false;
$UID = $unit->id;

switch($unit->unit_type) {
case TYPE_ARMY:
	echo "<h3>Army: Commander: ".$unit->army->commander."</h3><br>";
	$cmd = true;
	break;
case TYPE_CORPS:
case TYPE_WING:
	echo "<h3>Corps/Wing: Commander ".$unit->corps->commander."</h3><br>";
	$cmd = true;
	break;
case TYPE_DIVISION:
	echo "<h3>Division: Commander ".$unit->division->commander."</h3><br>";
	$cmd = true;
	break;
case TYPE_BRIGADE:
	echo "<h3>Brigade: Commander ".$unit->brigade->commander."</h3><br>";
	$cmd = true;
	break;
case TYPE_CAV_BRIGADE:
	echo "<h3>Cavalry Brigade: Commander ".$unit->cavbrigade->commander."</h3><br>";
	$cmd = true;
	break;
case TYPE_BATTALION:
	echo "<h3>Battalion - [ #$UID ] </h3><br>";
	break;
case TYPE_SQUADRON:
	echo "<h3>Squadron - [ #$UID ] </h3><br>";
	break;
case TYPE_BATTERY:
	echo "<h3>Battery - [ #$UID ] </h3><br>";
	break;
}

if ($unit) {
	$s1 = $unit->initial_strength;
	$s2 = $unit->initial_officers;
	$l1 = $unit->casualties;
	$l2 = $unit->officers_killed;

	echo "<br>";
	echo "<br>";
	echo "<br><img src=../images/fancy-1.png><br>";

	/*
	 * Color Test !!
	 
	echo "<font color=".COLOR_1.">Color 1</font><br>";
	echo "<font color=".COLOR_2.">Color 2</font><br>";
	echo "<font color=".COLOR_3.">Color 3</font><br>";
	echo "<font color=".COLOR_4.">Color 4</font><br>";
	echo "<font color=".COLOR_5.">Color 5</font><br>";
	echo "<font color=".COLOR_1."><b>Color 1</b></font><br>";
	echo "<font color=".COLOR_2."><b>Color 2</b></font><br>";
	echo "<font color=".COLOR_3."><b>Color 3</b></font><br>";
	echo "<font color=".COLOR_4."><b>Color 4</b></font><br>";
	echo "<font color=".COLOR_5."><b>Color 5</b></font><br>";
	 /**/

	echo "<b><u><font size=+1>Status Report as of ".$game->hrs." in game ".$unit->game_id."</font></u></b><br><br>\n";
	if ($cmd) {
		echo "This officer has a well deserved reputation as a truly $unit->inspiration_descr leader.<br><br>\n";
		echo "The professional competence of the staff could best be described as $unit->skill_descr<br><br>\n";
		echo "Command Doctrine system is : $unit->doctrine_descr<br>\n";
	} else {
		echo "Rating: This unit is made up of ".$unit->morale_grade_descr." troops.<br>and they are ".$unit->small_arms_descr." shots with their firearms.<br>\n";
		switch($unit->unit_type) {
		case TYPE_BATTALION:
			echo "<br>\n";
			echo "This unit operates in ".$unit->battalion->ranks." ranks<br>";
			if ((int)$unit->battalion->skirmishers) { echo "This unit can issue ".$unit->battalion->skirmishers." skirmisher bases.<br>"; }
			if ($unit->battalion->open_order == 'T') { echo "This unit can operate in open order if desired.<br>"; }
			if ($unit->battalion->rifles == 'T') { echo "This unit is equipped with the latest rifled firearms.<br>"; }
			if ($unit->battalion->closed_column == 'T') { echo "This can operate in closed column if desired.<br>"; }
			if ($unit->battalion->shock_troops == 'T') { echo "These are Shock Troops .. most likely to close with the bayonet.<br>"; }
			if ($unit->battalion->battalion_guns == 'T') { echo "This unit has battalion guns attached.<br>"; }
			break;
		case TYPE_SQUADRON:
			echo "<br>\n";
			echo "Moves at ".$unit->squadron->move_rate." Cavalry rate.<br>\n";
			if ($unit->squadron->battle_cavalry == 'T') { echo "This fine unit is rated as Battle Cavalry<br>\n"; }
			if ($unit->squadron->undistinguished == 'T') { echo "Decidedly Undistinguished, they are here to put in a jolly good showing with any luck.<br>\n"; }
			if ($unit->squadron->skirmisher == 'T') { echo "This unit can conduct skirmish operations<br>\n"; }
			break;
		case TYPE_BATTERY:
			echo "<br>\n";
			echo "This is a ".$unit->battery->class." ".$unit->battery->type." artillery Battery.<br>\n";
			echo "Comprised of ".$unit->battery->calibre." cannon.<br>\n";
			if ($unit->battery->howitzers != '') { echo "Also included are ".$unit->battery->howitzers.".<br>\n"; }
			break;
		}

	}

	echo "<img src=../images/fancy-pants3.png><br>";
	echo "The morale of the men is ".$unit->morale_state_descr."<br>\n";
	echo $unit->fatigue_descr."<br><br>\n";

	switch($this->session->userdata('role')) {
	case 'A':
	case 'U':
		echo "<br>Actual Fatigue Level =  ".$unit->current_fatigue."<br><br>\n";
		break;
	}
	if (!$cmd) {
		switch($unit->unit_type) {
		case TYPE_BATTALION:
			echo "Initial Strength: $s1 Infantrymen and $s2 Officers<br>\n";
			break;
		case TYPE_SQUADRON:
			echo "Initial Strength: $s1 Cavalrymen and $s2 Officers<br>\n";
			break;
		case TYPE_BATTERY:
			echo "Initial Strength: $s1 Cannon with Crew and $s2 Officers<br>\n";
			break;
		default:
			echo "This unit comprises a number of Officers and their staff.\n";
			break;
		}
		$infantry_figs_per_base = (int)$game->infantry_base;
		$cavalry_figs_per_base = (int)$game->cavalry_base;
		if ($infantry_figs_per_base < 1) { $infantry_figs_per_base = 3; }
		if ($cavalry_figs_per_base < 1) { $cavalry_figs_per_base = 2; }

		switch($this->session->userdata('role')) {
		case 'A':
		case 'U':
			// Give detailed view of casualties
			echo "Casualties: $l1 Men and $l2 Officers lost<br>\n";
			printf ("Losses = %2d", $unit->percent_lost); echo "%<br>\n";
			echo "<img src=../images/fancy-pants3.png><br>";
			echo "<b>Remaining Strength: $unit->current_strength effectives</b><br>\n";

			switch ($unit->unit_type) {
			case TYPE_BATTALION:
				$num_bases = ($unit->num_figures / $infantry_figs_per_base);
				echo "<br><i>Which equates to $unit->num_figures figures or $num_bases bases at 1:$unit->scale ratio</i> - $infantry_figs_per_base figs per base<br>\n";
				break;
			case TYPE_SQUADRON:
				$num_bases = ($unit->num_figures / $cavalry_figs_per_base);
				echo "<br><i>Which equates to $unit->num_figures figures or $num_bases bases at 1:$unit->scale ratio</i> - $cavalry_figs_per_base figs per base<br>\n";
				break;
			case TYPE_BATTERY:
				$crew = $unit->battery->crew_figures;
				if (!$crew) { $crew = 3; }
				echo "<br><i>Which equates to $unit->num_bases Gun Models with $crew Crew Figures each.</i><br>\n";
				break;
			}
			break;
		default:

			if ($unit->casualties == 0) {
				echo "<font color=".COLOR_1."><b>We have yet to lose a single man !</b></font><br>\n";
			} elseif ($unit->percent_lost < 10.0) {
				echo "<font color=".COLOR_2."><b>Insignificant losses, not worth reporting.</b></font><br>\n";
			} elseif ($unit->percent_lost < 20.0) {
				echo "<font color=".COLOR_3."><b>A few men down, nothing to be alarmed about.</b></font><br>\n";
			} elseif ($unit->percent_lost < 40.0) {
				echo "<font color=".COLOR_4."><b>Casualties appear to be mounting.</b></font><br>\n";
			} elseif ($unit->percent_lost < 66.0) {
				echo "<font color=".COLOR_5."><b>I am afraid to report that casualties are somewhat severe at the moment.</b></font><br>\n";
			} elseif ($unit->percent_lost > 90.0) {
				echo "<font color=".COLOR_6."><b>We deeply regret to inform, that the unit is no more ....</b></font><br>All Gone ....<br>";
			} else {
				echo "<font color=".COLOR_6.">We are being massacred !</font><br>";
			}

			switch ($unit->unit_type) {
			case TYPE_BATTALION:
				echo "<br><i>$unit->num_bases bases of infantry (3 castings per base)</i><br>\n";
				break;
			case TYPE_SQUADRON:
				echo "<br><i>$unit->num_bases bases of cavalry (2 castings per base)</i><br>\n";
				break;
			case TYPE_BATTERY:
				$crew = $unit->battery->crew_figures;
				if (!$crew) { $crew = 3; }
				echo "<br><i>Which equates to $unit->num_bases Gun Models with $crew Crew Figures each.</i><br>\n";
				break;
			}
			echo "<img src=../images/fancy-pants3.png><br>";
			break;
		}
		
	} else {
		// Is command - display the 
	}
	echo "<br><br><br>";
	echo "<br><img src=/empire/images/fancy-2.png><br>";
	echo "<br><br><br>";
	echo "<br><br><br>";
	echo "</div>"; // <div id=reportimg><img src=/empire/images/french-legere.jpg width=400>";
} else {
	echo "<br>";
	echo "<br>";
	echo "<br><img src=../images/fancy-1.png><br>";
	echo "<br>You currently do not have a game selected,<br>so I dont know which status reports to fetch ...<br>\n";
	echo "<br><br><br>";
	echo "<br><img src=/empire/images/fancy-2.png><br>";
	echo "<br><br><br>";
}

?>

</center>

<div id="eventreport">
<center>
<?
$cmd = false;
$UID = $unit->id;

switch($unit->unit_type) {
case TYPE_ARMY:
	echo "<h3>Army: Commander: ".$unit->army->commander."</h3><br>";
	$cmd = true;
	break;
case TYPE_CORPS:
case TYPE_WING:
	echo "<h3>Corps/Wing: Commander ".$unit->corps->commander."</h3><br>";
	$cmd = true;
	break;
case TYPE_DIVISION:
	echo "<h3>Division: Commander ".$unit->division->commander."</h3><br>";
	$cmd = true;
	break;
case TYPE_BRIGADE:
	echo "<h3>Brigade: Commander ".$unit->brigade->commander."</h3><br>";
	$cmd = true;
	break;
case TYPE_CAV_BRIGADE:
	echo "<h3>Cavalry Brigade: Commander ".$unit->cavbrigade->commander."</h3><br>";
	$cmd = true;
	break;
case TYPE_BATTALION:
	echo "<h3>Battalion - [ #$UID ] </h3><br>";
	break;
case TYPE_SQUADRON:
	echo "<h3>Squadron - [ #$UID ] </h3><br>";
	break;
case TYPE_BATTERY:
	echo "<h3>Battery - [ #$UID ] </h3><br>";
	break;
}


?>
<img src=/empire/images/fancy-1.png><br>

<b>A true and complete record of events.</b><br>
<?

$game_id = $unit->game_id;
if ($game_id) {
$unit_id = $unit->id;
$query = $this->db->query("select event_type,turn_number,descr,value from game_event where game_id=$game_id and unit_id=$unit_id");
$i = 0;
$last_turn = 0;
foreach ($query->result() as $row) {
	$et = $this->db->get_where('event_type',array('id'=>$row->event_type))->row();
	$descr = $row->descr;
	$descr = str_replace('\n','<br>',$descr);
	$event_details='';

	switch($et->id) {
	case 1:	// order received
	case 2:	// order activated
		$_ = $this->db->get_where('order_types',array('id'=>$row->value))->row();
		if ($_) {
			$event_details = "(".$_->name." Order)";
		} else {
			echo "Unknown order type ".$row->value." in event : ";
			print_r($row);
			die ("Exiting ...");
		}
		break;
	}
	// Calculate the hour
	$turn = (int)$row->turn_number;
	$hour = (int)$game->start_hour + (int)$row->turn_number -1;
	if ($turn != $last_turn) {
		if ($i) { echo "<img src=".site_url()."images/fancy-pants3.png><br>\n"; }
		echo "<b> Time: $hour:00hrs</b> (Turn ".$row->turn_number.")<br>";
	}

	echo "</center>";
	echo "<br>Event: ".$et->descr." ".$event_details."<br>\n";
	echo "&nbsp;<i>$descr</i><br>\n";
	echo "<center>";
	$last_turn = $turn;
	$i++;
}
} else {
	echo "<br>";
	echo "<br>";
	echo "<br><img src=".site_url()."images/fancy-1.png><br>";
	echo "<br>You currently do not have a game selected,<br>so I dont know which journal to fetch ...<br>\n";
	echo "<br><br><br>";
	echo "<br><img src=".site_url()."images/fancy-2.png><br>";
	echo "<br><br><br>";
}
?>


<img src=/empire/images/fancy-2.png>
</center>

