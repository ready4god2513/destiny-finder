<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This page outputs the related products for a selected product. Called by product.related --->

<!--- Accepts the parameter section_title to set the title for the related products display --->


<!--- Display Related Products --->
<cfif Qry_Get_Rel_Prods.RecordCount>
	
	<cfparam name="attributes.SectionTitle" default="May we also suggest">
	
	<cfif len(attributes.SectionTitle)>
		<cfmodule template="../customtags/putline.cfm" linetype="thin">
		<div class="section_title" style="margin-top:5px;"><cfoutput>#attributes.SectionTitle#</cfoutput></div>
		
	</cfif>
	
	
<cfoutput>
<table cellspacing="0" width="100%" cellpadding="4" class="cat_text_list">
</cfoutput>
	<tr>
	<cfoutput query="Qry_Get_Rel_Prods">
		<cfif Request.AppSettings.UseSES>
			<cfset prodlink = "#Request.SESindex#product/#Qry_Get_Rel_Prods.product_ID#/#SESFile(Qry_Get_Rel_Prods.Name)##Request.Token1#">
		<cfelse>
			<cfset prodlink = "#self#?fuseaction=product.display&product_ID=#Qry_Get_Rel_Prods.product_ID##Request.Token2#">
		</cfif>
		<td align="center"  valign="top">
		<cfif len(Qry_Get_Rel_Prods.Sm_Image)>
<cfmodule template="../customtags/putimage.cfm" filename="#Qry_Get_Rel_Prods.Sm_Image#" filealt="#Name#" imglink="#XHTMLFormat(prodlink)#"  addbr="yes" hspace="2" vspace="1"  User="#Qry_Get_Rel_Prods.User_ID#"></cfif><a href="#XHTMLFormat(prodlink)#" class="cat_title_list" #doMouseover(Name)#>#Name#</a>

<!--- Uncomment to put description under related product links --->
<!--- <cfif len(Short_Desc)><br/>#short_desc#</cfif> --->

		</td>
	</cfoutput>
	</tr>
</table>
	
<!---- Plain text version ---
	<blockquote>
	<cfoutput query="Qry_Get_Rel_Prods">

		<a href="#self#?fuseaction=product.display&Product_ID=#Product_ID#" class="cat_title_list">#Name#</a><br/>
	</cfoutput>
	</blockquote>
---->	
	
	<br/><br/>

</cfif>

