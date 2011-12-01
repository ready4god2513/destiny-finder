<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This template puts the comments on a Feature detail page. --->

<!--- For link to comments ---->
<cfoutput><a name="reviews"></a></cfoutput>

<!--- Section Title ----------->
<cfmodule template="../../customtags/putline.cfm" linetype="thin"/>

<cfoutput>
<div class="mainpage" style="margin-top:5px;">
<cfset commentlink = "#self#?fuseaction=feature.reviews&do=write&feature_id=#attributes.feature_ID##PCatNoSES##request.token2#">

<span class="section_title">Add Your Opinion</span> - <a href="#XHTMLFormat(commentlink)#" #doMouseover('Comment')#>Post Your Comment Here</a>

<cfif qry_get_reviews.recordcount>
	<p>Explore Comments</p>
<cfelse>
	<p>Be the First to Comment</p>
</cfif>
</div>
</cfoutput> 

<cfinclude template="put_review_tree.cfm">
<br/>