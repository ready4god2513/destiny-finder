<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Page to help debug permissions --->

<h1>session.UserPermissions</h1>

<cfoutput>
	session.userpermissions is: <b>#session.userpermissions#</b>
	
	<br/><br/>
	<!------
	<p>registration key value is
	<cfset reg_loc = ListContains(session.userPermissions,'registration',';')>
	<cfset reg_val = ListLast(ListGetAt(session.userPermissions,reg_loc,';'),'^')>
	#reg_val#
	</p>
			
	<p>shopping key value 
	<cfset keyname = "shopping">
	<cfset key_loc = ListContainsNoCase(session.userPermissions,keyname,';')>
	<cfif key_loc>
		<cfset key_val = ListLast(ListGetAt(session.userPermissions,key_loc,';'),'^')>
	<cfelse>
		<cfset key_val = 0>
	</cfif>
	list location is #key_loc# and value is #key_val#
	</p>		
	---->	
</cfoutput>
