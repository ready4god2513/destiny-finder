<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Saves the credit card processing settings for the store. Includes 5 fields which can be used by the processor form pages. Called by shopping.admin&payment=cards --->

<cfscript>
function CheckNull(val) {
	var returnval = YesNoFormat(not Len(trim(val)));
	return returnval;
}

</cfscript>

<cfparam name="attributes.CCServer" default="">
<cfparam name="attributes.Password" default="">
<cfparam name="attributes.Transtype" default="">
<cfparam name="attributes.Username" default="">
<cfparam name="attributes.Setting1" default="">
<cfparam name="attributes.Setting2" default="">
<cfparam name="attributes.Setting3" default="">

<!--- BEGIN MOD - added SMS: 04/10/2007 --->
<cfswitch expression="#get_Order_Settings.CCProcess#">
	<cfcase value="Shift4OTN">
		<cfinclude template="act_shift4otn.cfm">
	</cfcase>
</cfswitch>
<!--- END MOD --->

<cfquery name="EditCCProcess" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
UPDATE #Request.DB_Prefix#CCProcess
SET CCServer = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Trim(attributes.CCServer)#" null="#CheckNull(attributes.CCServer)#">,
Password = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Trim(attributes.Password)#" null="#CheckNull(attributes.Password)#">,
Transtype = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Trim(attributes.Transtype)#" null="#CheckNull(attributes.Transtype)#">,
Username = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Trim(attributes.Username)#" null="#CheckNull(attributes.Username)#">,
Setting1 = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Trim(attributes.Setting1)#" null="#CheckNull(attributes.Setting1)#">,
Setting2 = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Trim(attributes.Setting2)#" null="#CheckNull(attributes.Setting2)#">,
Setting3 = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Trim(attributes.Setting3)#" null="#CheckNull(attributes.Setting3)#">
</cfquery>

<cfif IsDefined("FORM.ProcessPost")>
	<cfset VARIABLES.ConfigProcess="Postprocess.Post">
	<cfinclude template="#FORM.ProcessPost#">
</cfif>





