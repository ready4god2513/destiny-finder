<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This template is called by any of the detail pages to output a list of features that the detail item appears in. The output is a feature Listing. Called by feature.related

REQUIRED: DETAIL_TYPE -- Feature (Item), Product, etc.  --->


<cfif (GetRelatedFeatures.recordcount)>
	
	<cfparam name="attributes.SectionTitle" default="Related Features">

	<cfif len(attributes.SectionTitle)>
		<cfmodule template="../customtags/putline.cfm" linetype="thin">
		<div class="section_title" style="margin-top:5px;"><cfoutput>#attributes.SectionTitle#</cfoutput></div>
		
	</cfif>
<ul>
	<cfoutput query="GetRelatedFeatures">
	<cfif Request.AppSettings.UseSES>
		<cfset featurelink = "#Request.SESindex#feature/#GetRelatedFeatures.Feature_ID#/#SESFile(GetRelatedFeatures.Name)##Request.Token1#">
	<cfelse>
		<cfset featurelink = "#self#?fuseaction=feature.display&feature_ID=#GetRelatedFeatures.Feature_ID##Request.Token2#">
	</cfif>
		<li><a href="#XHTMLFormat(featurelink)#" class="listingtitle" #doMouseover(Name)#>#name#</a>
		<cfif Len(Trim(Short_Desc))>
		- <cfmodule template="../customtags/puttext.cfm" Text="#Short_Desc#" Token="#Request.Token1#" class="listingsubtitle">
		</cfif><br/></li>
	</cfoutput>
</ul>	
	
</cfif>