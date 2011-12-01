<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the admin menu for features. Called by feature.admin --->

<cfparam name="totaltabs" default="0">
<cfparam name="featuremenu" default="">

<cfmodule template="../../access/secure.cfm"
	keyname="feature"
	requiredPermission="7"
	> 
	
<!--- If page being called is a feature admin page, set tabs open on Feature menu --->
<cfif (FindNoCase("feature.admin", attributes.xfa_admin_link))>
	<cfset tabstart = totaltabs>
</cfif>

<cfset totaltabs = totaltabs + 1>
	
<cfsavecontent variable="featuremenu">

<cfoutput><br/>
<a href="#self#?fuseaction=feature.admin&feature=add&cid=0#Request.Token2#" onmouseover="return escape(feature4)" target="AdminContent">Add Feature</a><br/>

<a href="#self#?fuseaction=feature.admin&feature=list&cid=0#Request.Token2#" onmouseover="return escape(feature1)" target="AdminContent">Manage Features</a><br/><br/>
	
<!--- Feature Reviews --->

	
	<cfif request.appsettings.featurereviews>
	
		<cfmodule template="../../access/secure.cfm"
		keyname="feature"
		requiredPermission="2"
		> 
		<cfif request.appsettings.FeatureReview_Approve OR request.appsettings.FeatureReview_Flag>		
		<cfset innertext = Application.objMenus.getPendingComments()>
		<div id="Comments_Div" spry:region="txtPending"><a href="#self#?fuseaction=feature.admin&review=listform&display_status=editor&order=DESC#Request.Token2#" target="AdminContent">Comments Pending</a>:<br/> <span style="color: red"><span id="commentcount" spry:content="{Comments}">#innertext#</span> approval.</span><br/><br/>
		</div>
		</cfif>
		
		<a href="#self#?fuseaction=feature.admin&review=list#Request.Token2#" onmouseover="return escape(feature3)" target="AdminContent">Feature Reviews</a><br/>
		
	</cfif>
	
		<cfmodule template="../../access/secure.cfm"
			keyname="feature"
			requiredPermission="1"
			> 
			<a href="#self#?fuseaction=feature.admin&review=settings#Request.Token2#" onmouseover="return escape(feature2)" target="AdminContent">Feature Review Settings</a><br/>
		</cfmodule>
<!--- end custom code. --->

</cfoutput>

</cfsavecontent>

</cfmodule>