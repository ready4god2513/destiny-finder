<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This template displays review results in a table format. It is used to display all the comments a particular user has written. A link appears on each comment which goes to this page.
--->

<cfparam name="attributes.currentpage" default="1">
<cfparam name="attributes.displaycount" default="12">

<!--- Set this page as the session.page for "flag" processing ---->
<cfset Session.Page= Request.currentURL>

<!--- Define URL for pagethrough --->
<cfset addedpath="&amp;fuseaction=#attributes.fuseaction#">
<cfloop list="do,Feature_ID,UID,sortby,order,recent_days,format,editorial" index="counter">
	<cfif isdefined('attributes.' & counter) and len(evaluate('attributes.' & counter))>
		<cfset addedpath="#addedpath#&amp;#counter#=" & evaluate('attributes.' & counter)>
	</cfif>
</cfloop>

<!--- Create the page through links, max records set by the display count --->	
<cfmodule template="../../customtags/pagethru.cfm" 
	totalrecords="#qry_get_reviews.recordcount#" 
	currentpage="#attributes.currentpage#"
	templateurl="#self#"
	addedpath="#addedpath##request.token2#"
	displaycount="#attributes.displaycount#" 
	imagepath="#request.appsettings.defaultimages#/icons/" 
	imageheight="12" 
	imagewidth="12"
	hilitecolor="###request.getcolors.mainlink#">


<!--- Provide a Page Title IF this page is being called directly (fuseaction=Feature.review).--->
<cfif not IsDefined("ThisTag.ExecutionMode")>
	<cfset Webpage_title = "Comments">
	<cfmodule template="../../customtags/puttitle.cfm" TitleText="Your Opinion" class="feature">
</cfif> 


<cfif qry_get_reviews.recordcount>

	<!--- Put Search Header --->
	<cfoutput>
	<br/><div class="searchheader">#Searchheader#</div><br/>

	<!--- Sort select form --->
	<form action="#self#?#replace(addedpath,'&amp;sortby='&attributes.sortby,'')#" method="post">
	<table class="mainpage" width="100%">
		<tr>
			<td>
		
			Sort by 
			<select name="sortby" size="1" class="formfield" onchange="javascript:this.form.submit();">
			<option value="newest" #doSelected(attributes.sortby,'newest')#>Newest</option>
			<option value="oldest" #doSelected(attributes.sortby,'oldest')#>Oldest</option>
			<option value="highest" #doSelected(attributes.sortby,'highest')#>Highest</option>
			<option value="lowest" #doSelected(attributes.sortby,'lowest')#>Lowest</option>
			</select>
			</td>
	
			<td align="right">
			#pt_pagethru#
			</td>
		</tr>
	</table>
	</form>
	</cfoutput>

</cfif>


<cfmodule template="../../customtags/putline.cfm" linetype="thin">

<cfif qry_get_reviews.recordcount>

<!--- Table Title Row ---->
<cfoutput>
<table class="listingtext" width="100%" cellpadding="5">
	<tr class="listinghead">
		<th align="left">Date</th>
		<th align="left">Title/<cfif len(attributes.Feature_ID)>Reviewer
			<cfelse>Item</cfif>
		</th>
		<th align="left">Rating</th>
		<cfif attributes.do is "manager">
		<th>&nbsp;</th>
		</cfif>
	</tr>
</cfoutput>

<!--- If sort is NEWEST, group output by Editorial ---->
<cfif attributes.sortby is "newest">

	<cfoutput query="qry_get_reviews" group="editorial"  startrow="#pt_StartRow#" maxrows="#attributes.displaycount#">
	
	<!--- Group Title unless listing feature comments only (feature comments don't use editorial) --->
	
	<tr>
		<td colspan="4">
		<div class="section_title"><cfif len(editorial)>#Editorial#<cfelse>Member Comments</cfif> </div>
		</td>
	</tr>	
	
		<cfinclude template="put_review_table.cfm">
	
	</cfoutput>

<cfelse><!--- Ungrouped output when sort is not Newest --->

	<cfloop query="qry_get_reviews" startrow="#pt_StartRow#" endrow="#pt_EndRow#">
		<cfinclude template="put_review_table.cfm">
	</cfloop>
	
</cfif><!--- Grouped or ungrouped --->

</table>	

<cfoutput><div align="right">#pt_pagethru#</div><br/></cfoutput>		


<!--- message if no reviews --->
<cfelse>
	<cfset commentLink="#XHTMLFormat('#self#?fuseaction=feature.reviews&do=write&feature_ID=#attributes.feature_ID##request.token2#')#">
	Be the first to comment.

</cfif>