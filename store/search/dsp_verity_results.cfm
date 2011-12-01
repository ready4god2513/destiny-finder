<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This page is used to output the results of the verity search. It includes all categories, products, and features in one search. Called from act_search.cfm --->

<cfparam name="attributes.currentpage" default="1">
<cfset addedpath="&amp;fuseaction=#attributes.fuseaction#&amp;string=#attributes.string#">

<!--- Create the page through links, max records set to 10 --->
<cfmodule template="../customtags/pagethru.cfm" 
	totalrecords="#results.recordcount#" 
	currentpage="#attributes.currentpage#"
	templateurl="#self#"
	addedpath="#addedpath##request.token2#"
	displaycount="10" 
	imagepath="#request.appsettings.defaultimages#/icons/" 
	imageheight="12" 
	imagewidth="12"
	hilitecolor="###request.getcolors.mainlink#" >



<cfif Results.RecordCount>


<cfoutput>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<!--- PageThru --->	
	<tr>
		<!---------
		<td class="section_footer"><a href="##top" class="section_footer">top</a></td>---------->
		<td>
		Your search for "#string#" returned #Results.RecordCount# result<cfif Results.RecordCount GT 1>s</cfif> out of #Results.RecordsSearched# records searched.
		</td>
	</tr>
	<!--- LINE --->	
	<tr><td colspan="2">
	<img src="#Request.AppSettings.defaultimages#/spacer.gif" height="6" width="1" border="0" alt="" hspace="0" vspace="0" />
	</td></tr>
<!--- LINE --->	
	<tr><td colspan="2" bgcolor="###Request.GetColors.linecolor#">
	<img src="#Request.AppSettings.defaultimages#/spacer.gif" height="1" width="1" border="0" alt="" hspace="0" vspace="0" />
	</td></tr>

	<td>
	<br/>Showing records #pt_StartRow# through <cfif (pt_StartRow + 9) LT Results.RecordCount>#Evaluate(pt_StartRow + 9)#<cfelse>#Results.RecordCount#</cfif>
		</td>

</table>
</cfoutput>


<cfoutput><ul></cfoutput>

<cfoutput query="Results" startrow="#pt_StartRow#" maxrows="10">
<cfif len(Score)>
	<cfset Myval = Score>
<cfelse>
	<cfset Myval = 1>
</cfif>
      <cfset Myval = (Myval * 100)>
      <cfset Myval = NumberFormat(Myval,'___')>
      <cfset Myval = Myval & "%">
	  
<li><b>#Myval# - 
<cfif Right(key, 3) is not "pdf">
	<cfif Left(key, 1) IS "C">
		<cfset CatID = RemoveChars(key, 1,1)>
		<cfif Request.AppSettings.UseSES>
			<cfset catlink = "#Request.SESindex#category/#CatID#/#SESFile(Title)##Request.Token1#">
		<cfelse>
			<cfset catlink = "#self#?fuseaction=category.display&category_ID=#CatID##Request.Token2#">
		</cfif>
		Category: <a href="#XHTMLFormat(catlink)#">	
	<cfelseif Left(key, 1) IS "P">
		<cfset ProdID = RemoveChars(key, 1,1)>
		<cfif Request.AppSettings.UseSES>
			<cfset prodlink = "#Request.SESindex#product/#ProdID#/#SESFile(Title)##Request.Token1#">
		<cfelse>
			<cfset prodlink = "#self#?fuseaction=product.display&product_ID=#ProdID##Request.Token2#">
		</cfif>
		Product: <a href="#XHTMLFormat(prodlink)#">
	<cfelseif Left(key, 1) IS "G">
		Page: <a href="#XHTMLFormat('#Custom1##Request.Token2#')#">
	<cfelse>
		<cfif Request.AppSettings.UseSES>
			<cfset featurelink = "#Request.SESindex#feature/#key#/#SESFile(Title)##Request.Token1#">
		<cfelse>
			<cfset featurelink = "#self#?fuseaction=feature.display&feature_ID=#key##Request.Token2#">
		</cfif>
		Document: 
		<a href="#XHTMLFormat(featurelink)#">
	</cfif>#Title#</a></b><br/>
	<cfif Left(key, 1) IS "P" AND Custom1 IS NOT "">SKU: #Custom1#<br/></cfif>
<cfelse>
	File: <a href="#XHTMLFormat('#self#?fuseaction=feature.show&file=#getfilefrompath(key)##Request.Token2#')#" target="article">#getfilefrompath(key)#</a></b>
</cfif>
<br/>#ReReplaceNoCase(Summary, "<[^>]*>", "", "ALL")#<br/><br/></li>

</cfoutput>

<cfoutput></ul></cfoutput>



<cfoutput>
<table width="100%" border="0" cellspacing="3" cellpadding="0">
<!--- LINE --->	
	<tr><td colspan="2" bgcolor="###Request.GetColors.linecolor#">
	<img src="#Request.AppSettings.defaultimages#/spacer.gif" height="1" width="1" border="0" alt="" hspace="0" vspace="0" />
	</td></tr>
<!--- PageThru --->	
	<tr>
		<!---------
		<td class="section_footer"><a href="##top" class="section_footer">top</a></td>---------->
		<td align="right" class="section_footer">
		#pt_pagethru#
		</td>
	</tr>
</table>
</cfoutput>


<cfelse>


<cfoutput>
<form action="#self#?fuseaction=page.search#request.token2#" method="post">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
		Sorry, no records found for "#string#"
		</td>
	</tr>
	
<!--- LINE --->	
	<tr><td colspan="2">
	<img src="#Request.AppSettings.defaultimages#/spacer.gif" height="7" width="1" border="0" alt="" hspace="0" vspace="0" />
	</td></tr>	
<!--- LINE --->	
	<tr><td colspan="2" bgcolor="###Request.GetColors.linecolor#">
	<img src="#Request.AppSettings.defaultimages#/spacer.gif" height="1" width="1" border="0" alt="" hspace="0" vspace="0" />
	</td></tr>

	<tr>
		<td align="center"><br/>
		<input type="submit" value="search again" class="formbutton"/>
		</td>
	</tr>
	
</table>
</form>
</cfoutput>


</cfif>





