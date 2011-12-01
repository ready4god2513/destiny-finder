

<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Used to display the list of pending items according to the user's permission level --->
<cfinclude template="../users/qry_get_user_settings.cfm">

<cfmodule template="../access/secure.cfm" keyname="shopping" requiredPermission="8">
	<cfset innertext = Application.objMenus.getPendingOrders()>
		<br/>
		<cfoutput>
			<a href="#self#?fuseaction=shopping.admin&order=pending#Request.Token2#">#innertext# Pending.</a>
		</cfoutput>	
</cfmodule>

<cfmodule template="../access/secure.cfm" keyname="access" requiredPermission="4">  
		<cfset innertext = Application.objMenus.getValidMemberships()>
		<br/>
		<cfoutput>
			<a href="#self#?fuseaction=access.admin&membership=list&show=all&valid=0#Request.Token2#">#innertext# need approval.</a>
		</cfoutput>	
</cfmodule>

<cfif request.appsettings.productreviews AND (request.appsettings.ProductReview_Approve OR request.appsettings.ProductReview_Flag)>
<cfmodule template="../access/secure.cfm" keyname="product" requiredPermission="64"> 		
		<cfset innertext = Application.objMenus.getPendingReviews()>
		<br/>
		<cfoutput>
		<a href="#self#?fuseaction=product.admin&review=listform&display_status=editor&order=DESC#Request.Token2#">#innertext# approval.</a>
		</cfoutput>	
</cfmodule>
</cfif>

<cfif request.appsettings.featurereviews AND (request.appsettings.FeatureReview_Approve OR request.appsettings.FeatureReview_Flag)>		
	<cfmodule template="../access/secure.cfm"	keyname="feature"	requiredPermission="2"> 
		<cfset innertext = Application.objMenus.getPendingComments()>
		<br/>
		<cfoutput>
		<a href="#self#?fuseaction=feature.admin&review=listform&display_status=editor&order=DESC#Request.Token2#">#innertext# approval.</a>
		</cfoutput>	
</cfmodule>
</cfif>

<cfif get_User_Settings.UseCCard>
	<cfmodule template="../access/secure.cfm"	keyname="users"	requiredPermission="4">	
		<cfset innertext = Application.objMenus.getValidUserCCs()>
				<br/>
		<cfoutput>
	<a href="#self#?fuseaction=users.admin&user=list&show=all&cardisvalid=0&cardnumber=1#Request.Token2#">#innertext# approval.</a>
		</cfoutput>	
</cfmodule>
</cfif>

<cfmodule template="../access/secure.cfm" keyname="users" requiredPermission="1">	
	<cftry>
<cfset innertext = Application.objMenus.getErrorDumps()>
	<br/>
		<cfoutput>
	<a href="#self#?fuseaction=home.admin&error=list#Request.Token2#">#innertext# pending.
		</cfoutput>	
<cfcatch>
<!--- CFDirectory not enabled, or other issue with site error code --->
</cfcatch>
</cftry>
</cfmodule>
