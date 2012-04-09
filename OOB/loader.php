#!/usr/bin/php

<?php

// Check the parameters passed in - looking for filename and starting ID
if (!empty($argc) && strstr($argv[0], basename(__FILE__))) {
	if (file_exists($argv[1])) {
		$filename = $argv[1];
		echo "Parsing $filename\n";
	} else {
		die ("Cannot open $filename for processing\n");
	}
}

// open database connection to the Empire database
$dblink = mysql_connect('localhost', 'root', 'unx911zxx');
if (!$dblink) {
    die('Could not connect: ' . mysql_error());
}
$db = mysql_select_db('empire', $dblink);
if (!$db) {
    die ('Cannnot connect to empire database :( ' . mysql_error());
}
echo "Connected to Empire database\n";

function sql($command) {
	global $dblink;

	echo "$command\n";
	$res = mysql_query($command,$dblink) or die ("SQL: $command\n".mysql_error()."\nBYE\n");
	return $res;
}


// Possibly zap the data for debugging and development 

$clear_all = false;
if ($clear_all) {
echo "Clearing all unit data (development only)\n";
sql("truncate unit");
sql("truncate unit_army");
sql("truncate unit_corps");
sql("truncate unit_division");
sql("truncate unit_brigade");
sql("truncate unit_cavbrigade");
sql("truncate unit_battalion");
sql("truncate unit_squadron");
sql("truncate unit_battery");
}


$starting_id = $uid = (int) $argv[2];
echo "Starting ID of $uid\n";

// If ORBAT already exists, clear it out
$res = sql("select id from orbat where filename='$filename'");
$_ = mysql_fetch_row($res);
$oid = $_[0];
if ($oid != 0) {
	echo "The ORBAT from $filename has already been loaded .. do you want to overwrite this ORBAT ? (y/n)  or enter Z to remove it !!\n> ";
	$fp = fopen ("php://stdin","r");
	$line = trim(fgets($fp));
	if ($line == 'y' || $line == 'Z') {
		echo "Removing old ORBAT !!\n";
		$res = sql("select id,unit_type,type_id from unit where orbat_id='$oid'");
		while ($row = mysql_fetch_row($res)) {
			$unit_id = (int) $row[0];
			$unit_type = (int) $row[1];
			$type_id = (int) $row[2];
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
			sql("delete from unit_$kill where id=$type_id");
			sql("delete from unit where id=$unit_id");
		}
		sql("delete from orbat where id=$oid");
	} else { 
		die ("OK, terminating loader session ....\n"); 
	}
	if ($line == 'Z') {
		die ("OK, ORBAT has been zapped ...\n");
	}
}

// Create the ORBAT file
sql("insert into orbat (filename) values ('$filename')");
$orbat_id = mysql_insert_id();
$num_commands = $num_bases = $num_units = $total_strength = 0;

// Open the XML file
$xml = simplexml_load_file($argv[1]);

// Now look in the XML file and see where we are staring - has to being either at the Division level or up !!


switch ($xml->getName()) {
case 'Division': 
	$army_id = $corps_id = 0;
	$army_name = $corps_name = '';
	process_division($xml,0);
	break;
case 'Wing':
	$army_id = 0;
	$army_name = '';
	process_wing($xml,0);
	break;
case 'Corps':
	$army_id = 0;
	$army_name = '';
	process_corps($xml,0);
	break;
case 'ROOT':
	$army_id = 0;
	$army_name = '';
	foreach ($xml->children() as $child) {
		switch ($child->getName()) {
		case 'Division':
			process_division($child,0);
			break;
		case 'Wing':
			process_wing($child,0);
			break;
		case 'Corps':
			process_corps($child,0);
			break;
		case '':
			break;
		default:
			echo "I dont know how to handle a $xml->getName as a top level force, looking for a Division, Wing or Corps at this point\n";
			break;
		}
	}
	break;
case 'Army':
	$attr = $xml->attributes();

	echo "==============================================\n";
	echo "Army: $xml->Name\n";
	echo "Commander = $xml->Commander\n";
	echo "Inspiration = $xml->Inspiration\n";
	echo "ProfessionalSkill = $xml->ProfessionalSkill\n";
	echo "Doctrine = $xml->Doctrine\n";
	 

	// Get the IDs for the various bits
	$res = sql("select id from inspiration where name='$xml->Inspiration'");
	$row = mysql_fetch_row($res);
	$iid = (int)$row[0];
	$res = sql("select id from professional_skill where name='$xml->ProfessionalSkill'");
	$row = mysql_fetch_row($res);
	$sid = (int)$row[0];
	$res = sql("select id from doctrine where name='$xml->Doctrine'");
	$row = mysql_fetch_row($res);
	$did = (int)$row[0];
	$name = mysql_escape_string($xml->Name);

	// Create a new army record
	sql("insert into unit_army (commander,inspiration,professional_skill,doctrine) values ('$xml->Commander',$iid,$sid,$did)");
	$_ = mysql_insert_id();

	// Create the unit with the starting UID
	sql("insert into unit (uid,name,unit_type,type_id,orbat_id) values ('$uid','$name','1','$_',$orbat_id)");
	$army_id = mysql_insert_id();
	echo "New Unit (Army), id = $army_id\n";
	$uid++;
	$army_name = $xml->Name;

	// Now look for Units attached to this army
	foreach ($xml->children() as $child) {
		if ($child->count()) {
		switch ($child->getName()) {
		case 'Wing':
			process_wing($child,$army_id);
			break;
		case 'Corps':
			process_corps($child,$army_id);
			break;
		default:
			echo "Dont know what to do with an independent ".$child->getName()." unit attached to the Army level\n";
			break;
		}
		}
	}
	break;
}

// Now update the orbat record

	$fp = fopen ("php://stdin","r");
	echo "Which side is this ORBAT for ? (eg, French, Prussian, Allied, etc)\n> ";
	$side = mysql_escape_string(trim(fgets($fp)));
	echo "Enter a short description for this ORBAT\n> ";
	$desc = mysql_escape_string(trim(fgets($fp)));

sql("update orbat set side='$side',descr='$desc',starting_id='$starting_id',ending_id='$uid',num_commands='$num_commands',num_units='$num_units',num_bases='$num_bases',total_strength='$total_strength' where id=$orbat_id");

// Now grab the whole xml content, and attach this to the database, so we can export it later as a .trl file for others to edit !!
$fp = fopen($filename,'r');
$size = filesize($filename);
$xmlcontent = mysql_escape_string(fread($fp,$size));
sql("update orbat set xml_content='$xmlcontent' where id=$orbat_id");


function process_wing ($xml,$parentid) {

	global $army_id, $army_name;
	global $corps_id, $corps_name;
	global $uid, $orbat_id;
	global $num_commands, $num_bases, $num_units, $total_strength;

	if ($xml->Name == '') return;

	echo "==============================================\n";
	echo "  Wing: $xml->Name\n";
	echo "    Attached to $army_name\n";
	echo "    MoraleState = $xml->MoraleState\n";
	echo "    Commander = $xml->Commander\n";
	echo "    Inspiration = $xml->Inspiration\n";
	echo "    ProfessionalSkill = $xml->ProfessionalSkill\n";
	echo "    Doctrine = $xml->Doctrine\n";

	// Get the IDs for the various bits
	$res = sql("select id from inspiration where name='$xml->Inspiration'");
	$row = mysql_fetch_row($res);
	$iid = (int)$row[0];
	$res = sql("select id from professional_skill where name='$xml->ProfessionalSkill'");
	$row = mysql_fetch_row($res);
	$sid = (int)$row[0];
	$res = sql("select id from doctrine where name='$xml->Doctrine'");
	$row = mysql_fetch_row($res);
	$did = (int)$row[0];
	$name = mysql_escape_string($xml->Name);

	// Create a Corps record
	sql("insert into unit_corps (commander,inspiration,professional_skill,doctrine) values ('$xml->Commander',$iid,$sid,$did)");
	$_ = mysql_insert_id();

	// Create a unit
	sql("insert into unit (uid,parent_id,name,unit_type,type_id,orbat_id) values ('$uid',$parentid,'$name','3','$_',$orbat_id)");
	$corps_id = mysql_insert_id();
	echo "    New Unit (Wing/Corps), id = $corps_id\n";
	$uid++;

	$corps_name = $xml->Name;

	// Now look for Units attached to this wing
	foreach ($xml->children() as $child) {
		if ($child->count()) {
		switch ($child->getName()) {
		case 'Division':
			process_division($child,$corps_id);
			break;
		case 'Brigade':
			process_brigade($child,$corps_id);
			break;
		case 'CavBrigade':
			process_cavbrigade($child,$corps_id);
			break;
		default:
			echo "Dont know how to attach a ".$child->getName()." unit to a Wing. Looking for Divisions or Brigades only here !!\n";
			break;
		}
		}
	}
	
	// Update stats for ORBAT
	$num_units++;
	$num_commands++;
}

function process_corps ($xml,$parentid) {

	global $army_id, $army_name;
	global $corps_id, $corps_name;
	global $uid, $orbat_id;
	global $num_commands, $num_bases, $num_units, $total_strength;

	if ($xml->Name == '') return;

	echo "==============================================\n";
	echo "  Corps: $xml->Name\n";
	echo "    Part of Army $army_name\n";
	echo "    MoraleState = $xml->MoraleState\n";
	echo "    Commander = $xml->Commander\n";
	echo "    Inspiration = $xml->Inspiration\n";
	echo "    ProfessionalSkill = $xml->ProfessionalSkill\n";
	echo "    Doctrine = $xml->Doctrine\n";

	// Get the IDs for the various bits
	$res = sql("select id from inspiration where name='$xml->Inspiration'");
	$row = mysql_fetch_row($res);
	$iid = (int)$row[0];
	$res = sql("select id from professional_skill where name='$xml->ProfessionalSkill'");
	$row = mysql_fetch_row($res);
	$sid = (int)$row[0];
	$res = sql("select id from doctrine where name='$xml->Doctrine'");
	$row = mysql_fetch_row($res);
	$did = (int)$row[0];
	$name = mysql_escape_string($xml->Name);

	// Create a Corps record
	sql("insert into unit_corps (commander,inspiration,professional_skill,doctrine) values ('$xml->Commander',$iid,$sid,$did)");
	$_ = mysql_insert_id();

	// Create a unit
	sql("insert into unit (uid,parent_id,name,unit_type,type_id,orbat_id) values ('$uid',$parentid,'$name','2','$_',$orbat_id)") or die (mysql_error());;
	$corps_id = mysql_insert_id();
	echo "    New Unit (Corps), id = $corps_id\n";
	$uid++;
	$corps_name = $xml->Name;

	// Now look for Units attached to this corps
	foreach ($xml->children() as $child) {
		if ($child->count()) {
		switch ($child->getName()) {
		case 'Division':
			process_division($child,$corps_id);
			break;
		case 'Brigade':
			process_brigade($child,$corps_id);
			break;
		case 'CavBrigade':
			process_cavbrigade($child,$corps_id);
			break;
		default:
			echo "Dont know how to attach a ".$child->getName()." unit to a Corps. Looking for Divisions or Brigades only here !!\n";
			break;
		}
		}
	}
	
	// Update stats for ORBAT
	$num_units++;
	$num_commands++;
}


function process_division ($xml,$parentid) {

	global $army_id, $army_name;
	global $corps_id, $corps_name;
	global $division_id, $division_name;
	global $uid, $orbat_id;
	global $num_commands, $num_bases, $num_units, $total_strength;

	if ($xml->Name == '') return;

	echo "==============================================\n";
	echo "    Division: $xml->Name\n";
	echo "      Part of Corps $corps_name\n";
	echo "      MoraleState = $xml->MoraleState\n";
	echo "      Commander = $xml->Commander\n";
	echo "      Inspiration = $xml->Inspiration\n";
	echo "      ProfessionalSkill = $xml->ProfessionalSkill\n";
	echo "      Doctrine = $xml->Doctrine\n";

	// Get the IDs for the various bits
	$res = sql("select id from inspiration where name='$xml->Inspiration'");
	$row = mysql_fetch_row($res);
	$iid = (int)$row[0];
	$res = sql("select id from professional_skill where name='$xml->ProfessionalSkill'");
	$row = mysql_fetch_row($res);
	$sid = (int)$row[0];
	$res = sql("select id from doctrine where name='$xml->Doctrine'");
	$row = mysql_fetch_row($res);
	$did = (int)$row[0];
	$name = mysql_escape_string($xml->Name);

	// Create a Division record
	sql("insert into unit_division (commander,inspiration,professional_skill,doctrine) values ('$xml->Commander',$iid,$sid,$did)");
	$_ = mysql_insert_id();

	// Create a unit
	sql("insert into unit (uid,parent_id,name,unit_type,type_id,orbat_id) values ('$uid',$parentid,'$name','4','$_',$orbat_id)");
	$division_id = mysql_insert_id();
	echo "      New Unit (Division), id = $division_id\n";
	$uid++;
	$division_name = $xml->Name;

	// Now look for Units attached to this division
	foreach ($xml->children() as $child) {
		if ($child->count()) {
		switch ($child->getName()) {
		case 'Brigade':
			process_brigade($child,$division_id);
			break;
		case 'CavBrigade':
			process_cavbrigade($child,$division_id);
			break;  
		case 'Battery':
			process_battery($child,$division_id);
			break;  
		default:
			echo "Dont know how to attach a ".$child->getName()." unit to a Division. Looking for Brigades, Batteries,  and CavalryBrigades only here !!\n";
			break;
		}
		}
	}
	
	// Update stats for ORBAT
	$num_units++;
	$num_commands++;

}

function process_brigade ($xml,$parentid) {
	
	global $army_id, $army_name;
	global $corps_id, $corps_name;
	global $division_id, $division_name;
	global $brigade_id, $brigade_name;
	global $uid, $orbat_id;
	global $num_commands, $num_bases, $num_units, $total_strength;

	if ($xml->Name == '') return;

	echo "==============================================\n";
	echo "      Brigade: $xml->Name\n";
	echo "        Part of $division_name / $corps_name\n";
	echo "        Commander = $xml->Commander\n";
	echo "        Inspiration = $xml->Inspiration\n";
	echo "        Drill = $xml->Drill\n";

	// Get the IDs for the various bits
	$res = sql("select id from inspiration where name='$xml->Inspiration'");
	$row = mysql_fetch_row($res);
	$iid = (int)$row[0];
	$res = sql("select id from drill_type where name='$xml->Drill'");
	$row = mysql_fetch_row($res);
	$did = (int)$row[0];
	$name = mysql_escape_string($xml->Name);

	// Create a Brigade record
	sql("insert into unit_brigade (commander,inspiration,drill) values ('$xml->Commander',$iid,$did)");
	$_ = mysql_insert_id();

	// Create a unit
	sql("insert into unit (uid,parent_id,name,unit_type,type_id,orbat_id) values ('$uid',$parentid,'$name','5','$_',$orbat_id)") or die (mysql_error());;
	$brigade_id = mysql_insert_id();
	echo "        New Unit (Brigade), id = $brigade_id\n";
	$uid++;
	$brigade_name = $xml->Name;

	// Now look for Units attached to this brigade
	foreach ($xml->children() as $child) {
		if ($child->count()) {
		switch ($child->getName()) {
		case 'Battalion':
			process_battalion($child,$brigade_id);
			break;
		case 'Battery':
			process_battery($child,$brigade_id);
			break;
		case 'Squadron':
			process_squadron($child,$brigade_id);
			break;
		default:
			echo "Dont know how to attach a ".$child->getName()." unit to a Brigade. Looking for Battalions,Batteries and Squadrons only here !!\n";
			break;
		}
		}
	}
	
	// Update stats for ORBAT
	$num_units++;
	$num_commands++;


}

function process_cavbrigade ($xml,$parentid) {
	
	global $army_id, $army_name;
	global $corps_id, $corps_name;
	global $division_id, $division_name;
	global $brigade_id, $brigade_name;
	global $uid, $orbat_id;
	global $num_commands, $num_bases, $num_units, $total_strength;

	if ($xml->Name == '') return;

	echo "==============================================\n";
	echo "      Cavalry Brigade: $xml->Name\n";
	echo "        Part of $division_name / $corps_name\n";
	echo "        Commander = $xml->Commander\n";
	echo "        Inspiration = $xml->Inspiration\n";
	echo "        BattleGroup = $xml->BattleGroup\n";
	echo "        Doctrine = $xml->Doctrine\n";

	// Get the IDs for the various bits
	$res = sql("select id from inspiration where name='$xml->Inspiration'");
	$row = mysql_fetch_row($res);
	$iid = (int)$row[0];
	$battlegroup = ($xml->BattleGroup == 'true') ? 'T' : 'F';
	$name = mysql_escape_string($xml->Name);

	// Create a CavBrigade record
	sql("insert into unit_cavbrigade (commander,inspiration,battle_group,doctrine) values ('$xml->Commander',$iid,'$battlegroup','$xml->Doctrine')");
	$_ = mysql_insert_id();

	// Create a unit
	sql("insert into unit (uid,parent_id,name,unit_type,type_id,orbat_id) values ('$uid',$parentid,'$name','6','$_',$orbat_id)");
	$brigade_id = mysql_insert_id();
	echo "        New Unit (CavBrigade), id = $brigade_id\n";
	$uid++;
	$brigade_name = $xml->Name;

	// Now look for Units attached to this brigade
	foreach ($xml->children() as $child) {
		if ($child->count()) {
		switch ($child->getName()) {
		case 'Battery':
			process_battery($child,$brigade_id);
			break;
		case 'Squadron':
			process_squadron($child,$brigade_id);
			break;
		default:
			echo "Dont know how to attach a ".$child->getName()." unit to a CavBrigade. Looking for Batteries and Squadrons only here !!\n";
			break;
		}
		}
	}
	
	// Update stats for ORBAT
	$num_units++;
	$num_commands++;
}

function process_battalion ($xml,$parentid) {
	
	global $army_id, $army_name;
	global $corps_id, $corps_name;
	global $division_id, $division_name;
	global $brigade_id, $brigade_name;
	global $uid, $orbat_id;
	global $num_commands, $num_bases, $num_units, $total_strength;

	if ($xml->Name == '') return;

	echo "==============================================\n";
	echo "        Battalion: $xml->Name\n";
	echo "          Part of $brigade_name\n";
	echo "          Name = $xml->Name\n";
	echo "          Strength = $xml->Strength\n";
	echo "          NumBases = $xml->NumBases\n";
	echo "          Ranks = $xml->Ranks\n";
	echo "          Officers = $xml->Officers\n";
	echo "          ACE = $xml->ACE\n";
	echo "          MoraleGrade = $xml->MoraleGrade\n";
	echo "          SmallArms = $xml->SmallArms\n";
	echo "          Skirmishers = $xml->Skirmishers\n";
	echo "          OpenOrder = $xml->OpenOrder\n";
	echo "          Rifles = $xml->Rifles\n";
	echo "          ClosedColumn = $xml->ClosedColumn\n";
	echo "          ShockTroops = $xml->ShockTroops\n";
	echo "          BattalionGuns = $xml->BattalionGuns\n";
	echo "          Breakpoint = $xml->Breakpoint\n";
	echo "          Fatigue = $xml->Fatigue\n";

	// Get the IDs for the various bits
	$res = sql("select id from morale_grade where name like '$xml->MoraleGrade%'");
	$row = mysql_fetch_row($res);
	$mgid = (int)$row[0];
	$res = sql("select id from morale_grade where name like '$xml->SmallArms%'");
	$row = mysql_fetch_row($res);
	$said = (int)$row[0];
	$sk = (int)$xml->Skirmishers;
	$openorder = ($xml->OpenOrder == 'true') ? 'T' : 'F';
	$rifles = ($xml->Rifles == 'true') ? 'T' : 'F';
	$closedcol = ($xml->ClosedColumn == 'true') ? 'T' : 'F';
	$shock = ($xml->ShockTroops == 'true') ? 'T' : 'F';
	$bnguns = ($xml->BattalionGuns == 'true') ? 'T' : 'F';
	$name = mysql_escape_string($xml->Name);

	// Create a Battalion record
	$query = "insert into unit_battalion (strength,num_bases,ranks,officers,ace,morale_grade,small_arms,skirmishers,open_order,rifles,closed_column,shock_troops,battalion_guns) values ($xml->Strength,'$xml->NumBases','$xml->Ranks',$xml->Officers,$xml->ACE,$mgid,$said,$sk,'$openorder','$rifles','$closedcol','$shock','$bnguns')";
	//echo $query;
	sql($query) or die(mysql_error());
	$_ = mysql_insert_id();

	// Create a unit
	sql("insert into unit (uid,parent_id,name,unit_type,type_id,orbat_id) values ('$uid',$parentid,'$name','10','$_',$orbat_id)");
	$__ = mysql_insert_id();
	echo "        New Unit (Battalion), id = $__\n";
	$uid++;
	
	// Update stats for ORBAT
	$num_units++;
	$num_bases += (int)$xml->NumBases;
	$total_strength += (int)$xml->Strength;
}

function process_squadron ($xml,$parentid) {
	
	global $army_id, $army_name;
	global $corps_id, $corps_name;
	global $division_id, $division_name;
	global $brigade_id, $brigade_name;
	global $uid, $orbat_id;
	global $num_commands, $num_bases, $num_units, $total_strength;

	if ($xml->Name == '') return;

	echo "==============================================\n";
	echo "        Squadron: $xml->Name\n";
	echo "          Part of $brigade_name\n";
	echo "          Name = $xml->Name\n";
	echo "          Type = $xml->Type\n";
	echo "          Strength = $xml->Strength\n";
	echo "          NumBases = $xml->NumBases\n";
	echo "          Officers = $xml->Officers\n";
	echo "          ACE = $xml->ACE\n";
	echo "          MoraleGrade = $xml->MoraleClass\n";
	echo "          SmallArms = $xml->SmallArms\n";
	echo "          BattleCavalry = $xml->BattleCavalry\n";
	echo "          Undistinguished = $xml->Undistinguished\n";
	echo "          Skirmishers = $xml->Skirmisher\n";
	echo "          MoveRate = $xml->MoveRate\n";
	echo "          Breakpoint = $xml->Breakpoint\n";
	echo "          Fatigue = $xml->Fatigue\n";

	// Get the IDs for the various bits
	$res = sql("select id from morale_grade where name like '$xml->MoraleClass%'");
	$row = mysql_fetch_row($res);
	$mgid = (int)$row[0];
	$res = sql("select id from morale_grade where name like '$xml->SmallArms%'");
	$row = mysql_fetch_row($res);
	$said = (int)$row[0];
	$res = sql("select id from cavalry_type where name like '$xml->Type%'");
	$row = mysql_fetch_row($res);
	$ct = (int)$row[0];
	$sk = (int)$xml->Skirmisher;
	$bc = ($xml->BattleCavalry == 'true') ? 'T' : 'F';
	$dub = ($xml->Undistinguished == 'true') ? 'T' : 'F';
	$name = mysql_escape_string($xml->Name);

	// Create a Squadon record
	$query = "insert into unit_squadron (cavalry_type,strength,num_bases,officers,ace,morale_grade,small_arms,battle_cavalry,undistinguished,skirmisher,move_rate) values ($ct,$xml->Strength,'$xml->NumBases',$xml->Officers,$xml->ACE,$mgid,$said,'$bc','$dub',$sk,'$xml->MoveRate')";
	//echo $query;
	sql($query);
	$_ = mysql_insert_id();

	// Create a unit
	//echo "insert into unit (uid,parent_id,name,unit_type,type_id) values ('$uid',$parentid,'$name','11','$_')\n";
	sql("insert into unit (uid,parent_id,name,unit_type,type_id,orbat_id) values ('$uid',$parentid,'$name','11','$_',$orbat_id)");
	$__ = mysql_insert_id();
	echo "        New Unit (Squadron), id = $__\n";
	$uid++;

	// Update stats for ORBAT
	$num_units++;
	$num_bases += (int)$xml->NumBases;
	$total_strength += (int)$xml->Strength;
}

function process_battery ($xml) {
}




?>
