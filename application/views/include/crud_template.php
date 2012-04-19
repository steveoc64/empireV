<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8" />
	<title>Empire V - Electro Mechanical Apparatus for Combat Simulation</title>
	<link rel="stylesheet" href="css/style.css" type="text/css" media="screen">

<?php foreach($css_files as $file): ?>
	<link type="text/css" rel="stylesheet" href="<?php echo $file; ?>" />
<?php endforeach; ?>
<?php foreach($js_files as $file): ?>
	<script src="<?php echo $file; ?>"></script>
<?php endforeach; ?>

</head>
<body>
<script src="jquery.js"></script>
<script>
     $(document).ready(function(){
       $("input").click(function(event){
	       $(this).select();
       });
     });
</script>
<body>
<div id="menu">
<ul class="vmenu">
<?php
?>
</ul>
</div>


</body>
</html>
