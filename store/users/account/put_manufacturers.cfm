
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Used to create a box that lists manufacturers, for user to view list of products for each. Used as a page template of custom tag. --->

<cfparam name="attributes.more" default="">
<cfparam name="attributes.box_title" default="Shop By Manufacturer">
<cfparam name="attributes.AccountCols" default="#request.appsettings.CColumns#">

<cfset type1 = "manufacturer">
<cfinclude template="qry_get_vendors.cfm">

<cfset numrows = Ceiling(qry_get_Vendors.RecordCount/attributes.AccountCols)>
<cfset rowcount = 1>

<cfmodule template="../../customtags/format_box.cfm"
box_title="#attributes.box_title#"
TBgcolor="###Request.GetColors.BoxHBgcolor#"
more="#attributes.more#"
float=""
>

<cfoutput>
<table width="100%" cellspacing="0" cellpadding="4">
	<tr>
	<cfloop query="qry_get_Vendors">		
		<cfif rowcount IS 1>
			<td width="#(100/attributes.AccountCols)#%" bgcolor="###Request.GetColors.BoxTBgcolor#" class="manufacturer_list">
		</cfif>
		<a href="#XHTMLFormat("index.cfm?fuseaction=product.list&mfg_account_id=#Account_ID##Request.Token2#")#" class="manufacturer_list" #doMouseover(Account_Name)#>#Account_Name#</a><br/>
		
		<cfif rowcount IS numrows>
			</td>
			<cfset rowcount = 1>
		<cfelse>
			<cfset rowcount = rowcount + 1>
		</cfif>
	</cfloop>
	</tr>
</table>
</cfoutput>

</cfmodule>	
