<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the admin menu for features. Called by feature.admin --->

<cfmodule template="../../access/secure.cfm"
	keyname="feature"
	requiredPermission="1,2,4"
	> 
	
<b>Feature Articles</b>
<cfoutput>
<ul>
	<li><a href="#self#?fuseaction=feature.admin&feature=list&cid=0#Request.Token2#">Features</a></li>
	
<!--- Feature Reviews Upgrade - start custom code --->
	<cfmodule template="../../access/secure.cfm"
	keyname="feature"
	requiredPermission="1"
	> 
		<li><a href="#self#?fuseaction=feature.admin&review=settings#Request.Token2#">Feature Reviews Settings</a>: Setting for how feature reviews work.</li>
	</cfmodule>
	
	<cfif request.appsettings.featurereviews>
	
		<cfmodule template="../../access/secure.cfm"
		keyname="feature"
		requiredPermission="2"
		> 
		<li><a href="#self#?fuseaction=feature.admin&review=list#Request.Token2#">Feature Reviews</a>: Maintain feature reviews.</li>

		<cfset attributes.display_status = "editor">
		<cfinclude template="review/qry_get_reviews.cfm">
		<cfif qry_get_reviews.recordcount>
		<li><strong><a href="#self#?fuseaction=feature.admin&review=listform&display_status=editor&order=DESC#Request.Token2#">Reviews Pending</a>: <span class="formerror">#qry_get_reviews.recordcount# review(s) require editorial approval.</span></strong></li>
		</cfif>
		</cfmodule>
	</cfif>
<!--- end custom code. --->
</ul>
</cfoutput>

</cfmodule>