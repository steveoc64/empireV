<html>
<head>
<title>Photo Upload</title>
</head>
<body>

<h2>File Uploaded</h2>

<ul>
<?php foreach ($upload_data as $item => $value):?>
<li><?php echo $item;?>: <?php echo $value;?></li>
<?php endforeach; ?>
</ul>

</body>
</html>
