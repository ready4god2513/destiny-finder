
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!---
<fusedoc fuse="FBX_Switch.cfm">
	<responsibilities>
		I am the cfswitch statement that handles the fuseaction, delegating work to various fuses.
	</responsibilities>
	<io>
		<string name="fusebox.fuseaction" />
		<string name="fusebox.circuit" />
	</io>	
</fusedoc>
--->

<!---
Features: 
	List (lists all the features)
	Category (category_id)
	Display (feature_id)
	search
	related - custom tag to put related features
--->

<cfif ListFindNoCase("display,print", fusebox.fuseaction)>
	<cfinclude template="qry_get_feature.cfm">	
		
	<!--- Make sure a feature was found --->
	<cfif not invalid and qry_get_feature.recordcount>
	
		<!--- update colors if custom palette --->
		<cfif isNumeric(qry_get_feature.color_id) AND qry_get_feature.color_id is not request.appsettings.color_id>
			<cfset request.color_id = qry_get_feature.color_id>
			<cfinclude template="../queries/qry_getcolors.cfm">
			<cfinclude template="../customtags/setimages.cfm">
		</cfif>
		
		<!--- set any variables listed in the feature's 'passparam' field --->
		<cfset QuerytoUse = qry_get_feature>
		<cfinclude template="../includes/parseparams.cfm">
		
		<!--- check if feature, or any assigned categories are locked with an access key --->
		<cfparam name="ispermitted" default=1>
		<cfif qry_check_accesskey.recordcount>
			<cfmodule template="../access/secure.cfm"
			keyname="contentkey_list"		
			requiredPermission="#qry_check_accesskey.AccessKey#" 
			>
		<cfelseif qry_get_feature.AccessKey>
			<cfmodule template="../access/secure.cfm"
			keyname="contentkey_list"		
			requiredPermission="#qry_get_feature.AccessKey#" 
			>
		</cfif>
		<cfif ispermitted>
			<cfif right(qry_get_feature.lg_image,3) is 'pdf'>
				<cfset FilePath = GetDirectoryFromPath(ExpandPath("*.*"))>
				<cfset theFile = "#FilePath##Request.AppSettings.defaultimages#/#qry_get_feature.lg_image#">
				<cfcontent type="application/pdf" file="#theFile#" deletefile="No" reset="No">
			<cfelse>		
				<cfinclude template="dsp_feature.cfm">
			</cfif> <!--- pdf check ----->
		</cfif>
		
	<cfelse>
		<cfinclude template="../errors/dsp_notfound.cfm">
	</cfif>
	
<cfelseif CompareNoCase(fusebox.fuseaction, "list") IS 0>
	<cfif isdefined("attributes.category_id")>
		<cfset attributes.cat_id = attributes.category_id>
	</cfif>
	<cfinclude template="qry_get_features.cfm">	
	<cfinclude template="dsp_results.cfm">	
	
<cfelseif CompareNoCase(fusebox.fuseaction, "related") IS 0>
	<cfparam name="attributes.DETAIL_TYPE" default="Item">
	<cfparam name="attributes.DETAIL_ID" default="0">
	<cfinclude template="qry_get_related_features.cfm">
	<cfinclude template="dsp_related_features.cfm">

<cfelseif CompareNoCase(fusebox.fuseaction, "reviews") IS 0>	
	<cfinclude template="reviews/index.cfm">

<cfelseif CompareNoCase(fusebox.fuseaction, "admin") IS 0>
	<cfinclude template="admin/index.cfm">
		
<cfelseif CompareNoCase(fusebox.fuseaction, "search") IS 0>
	<cfparam name="attributes.Feature_searchsubmit" default="1"> 
	<cfif isdefined("attributes.category_id")>
		<cfset attributes.cat_id = attributes.category_id>
	</cfif>
		<cfinclude template="qry_get_features.cfm">	
		<cfinclude template="dsp_results.cfm">

<!--- no valid fuseaction --->
<cfelse>
	<cfmodule template="../#self#" fuseaction="page.pageNotFound">

</cfif>



