
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Outputs an individual feature listing. Called by dsp_features.cfm --->

<cfscript>
	// set text for Parent ID 
	if (isDefined("attributes.category_ID") and isNumeric(attributes.category_ID)) {
		PCatSES = "_#attributes.Category_ID#";
		PCatNoSES = "&ParentCat=#attributes.Category_ID#";
	}
	else {
		PCatSES = "";
		PCatNoSES = "";
	}
	
	if (Request.AppSettings.UseSES) 
		featurelink = "#Request.SESindex#feature/#qry_get_features.Feature_ID##PCatSES#/#SESFile(qry_get_features.Name)##Request.Token1#";
	else 
		featurelink = "#self#?fuseaction=feature.display&feature_ID=#qry_get_features.Feature_ID##PCatNoSES##Request.Token2#";
		
	//Pop pdf feature open in their own window
	if (right(lg_image,3) is 'pdf') 
		target = 'target="article"';
	else 
		target="";
</cfscript>

<!--- set this with a category parameter to show the feature_type above name --->
<cfparam name="attributes.showType" default="0">

<table border="0" cellspacing="0" cellpadding="0"><tr><td valign="top">
	
	<cfif len(Sm_Image)>
		<cfmodule template="../customtags/putimage.cfm" filename="#Sm_Image#" filealt="#Name#"
		imglink="#XHTMLFormat(featurelink)#" imgclass="listingimg" target="#target#">
	</cfif>
	
	</td><td align="left" valign="top">

<cfif display_title is 1>
	<cfif len(Sm_Title)>	
		<cfmodule template="../customtags/putimage.cfm" filename="#Sm_Title#" target="#target#"
		 filealt="#Name#" imglink="#XHTMLFormat(featurelink)#"			
		>
	<cfelse>
		<cfoutput>
		<cfif len(feature_type) and attributes.showType><span class="feature_type">#feature_Type#</span><br/></cfif>
		<h2 class="feature"><a href="#XHTMLFormat(featurelink)#"  class="cat_title_small" #target#>#Name#</a></h2>
		</cfoutput>
		</cfif>
		<!---<cfif Highlight>#Request.NewImage#</cfif>---->
</cfif>		

	<cfif len(short_desc)>
		<cfmodule template="../customtags/puttext.cfm" Text="#Short_Desc#" Token="#Request.Token1#" ptag="no" class="cat_text_small">
	<cfelse>
		<cfmodule template="../customtags/puttext.cfm" Text="#Long_Desc#" Token="#Request.Token1#" ptag="no" class="cat_text_small">
	</cfif>
	
	<cfif display_title is 1>
	<cfoutput>
	<span class="listingtagline">
	<cfif author is not "">by #author#  </cfif>
	<!-----#dateformat(created, "mmm d, yyyy")# ---></span>
	</cfoutput>
	</cfif>
	

</td></tr></table>



