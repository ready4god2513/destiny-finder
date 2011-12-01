<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This template emails the ADMIN when a new member signs up. It is called from act_register.cfm. ---->	

<cfset LineBreak = Chr(13) & Chr(10)>

<cfif NOT isDefined("attributes.FirstName")>
	<!--- See if the user has a customer record --->
	<cfif qry_get_user.Customer_ID IS NOT 0>
		<cfset attributes.Customer_ID = qry_get_user.Customer_ID>
		<cfinclude template="qry_get_customer.cfm">
		<cfloop list="#qry_get_customer.ColumnList#" index="counter">
			<cfset "attributes.#counter#" = evaluate("qry_get_customer." & counter)>
		</cfloop>			
	</cfif>
</cfif>

<cfset MergeContent = "User Name:  #qry_get_user.Username#" & LineBreak & LineBreak>

<cfif isDefined("attributes.FirstName")>
<cfset MergeContent = MergeContent & "#attributes.FirstName# #attributes.LastName#" & LineBreak>
<cfif len(attributes.Company)>
	<cfset MergeContent = MergeContent & "#attributes.Company#" & LineBreak>	
</cfif>
<cfset MergeContent = MergeContent & "#attributes.Address1#" & LineBreak>	
<cfif len(attributes.address2)>
	<cfset MergeContent = MergeContent & "#attributes.Address2#" & LineBreak>	
</cfif>
<cfset MergeContent = MergeContent & LineBreak & "#attributes.City#, ">

<cfif attributes.State IS NOT "Unlisted">
	<cfset MergeContent = MergeContent & "#attributes.State# ">
<cfelse>
	<cfset MergeContent = MergeContent & "#attributes.State2# ">
</cfif>

<cfset MergeContent = MergeContent & "#attributes.Zip# ">

<cfif attributes.Country IS NOT "" AND attributes.Country IS NOT Request.AppSettings.HomeCountry>
	<cfset MergeContent = MergeContent & ListLast(attributes.Country,"^")& LineBreak & LineBreak>
</cfif>

<cfset MergeContent = MergeContent & "Phone: #attributes.Phone#" & LineBreak>
<cfset MergeContent = MergeContent & "Fax: #attributes.Fax#" & LineBreak>

</cfif>

<cfset MergeContent = MergeContent & "Email: #attributes.Email#" & LineBreak>

<!--- Send Confirmation Email --->
<cfinvoke component="#Request.CFCMapping#.global" 
	method="sendAutoEmail" Email="#Request.AppSettings.Webmaster#" 
	MailAction="NewMemberNotice" MergeContent="#MergeContent#">

