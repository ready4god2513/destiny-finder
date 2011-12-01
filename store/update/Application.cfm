
<!--- Set Datasource Name and login  --->
<cfparam name="Request.ds" default="cfwebstorefb6">
<cfparam name="Request.user" default="">
<cfparam name="Request.pass" default="">

<!--- Set database type, used for some queries. Options are 'MSSQL' and 'MySQL' --->
<cfparam name="Request.dbtype" default="MySQL">

<!--- For CC Encryption, this should be the same as the one in config.cfm if you have 
user credit cards turned on and save card data for your customers --->
<cfparam name="Request.encrypt_key" default="mykey">

<!--- Path to store directory from the web root. It should be at least a forward slash, if you are running the store from the top directory, and should include a trailing slash if using a subdirectory. --->
<cfset Request.StorePath = "/cfwebstorefb6/">

<!--- Mapping on ColdFusion to the CFCs directory, you can leave this as is unless you want to set up a custom mapping --->
<cfset Request.CFCMapping = "#Request.StorePath#cfcs">

<!--- Set timeout to prevent long queries from timing out the page --->
<cfsetting requestTimeout = 1000>

<!--- Don't change anything else --->

<cfset Request.Cache = CreateTimeSpan(0, 0, 0, 0)>
<cfparam name="Request.DB_Prefix" default="">

<cfapplication name="#Request.DS#" clientmanagement="No" sessionmanagement="Yes" 
	setclientcookies="No" sessiontimeout="#CreateTimeSpan(0, 0, 20, 0)#"
	applicationtimeout="#CreateTimeSpan(0, 2, 0, 0)#">	
	
