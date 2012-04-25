<?php

class Movement extends CI_Model {

	// Initialize
	function init ($game) {
		$this->game = $game;
		$this->multiplier = 1.0;
	}

	// For a given unit, return an array of move distances (in yards) based on formation and terrain
	function grand_tactical_move ($unit, $formation = null) {
		$retval = array();
		$retval['Contour'] = -50;

		$unit_type = $unit->unit_type;
		if ($unit_type == TYPE_BATTERY) {
			if ($unit->is_limbered) {
				if ($unit->battery->type == 'Horse') {
					// Limbered Horse artillery move as cavalry in Grand Tactical movement
					$unit_type = TYPE_SQUADRON;
				} else {
					// Limbered Foot artillery move as infantry - speed depends on the drill
					// type of the immediate parent formation
					$unit_type = TYPE_BATTALION;
				}
			} 
			// Not limbered - drop down below to return the Prolong movement rates
		}

		switch ($unit->unit_type) {
		case TYPE_ARMY:
		case TYPE_CORPS:
		case TYPE_WING:
		case TYPE_DIVISION:
		case TYPE_BRIGADE:
		case TYPE_CAV_BRIGADE:
			// All leaders move at a standard rate
			$retval['Column'] = array();
			$retval['Column']['Open'] = 2000 * $this->multiplier;
			$retval['Column']['LightWoods'] = 1000 * $this->multiplier;
			$retval['Column']['HeavyWoods'] = 500 * $this->multiplier;
			$retval['Column']['Town'] = 1000 * $this->multiplier;
			$retval['Column']['Swamp'] = 500 * $this->multiplier;
			$retval['RoadColumn'] = array();
			$retval['RoadColumn']['Open'] = 2880 * $this->multiplier;
			$retval['RoadColumn']['LightWoods'] = 1440 * $this->multiplier;
			$retval['RoadColumn']['HeavyWoods'] = 720 * $this->multiplier;
			$retval['RoadColumn']['Town'] = 1440 * $this->multiplier;
			$retval['RoadColumn']['Swamp'] = 720 * $this->multiplier;
			break;

		case TYPE_BATTALION:
			// Depending on Drill - so get the immediate parent unit for this unit to work out the drill used
			$drill = 1;	// Default to old school Prussian Drill, unless the parent unit is using reformed (French) drill
			$_ = $this->db->get_where('unit',array('id' => $unit->parent_id))->row();
			if ($_) {
				$parent_unit = $this->game->get_unit($_->id);
				if ($parent_unit && $parent_unit->unit_type == TYPE_BRIGADE) {
					if ($parent_unit->brigade->drill == 2) {
						$drill = 2;
					}
				}
			}

			$retval['Column'] = array();
			$retval['Line'] = array();
			$retval['Square'] = array();
			$retval['RoadColumn'] = array();

			switch ($drill) {
			case 1: // Old school Prussian Drill manual
				$retval['Column']['Open'] = 1120 * $this->multiplier;
				$retval['Column']['LightWoods'] = 560 * $this->multiplier;
				$retval['Column']['HeavyWoods'] = 280 * $this->multiplier;
				$retval['Column']['Town'] = 560 * $this->multiplier;
				$retval['Column']['Swamp'] = 280 * $this->multiplier;
				$retval['Line']['Open'] = 840 * $this->multiplier;
				$retval['Line']['LightWoods'] = 420 * $this->multiplier;
				$retval['Line']['HeavyWoods'] = 210 * $this->multiplier;
				$retval['Line']['Town'] = 420 * $this->multiplier;
				$retval['Line']['Swamp'] = 210 * $this->multiplier;
				$retval['Square']['Open'] = 560 * $this->multiplier;
				$retval['Square']['LightWoods'] = 280 * $this->multiplier;
				$retval['Square']['HeavyWoods'] = 140 * $this->multiplier;
				$retval['Square']['Town'] = 280 * $this->multiplier;
				$retval['Square']['Swamp'] = 140 * $this->multiplier;
				$retval['RoadColumn']['Open'] = 1600 * $this->multiplier;
				$retval['RoadColumn']['LightWoods'] = 800 * $this->multiplier;
				$retval['RoadColumn']['HeavyWoods'] = 400 * $this->multiplier;
				$retval['RoadColumn']['Town'] = 800 * $this->multiplier;
				$retval['RoadColumn']['Swamp'] = 400 * $this->multiplier;
				break;

			case 2: // Reformed French Drill manual
				$retval['Column']['Open'] = 1600 * $this->multiplier;
				$retval['Column']['LightWoods'] = 800 * $this->multiplier;
				$retval['Column']['HeavyWoods'] = 400 * $this->multiplier;
				$retval['Column']['Town'] = 800 * $this->multiplier;
				$retval['Column']['Swamp'] = 400 * $this->multiplier;
				$retval['Line']['Open'] = 1200 * $this->multiplier;
				$retval['Line']['LightWoods'] = 600 * $this->multiplier;
				$retval['Line']['HeavyWoods'] = 300 * $this->multiplier;
				$retval['Line']['Town'] = 600 * $this->multiplier;
				$retval['Line']['Swamp'] = 300 * $this->multiplier;
				$retval['Square']['Open'] = 800 * $this->multiplier;
				$retval['Square']['LightWoods'] = 400 * $this->multiplier;
				$retval['Square']['HeavyWoods'] = 200 * $this->multiplier;
				$retval['Square']['Town'] = 400 * $this->multiplier;
				$retval['Square']['Swamp'] = 200 * $this->multiplier;
				$retval['RoadColumn']['Open'] = 2400 * $this->multiplier;
				$retval['RoadColumn']['LightWoods'] = 1200 * $this->multiplier;
				$retval['RoadColumn']['HeavyWoods'] = 600 * $this->multiplier;
				$retval['RoadColumn']['Town'] = 1200 * $this->multiplier;
				$retval['RoadColumn']['Swamp'] = 600 * $this->multiplier;
				break;
			}
			break;
		case TYPE_SQUADRON:
			$retval['Column'] = array();
			$retval['Line'] = array();
			$retval['RoadColumn'] = array();

			$retval['Column']['Open'] = 2000 * $this->multiplier;
			$retval['Column']['LightWoods'] = 1000 * $this->multiplier;
			$retval['Column']['HeavyWoods'] = 500 * $this->multiplier;
			$retval['Column']['Town'] = 1000 * $this->multiplier;
			$retval['Column']['Swamp'] = 500 * $this->multiplier;
			$retval['Line']['Open'] = 1600 * $this->multiplier;
			$retval['Line']['LightWoods'] = 800 * $this->multiplier;
			$retval['Line']['HeavyWoods'] = 400 * $this->multiplier;
			$retval['Line']['Town'] = 800 * $this->multiplier;
			$retval['Line']['Swamp'] = 400 * $this->multiplier;
			$retval['RoadColumn']['Open'] = 2880 * $this->multiplier;
			$retval['RoadColumn']['LightWoods'] = 1440 * $this->multiplier;
			$retval['RoadColumn']['HeavyWoods'] = 720 * $this->multiplier;
			$retval['RoadColumn']['Town'] = 1440 * $this->multiplier;
			$retval['RoadColumn']['Swamp'] = 720 * $this->multiplier;
			break;

		case TYPE_BATTERY:
			// This is for Prolong rates only
			$retval['Prolong'] = array();

			if ($unit->battery->type == 'Horse') {
				$retval['Prolong']['Open'] = 240 * $this->multiplier;
				$retval['Prolong']['LightWoods'] = 120 * $this->multiplier;
				$retval['Prolong']['HeavyWoods'] = 0;
				$retval['Prolong']['Town'] = 120 * $this->multiplier;
				$retval['Prolong']['Swamp'] = 0;
			} else {
				$retval['Prolong']['Open'] = 160 * $this->multiplier;
				$retval['Prolong']['LightWoods'] = 80 * $this->multiplier;
				$retval['Prolong']['HeavyWoods'] = 0;
				$retval['Prolong']['Town'] = 80 * $this->multiplier;
				$retval['Prolong']['Swamp'] = 0;
			}

			break;
		}

		return $retval;
	}


}

?>
