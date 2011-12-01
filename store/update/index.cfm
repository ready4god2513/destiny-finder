<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>CFWebstore Migration</title>
</head>

<body>
Important: Be sure your database has been upgraded to the latest 5.x version first. <br><br>

Before running these ColdFusion scripts, you must run the update SQL scripts for your database first to update the database structure and data.<br><br> 

Be sure to set up the CFC mapping and configure your settings in Application.cfm first!<br>
<br>

	<form action="migration.cfm" method="post">
	<input type="Hidden" name="Page" value="1">
	<input type="submit" value="Begin the Migration">
	</form>
	
	
</body>
</html>
