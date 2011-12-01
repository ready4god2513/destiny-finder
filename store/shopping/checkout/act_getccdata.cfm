<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Retrieves the CC data and makes sure it is valid for use --->

<cfinclude template="../../users/qry_get_user.cfm">

<cfif NOT isDate(qry_Get_User.CardExpire)>

	<cfset validonfile = 0>
	<cfset checkdate = 0>
	
<cfelse>

	<cfset Month = Month(qry_Get_User.CardExpire)>
	<cfset Year = Year(qry_Get_User.CardExpire)>
	
</cfif>

<cftry>

<cfmodule template="../../customtags/crypt.cfm" action="de" string="#qry_Get_User.EncryptedCard#" key="#Request.encrypt_key#">
						
<cfset attributes.CardNumber = crypt.value>

<cfcatch type="Any">
	<cfset attributes.CardNumber = 'Decrypt Failed'>
</cfcatch>
</cftry>

<cfset attributes.CardType = qry_Get_User.CardType>
<cfset attributes.NameonCard = qry_Get_User.NameonCard>
<cfset attributes.CVV2 = ''>
