<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This page is used to output the results of the SQL search. It lists the categories, products, and then features. Called from act_search.cfm --->

<cfscript>
/**
 * An enhanced version of left() that doesn't cut words off in the middle.
 * Minor edits by Rob Brooks-Bilson (rbils@amkor.com) and Raymond Camden (ray@camdenfamily.com)
 * 
 * Updates for version 2 include fixes where count was very short, and when count+1 was a space. Done by RCamden.
 * 
 * @param str 	 String to be checked. 
 * @param count 	 Number of characters from the left to return. 
 * @return Returns a string. 
 * @author Marc Esher (jonnycattt@aol.com) 
 * @version 2, April 16, 2002 
 */
function fullLeft(str, count) {
	if (not refind("[[:space:]]", str) or (count gte len(str)))
		return Left(str, count);
	else if(reFind("[[:space:]]",mid(str,count+1,1))) {
	  	return left(str,count);
	} else { 
		if(count-refind("[[:space:]]", reverse(mid(str,1,count)))) return Left(str, (count-refind("[[:space:]]", reverse(mid(str,1,count))))); 
		else return(left(str,1));
	}
}
</cfscript>

<!--- Code added to page through the results --->
<cfset maxrecords = 20>
<cfparam name="attributes.currentpage" default="1">
<cfset startrow = (attributes.currentpage -1) * maxrecords + 1>
<cfset endrow = attributes.currentpage * maxrecords>

<cfset addedpath="&amp;fuseaction=#attributes.fuseaction#">
	<!--- Add any additional parameters you might need here --->
	<cfloop list="string,all_words" index="counter">
	<cfif isdefined('attributes.' & counter) and len(evaluate('attributes.' & counter))>
		<cfset addedpath="#addedpath#&amp;#counter#=" & evaluate('attributes.' & counter)>
	</cfif>
	</cfloop>

<cfmodule template="../customtags/pagethru.cfm" 
	totalrecords="#Results#" 
	currentpage="#attributes.currentpage#"
	templateurl="#self#"
	addedpath="#addedpath##request.token2#"
	displaycount="#maxrecords#" 
	imagepath="#request.appsettings.defaultimages#/icons/" 
	imageheight="12" 
	imagewidth="12"
	hilitecolor="###request.getcolors.mainlink#" >
	

<cfif Results>
<cfoutput><p>Your search returned #Results# result<cfif Results GT 1>s</cfif> out of #Searched# records searched.</p></cfoutput>
<cfelse>
<cfoutput><blockquote>
<p>Sorry, your search turned up no results. Please try again.</p>
</blockquote></cfoutput>
<cfinclude template="dsp_search_form.cfm">
</cfif>

<cfset counter = 1>

<cfoutput><ul></cfoutput>

<cfoutput query="GetCategories">
	<cfif counter GTE startrow AND counter LTE endrow>
		<cfif Request.AppSettings.UseSES>
			<cfset catlink = "#Request.SESindex#category/#GetCategories.Category_ID#/#SESFile(GetCategories.Name)##Request.Token1#">
		<cfelse>
			<cfset catlink = "#self#?fuseaction=category.display&category_ID=#GetCategories.Category_ID##Request.Token2#">
		</cfif>
		<li><b>Category: <a href="#XHTMLFormat(catlink)#">#Name#</a></b><br/>
		#ReReplaceNoCase(Short_Desc, "<[^>]*>", "", "ALL")#<br/><br/></li>
	</cfif>
	<cfset counter = counter + 1>
</cfoutput>

<cfoutput query="GetProducts">
	<cfif counter GTE startrow AND counter LTE endrow>
		<cfif Request.AppSettings.UseSES>
			<cfset prodlink = "#Request.SESindex#product/#GetProducts.Product_ID#/#SESFile(GetProducts.Name)##Request.Token1#">
		<cfelse>
			<cfset prodlink = "#self#?fuseaction=product.display&product_ID=#GetProducts.Product_ID##Request.Token2#">
		</cfif>
		<li><b>Product: <a href="#XHTMLFormat(prodlink)#">#Name#</a></b><br/>
		<cfif SKU IS NOT "">SKU: #SKU#<br/></cfif>
		#ReReplaceNoCase(Short_Desc, "<[^>]*>", "", "ALL")#<br/><br/></li>
	</cfif>
	<cfset counter = counter + 1>
</cfoutput>

<cfoutput query="GetFeatures">
	<cfif counter GTE startrow AND counter LTE endrow>
		<cfif Request.AppSettings.UseSES>
			<cfset featurelink = "#Request.SESindex#feature/#GetFeatures.Feature_ID#/#SESFile(GetFeatures.Name)##Request.Token1#">
		<cfelse>
			<cfset featurelink = "#self#?fuseaction=feature.display&feature_ID=#GetFeatures.Feature_ID##Request.Token2#">
		</cfif>
		<li><b>Feature: <a href="#XHTMLFormat(featurelink)#">#Name#</a></b><br/>
		#ReReplaceNoCase(Short_Desc, "<[^>]*>", "", "ALL")#<br/><br/></li>
	</cfif>
	<cfset counter = counter + 1>
</cfoutput>

<cfoutput query="GetPages">
	<cfif counter GTE startrow AND counter LTE endrow>
	<li><b>Page: <a href="#XHTMLFormat('#Page_URL##Request.Token2#')#">#Page_Name#</a></b><br/>
	#fullLeft(ReReplaceNoCase(PageText, "<[^>]*>", "", "ALL"),150)#<br/><br/></li>
	</cfif>
	<cfset counter = counter + 1>
</cfoutput>

<cfoutput>
</ul>

<div align="right" class="formtext">#pt_pagethru#</div>
</cfoutput>