<!--- Place any code that needs to be run daily on this template. This template can be called at any number of hourly intervals, 
but the first time should run after midnight (or just adjust the setting below)--->

<!--- Set the time interval in hours that you are going to set this up for. Typically you would only run daily unless you use recurring memberships, in which case you may want to run it every 2 or 3 hours --->
<cfset run_interval = "24">

<!--- Run these functions only if running between midnight and 1 am --->
<cfif DatePart("h", Now()) IS 0>

	<!--- Save all output to a variable to email --->
	<cfsavecontent variable="dailyEmail">
	
		<!--- Send a 3-day expiration notice --->
		<cfinclude template="../../access/admin/membership/act_expiration_notice.cfm">
	
		<!--- Bill recurring memberships --->
		<cfinclude template="../../access/admin/membership/act_bill_recurring.cfm">
		
		<!--- Clear old download directories --->
		<cfinclude template="../../access/act_clear_downloads.cfm">
		
		<cfif Request.AppSettings.UseVerity>
			<cfinclude template="../settings/act_verity.cfm">
		</cfif>
		
	</cfsavecontent>
	  
	<cfoutput>#variables.dailyEmail#</cfoutput>
	
	<!--- Send a summary email to the site admin --->
	<cfmail to="#request.appsettings.merchantemail#" from="#request.appsettings.merchantemail#" 
		subject="#request.appsettings.sitename# Daily Maintenance" 
		server="#request.appsettings.email_server#" port="#request.appsettings.email_port#">
	
	#variables.dailyEmail#
	
	</cfmail>


<cfelse>
	<!--- Bill recurring memberships --->
	<cfinclude template="../../access/admin/membership/act_bill_recurring.cfm">
		
	<!--- Clear old download directories --->
	<cfinclude template="../../access/act_clear_downloads.cfm">
	
</cfif>
