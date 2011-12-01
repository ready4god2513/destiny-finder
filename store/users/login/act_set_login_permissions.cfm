<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This code is called from both act_login.cfm and shopping/checkout/post_processing/act_membership.cfm. --->
	
<!--- Retrieve User Group info --->
<cfquery name="UserGroup" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" maxrows=1>
SELECT Wholesale, Permissions FROM #Request.DB_Prefix#Groups
WHERE Group_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#qry_get_user.Group_ID#">
</cfquery>
	
<!--- combine User Permissions & Group Permissions --->
<cfset Keys = StructNew()>

	<!--- loop through user permissions and put them in keys --->
	<cfif len(qry_get_user.permissions)>
		<cfloop index="thiskey" list="#qry_get_user.permissions#" delimiters=";">
		<cfif listLen(thiskey,'^') is not 1>
			<cfset success = StructInsert(keys, listGetAt(thiskey, 1, '^'),listGetAt(thiskey, 2, '^'))>
		<cfelse>
			<cfset success = StructInsert(keys, listGetAt(thiskey, 1, '^'),'')>
		</cfif>
		
		</cfloop>
	</cfif>
	
	<!--- loop through group permissions and add them to keys --->
	<cfif len(UserGroup.permissions)>
		
		<cfloop index="thiskey" list="#UserGroup.permissions#" delimiters=";">
			<cfset thiskey_name = listGetAt(thiskey, 1, '^')>
			<cfif listLen(thiskey,'^') is not 1>
				<cfset thiskey_value = listGetAt(thiskey, 2, '^')>
			<cfelse>
				<cfset thiskey_value = 0>
			</cfif>
				
			<cfif StructKeyExists(Keys, thiskey_name)>
				<cfif Right(thiskey_name,4) is "list">
					<cfset newlist = ListAppend(evaluate("Keys." & thiskey_name), thiskey_value)>
					<cfset success = SetVariable("keys." & thiskey_name, newlist)>
				<cfelse>
					<cfset success = SetVariable("keys." & thiskey_name, 
BitOr(Evaluate("Keys." & thiskey_name), thiskey_value))>
				</cfif>										
			<cfelse>
				<cfset success = StructInsert(keys, thiskey_name, thiskey_value)>
			</cfif>
		</cfloop>
	</cfif>
	
	<!--- Add membership access keys in -------------->
	<cfquery name="GetMemberships" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	SELECT Accesskey_ID	FROM #Request.DB_Prefix#Memberships
	WHERE User_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#qry_get_user.user_id#">
		AND Valid = 1
		AND AccessKey_ID IS NOT NULL
		AND (Start <= <cfqueryparam cfsqltype="CF_SQL_TIMESTAMP" value="#Now()#">
			 OR Start IS NULL)
		AND (Expire > <cfqueryparam cfsqltype="CF_SQL_TIMESTAMP" value="#DateAdd('d', -1, Now())#">
			 OR Expire IS NULL)
		AND (Suspend_Begin_Date IS NULL 
		OR Suspend_Begin_Date > <cfqueryparam cfsqltype="CF_SQL_TIMESTAMP" value="#DateAdd('d', -1, Now())#">)
	</cfquery>
	
	<cfif GetMemberships.recordcount>
	
		<cfif StructKeyExists(Keys, 'contentkey_list')>
			<cfset keys.contentkey_list = listappend(keys.contentkey_list,valuelist(GetMemberships.Accesskey_ID))>
		<cfelse>
			<cfset success = StructInsert(keys, 'contentkey_list', valuelist(GetMemberships.Accesskey_ID))>
		</cfif>
	
	</cfif>
	

	<!--- turn key structure into session variable  ---->
	<cfset sessionkeys = "">
	
	<!--- loop through structure and add keyname^keyvalue to list --->
	<cfloop index="thiskey" list="#StructKeyList(Keys)#">
		<cfset sessionkeys = listappend(sessionkeys,'#thiskey#^#evaluate('keys.' & thiskey)#',';')>
	</cfloop>		
	
					
<!--- CODE TO PREVENT MULTIPLE LOGINS OF A SINGLE USER 
Membership Fraud Protection: Knock out any current session already using this user_ID --->

<cfif get_User_Settings.StrictLogins>
	<cfset tracker = createObject("java", "coldfusion.runtime.SessionTracker")>
	<cfset sessions = tracker.getSessionCollection(application.applicationName)>
	<!--- DEBUG:<cfdump var="#sessions#">  --->
		<cfloop collection="#sessions#" item="cfid">
		<cfif StructKeyExists(sessions[cfid], "user_id") AND sessions[cfid].user_id is qry_get_user.User_ID>
		<!--- Send Alert Email to site Admin  ---->
		<cfmail to="#request.appsettings.merchantemail#" from="#request.appsettings.merchantemail#"
		subject="#request.appsettings.sitename# Simultaneous Login: #sessions[cfid].username#"
		server="#request.appsettings.email_server#" port="#request.appsettings.email_port#">
		On #dateformat(now(),"mm/dd/yyyy")# at #timeformat(now(),"HH:mm:ss")#
		User #sessions[cfid].username# ID (User ID #sessions[cfid].user_id#)
		had a simultaneous login
		</cfmail>
			<cfset sessions[cfid].user_id = 0>
		</cfif>
		<!--- DEBUG: <cfdump var="#sessions[cfid]#"><br/>  --->
	</cfloop>
</cfif>
<!--- end strict login code --->
							
					
<cflock timeout="20" throwontimeout="No" type="EXCLUSIVE" scope="SESSION">
	<cfset Session.UserPermissions = sessionkeys>
	<cfset Session.Group_ID = qry_get_user.Group_ID>
	<cfset Session.User_ID = qry_get_user.User_ID>
	<cfset Session.Username = qry_get_user.username>
	<cfif userGroup.Wholesale is "">
		<cfset Session.Wholesaler = 0>
	<cfelse>
		<cfset Session.Wholesaler = UserGroup.Wholesale>
	</cfif>
	<cfif len(qry_get_user.firstname)>
		<cfset Session.Realname = qry_get_user.firstname & " " & qry_get_user.lastname>
	<cfelse>
		<cfset Session.Realname = qry_get_user.username>
	</cfif>		
</cflock>


