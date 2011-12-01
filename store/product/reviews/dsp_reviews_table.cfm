<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This template displays review results in a table format. 

It is also used to display all the reviews a particular user has written (review.manager). In this case, review editing options links appear.
--->

<cfparam name="attributes.currentpage" default="1">
<cfparam name="attributes.displaycount" default="10">

<!--- Set this page as the session.page for "helpful" and "flag" processing ---->
<cfset Session.Page="#Request.currentURL#">

<!--- Define URL for pagethrough --->
<cfset addedpath="&amp;fuseaction=#attributes.fuseaction#">
<cfloop list="do,product_ID,UID,sortby,order,recent_days,format,editorial" index="counter">
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


<!--- Include the headere information --->
<cfinclude template="put_search_header.cfm">

<cfmodule template="../../customtags/putline.cfm" linetype="thin"/><br/>

<cfif qry_get_reviews.recordcount>

<!--- Table Title Row ---->
<cfoutput>
<table class="listingtext" width="100%" cellpadding="5">
	<tr class="listinghead">
		<th align="left">Date</th>
		<th align="left">Title/<cfif len(attributes.product_ID)>Reviewer
			<cfelse>Item</cfif>
		</th>
		<th align="left">Rating</th>
		<th align="left">Helpful</th>
		<cfif attributes.do is "manager">
		<th>&nbsp;</th>
		</cfif>
	</tr>
</cfoutput>

<!--- If sort is NEWEST, group output by Editorial ---->
<cfif attributes.sortby is "newest">

	<cfoutput query="qry_get_reviews" group="editorial"  startrow="#pt_StartRow#" maxrows="#attributes.displaycount#">
	
	<!--- Group Tile unless listing feature comments only (feature comments don't use editorial) --->
	
	<tr>
		<td colspan="4">
		<div class="section_title"><cfif len(editorial)>#Editorial# Reviews<cfelse>Member Opinions </cfif> </div>
		</td>
	</tr>
	
	
		<cfoutput>
			<cfinclude template="put_review_table.cfm">
		</cfoutput>
	
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

	<cfif attributes.do is "manager">
	You have not written any product reviews.
	<cfelse>
	<cfoutput>Be the first to <a href="#XHTMLFormat('#self#?fuseaction=product.reviews&do=write&product_ID=#attributes.product_ID##PCatNoSES##request.token2#')#" #doMouseover('Write a Review')#>write a review</a> of this product.</cfoutput>
	</cfif>
</cfif>