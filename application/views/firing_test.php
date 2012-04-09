<div id="form">
	<h1>Firing Test</h1>
<fieldset>
<?php
	echo form_open('test/firing');
	
	echo form_fieldset('Firer Details (ID #Figs Formation)');
        echo form_input('fu','FiringUnit');
	echo form_input('fb','Figures');
	$options = array('CL' => 'Column','LN'=>'Line','SQ'=>'Square','CC'=>'Closed Column','OO'=>'Open Order','HS'=>'Hasty Square');
	echo form_dropdown('ff',$options);
	echo form_fieldset_close(); 

	echo form_fieldset('Target Details (ID #Figs Formation)');
	echo form_input('tu','TargetUnit');
	echo form_input('tb','Figures');
	$options = array('CL' => 'Column','LN'=>'Line','SQ'=>'Square','CC'=>'Closed Column','OO'=>'Open Order','HS'=>'Hasty Square');
	echo form_dropdown('tf',$options);
	echo form_fieldset_close(); 

	echo form_fieldset('Range in Inches');
	echo form_input('range','0');
	echo form_fieldset_close(); 

	echo form_fieldset('Special Conditions');
 	echo "Flank Shot  ";
	echo form_checkbox('flank', 'flank', FALSE);
	echo form_fieldset_close(); 


	echo form_submit('submit','Submit');

?>
</fieldset>
</div>
