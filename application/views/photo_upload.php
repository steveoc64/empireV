<html>
<head>
<title>Photo Upload</title>
</head>
<body>

<h2>Upload Photo to Game</h2>
<?php echo form_open_multipart('photo_upload/do_upload');?>

<input type="file" name="userfile" size="40" />
<br>
Description of the Photo :
<br>
<textarea rows="4" cols="40" name=caption>
</textarea>

<br /><br />

<input type="submit" value="upload" />

</form>

</body>
</html>

