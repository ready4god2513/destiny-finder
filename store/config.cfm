<cfsilent>
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Used to set variables for databases and store, called by main fbx_settings.cfm --->


<!--- Set Datasource Name and login  --->
<cfparam name="Request.ds" default="destinyfinder_store">
<cfparam name="Request.user" default="">
<cfparam name="Request.pass" default="">

<!--- Set database type, used for some queries. Options are 'Access' 'MSSQL' and 'MySQL' --->
<cfparam name="Request.dbtype" default="MSSQL">

<!--- Set server type, used when setting file paths. Options are 'Unix' or 'Windows'. 
	For other servers, choose the one that matches the same file paths as yours.  --->
<cfparam name="Request.servertype" default="Windows">

<!--- For CC Encryption, just enter a random string here when setting up a new store --->
<!--- Don't change this after your store goes live unless all orders are filled! --->
<!--- If you have user credit cards turned on and save card data for your customers, change this only ONCE when you set up your site for the first time.  --->
<!--- Be sure to save your key elsewhere as well, in the event it accidentally gets lost or overwritten.  --->
<cfparam name="Request.encrypt_key" default="DEST93850">

<!--- This is a prefix appended to the front of the table names in your database. Useful if you need to run multiple stores from one database. Leave blank for normal installations. --->
<cfparam name="Request.DB_Prefix" default="">

<!--- Set Store and Secure site URLS. MUST include a trailing slash! 
EXAMPLE: <cfparam name="Request.StoreURL" default="http://www.cfwebstore.com/"> --->	
<cfparam name="Request.StoreURL" default="http://www.destinyfinder.com/store/">
<cfparam name="Request.SecureURL" default="https://www.destinyfinder.com/store/"> 

<!--- Set this to "yes" if your SSL is shared, or otherwise does not match your main URL (i.e. secure.domain.com versus www.domain.com) --->
<!--- PLEASE NOTE that setting this to "yes" will append session IDs to the URL which is somewhat of a security risk, but is necessary to maintain sessions. 
		It is strongly recommended that you purchase your own SSL (godaddy.com is a cheap source) so you can turn this setting off. --->
<cfparam name="Request.SharedSSL" default="no"> 

<!--- Path to store directory from your web root. It should be at least a forward slash, if you are running the store from the top directory, 
		and should include a trailing slash if using a subdirectory. The example below would be the store path given the URLs used above. --->
<cfset Request.StorePath = "/store/">

<!--- 	Mapping on ColdFusion to the CFCs directory, you can leave this as is unless you want to set up a custom mapping
		If you have periods in your storepath above, or are using an SSL with a different URL path, 
		you may need to use a custom mapping to the cfcs directory, as those configurations will cause problems here --->
<cfset Request.CFCMapping = "#Request.StorePath#cfcs">

<!--- Path on the server to your downloads directory. Used if you sell any electonic downloadable files. --->
<!--- The downloads directory can be located away from your web root for the best security  --->
<cfset Request.DownloadPath = "">

<!--- Path on the server to a temporary uploads directory. Leave this blank if you don't want to use it, but if you allow public uploads on your site, 
		such as the Contact Us with Attachment form, you definitely should use a temp directory for uploads for additional security. It's a good idea to 
		use it on any site for protection against external hack attempts. --->
<!--- The temp directory should be located away from your web root for the best security  --->
<!--- Example: <cfset Request.TempPath = "c:\cfusionmx\wwwroot\tempfiles"> --->
<cfset Request.TempPath = "">

<!--- Mime types allowed for downloads, and matching file extensions. Any uploads must be one of the mime types you list here. --->
<!--- Be careful what files you allow! Do not configure this to allow octect stream or other executable file types. --->
<!--- You can also upload other files through regular FTP --->
<cfset Request.MimeTypes = "application/x-zip-compressed, application/zip, application/msword, application/x-excel, text/plain, application/pdf, audio/mpeg">
<cfset Request.AllowExtensions = "jpg,jpeg,gif,png,pdf,doc,mov,ppt,zip,txt,xls">

<!--- Demo mode is used for demoing the software and will disable certain features, such as signing up for UPS and Fedex, setting payment gateways, uploading files, or modifying the admin account --->
<cfset Request.DemoMode = "no">

<!--- Uncomment this line to use an image for the gift registry button (this setting will eventually be moved to the DB) --->
<cfset Request.RegistryButton = "addtoregistry.gif">

</cfsilent>
