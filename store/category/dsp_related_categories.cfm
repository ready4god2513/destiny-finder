<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This template is called by any of the detail pages to output a list of categories that the detail item appears in. The output is a Category Listing. Called by category.related --->

<cfif Request.GetRelatedCats.recordcount>

<div class="section_footer">
<cfoutput query="Request.GetRelatedCats">
<cfif Request.AppSettings.UseSES>
	<cfset catlink = "#Request.SESindex#category/#Category_ID#/#SESFile(Name)##Request.Token1#">
<cfelse>
	<cfset catlink = "#self#?fuseaction=category.display&category_ID=#Category_ID##Request.Token2#">
</cfif>
<img src="#Request.AppSettings.defaultimages#/icons/lleft.gif" border="0" style="vertical-align: middle" alt="" hspace="2" vspace="0" /> <a href="#XHTMLFormat(catlink)#" class="section_footer" #doMouseover(Name)#>#name#</a><br/>
</cfoutput>	
</div>

</cfif>