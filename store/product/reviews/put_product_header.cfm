<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This template outputs the product information. It is used as a header above the list of related review(s). It is called by:
 
--->


	<!--- <cfset Product_ID = GetDetail.Product_ID>
	<cfinclude template="../listings/do_prodlinks.cfm"> --->

<cfoutput query="GetDetail">
<br/>
<table class="listingtext" width="100%">
	<tr>
		<td align="center" valign="top">
		<cfif len(Sm_Image)>
			<cfmodule template="../../customtags/putimage.cfm" filename="#Sm_Image#" filealt="#Name#" prodlink="#XHTMLFormat(prodlink)#" imgclass="listingimg" User="#GetDetail.User_ID#" />
		</cfif>
		</td>
		<td>
		<h2 class="product"><a href="#XHTMLFormat(prodlink)#">#Name#</a></h2><br/>
		<cfif len(Short_Desc)>
			<cfmodule template="../../customtags/puttext.cfm" Text="#Short_Desc#" Token="#Request.Token1#" class="cat_text_small" ptag="0" /><br/>
		</cfif>
		
		<br/>
		
		<!--- Rating Summary Table --->
		<table class="listingtext" width="80%">
			<tr>
					
				<td valign="top">
				<cfif isdefined("qry_prod_reviews.avg_rating") and len(qry_prod_reviews.avg_rating)>
				Overall Rating: <img src="#request.appsettings.defaultimages#/icons/#round(qry_prod_reviews.avg_rating)#_med_stars.gif" alt="#round(qry_prod_reviews.avg_rating)# Stars" /><br/>
				Based on #qry_prod_reviews.total_ratings# review<cfif qry_prod_reviews.total_ratings neq 1>s</cfif>
				
				<!--- <cfelse>
					<cfset attributes.do = "summary">
					<cfset attribues.putlink = "">
					<cfset fusebox.nextaction="product.reviews">
					<cfinclude template="../../lbb_runaction.cfm"> --->
					
				</cfif>	
				</td>
				
				<cfset reviewlink = "#self#?fuseaction=product.reviews&product_ID=#attributes.product_ID##request.token2#">
				
				<td valign="top">
					<ul>
					<li><a href="#XHTMLFormat('#reviewlink#&do=write')#">Write A Review</a></li>
					<li><a href="#XHTMLFormat(prodlink)#">View Details</a></li>
	
					<cfif NOT isdefined("qry_get_reviews.recordcount")>
					<li><a href="#XHTMLFormat('#reviewlink#&do=list')#"><strong>See All Reviews</strong></a></li>
					</cfif>
					</ul>
				</td>		
			</tr>
		</table>	
			
		</td>
	</tr> 
</table>
	<br/>
</cfoutput>
