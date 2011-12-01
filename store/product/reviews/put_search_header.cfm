<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This template creates the review list header information.

The review list can be of recent reviews, reviews of a specific product or reviews written by a specific person. --->

<!--- Provide a Page Title IF this page is being called directly (fuseaction=product.review).--->
<cfif not IsDefined("ThisTag.ExecutionMode")>
	<cfset Webpage_title = "Product Reviews">
	<cfmodule template="../../customtags/puttitle.cfm" TitleText="Product Reviews" class="product">
</cfif> 

<!--- If this listing is for a specific product then display the product --->
<cfif isdefined("GetDetail.recordcount") AND GetDetail.recordcount>
	<cfinclude template="put_product_header.cfm">
<cfelseif attributes.do is "manager">
	<cfinclude template="put_manager_header.cfm">
<cfelse>
	<br/><br/>There was a problem retrieving the information, due to a missing product, or invalid request. <br/><br/>
</cfif>

<cfif qry_get_reviews.recordcount>

	<!--- Put Search Header --->
	<cfoutput><br/><div class="searchheader">#Searchheader#</div><br/></cfoutput>

	<!--- Sort and Pagethrough line --->
	<cfoutput>
	<table class="mainpage" width="100%">
		<tr>
			<!--- Sort select form --->
			<form action="#self#?#replace(addedpath,'&amp;sortby='&attributes.sortby,'')#" method="post">
			<td>
		
			Sort by 
			<select name="sortby" size="1" class="formfield" onChange="javascript:this.form.submit();">
				<option value="newest" #doSelected(attributes.sortby,'newest')#>newest first</option>
				<option value="oldest" #doSelected(attributes.sortby,'oldest')#>oldest first</option>
				<option value="highest" #doSelected(attributes.sortby,'highest')#>highest ratings first</option>
				<option value="lowest" #doSelected(attributes.sortby,'lowest')#>lowest ratings first</option>
				<option value="mosthelp" #doSelected(attributes.sortby,'mosthelp')#>ranked most helpful</option>
				<option value="leasthelp" #doSelected(attributes.sortby,'leasthelp')#>ranked least helpful</option>
			</select>
			</td>
		</form>
	
			<td align="right">
			#pt_pagethru#
			</td>
		</tr>
	</table>
	</cfoutput>

</cfif>


