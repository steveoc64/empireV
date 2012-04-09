<?php

function d100 () {
	return rand(1,100);
}

function roll_dice ($fractional) {

	$dice = rand(1,100);
	$result = (int) ((($fractional * 100) + (100 - $dice)) / 100);
	echo "<br>Test fractional value of $fractional, die roll = $dice, <b><font color=red>result = $result KILL</font></b><br>\n";
	return $result;
}

$ace_values = array(0.7,0.8,0.9,1.0,2.0,2.1,2.2,2.3,2.4,3.0,
	3.1,4.0,4.1,5.0,5.1,6,6,7,8,9,
	10,11,12,14,16,18,20,22,24,27,
	30,35,40,45,50,55,62,70,80,90,
	100,110,120,140,160,180,200,220,240,270,
	300,350,400,450,500,550,620,700,800,900);

function ace_adjust($start_ace,$add) {
	global $ace_values;

	for ($i = 0; $i < sizeof($ace_values); $i++) {
		if ($ace_values[$i] == $start_ace) {
			//echo "<br>Found value of $start_ace at index $i<br>";
			$i += $add;
			if ($i >= 0) {
				//echo "<br>Returning value at index $i<br>";
				return ($ace_values[$i]);
			} else
				return 0;
		}
	}

}

class Test extends MY_Controller 
{
	////////////////////////////////////////////////////////////////////////////////
	//  Test Jig
	function index() {

		if ($this->session->userdata('role') == 'A') {
			$this->render_header('Firing Test');
			$this->load->view('firing_test');
			$this->render_footer();
			//$data['main_content'] = 'firing_test';
			//$this->load->view('include/template', $data);		
		} else {
			$this->load->view('include/template', $data);		
		}
	}

	function firing() {
		$fu = $this->input->post('fu');
		$tu = $this->input->post('tu');
		$fb = $this->input->post('fb');
		$tb = $this->input->post('tb');
		$ff = $this->input->post('ff');
		$tf = $this->input->post('tf');
		$flank = $this->input->post('flank');
		$range = $this->input->post('range');

		// Get the unit model
		$this->load->model('unit_model');

		// Lookup the units
		$firer = $this->unit_model->get($fu);
		$target = $this->unit_model->get($tu);

		if (!$firer->battalion) {
			echo "Ooops - Firer $firer->name is not a battalion, cannot fire !\n";
			return;
		}
		if (!$target->battalion) {
			echo "Ooops - Target $target->name is not a battalion, cannot fire !\n";
			return;
		}

		// Check that both units are still alive before we continue
		$castings = (int) ($firer->battalion->strength / 60.0) - $firer->battalion->casualties;
		if ($castings < 1) {
			echo "Ooops - $firer->name is currently wiped out, cannot take part in this battle.<br>\n";
			return;
		}
		$castings = (int) ($target->battalion->strength / 60.0) - $target->battalion->casualties;
		if ($castings < 1) {
			echo "Ooops - $target->name is currently wiped out, cannot take part in this battle.<br>\n";
			return;
		}
		if ($firer->fatigue >= $firer->breakpoint) {
			echo "Ooops - $firer->name is currently utterly exhausted (fatigue = $firer->fatigue), they can no longer fire.<br>\n";
			return;
		}

		echo "$firer->name in formation $ff with $fb figures of troops firing<br> fires on<br>$target->name in formation $tf with $tb figures of troops firing<br>at a range of $range !<hr>";

		if ($flank) {
			echo "Jolly Good - A Flank Shot !!<br>\n";
		}

		$fsa = $firer->battalion->small_arms;
		$range = (int)$range;
		if ($range <= 2) {
			if (!$flank) {
				echo "Inside 100yards, so a firefight may develop<br>\n";
			}

			$multiplier = 1.0;
			if ($flank) {
				$multiplier = 2.0;
			}

			// Set the multiplier for target formation
			switch($tf) {
			case 'CC':
				$multiplier = 1.1;
				echo "Target is closed column * 1.1 ..";
				break;
			case 'SQ':
			case 'HS':
				$multiplier = 2.0;
				echo "Target is square * 2.0 ..";
				break;
			case 'OO':
				echo "Target is open order * 0.5 ..";
				$multiplier = 0.5;
				break;
			}
			// Set the multiplier for firer formation
			switch($ff) {
			case 'CC':
				echo "Firer is closed column * 0.9 ..";
				$multiplier *= 0.9;
				break;
			case 'SQ':
			case 'HS':
				echo "Firer is in square * 0.5 ..";
				$multiplier *= 0.5;
				break;
			}
			if ($firer->disorder) {
				echo "Firer has $firer->disorder% disorder ..";
				$multiplier *= ((100 - $firer->disorder)/100.0);
			}
			// Set the multiplier for target cover
			switch($target->cover) {
			case 'L':
				echo "Target is in light cover * 0.9 ..";
				$multiplier *= 0.9;
				break;
			case 'M':
				echo "Target is in medium cover * 0.5 ..";
				$multiplier *= 0.5;
				break;
			case 'H':
				echo "Target is in heavy cover * 0.33 ..";
				$multiplier *= 0.33;
				break;
			case 'S':
				echo "Target is in super heavy cover * 0.1 ..";
				$multiplier *= 0.1;
				break;
			}
			echo "  Total Multiplier = $multiplier<br>\n";
			
			// table depends on target formation
			switch($tf) {
			case 'CC':
			case 'CL':
				switch ($fsa) {
				case 1: $per = 30; break;
				case 2: $per = 24; break;
				case 3: $per = 20; break;
				case 4: $per = 16; break;
				case 5: $per = 12; break;
				case 6: $per = 10; break;
				case 7: $per = 8; break;
				case 8: $per = 6; break; 
				case 9: $per = 4; break;
				case 10: $per = 2; break;
				}
				break;
			case 'SQ':
			case 'HS':
			case 'LN':
			case 'OO':
				switch ($fsa) {
				case 1: $per = 23; break;
				case 2: $per = 18; break;
				case 3: $per = 15; break;
				case 4: $per = 12; break;
				case 5: $per = 9; break;
				case 6: $per = 7; break;
				case 7: $per = 6; break;
				case 8: $per = 5; break; 
				case 9: $per = 3; break;
				case 10: $per = 1.5; break;
				}
				break;
			}

			$perm = $per * $multiplier;
			echo "Per casting firing base rate = $per%, after multiplier $perm%<br>\n";

			$castings = (int) ($firer->battalion->strength / 60.0) - $firer->battalion->casualties;
			$fcastings = $fb; // * 3;
			if ($fcastings > $castings) { $fcastings = $castings; }
				print_r($firer);
			echo "Firing unit has an initial strength of $firer->battalion->strength , minus $firer->battalion->casualties casualties and $firer->fatigue fatigue ... which is $castings castings left<br>\n";
			echo "But only $fcastings are firing<br>\n";

			$damage = $castings * $perm / 100.0;
			$fulldamage = (int)($firer->battalion->strength * $perm / 100);
			//echo "Total damage = $damage castings / $fulldamage troops (if all of the firing unit is in line)<br>\n";
			echo "<hr>";
			$damage = $fcastings * $perm / 100.0;
			$fulldamage = (int) ($damage * 60);
			echo "Total damage = $damage castings / $fulldamage troops";
			$kills1 = roll_dice($damage);

			$this->unit_model->kills($tu,$kills1);


			echo "<hr>";
			echo "Target takes a morale test if it is over 30% casualties, or has lost 25% this shot ....<br>\n";

			if ($flank) {
				echo "Target is flanked, so no return fire, and no firefight<br>\n";
				$story = "Take That !  $target->name<br>Hurrah for the $firer->name<br>";
				echo "<font color=blue>$story</blue>";
			} else {
			if ($target->fatigue >= $target->breakpoint) {
				echo "Ooops - $target->name is currently utterly exhausted (fatigue = $target->fatigue), they can no longer fire.<br>\n";
				return;
			}
			echo "Target unit returns fire !!<br>";

			$tsa = $target->battalion->small_arms;
			$range = (int)$range;
			if ($range <= 2) {

			$multiplier = 1.0;
			// Set the multiplier for target formation
			switch($ff) {
			case 'CC':
				$multiplier = 1.1;
				echo "Target is closed column * 1.1 ..";
				break;
			case 'SQ':
			case 'HS':
				$multiplier = 2.0;
				echo "Target is square * 2.0 ..";
				break;
			case 'OO':
				echo "Target is open order * 0.5 ..";
				$multiplier = 0.5;
				break;
			}
			// Set the multiplier for firer formation
			switch($tf) {
			case 'CC':
				echo "Firer is closed column * 0.9 ..";
				$multiplier *= 0.9;
				break;
			case 'SQ':
			case 'HS':
				echo "Firer is in square * 0.5 ..";
				$multiplier *= 0.5;
				break;
			}
			if ($target->disorder) {
				echo "Firer has $target->disorder% disorder ..";
				$multiplier *= ((100 - $target->disorder)/100.0);
			}
	
			// Set the multiplier for target cover
			switch($firer->cover) {
			case 'L':
				echo "Target is in light cover * 0.9 ..";
				$multiplier *= 0.9;
				break;
			case 'M':
				echo "Target is in medium cover * 0.5 ..";
				$multiplier *= 0.5;
				break;
			case 'H':
				echo "Target is in heavy cover * 0.33 ..";
				$multiplier *= 0.33;
				break;
			case 'S':
				echo "Target is in super heavy cover * 0.1 ..";
				$multiplier *= 0.1;
				break;
			}
			echo "  Total Multiplier = $multiplier<br>\n";
			
			// table depends on target formation
			switch($ff) {
			case 'CC':
			case 'CL':
				switch ($tsa) {
				case 1: $per = 30; break;
				case 2: $per = 24; break;
				case 3: $per = 20; break;
				case 4: $per = 16; break;
				case 5: $per = 12; break;
				case 6: $per = 10; break;
				case 7: $per = 8; break;
				case 8: $per = 6; break; 
				case 9: $per = 4; break;
				case 10: $per = 2; break;
				}
				break;
			case 'SQ':
			case 'HS':
			case 'LN':
			case 'OO':
				switch ($tsa) {
				case 1: $per = 23; break;
				case 2: $per = 18; break;
				case 3: $per = 15; break;
				case 4: $per = 12; break;
				case 5: $per = 9; break;
				case 6: $per = 7; break;
				case 7: $per = 6; break;
				case 8: $per = 5; break; 
				case 9: $per = 3; break;
				case 10: $per = 1.5; break;
				}
				break;
			}

			$perm = $per * $multiplier;
			echo "Per casting firing base rate = $per%, after multiplier $perm%<br>\n";

			$castings = (int) ($target->battalion->strength / 60.0) - $target->battalion->casualties;
			$fcastings = $tb; // * 3;
			if ($fcastings > $castings) { $fcastings = $castings; }
				$strength = $target->battalion->strength;
				$cas = $target->battalion->casualties;
				$fatigue = $target->fatigue;
			echo "Firing unit has an initial strength of $strength , minus $cas casualties and $fatigue fatigue ... which is $castings castings left<br>\n";
			echo "But only $fcastings are firing<br>\n";

			$damage = $castings * $perm / 100.0;
			$fulldamage = (int)($target->battalion->strength * $perm / 100);
			// echo "Total damage = $damage castings / $fulldamage troops (if all of the firing unit is in line)<br>\n";
			echo "<hr>";
			$damage = $fcastings * $perm / 100.0;
			$fulldamage = (int) ($damage * 60);
			echo "Total damage = $damage castings / $fulldamage troops";
			$kills2 = roll_dice($damage);

			$this->unit_model->kills($fu,$kills2);

			echo "<hr>";
			echo "Initial firing unit takes a morale test if it is over 30% casualties, or has lost 25% this shot ....<br>\n";
			echo "<hr>";
			echo "Firefight develops !<br>\n";

			$ace1 = $firer->battalion->ace;
			$ace2 = $target->battalion->ace;
			$diff = $ace1 - $ace2;
			echo "Firer starting ACE = $ace1  Target starting ACE = $ace2, difference = $diff<br>\n";
			if ($kills2) {
				$adjust = $kills2 * 2;
				$ace1 =  ace_adjust($ace1, $adjust * -1);
				echo "Firer took $kills2 kills, so it shifts down $adjust levels from an ACE of $firer->battalion->ace to an ACE of $ace1<br>\n";
			}
			if ($kills1) {
				$adjust = $kills1 * 2;
				$ace2 =  ace_adjust($ace2, $adjust * -1);
				echo "Target took $kills1 kills, so it shifts down $adjust levels from an ACE of $target->battalion->ace to an ACE of $ace2<br>\n";
			}
			$adjust = (int) ($firer->fatigue / 3);
			if ($adjust) {
				$ace1 =  ace_adjust($ace1, $adjust * -1);
				echo "Firer is getting badly fatigued (fatigue = $firer->fatigue), so it shifts down $adjust levels from an ACE of $firer->battalion->ace to an ACE of $ace1<br>\n";
			}
			$adjust = (int) ($target->fatigue / 3);
			if ($adjust) {
				$ace2 =  ace_adjust($ace2, $adjust * -1);
				echo "Target is getting badly fatigued (fatigue = $target->fatigue), so it shifts down $adjust levels from an ACE of $target->battalion->ace to an ACE of $ace2<br>\n";
			}

			$diff2 = $ace1 - $ace2;
			$win_chance = 50 + ($diff2 * 5);
			echo "Modified difference is $diff2, so attacker has a $win_chance% chance of winning the firefight<br>\n";
			$dice = d100();
			echo "Percentile Dice Roll = $dice<br>\n";
			if ($dice <= $win_chance) {
				echo "Attacker wins the firefight !<br>\n";
				$winner = 'Attacker';
				$loser = 'Defender';
				$story = "Take That !  $target->name<br>Hurrah for the $firer->name<br>";
				$extra_kills = $tu;
			} else {
				echo "Defender wins the firefight !<br>\n";
				$loser = 'Attacker';
				$winner = 'Defender';
				$story = "Take That !  $firer->name<br>Hurrah for the $target->name<br>";
				$extra_kills = $fu;
			}
			if ($win_chance < 0) {
				$win_chance *= -1;
			}
			$dice = d100();
			echo "Firefight Percentile Dice roll = $dice<br>\n";
			echo "<font color=blue>";
			if ($win_chance > 99) {
				echo "Automatic win for the $winner !<br>\n";
				if ($dice <= 10) {
					echo "DRAW - no extra casualties<br>\n";
				} else if ($dice <= 50) {
					echo "MINOR VICTORY to $winner - $loser falls back 200yds in good order<br>\n";
					echo $story;
				} else if ($dice <= 80) {
					echo "VICTORY to $winner - defender falls back 300yds in disorder, <b><font color=red>1 EXTRA KILL</font></b><br>\n";
					$this->unit_model->kills($extra_kills,1);
					$this->unit_model->disorder($extra_kills,25);
					echo $story;
				} else {
					echo "MAJOR VICTORY to $winner - defender retreats back 400yds in BAD morale, <b><font color=red>1 EXTRA KILL</font><br>\n";
					$this->unit_model->kills($extra_kills,1);
					$this->unit_model->bad_morale($extra_kills);
					echo $story;
				}

			} else {
				if ($dice <= 40) {
					echo "DRAW - no extra casualties<br>\n";
				} else if ($dice <= 90) {
					echo "MINOR VICTORY to $winner - $loser falls back 200yds in good order<br>\n";
					echo $story;
				} else {
					echo "VICTORY to $winner - $loser falls back 300yds in some disorder<br>\n";
					$this->unit_model->disorder($extra_kills,25);
					echo $story;
				}
			}
			echo "</font>";

			}

			}
		}
		echo "<center><img src=/empire/images/musket-volley.jpg></center>";
	}

}
