<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Used to output a listing of features. Used by various category templates --->

<cfparam name="attributes.featureCols" default="#request.appsettings.PColumns#">
<cfif isdefined("request.qry_get_cat.pcolumns") and len(request.qry_get_cat.pcolumns)>
	<cfset attributes.featureCols = request.qry_get_cat.pcolumns>
</cfif>

<cfloop query="qry_get_features" startrow="#PT_StartRow#" endrow="#PT_EndRow#">

<!--- Output feature's name and description --->
<cfoutput>
<cfif attributes.featureCols LTE 1 OR qry_get_features.CurrentRow MOD attributes.featureCols IS 1>
<table border="0" cellspacing="0" cellpadding="6" width="100%"><tr>
</cfif> 
	<td valign="top" width="#(100/attributes.featureCols)#%">
	</cfoutput>

	<cfinclude template="put_feature_listing.cfm">

<cfmodule template="../access/secure.cfm"
	keyname="users"
	requiredPermission="1"
	>	
	<cfoutput>
	<span class="menu_admin">[<a href="#XHTMLFormat('#Request.SecureURL##self#?fuseaction=feature.admin&feature=edit&feature_id=#feature_id##Request.AddToken#')#" #doAdmin()#>EDIT FEATURE #Feature_id#</a>]</span>
	</cfoutput>
</cfmodule>

<cfoutput></td></cfoutput>

<cfset NumList = NumList - 1>

<cfif attributes.featureCols LTE 1 OR Numlist is 0 OR qry_get_features.CurrentRow MOD attributes.featureCols IS 0>
<cfoutput></tr></table></cfoutput>


<cfif NumList IS NOT 0 and (currentrow is not pt_endrow) and attributes.thinline>
<!--- DEBUG <cfoutput>#numlist# #currentrow##pt_endrow#</cfoutput>---> 
<cfmodule template="../customtags/putline.cfm" linetype="thin">
</cfif>

<cfelseif qry_get_features.CurrentRow  IS pt_EndRow>
<cfloop index = "num" from="1" to="#(attributes.featureCols - pt_EndRow MOD attributes.featureCols)#">
<cfoutput><td>&nbsp;</td></cfoutput>
</cfloop>
<cfoutput></tr></table> </cfoutput>

<cfif NumList IS NOT 0  and attributes.thinline>
<cfmodule template="../customtags/putline.cfm" linetype="thin">
</cfif>

</cfif>	

</cfloop>

