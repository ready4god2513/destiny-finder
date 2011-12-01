
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the List Edit form for products. This page is used to make common changes to multiple products at one time. Called by product.admin&do=listform --->

<!--- Create the string with the filter parameters --->	
<cfset addedpath="&fuseaction=product.admin&do=#attributes.do#">
		<cfloop list="name,sku,display,highlight,notsold,sale,hot,type,account_id,cid,nocat" index="counter">
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
	width="700"
	required_fields="0"
	>
		

<cfoutput>		
<table width="100%" cellspacing="4" border="0" cellpadding="0" class="formtext" style="color:###Request.GetColors.InputTText#">	

	<tr>
		<td colspan="6">
			<a href="#self#?fuseaction=Product.admin&do=add<cfif len(attributes.cid)>&cid=#attributes.cid#</cfif>#Request.Token2#">New Product</a> | <a href="#self#?#replace(addedpath,"listform","list")##Request.Token2#">List View</a>
		</td>
		<td colspan="5"
		align="right">#pt_pagethru#</td>
	</tr>

	<form action="#self#?fuseaction=Product.admin&do=listform#request.token2#" method="post">
	
	<tr>
		<td colspan="11">
		
		<table width="100%" cellspacing="2" border="0" cellpadding="0" class="formtext"><tr>
		<td><span class="formtextsmall"><br/></span>
		<input type="submit" value="Search" class="formbutton"/></td>	
	
		<td><span class="formtextsmall">name<br/></span>
			<input type="text" name="name" size="25" maxlength="25" class="formfield" value="#HTMLEditFormat(attributes.name)#"/></td>	
			
	
		<td><span class="formtextsmall">sku<br/></span>
			<input type="text" name="sku" size="10" maxlength="25" class="formfield" value="#attributes.sku#"/></td>	
			
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
		
		<td><br/><a href="#self#?fuseaction=Product.admin&do=listform#Request.Token2#">ALL</a><br/>
		</td></tr>
	
		</table>
		</td>
		</tr>	
		</form>		
		
<!---- Category Browse --------->		
	<tr>
		<td colspan="9">
		<cfparam name="attributes.cid" default="">
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
			<td colspan="11" style="BACKGROUND-COLOR: ###Request.GetColors.inputHBgcolor#;">
			<img src="#Request.AppSettings.defaultimages#/spacer.gif" alt="" height="1" width="1" /></td>
		</tr>
		
	<tr>
		<th>Product</th>
		<th align="center">Price</th>
		<th align="center" nowrap="nowrap">Retail</th>
		<th align="center" nowrap="nowrap">Wholesale</th>
		<th align="center">## stock</th>
		<th align="center">Opt ##'s</th>
		<th align="center" nowrap="nowrap">Priority</th>
		<th align="center" nowrap="nowrap">Display</th>
		<th align="center" nowrap="nowrap">New</th>
		<th align="center" nowrap="nowrap">Sale</th>	
		<th align="center" nowrap="nowrap">Hot</th>	
		</tr>			
		
<!--- Make list of product IDs to send to next page --->
<cfset ProductList = "">

<form name="editform" action="#self#?#replace(addedpath,"listform","actform")##request.token2#" method="post">

<cfif qry_get_Products.recordcount gt 0>					
	<cfloop query="qry_get_Products" startrow="#PT_StartRow#" endrow="#PT_EndRow#">
		<!--- Add product ID to the list --->
		<cfset ProductList = ListAppend(ProductList, product_ID)>
		<tr>
		
		<td width="30%">
			<a href="#self#?fuseaction=Product.admin&do=edit&Product_ID=#Product_id##Request.Token2#">#name#</a>
		</td>
	
		<td align="center"><input type="text" name="Base_Price#Product_ID#" value="#NumberFormat(Base_price, '0.00')#" size="6" maxlength="15" class="formfield"/></td>
<td align="center"><input type="text" name="Retail_Price#Product_ID#" value="#iif(Retail_price IS NOT 0, NumberFormat(Retail_price, '0.00'), DE(""))#" size="6" maxlength="15" class="formfield"/></td>
<td align="center"><input type="text" name="Wholesale#Product_ID#" value="#iif(Wholesale IS NOT 0, NumberFormat(Wholesale, '0.00'), DE(""))#" size="6" maxlength="15" class="formfield"/></td>

		<td align="center">
<cfif OptQuant>#NumInStock#<input type="hidden" name="NumInStock#Product_ID#" value="#NumInStock#"/>
<cfelse><input type="text" name="NumInStock#Product_ID#" value="#NumInStock#" size="5" maxlength="15" class="formfield"/></cfif>
</td>

		<td align="center">
<cfif OptQuant>
<!--- Get the stock amount for this option --->
<cfquery name="GetStockNums" datasource="#Request.ds#" username="#Request.user#" password="#Request.pass#">
	SELECT PC.Choice_ID, PC.NumInStock
	FROM #Request.DB_Prefix#ProdOpt_Choices PC
	WHERE PC.Option_ID = #OptQuant#
	ORDER BY SortOrder
</cfquery>

<input type="text" name="OptQuants#Product_ID#" value="#ValueList(GetStockNums.NumInStock)#" size="8" maxlength="150" class="formfield"/>
<input type="hidden" name="ChoiceIDs#Product_ID#" value="#ValueList(GetStockNums.Choice_ID)#"/>
</cfif>
<input type="hidden" name="OptQuant#Product_ID#" value="#OptQuant#"/>
</td>

	<td align="center"><input type="text" name="Priority#Product_ID#" value="#doPriority(qry_Get_Products.Priority,0)#" size="4" maxlength="15" class="formfield"/></td>
	<td align="center"><input type="checkbox" name="Display#Product_ID#" value="1" #doChecked(Display)# /></td>
	<td align="center"><input type="checkbox" name="Highlight#Product_ID#" value="1" #doChecked(Highlight)# /></td>
	<td align="center"><input type="checkbox" name="Sale#Product_ID#" value="1" #doChecked(Sale)# /></td>
	<td align="center"><input type="checkbox" name="Hot#Product_ID#" value="1" #doChecked(Hot)# /></td>
		</tr>	
			</cfloop>	
	</table>		
	<div align="center"><input type="submit" name="Action" value="Save Changes" class="formbutton"/></div><br/>
	<input type="hidden" name="ProductList" value="#ProductList#"/>
</form>

<div align="right" class="formtext">#pt_pagethru#</div>

<cfprocessingdirective suppresswhitespace="no">
<script type="text/javascript">
objForm = new qForm("editform");

<cfloop index="product_ID" list="#productList#">
	objForm.Priority#product_ID#.description = "priority number #product_ID#";
	objForm.NumInStock#product_ID#.description = "number in stock #product_ID#";
</cfloop>

<cfloop index="product_ID" list="#productList#">
	objForm.Priority#product_ID#.validateNumeric();
	objForm.Priority#product_ID#.validateRange('0','9999');
	objForm.Base_Price#product_ID#.validateNumeric();
	objForm.Retail_Price#product_ID#.validateNumeric();
	objForm.Wholesale#product_ID#.validateNumeric();
	objForm.NumInStock#product_ID#.validateNumericfloat();
</cfloop>

qFormAPI.errorColor = "###Request.GetColors.formreq#";
</script>
</cfprocessingdirective>

	<cfelse>	
		<td colspan="11">
		<br/>
		<span class="formerror">No records selected</span>
		</td>
	</table>	
	</cfif>

</cfoutput>
<!---- CLOSE MODULE ----->
</cfmodule>

		
