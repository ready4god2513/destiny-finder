<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Outputs a formatted search box for products. Includes search by product name or keyword, and links to search by category. Can select to include all search words in the search or any of the words. Called from dsp_results.cfm and catcores/catcore_products_home.cfm --->


<cfparam name="attributes.category_id" default="">
<cfparam name="attributes.name" default="">
<cfparam name="attributes.search_string" default="">
<cfparam name="attributes.all_words" default="1">

<cfparam name="request.qry_get_subcats.recordcount" default="0">

<cfsavecontent variable="jscript">
<cfoutput>
<script type='text/javascript'>
<!--
function DoCatSearch(category)
{
<cfif Request.AppSettings.UseSES>
  var strURL = '#Request.SESindex#category/' + category + '/index.cfm?redirect=yes';
<cfelse>
  var strURL = '#self#?fuseaction=category.display&redirect=yes#request.token2#&category_id=' + category;
</cfif>
  var j = 0;

if (document.prodsearchform.name.value != '')
{
strURL += '&name=' + escape(document.prodsearchform.name.value);
} 

if (window.document.prodsearchform.search_string.value != '')
{
strURL += '&search_string=' + escape(document.prodsearchform.search_string.value);
} 

if (document.prodsearchform.all_words[0].checked) {
	allwords = document.prodsearchform.all_words[0].value
}
else {
	allwords = document.prodsearchform.all_words[1].value
}

strURL += '&all_words=' + allwords

 window.location.href = strURL;
  return;
}
// --> 
</script>
</cfoutput>
</cfsavecontent>

<cfhtmlhead text="#jscript#">

<cfoutput>
	<form action="#XHTMLFormat('#self#?fuseaction=product.search#request.token2#')#" method="post" name="prodsearchform" class="nomargins">
</cfoutput>

<cfmodule template="../customtags/format_input_form.cfm"
box_title="Product Search"
required_fields="0"
>	

<cfoutput>
	
	<tr align="left"> 
         <td align="right" valign="bottom" class="formtext">Product Name</td>
		 <td><img src="#Request.AppSettings.defaultimages#/spacer.gif" alt="" width="1" height="1" /></td>
         <td valign="bottom" colspan="2"><input name="name" size="40" value="#HTMLEditFormat(attributes.name)#" class="formfield"/></td>
    </tr>
	
	<tr align="left"> 
         <td align="right" valign="bottom" class="formtext">Description Keyword</td>
		 <td><img src="#Request.AppSettings.defaultimages#/spacer.gif" alt="" width="1" height="1" /></td>
         <td valign="bottom" colspan="2"><input name="search_string" size="40" value="#HTMLEditFormat(attributes.search_string)#" class="formfield"/></td>
    </tr>
<tr align="left">
	<td colspan="2">&nbsp;</td>
	<td valign="bottom" colspan="2"><input type="radio" name="all_words" value="1" #doChecked(attributes.all_words)# />Match all words
	&nbsp;&nbsp;&nbsp;<input type="radio" name="all_words" value="0" #doChecked(attributes.all_words,0)# />Match any words</td>
</tr>
</cfoutput>
	
	<cfif Len(attributes.Category_ID)>	
	<tr align="left">
        <td align="right" valign="bottom" class="formtext">In Category</td>
		<td>&nbsp;</td>
		<td colspan="2">
		 <cfset root_category= request.appsettings.prodroot >
		<cfinclude template="../customtags/parentstringsearch.cfm">
		<cfoutput>#ParentStringSearch#</cfoutput>:</td>
	</tr>
	<cfif request.qry_get_subcats.RecordCount>
	<tr align="left">
		<td colspan="2">&nbsp;</td>
		<td colspan="2">
		
		<table width="100%">
			<tr>
<cfset ending = "#val(request.qry_get_subcats.RecordCount/2)#">
				<td align="left" valign="top"  width="50%">
              <cfloop startrow="1" query="request.qry_Get_SubCats" endrow="#ENDING#"> 			
			  <cfoutput><a href="javascript:DoCatSearch('#category_id#')" class="cat_text_list">#name#</a></cfoutput>
				<br/>
			</cfloop>
				</td>
				<td align="left" valign="top"  width="50%">
				<cfloop startrow="#val(ending+1)#" query="request.qry_Get_SubCats" > 	
			   <cfoutput>
			   <a 
            href="javascript:DoCatSearch('#category_id#')" class="cat_text_list">#name#</a>
			</cfoutput>
				<br/>
				</cfloop>
				</td>
			</tr>
		</table>

		</td>
	</tr>
	</cfif>
	
	</cfif>
	
	<tr align="left">
		<td align="right"></td>
		<td align="right"></td>
		<td colspan="2"><input type="submit" name="product_searchsubmit" class="formbutton" value="search all categories"/>
		</td>
	</tr>
	
		<cfif NOT Len(attributes.Category_ID) AND request.appsettings.prodroot IS NOT 0>	
		<cfif Request.AppSettings.UseSES>
			<cfset catlink = "#Request.SESindex#category/#request.appsettings.prodroot#/index.cfm#Request.Token1#">
		<cfelse>
			<cfset catlink = "#self#?fuseaction=category.display&category_ID=#request.appsettings.prodroot##Request.Token2#">
		
		</cfif>
	<tr align="left">
		<td>&nbsp;</td> 
		<td colspan="3">
		OR &nbsp;<a href="<cfoutput>#XHTMLFormat(catlink)#</cfoutput>" class="formtitle">browse products by category</a><br/><br/>
		</td>
	</tr>
	</cfif>

</cfmodule>

</form>
