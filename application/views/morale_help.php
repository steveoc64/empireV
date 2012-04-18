<h2>Empire Morale Help Notes</h2>
<? $_ = site_url(); ?>
<table border=0><tr><td valign=top><img src=<?=$_?>images/pix_arcola.jpg><br><img src=<?=$_?>images/arcola.jpg><br><img src=<?=$_?>images/rivoli.jpg><br><img src=<?=$_?>images/russian-cav.jpg></td><td>
Morale tests in Empire at this phase of the turn are conducted over entire MEs (Manoeure Elements) that have been close to some serious action in the previous turn.
<p>
The Morale Grade used in each case is the average morale grade for the whole unit. (The computer moderated system already calculates this average for you).
<p>
<b><u>Running the Morale Tests :</b></u><br>
Very simple - click the checkboxes for any units that you want to test, and then click 'Run Selected Morale Tests'.
<p>
Doing so will generate a set of morale checks, and immediately apply the results to the affected units (should they fail).
<p>
If any units fail, then this can trigger more tests, as detailed below.
<p>
When you are all done, click the 'All done .. continue to next Phase' button at the bottom of the screen to move along.

<p>
Not every unit needs to test. Generally, you definitely test units that fall into any of the categories below, but the players and umpires may choose to run additional tests as well if they think that the circumstances or scenario demand it. 
<p>
The following cases trigger an ME morale test at this phase of the game :

<ol>
<li> If a friendly ME failed the previous test, and retreated into this ME.
<li> If this ME is within 400 yards<br><i>(<?
if (isset($game)) {
	if ($game->ground_scale) {
		$distance = (int) (400 / $game->ground_scale);
		echo "$distance inches at 1\"=".$game->ground_scale."yds current game scale";
	} else {
		echo "10 inches at 1\"=40yds";
	}
} else {
		echo "10 inches at 1\"=40yds";
}
?>)</i><br>of any friendly ME which did the following :
<ul>
<li> Broke due to loss of a commander.
<li> Broke during determination test (previous phase)
<li> Was completely wiped out in the last hour.
<li> Broke during a morale test in this same phase **
</ul>
</ol>
</td></tr><tr><td colspan=2>
** So you can see here, that some judgement is required in running the ME morale test. Failures during this test may trigger more tests in adjoining units, if they are within range before breaking and running away. This is best managed by a human umpire, and not the computer !!
<p>
Any given ME may need to be tested <u>multiple times</u> during this phase !
<p>
<b><u>Exemptions to Morale Tests :</b></u><br>
There are always exemptions to rules in Empire ! The following factors will exempt a unit from needing to test morale during this phase :

<ul>
<li> If this unit is 2 or more morale grades BETTER than the adjoining unit that triggers a test, this unit ignores the effect of the rabble in the other unit breaking. Losing your Landwehr wont cause the Lieb Garde to panic under this system. (Except if the Landwehr retreat directly into the Lieb Garde, then you must test under point 1) above).
<li> If this is an Infantry ME, in a BUA, on Garrison orders .. then it stays put and will not need to test morale (even if another ME retreats into the unit).
<li> Finally - units who suffered Retreat or Broken results from the previous phase's ME Determination test ... are already running away, so there is no need for additional testing of them.
</ul>
</td></tr></table>

