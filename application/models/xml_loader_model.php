<?php

class Xml_loader_model extends CI_Model {

	function load_xml($filename,$tmpname,$startvalue) {
		echo "<pre>";
		echo  "Loading xml file $filename from local file $tmpname, with start value of $startvalue\n";
		$this->uid = $this->starting_id = $startvalue;

		//$fp = fopen($tmpname, 'r');
		//while ($_ = fgets($fp)) {
			//echo $_;
		//}
//
		// If ORBAT already exists, fail with an error
		$orbat = $this->db->query("select id from orbat where filename='$filename'")->row();
		if ($orbat && $orbat->id) {
			die ("ORBAT for $filename has already been loaded - delete it first, and then try again.\n");
		}

		// Create a new ORBAT file
		$this->db->query("insert into orbat (filename,date_loaded) values ('$filename',now())");
		$this->orbat_id = $this->db->insert_id();
		$this->num_commands = $this->num_bases = $this->num_units = $this->total_strength = 0;

		// Zap the name and id fields
		$this->army_name = '';
		$this->corps_name = '';
		$this->division_name = '';
		$this->brigade_name = '';
	
		// Open the XML file
		$xml = simplexml_load_file($tmpname);
		
		// Now look in the XML file and see where we are staring - has to being either at the Division level or up !!
		
		switch ($xml->getName()) {
		case 'Division': 
			$this->army_id = $this->corps_id = 0;
			$this->army_name = '';
			$this->corps_name = '';
			$this->process_division($xml,0);
			break;
		case 'Wing':
			$this->army_id = 0;
			$this->army_name = '';
			$this->process_wing($xml,0);
			break;
		case 'Corps':
			$this->army_id = 0;
			$this->army_name = '';
			$this->process_corps($xml,0);
			break;
		case 'ROOT':
			$this->army_id = 0;
			$this->army_name = '';
			foreach ($xml->children() as $child) {
				switch ($child->getName()) {
				case 'Division':
					$this->process_division($child,0);
					break;
				case 'Wing':
					$this->process_wing($child,0);
					break;
				case 'Corps':
					$this->process_corps($child,0);
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
			$row = $this->db->query("select id from inspiration where name='$xml->Inspiration'")->row();
			$iid = (int)$row->id;
			$row = $this->db->query("select id from professional_skill where name='$xml->ProfessionalSkill'")->row();
			$sid = (int)$row->id;
			$row = $this->db->query("select id from doctrine where name='$xml->Doctrine'")->row();
			$did = (int)$row->id;
			$name = mysql_escape_string($xml->Name);
		
			// Create a new army record
			$this->db->query("insert into unit_army (commander,inspiration,professional_skill,doctrine) values ('$xml->Commander',$iid,$sid,$did)");
			$_ = $this->db->insert_id();
		
			// Create the unit with the starting UID
			$this->db->query("insert into unit (id,name,unit_type,type_id,orbat_id,is_command) values ('$this->uid','$name','1','$_',$this->orbat_id,'T')");
			$army_id = $this->uid;
			echo "New Unit (Army), SQL id = $army_id\n";
			$this->uid++;
			$this->army_name = $xml->Name;
		
			// Now look for Units attached to this army
			foreach ($xml->children() as $child) {
				if ($child->count()) {
				switch ($child->getName()) {
				case 'Wing':
					$this->process_wing($child,$army_id);
					break;
				case 'Corps':
					$this->process_corps($child,$army_id);
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

		$this->db->query("update orbat set starting_id='$this->starting_id',ending_id='$this->uid',num_commands='$this->num_commands',num_units='$this->num_units',num_bases='$this->num_bases',total_strength='$this->total_strength' where id=$this->orbat_id");
		
		// Now grab the whole xml content, and attach this to the database, so we can export it later as a .trl file for others to edit !!
		$fp = fopen($tmpname,'r');
		$size = filesize($tmpname);
		$xmlcontent = mysql_escape_string(fread($fp,$size));
		$this->db->query("update orbat set xml_content='$xmlcontent' where id=$this->orbat_id");

		return $this->orbat_id;
	}

	function process_wing ($xml,$parentid) {

		if ($xml->Name == '') return;

		echo "==============================================\n";
		echo "  Wing: $xml->Name\n";
		echo "    Attached to $this->army_name\n";
		echo "    MoraleState = $xml->MoraleState\n";
		echo "    Commander = $xml->Commander\n";
		echo "    Inspiration = $xml->Inspiration\n";
		echo "    ProfessionalSkill = $xml->ProfessionalSkill\n";
		echo "    Doctrine = $xml->Doctrine\n";
	
		// Get the IDs for the various bits
		$row = $this->db->query("select id from inspiration where name='$xml->Inspiration'")->row();
		$iid = (int)$row->id;
		$row = $this->db->query("select id from professional_skill where name='$xml->ProfessionalSkill'")->row();
		$sid = (int)$row->id;
		$row = $this->db->query("select id from doctrine where name='$xml->Doctrine'")->row();
		$did = (int)$row->id;
		$name = mysql_escape_string($xml->Name);
	
		// Create a Corps record
		$this->db->query("insert into unit_corps (commander,inspiration,professional_skill,doctrine) values ('$xml->Commander',$iid,$sid,$did)");
		$_ = $this->db->insert_id();
	
		// Create a unit
		$this->db->query("insert into unit (id,parent_id,name,unit_type,type_id,orbat_id,is_command) values ('$this->uid',$parentid,'$name','3','$_',$this->orbat_id,'T')");
		$this->corps_id = $this->uid;
		echo "    New Unit (Wing/Corps), SQL id = $this->corps_id\n";
		$this->uid++;
	
		$this->corps_name = $xml->Name;
	
		// Now look for Units attached to this wing
		foreach ($xml->children() as $child) {
			if ($child->count()) {
			switch ($child->getName()) {
			case 'Division':
				$this->process_division($child,$this->corps_id);
				break;
			case 'Brigade':
				$this->process_brigade($child,$this->corps_id);
				break;
			case 'CavBrigade':
				$this->process_cavbrigade($child,$this->corps_id);
				break;
			default:
				echo "Dont know how to attach a ".$child->getName()." unit to a Wing. Looking for Divisions or Brigades only here !!\n";
				break;
			}
			}
		}
		
		// Update stats for ORBAT
		$this->num_units++;
		$this->num_commands++;
	}
	
	function process_corps ($xml,$parentid) {

		if ($xml->Name == '') return;
	
		echo "==============================================\n";
		echo "  Corps: $xml->Name\n";
		echo "    Part of Army $this->army_name\n";
		echo "    MoraleState = $xml->MoraleState\n";
		echo "    Commander = $xml->Commander\n";
		echo "    Inspiration = $xml->Inspiration\n";
		echo "    ProfessionalSkill = $xml->ProfessionalSkill\n";
		echo "    Doctrine = $xml->Doctrine\n";
	
		// Get the IDs for the various bits
		$row = $this->db->query("select id from inspiration where name='$xml->Inspiration'")->row();
		$iid = (int)$row->id;
		$row = $this->db->query("select id from professional_skill where name='$xml->ProfessionalSkill'")->row();
		$sid = (int)$row->id;
		$row = $this->db->query("select id from doctrine where name='$xml->Doctrine'")->row();
		$did = (int)$row->id;
		$name = mysql_escape_string($xml->Name);
	
		// Create a Corps record
		$this->db->query("insert into unit_corps (commander,inspiration,professional_skill,doctrine) values ('$xml->Commander',$iid,$sid,$did)");
		$_ = $this->db->insert_id();
	
		// Create a unit
		$this->db->query("insert into unit (id,parent_id,name,unit_type,type_id,orbat_id,is_command) values ('$this->uid',$parentid,'$name','2','$_',$this->orbat_id,'T')");
		$this->corps_id = $this->uid;
		echo "    New Unit (Corps), SQL id = $this->corps_id\n";
		$this->uid++;
		$this->corps_name = $xml->Name;
	
		// Now look for Units attached to this corps
		foreach ($xml->children() as $child) {
			if ($child->count()) {
			switch ($child->getName()) {
			case 'Division':
				$this->process_division($child,$this->corps_id);
				break;
			case 'Brigade':
				$this->process_brigade($child,$this->corps_id);
				break;
			case 'CavBrigade':
				$this->process_cavbrigade($child,$this->corps_id);
				break;
			default:
				echo "Dont know how to attach a ".$child->getName()." unit to a Corps. Looking for Divisions or Brigades only here !!\n";
				break;
			}
			}
		}
	
		// Update stats for ORBAT
		$this->num_units++;
		$this->num_commands++;
	}

	function process_division ($xml,$parentid) {
	
		if ($xml->Name == '') return;
	
		echo "==============================================\n";
		echo "    Division: $xml->Name\n";
		echo "      Part of Corps $this->corps_name\n";
		echo "      MoraleState = $xml->MoraleState\n";
		echo "      Commander = $xml->Commander\n";
		echo "      Inspiration = $xml->Inspiration\n";
		echo "      ProfessionalSkill = $xml->ProfessionalSkill\n";
		echo "      Doctrine = $xml->Doctrine\n";
	
		// Get the IDs for the various bits
		$row = $this->db->query("select id from inspiration where name='$xml->Inspiration'")->row();
		$iid = (int)$row->id;
		$row = $this->db->query("select id from professional_skill where name='$xml->ProfessionalSkill'")->row();
		$sid = (int)$row->id;
		$row = $this->db->query("select id from doctrine where name='$xml->Doctrine'")->row();
		$did = (int)$row->id;
		$name = mysql_escape_string($xml->Name);
	
		// Create a Division record
		$this->db->query("insert into unit_division (commander,inspiration,professional_skill,doctrine) values ('$xml->Commander',$iid,$sid,$did)");
		$_ = $this->db->insert_id();
	
		// Create a unit
		$this->db->query("insert into unit (id,parent_id,name,unit_type,type_id,orbat_id,is_command) values ('$this->uid',$parentid,'$name','4','$_',$this->orbat_id,'T')");
		$this->division_id = $this->uid;
		echo "      New Unit (Division), SQL id = $this->division_id\n";
		$this->uid++;
		$this->division_name = $xml->Name;
	
		// Now look for Units attached to this division
		foreach ($xml->children() as $child) {
			if ($child->count()) {
			switch ($child->getName()) {
			case 'Brigade':
				$this->process_brigade($child,$this->division_id);
				break;
			case 'CavBrigade':
				$this->process_cavbrigade($child,$this->division_id);
				break;  
			case 'Battery':
				$this->process_battery($child,$this->division_id);
				break;  
			default:
				echo "Dont know how to attach a ".$child->getName()." unit to a Division. Looking for Brigades, Batteries,  and CavalryBrigades only here !!\n";
				break;
			}
			}
		}
		
		// Update stats for ORBAT
		$this->num_units++;
		$this->num_commands++;
	}

	function process_brigade ($xml,$parentid) {
	
		if ($xml->Name == '') return;
	
		echo "==============================================\n";
		echo "      Brigade: $xml->Name\n";
		echo "        Part of $this->division_name / $this->corps_name\n";
		echo "        Commander = $xml->Commander\n";
		echo "        Inspiration = $xml->Inspiration\n";
		echo "        Drill = $xml->Drill\n";
	
		// Get the IDs for the various bits
		$row = $this->db->query("select id from inspiration where name='$xml->Inspiration'")->row();
		$iid = (int)$row->id;
		$row = $this->db->query("select id from drill_type where name='$xml->Drill'")->row();
		$did = (int)$row->id;
		$name = mysql_escape_string($xml->Name);
	
		// Create a Brigade record
		$this->db->query("insert into unit_brigade (commander,inspiration,drill) values ('$xml->Commander',$iid,$did)");
		$_ = $this->db->insert_id();
	
		// Create a unit
		$this->db->query("insert into unit (id,parent_id,name,unit_type,type_id,orbat_id,is_command) values ('$this->uid',$parentid,'$name','5','$_',$this->orbat_id,'F')");
		$this->brigade_id = $this->uid;
		echo "        New Unit (Brigade), SQL id = $this->brigade_id\n";
		$this->uid++;
		$this->brigade_name = $xml->Name;
	
		// Now look for Units attached to this brigade
		foreach ($xml->children() as $child) {
			if ($child->count()) {
			switch ($child->getName()) {
			case 'Battalion':
				$this->process_battalion($child,$this->brigade_id);
				break;
			case 'Battery':
				$this->process_battery($child,$this->brigade_id);
				break;
			case 'Squadron':
				$this->process_squadron($child,$this->brigade_id);
				break;
			default:
				echo "Dont know how to attach a ".$child->getName()." unit to a Brigade. Looking for Battalions,Batteries and Squadrons only here !!\n";
				break;
			}
			}
		}
		
		// Update stats for ORBAT
		$this->num_units++;
		$this->num_commands++;
	}

	function process_cavbrigade ($xml,$parentid) {
	
		if ($xml->Name == '') return;
	
		echo "==============================================\n";
		echo "      Cavalry Brigade: $xml->Name\n";
		echo "        Part of $this->division_name / $this->corps_name\n";
		echo "        Commander = $xml->Commander\n";
		echo "        Inspiration = $xml->Inspiration\n";
		echo "        BattleGroup = $xml->BattleGroup\n";
		echo "        Doctrine = $xml->Doctrine\n";
	
		// Get the IDs for the various bits
		$row = $this->db->query("select id from inspiration where name='$xml->Inspiration'")->row();
		$iid = (int)$row->id;
		$battlegroup = ($xml->BattleGroup == 'true') ? 'T' : 'F';
		$name = mysql_escape_string($xml->Name);
	
		// Create a CavBrigade record
		$this->db->query("insert into unit_cavbrigade (commander,inspiration,battle_group,doctrine) values ('$xml->Commander',$iid,'$battlegroup','$xml->Doctrine')");
		$_ = $this->db->insert_id();
	
		// Create a unit - cav brigade is always an ME
		$this->db->query("insert into unit (id,parent_id,name,unit_type,type_id,orbat_id,is_command,is_me) values ('$this->uid',$parentid,'$name','6','$_',$this->orbat_id,'F','T')"); 
		$this->brigade_id = $this->uid;
		echo "        New Unit (CavBrigade), SQL id = $this->brigade_id\n";
		$this->uid++;
		$this->brigade_name = $xml->Name;
	
		// Now look for Units attached to this brigade
		foreach ($xml->children() as $child) {
			if ($child->count()) {
			switch ($child->getName()) {
			case 'Battery':
				$this->process_battery($child,$this->brigade_id);
				break;
			case 'Squadron':
				$this->process_squadron($child,$this->brigade_id);
				break;
			default:
				echo "Dont know how to attach a ".$child->getName()." unit to a CavBrigade. Looking for Batteries and Squadrons only here !!\n";
				break;
			}
			}
		}
		
		// Update stats for ORBAT
		$this->num_units++;
		$this->num_commands++;
	}

	function process_battalion ($xml,$parentid) {
	
		if ($xml->Name == '') return;
	
		echo "==============================================\n";
		echo "        Battalion: $xml->Name\n";
		echo "          Part of $this->brigade_name\n";
		echo "          Name = $xml->Name\n";
		echo "          UID = $xml->Uid\n";
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
		$row = $this->db->query("select id from morale_grade where name like '$xml->MoraleGrade%'")->row();
		$mgid = (int)$row->id;
		$row = $this->db->query("select id from morale_grade where name like '$xml->SmallArms%'")->row();
		$said = (int)$row->id;
		$sk = (int)$xml->Skirmishers;
		$openorder = ($xml->OpenOrder == 'true') ? 'T' : 'F';
		$rifles = ($xml->Rifles == 'true') ? 'T' : 'F';
		$closedcol = ($xml->ClosedColumn == 'true') ? 'T' : 'F';
		$shock = ($xml->ShockTroops == 'true') ? 'T' : 'F';
		$bnguns = ($xml->BattalionGuns == 'true') ? 'T' : 'F';
		$name = mysql_escape_string($xml->Name);
		$uid = mysql_escape_string($xml->Uid);
	
		// Create a Battalion record
		$query = "insert into unit_battalion (num_bases,ranks,skirmishers,open_order,rifles,closed_column,shock_troops,battalion_guns) values ('$xml->NumBases','$xml->Ranks',$sk,'$openorder','$rifles','$closedcol','$shock','$bnguns')";
		//echo $query;
		$this->db->query($query);
		$_ = $this->db->insert_id();
	
		// Create a unit
		$this->db->query("insert into unit (id,parent_id,name,uid,unit_type,type_id,orbat_id,strength,officers,ace,morale_grade,small_arms,is_command) values ('$this->uid',$parentid,'$name','$uid','10','$_',$this->orbat_id,$xml->Strength,$xml->Officers,$xml->ACE,$mgid,$said,'F')");
		$__ = $this->uid;
		echo "        New Unit (Battalion), SQL id = $__\n";
		$this->uid++;
		
		// Update stats for ORBAT
		$this->num_units++;
		$this->num_bases += (int)$xml->NumBases;
		$this->total_strength += (int)$xml->Strength;
	}

	function process_squadron ($xml,$parentid) {
	
		if ($xml->Name == '') return;
	
		echo "==============================================\n";
		echo "        Squadron: $xml->Name\n";
		echo "          Part of $this->brigade_name\n";
		echo "          Name = $xml->Name\n";
		echo "          UID = $xml->Uid\n";
		echo "          Type = $xml->Type\n";
		echo "          Strength = $xml->Strength\n";
		echo "          NumBases = $xml->NumBases\n";
		echo "          Officers = $xml->Officers\n";
		echo "          ACE = $xml->ACE\n";
		echo "          MoraleGrade = $xml->MoraleGrade\n";
		echo "          SmallArms = $xml->SmallArms\n";
		echo "          BattleCavalry = $xml->BattleCavalry\n";
		echo "          Undistinguished = $xml->Undistinguished\n";
		echo "          Skirmishers = $xml->Skirmisher\n";
		echo "          MoveRate = $xml->MoveRate\n";
		echo "          Breakpoint = $xml->Breakpoint\n";
		echo "          Fatigue = $xml->Fatigue\n";
	
		// Get the IDs for the various bits
		$row = $this->db->query("select id from morale_grade where name like '$xml->MoraleGrade%'")->row();
		$mgid = (int)$row->id;
		$row = $this->db->query("select id from morale_grade where name like '$xml->SmallArms%'")->row();
		$said = (int)$row->id;
		$row = $this->db->query("select id from cavalry_type where name like '$xml->Type%'")->row();
		$ct = (int)$row->id;
		$sk = (int)$xml->Skirmisher;
		$bc = ($xml->BattleCavalry == 'true') ? 'T' : 'F';
		$dub = ($xml->Undistinguished == 'true') ? 'T' : 'F';
		$name = mysql_escape_string($xml->Name);
		$uid = mysql_escape_string($xml->Uid);

		// Create a Squadon record
		$query = "insert into unit_squadron (cavalry_type,num_bases,battle_cavalry,undistinguished,skirmisher,move_rate) values ($ct,'$xml->NumBases','$bc','$dub',$sk,'$xml->MoveRate')";
		//echo $query;
		$this->db->query($query);
		$_ = $this->db->insert_id();
	
		// Create a unit - squadrons are always attached to an ME cav brigade
		$this->db->query("insert into unit (id,parent_id,parent_me,name,uid,unit_type,type_id,orbat_id,strength,officers,ace,morale_grade,small_arms,is_command) values ('$this->uid',$parentid,$this->brigade_id,'$name','$uid','11','$_',$this->orbat_id,$xml->Strength,$xml->Officers,$xml->ACE,$mgid,$said,'F')");
		$__ = $this->uid;
		echo "        New Unit (Squadron), SQL id = $__\n";
		$this->uid++;
	
		// Update stats for ORBAT
		$this->num_units++;
		$this->num_bases += (int)$xml->NumBases;
		$this->total_strength += (int)$xml->Strength;
	}

	function process_battery ($xml,$parentid) {
	
		if ($xml->Name == '') return;

		$parentunit = $this->db->query("select name from unit where id=$parentid")->row();
		$parent_name = $parentunit->name;
	
		echo "==============================================\n";
		echo "        Battery: $xml->Name\n";
		echo "          Part of $parentid : $parent_name\n";
		echo "          Name = $xml->Name\n";
		echo "          Type = $xml->Type\n";
		echo "          Calibre = $xml->Calibre\n";
		echo "          Strength = $xml->Strength\n";
		echo "          NumGuns = $xml->NumGuns\n";
		echo "          CrewFigures = $xml->CrewFigures\n";
		echo "          Howitzers = $xml->Howitzers\n";
		echo "          Class = $xml->Class\n";
	
		// Get the IDs for the various bits
		$row = $this->db->query("select id from morale_grade where name like '$xml->MoraleGrade%'")->row();
		$said = $mgid = (int)$row->id;

		// Create a Battery record
		$data = array(
			'type' => "$xml->Type",
			'calibre' => "$xml->Calibre",
			'gun_models' => "$xml->NumGuns",
			'crew_figures' => "$xml->CrewFigures",
			'howitzers' => "$xml->Howitzers",
			'class' => "$xml->Class"
		);
		$name = $xml->Name;
		$this->db->insert('unit_battery',$data);
		$_ = $this->db->insert_id();
	
		// Create a unit
		$this->db->query("insert into unit (id,parent_id,name,unit_type,type_id,orbat_id,strength,officers,ace,morale_grade,small_arms,is_command) values ('$this->uid',$parentid,'$name','12','$_',$this->orbat_id,$xml->Strength,10,10,$mgid,$said,'F')");
		$__ = $this->uid;
		echo "        New Unit (Battery), SQL id = $__\n";
		$this->uid++;
	
		// Update stats for ORBAT
		$this->num_units++;
		$this->num_bases += (int)$xml->NumBases;
		$this->total_strength += (int)$xml->Strength;
	}
	
	
}
