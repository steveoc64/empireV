<div id="lister">
<?php


$this->table->set_caption('<h2>Nations of the Napoleonic Wars</h2>');
$this->table->set_heading('Name','Description','Flag');

$tmpl = array ('table_open' => '<table border="1" cellpadding="4" cellspacing="0" width=100%>',
               'cell_alt_start'      => '<td bgcolor=#aaaaff>'
              );
$this->table->set_template($tmpl);

echo $this->table->generate($nations);

?>
</div>
