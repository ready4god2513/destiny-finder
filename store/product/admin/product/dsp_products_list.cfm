<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the list of products. The list can be filtered using the search fields, or can browse by category.  Called by product.admin&do=list --->

<!--- Create the string with the filter parameters --->	
<cfset addedpath="&fuseaction=product.admin&do=list">
	
<cfloop list="name,sku,display,highlight,notsold,sale,hot,type,event_id,account_id,cid,nocat" index="counter">
	<cfif isdefined('attributes.' & counter) and len(evaluate('attributes.' & counter))>
		<cfset addedpath="#addedpath#&#counter#=" & evaluate('attributes.' & counter)>
	</cfif>
</cfloop>
	
<cfparam name="currentpage" default="1">

<!--- Create the page through links, max records set to 20 --->
<cfmodule template="../../../customtags/pagethru.cfm" 
	totalrecords="#qry_get_products.recordcount#" 
	currentpage="#currentpage#"
	templateurl="#self#"
	addedpath="#addedpath##request.token2#"
	displaycount="20" 
	imagepath="#request.appsettings.defaultimages#/icons/" 
	imageheight="12" 
	imagewidth="12"
	hilightcolor="###request.getcolors.mainlink#" 
	>
		

<cfmodule template="../../../customtags/format_output_admin.cfm"
	box_title="Product Manager"
	width="450"
	>

	<cfoutput>		
<table width="100%" cellspacing="4" border="0" cellpadding="0" class="formtext" style="color: ###Request.GetColors.OutputTText#;">	

	<tr>
		<td colspan="4">
			<a href="#self#?fuseaction=Product.admin&do=add<cfif len(attributes.cid)>&cid=#attributes.cid#</cfif>#Request.Token2#">New Product</a> | <a href="#self#?#replace(addedpath,"list","listform")##Request.Token2#">List Edit</a>
		</td>
		<td colspan="6"
		align="right">#pt_pagethru#</td>
	</tr>

	<form action="#self#?fuseaction=Product.admin&do=list#request.token2#" method="post">
	
	<tr>
		<td><span class="formtextsmall"><br/></span>
		<input type="submit" value="Search" class="formbutton"/></td>
	
	
		<td><span class="formtextsmall">name<br/></span>
			<input type="text" name="name" size="22" maxlength="25" class="formfield" value="#HTMLEditFormat(attributes.name)#"/></td>	
			
	
		<td><span class="formtextsmall">sku<br/></span>
			<input type="text" name="sku" size="8" maxlength="25" class="formfield" value="#attributes.sku#"/></td>	
				
		<td><span class="formtextsmall">display<br/></span>
		<select name="display" class="formfield">
		<option value="" #doSelected(attributes.display,'')#>All</option>
		<option value="1" #doSelected(attributes.display,1)#>Yes</option>
		<option value="0" #doSelected(attributes.display,0)#>No</option>
		</select></td>				
	
		<td><span class="formtextsmall">sold<br/></span>
		<select name="notsold" class="formfield">
		<option value="" #doSelected(attributes.notsold,'')#>All</option>
		<option value="0" #doSelected(attributes.notsold,0)#>Yes</option>
		<option value="1" #doSelected(attributes.notsold,1)#>No</option>
		</select></td>			
		
		<td><span class="formtextsmall">new<br/></span>
		<select name="highlight" class="formfield">
		<option value="" #doSelected(attributes.highlight,'')#>All</option>
		<option value="1" #doSelected(attributes.highlight,1)#>Yes</option>
		<option value="0" #doSelected(attributes.highlight,0)#>No</option>
		</select></td>				
	
		<td><span class="formtextsmall">sale<br/></span>
		<select name="sale" class="formfield">
		<option value="" #doSelected(attributes.sale,'')#>All</option>
		<option value="1" #doSelected(attributes.sale,1)#>Yes</option>
		<option value="0" #doSelected(attributes.sale,0)#>No</option>
		</select></td>	
					
		<td><span class="formtextsmall">hot<br/></span>
		<select name="hot" class="formfield">
		<option value="" #doSelected(attributes.hot,'')#>All</option>
		<option value="1" #doSelected(attributes.hot,1)#>Yes</option>
		<option value="0" #doSelected(attributes.hot,0)#>No</option>
		</select></td>	
		
		<td><span class="formtextsmall">type<br/></span>
		<select name="type" class="formfield">
		<option value="" #doSelected(attributes.type,'')#>All</option>
		<option value="product" #doSelected(attributes.type,'product')#>product</option>
		<option value="membership" #doSelected(attributes.type,'membership')#>membership</option>
		<option value="download" #doSelected(attributes.type,'download')#>download</option>
		<option value="certificate" #doSelected(attributes.type,'certificate')#>certificate</option>
		</select>
			</td>				
		
		<td><br/><a href="#self#?fuseaction=Product.admin&do=list#Request.Token2#">ALL</a><br/>
		</td></tr>
		</form>
		
	
<!---- Category Browse --------->		
	<tr>
		<td colspan="8">
		<cfif attributes.cid is not "">
			in category <cfinclude template="../../../category/admin/dsp_parent_breadcrumb.cfm"><br/>
			<!---- include subcats ---->
			<cfset attributes.parent_ID = attributes.cid>
			<cfset all = 1>
			<cfinclude template="../../../category/qry_get_subcats.cfm">
			<cfinclude template="../../../category/admin/dsp_subcats_breadcrumb.cfm">
		<cfelse>
			<a href="#self#?cid=0#replace(addedpath,'&nocat=1','','ALL')##Request.Token2#">Browse Categories</a>
		</cfif>		
		</td>
		<td colspan="2" align="right" valign="top">
			<cfif attributes.nocat is not "1">
			<a href="#self#?pid=0&nocat=1#addedpath##Request.Token2#">Uncategorized</a>
			<cfelse>
			<strong>Uncategorized</strong>
			</cfif>
		</td>

		</tr>	
		
		<tr>
			<td colspan="10" style="BACKGROUND-COLOR: ###Request.GetColors.outputHBgcolor#;">
			<img src="#Request.AppSettings.defaultimages#/spacer.gif" alt="" height="1" width="1" /></td>
		</tr>	

<cfif qry_get_products.recordcount gt 0>					

	<cfloop query="qry_get_products" startrow="#PT_StartRow#" endrow="#PT_EndRow#">
		<cfset prodmenu = Application.objMenus.AdminProdMenu(qry_get_products.product_id,attributes.cid)>
		<tr>
			<td><a href="#self#?fuseaction=Product.admin&do=edit&product_ID=#product_id#<cfif len(attributes.cid)>&cid=#attributes.cid#</cfif>#Request.Token2#" onmouseover="this.T_OFFSETX=10;this.T_OFFSETY=5;return escape('#prodMenu#')">Edit #product_id#</a></td>		

		<td <!--- <cfif qry_get_products.catname is "">bgcolor="yellow"</cfif> --->><a href="#self#?fuseaction=product.display&product_id=#product_id##Request.Token2#" target="store" #doMouseover('View Product in Store')#>#name#</a></td>		

		<td>#sku#</td>		

		<td><cfif display is 1>Yes<cfelse>No</cfif></td>		

		<td><cfif notsold is 1>No<cfelse>Yes</cfif></td>	
		
		<td><cfif highlight is 1>Yes<cfelse>No</cfif></td>		

		<td><cfif sale is 1>Yes<cfelse>No</cfif></td>
		
		<td><cfif hot is 1>Yes<cfelse>No</cfif></td>
		
		<td>#prod_type#</td>		
		
		<td><a href="#self#?fuseaction=product.admin&do=copy&dup=#product_id#<cfif len(attributes.cid)>&cid=#attributes.cid#</cfif>#Request.Token2#" #doMouseover('Copy Product')#>copy</a></td>
	</tr>
			
			</cfloop>	
	</table>
		
	<div align="right" class="formtext">#pt_pagethru#</div>
		
	<cfelse>	
		<td colspan="10">
		<br/>
		No records selected
		</td>
	</table>	
	</cfif>

</cfoutput>
<!---- CLOSE MODULE ----->
</cfmodule>

<cfprocessingdirective suppresswhitespace="No">
<script type="text/javascript">
var ttBgColor     = "#ECDEEC";
var ttBorderColor = "#68286B";
var ttFontColor   = "#68286B";
var ttFontFace    = "arial,helvetica,sans-serif";
var ttFontSize    = "11px";
var ttFontWeight  = "normal";     // alternative: "bold";
var ttShadowColor = "#CCCCCC";
var ttShadowWidth = 2;
var ttSticky      = true;        // do NOT hide tooltip on mouseout? Alternative: true
var ttTextAlign   = "left";
var ttWidth       = 130;
</script>

<script type="text/javascript" src="includes/tooltips/wz_tooltip.js"></script>
</cfprocessingdirective>
		
