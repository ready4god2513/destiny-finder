
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the form to edit the product pricing information. Called by product.admin&do=price --->

<!--- Initialize the values for the form --->
	<cfset fieldlist="Product_ID,Name,SKU,Vendor_SKU,Retail_Price,Base_price,wholesale,weight,shipping,taxcodes,NumInStock,ShowOrderBox,VertOptions,ShowPrice,showDiscounts,ShowPromotions,NotSold,reorder_level,min_order,mult_min,sale_start,sale_end,prod_type,account_id,dropship_cost,content_url,Access_keys,access_count,num_days,availability,freight_dom,freight_intl,pack_length,pack_width,pack_height,user_id,giftwrap,Recur,Recur_Product_ID">	
	<!--- Set the form fields to values retrieved from the record --->
	<cfloop list="#fieldlist#" index="counter">
		<cfset "attributes.#counter#" = evaluate("qry_get_product." & counter)>
	</cfloop>
			
<cfset act_title="Update Product - #attributes.name#">
<cfset action="#self#?fuseaction=Product.admin&do=act_price">	

<cfparam name="attributes.cid" default="">
<cfset action="#action#&cid=#attributes.cid#">

<cfinclude template="../../../users/account/qry_get_vendors.cfm">		
<cfinclude template="options/qry_get_options.cfm">			
<cfinclude template="discounts/qry_get_product_discounts.cfm">
<cfinclude template="../../../includes/imagepreview.js">
<cfinclude template="../../../queries/qry_getpicklists.cfm">
<cfinclude template="../../../shopping/admin/tax/qry_codes.cfm">
				
<cfquery name="qry_get_AccessKeys"  datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	SELECT * FROM #Request.DB_Prefix#AccessKeys 
	ORDER BY Name
</cfquery>
		
	
	
<cfmodule template="../../../customtags/format_output_admin.cfm"
	box_title="#act_title#"
	Width="700"
	menutabs="yes">
	
	<cfinclude template="dsp_menu.cfm">
	
<cfoutput>
	<!--- Table --->
	<table border="0" cellpadding="0" cellspacing="4" width="100%" class="formtext" 
	style="color:###Request.GetColors.InputTText#">
	<form name="editform" action="#action##request.token2#" method="post">
	
	<input type="hidden" name="product_id" value="#attributes.product_id#"/>
	
			
 <!--- Name --->
		<tr>
			<td align="RIGHT" width="30%">Product:</td>
			<td width="4">&nbsp;</td>
			<td><strong>#attributes.name#</strong></td>
		</tr>
			
			


 <!--- NotSold --->
		<tr>
			<td align="RIGHT" valign="top">Sell this Item:</td>
			<td style="background-color: ###Request.GetColors.formreq#;" width="3">&nbsp;</td>
			<td><input type="radio" name="NotSold" value="0" #doChecked(attributes.NotSold, 0)# />Yes
			&nbsp;<input type="radio" name="NotSold" value="1" #doChecked(attributes.NotSold)# />No<br/>
		</tr>
		<tr><td colspan="2"></td>
		<td><span class="formtextsmall">If not sold, product will display without ordering information</span></td></tr>	
			
 <!--- sale_start --->
		<tr>
			<td align="RIGHT">Sales Start:</td>
			<td></td>
		 	<td>
			<cfmodule template="../../../customtags/calendar_input.cfm" ID="calstart" formfield="sale_start" formname="editform" value="#dateformat(attributes.sale_start,"mm/dd/yyyy")#" size="10" browser="#browsername#" bversion="#browserversion#" />
			</td>
			</tr>
			
 <!--- sale_end --->
		<tr>
			<td align="RIGHT" valign="baseline">Sales End:</td>
			<td></td>
			 <td>
			 <cfmodule template="../../../customtags/calendar_input.cfm" ID="calend" formfield="sale_end" formname="editform" value="#dateformat(attributes.sale_end,"mm/dd/yyyy")#" size="10" browser="#browsername#" bversion="#browserversion#" />
			<br/>
			<span class="formtextsmall">Leave dates blank if product is always sold</span> 
			</td></tr>				
			
			
							
<!--- Title --->
		<tr>
			<td align="RIGHT" class="formtitle"><br/>Inventory Details&nbsp;</td>
			<td colspan="2"><br/><cfmodule template="../../../customtags/putline.cfm" linetype="thin" linecolor="#Request.GetColors.InputHBgcolor#" /></td>
		</tr>
				
 <!--- SKU --->
		<tr>
			<td align="RIGHT">Product No. (SKU):</td>
			<td></td>
		 <td>
			<input type="text" name="SKU" value="#attributes.SKU#" size="30" maxlength="100" class="formfield"/>
			</td>
			</tr>		
			
 <!--- Min_order --->
		<tr>
			<td align="RIGHT" valign="top">Minimum Quantity to Buy:</td>
			<td></td>
		 <td>
			<input type="text" name="Min_Order" value="#attributes.Min_Order#" size="7" maxlength="15" class="formfield"/><br/>
			<span class="formtextsmall">Customer will be required to buy this minimum quantity of the product</span>
			</td>
			</tr>

 <!--- Mult_Min --->
		<tr>
			<td align="RIGHT" valign="top">Require Multiples<br/>of Minimum:</td>
			<td></td>
		 <td>
			<input type="radio" name="Mult_Min" value="1" #doChecked(attributes.Mult_Min)# />Yes
			&nbsp;<input type="radio" name="Mult_Min" value="0" #doChecked(attributes.Mult_Min,0)# />No<br/>
			<span class="formtextsmall">If turned on, will force purchases to multiples of the minimum amount,<br/>
		e.g. 12, 24, 36, etc.</span>	
			</td>
			</tr>	
								
 <!--- availability  --->
		<tr>
			<td align="RIGHT">Availability:</td>
			<td></td>
		 	<td>
			<select name="Availability" size="1" class="formfield">
			<option value="" #doSelected(attributes.Availability,'')#></option>
			<cfmodule template="../../../customtags/form/dropdown.cfm"
			mode="valuelist"
			valuelist="#qry_getpicklists.product_Availability#"
			selected="#attributes.Availability#"
			/>
	 		</select>
			<!----
			<input type="text" name="Availability" message=""  value="#HTMLEditFormat(attributes.Availability)#" size="30" maxlength="75" class="formfield"/>
			---->
			</td></tr>			
 
<!--- NumInStock --->
		<tr>
			<td align="RIGHT">Number in Stock:</td>
			<td></td>
			<td>	
			<cfif qry_Get_Options.Recordcount>
				#qry_Get_Product.NuminStock# (set by options)
				<input type="hidden" name="NumInStock" value="#attributes.NuminStock#" class="formfield"/>
			<cfelse>
				<input type="text" name="NumInStock" value="#attributes.NumInStock#" size="7" maxlength="15" class="formfield"/>
			</cfif>
			</td></tr>
			
 <!--- reorder_level --->
		<tr>
			<td align="RIGHT">Reorder Level:</td>
			<td></td>
		 	<td>
			<input type="text" name="reorder_level" value="#attributes.reorder_level#" size="7" maxlength="15" class="formfield"/>
			</td></tr>	
			<tr><td colspan="2"></td>
		<td><span class="formtextsmall">Set to any number higher than 0 to receive emails of low stock.</span></td></tr>		
				
	
<!--- Title --->
		<tr>
			<td align="RIGHT" class="formtitle"><br/>Drop-Shipping&nbsp;</td>
			<td colspan="2"><br/><cfmodule template="../../../customtags/putline.cfm" linetype="thin" linecolor="#Request.GetColors.InputHBgcolor#" /></td>
		</tr>	
		
<!--- Account_ID --->
	 	<tr>
			<td align="RIGHT">Vendor:</td>
			<td></td>
			<td>
	 		<select name="account_id" class="formfield">
			<option value="" #doSelected(attributes.account_id,'')#>select vendor...</option>
			<cfloop query="qry_get_vendors">
			<option value="#account_id#" #doSelected(attributes.account_id,qry_get_vendors.account_id)#>#Account_name#</option>
			 </cfloop>
			 </select>
			</td>
		</tr>		
		
 <!--- Vendor SKU --->
			<tr>
				<td align="RIGHT">Vendor Part No:</td>
	
				<td></td>
		 <td>
			<input type="text" name="Vendor_SKU" value="#attributes.Vendor_SKU#" size="30" maxlength="100" class="formfield"/>
			</td>
			</tr>		
		
 <!--- Base_price --->
		<tr>
			<td align="RIGHT">Purchase Order Cost:</td>
			<td></td>
		 	<td>
			<input type="text" name="dropship_cost"  class="formfield" value="#iif(attributes.dropship_cost IS NOT 0, NumberFormat(attributes.dropship_cost, '0.00'), DE(''))#" size="7" maxlength="15"/> #Request.AppSettings.MoneyUnit#
			</td></tr>
						
							
<!--- Title --->
		<tr>
			<td align="RIGHT" class="formtitle"><br/>Order Box&nbsp;</td>
			<td colspan="2"><br/><cfmodule template="../../../customtags/putline.cfm" linetype="thin" linecolor="#Request.GetColors.InputHBgcolor#" /></td>
		</tr>

		
		
<!--- ShowOrderBox --->
		<tr>
			<td align="RIGHT">Order Button:</td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
			<td>
			<input type="radio" name="ShowOrderBox" value="1" #doChecked(attributes.ShowOrderBox)# />HTML  
			&nbsp;<input type="radio" name="ShowOrderBox" value="0" #doChecked(attributes.ShowOrderBox, 0)# /> Image
			</td>
			</tr>		
		
<!--- ShowOrderBox --->
		<tr>
			<td align="RIGHT">Options Listing:</td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
			<td>
			<input type="radio" name="VertOptions" value="1" #doChecked(attributes.VertOptions)# /> Vertical List 
			&nbsp;<input type="radio" name="VertOptions" value="0" #doChecked(attributes.VertOptions,0)# /> Horizontal Bar
			</td>
			</tr>	
			
			
			
<!---============== Pricing ========================== --->					
<!--- Title --->
		<tr>
			<td align="RIGHT" class="formtitle"><br/>Price&nbsp;</td>
			<td colspan="2"><br/><cfmodule template="../../../customtags/putline.cfm" linetype="thin" linecolor="#Request.GetColors.InputHBgcolor#" /></td>
		</tr>
		
 <!--- ShowPrice --->
		<tr>
			<td align="RIGHT">Show Price:</td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
		 	<td>
			<input type="radio" name="ShowPrice" value="1" #doChecked(attributes.ShowPrice)# />Yes  
			&nbsp;<input type="radio" name="ShowPrice" value="0" #doChecked(attributes.ShowPrice,0)# /> No
			</td>
			</tr>	
		
 <!--- Base_price --->
		<tr>
			<td align="RIGHT">Store Base Price:</td>
			<td></td>
		 	<td>
			<input type="text" name="Base_Price"  class="formfield" value="#NumberFormat(attributes.Base_price, '0.00')#" size="7" maxlength="15"/> #Request.AppSettings.MoneyUnit#
			</td></tr>
			
 <!--- Retail_Price --->
		<tr>
			<td align="RIGHT">Retail Price (MSRP):</td>
			<td></td>
			<td>
				<input type="text" name="Retail_Price"  class="formfield" value="#iif(attributes.Retail_Price IS NOT 0, NumberFormat(attributes.Retail_Price, '0.00'), DE(''))#" size="7" maxlength="15"/> #Request.AppSettings.MoneyUnit#
			</td></tr>
		
 <!--- wholesale --->
		<tr>
			<td align="RIGHT">Wholesale Price:</td>
			<td></td>
		 	<td>
			<input type="text"  class="formfield" name="Wholesale" value="#iif(attributes.Wholesale IS NOT 0, NumberFormat(attributes.Wholesale, '0.00'), DE(''))#" size="7" maxlength="15"/> #Request.AppSettings.MoneyUnit#			
			</td></tr>
				
<!--- tax codes--->
		<tr>
			<td align="RIGHT" valign="top">Tax Codes:</td>
			<td></td>
		 	<td>
			<select name="TaxCodes" class="formfield" size="#iif(GetCodes.RecordCount LT 5,GetCodes.RecordCount + 1,5)#" multiple="multiple">
		<option value="" #doSelected(attributes.TaxCodes,'')#>None</option>
			<cfloop query="GetCodes">
			<option value="#Code_ID#" #doSelected(ListFind(attributes.taxcodes, GetCodes.Code_ID))#>#CodeName#</option>
			</cfloop>
			</select>
			</td></tr>					
			
<!---============== DISCOUNTS ========================== --->					
<!--- Title --->
		<tr>
			<td align="RIGHT" class="formtitle"><br/>Discounts&nbsp;</td>
			<td colspan="2"><br/><cfmodule template="../../../customtags/putline.cfm" linetype="thin" linecolor="#Request.GetColors.InputHBgcolor#" /></td>
		</tr>
			
 <!--- showDiscounts --->
		<tr>
			<td align="RIGHT">Show Discounts:</td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
		 	<td>
			<input type="radio" name="showDiscounts" value="1" #doChecked(attributes.showDiscounts)# /> Yes  
			&nbsp;<input type="radio" name="showDiscounts" value="0" #doChecked(attributes.showDiscounts,0)# /> No
			</td>
			</tr>			
	
<!--- discounts --->
<cfif qry_get_discounts.RecordCount> 
			<tr>
				<td align="RIGHT" valign="top">Discounts:<br/><br/></td>
				<td></td>
				<td>
<select name="Discounts" class="formfield" 
	size="#iif(qry_get_discounts.RecordCount LT 5,qry_get_discounts.RecordCount + 1,5)#" multiple="multiple">
<option value="" #doSelected(qry_Get_Prod_Discounts.Recordcount,0)#>None</option>
	<cfloop query="qry_get_discounts">
	<option value="#Discount_ID#" #doSelected(ListFind(DiscountList, qry_get_discounts.Discount_ID))#>#Name#</option>
	</cfloop>
	</select>	</td>
			</tr>
</cfif>	
<input type="hidden" name="DiscountList" value="#ValueList(qry_get_discounts.Discount_ID)#"/>
	
 <!--- showPromotions --->
		<tr>
			<td align="RIGHT">Show Promotions:</td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
		 	<td>
			<input type="radio" name="showPromotions" value="1" #doChecked(attributes.showPromotions)# /> Yes  
			&nbsp;<input type="radio" name="showPromotions" value="0" #doChecked(attributes.showPromotions,0)# /> No
			</td>
			</tr>	
							
<!--- Additional Product Settings - The following section choices depend on the product type. 
PRODUCTS:
	Shipping 	(yes/no)
	Weight		
	Freight Cost (domestic/international)
	Package Dimensions (length/width/height)
	Giftwrap	(yes/no)
DOWNLOADS:
	num_days
	content_url	
	access_count
MEMBERSHIPS:
	Access_Keys
	num_days
	Recur
	Recur_Product_ID
	access_count (used for auto-renew product_ID)
GIFTCERTS:
	num_days
--->

		
<!--- PRODUCTS  ========================================================= --->
<cfif attributes.prod_type is "product">
		<tr>
			<td align="RIGHT" class="formtitle"><br/>Shipping&nbsp;</td>
			<td colspan="2"><br/><cfmodule template="../../../customtags/putline.cfm" linetype="thin" linecolor="#Request.GetColors.InputHBgcolor#" /></td>
		</tr>

 <!--- shipping --->
		<tr>
			<td align="RIGHT">Calculate Shipping:</td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
			<td>
				<input type="radio" name="shipping" value="1" #doChecked(attributes.shipping)# />Yes  
				&nbsp;<input type="radio" name="shipping" value="0" #doChecked(attributes.shipping,0)# /> No
			</td>
			</tr>				
				
 <!--- shipping --->	
		<tr>
			<td align="RIGHT">Weight:</td>
			<td></td>
			<td>
				 <input type="text" name="Weight"  class="formfield" value="#iif(attributes.Weight IS NOT 0, NumberFormat(attributes.Weight, '0.00'), DE(''))#" size="7" maxlength="15"/>
#Request.AppSettings.WeightUnit#
			</td></tr>
			
 <!--- freight --->	
		<tr>
			<td align="RIGHT" valign="top">Freight Cost:</td>
			<td></td>
			<td>
				<input type="text" name="Freight_Dom"  class="formfield" value="#iif(attributes.Freight_Dom IS NOT 0, NumberFormat(attributes.Freight_Dom, '0.00'), DE(''))#" size="7" maxlength="15"/> #Request.AppSettings.MoneyUnit# (Domestic) &nbsp;&nbsp;
<input type="text" name="Freight_Intl"  class="formfield" value="#iif(attributes.Freight_Intl IS NOT 0, NumberFormat(attributes.Freight_Intl, '0.00'), DE(''))#" size="7" maxlength="15"/> #Request.AppSettings.MoneyUnit# (International) 
			<br/>
			<span class="formtextsmall">Overrides normal shipping cost, enter both or neither</span> </td></tr>

			
		<tr>
			<td align="RIGHT" valign="top">Package Dimensions:</td>
			<td></td>
			<td>
				<input type="text" name="Pack_Length"  class="formfield" value="#iif(attributes.Pack_Length IS NOT 0, NumberFormat(attributes.Pack_Length, '0.00'), DE(''))#" size="5" maxlength="15"/> #Request.AppSettings.SizeUnit# Long X <input type="text" name="Pack_Width"  class="formfield" value="#iif(attributes.Pack_Width IS NOT 0, NumberFormat(attributes.Pack_Width, '0.00'), DE(''))#" size="5" maxlength="15"/> #Request.AppSettings.SizeUnit# Wide X <input type="text" name="Pack_Height"  class="formfield" value="#iif(attributes.Pack_Height IS NOT 0, NumberFormat(attributes.Pack_Height, '0.00'), DE(''))#" size="5" maxlength="15"/> #Request.AppSettings.SizeUnit# High<br/>
			<span class="formtextsmall">For oversize items that ship separately, enter all dimensions or none</span> </td></tr>

<!--- Giftwrap --->	
		<tr>
			<td align="RIGHT">Gift Wrapping Available:</td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
			<td>
				<input type="radio" name="Giftwrap" value="1" #doChecked(attributes.Giftwrap)# />Yes  
				&nbsp;<input type="radio" name="Giftwrap" value="0" #doChecked(attributes.Giftwrap,0)# /> No 
			</td></tr>

</cfif>
		
<!--- DOWNLOADS ========================================================= --->

<cfif attributes.prod_type is "download">
<tr>
			<td align="RIGHT" class="formtitle"><br/>Download Info&nbsp;</td>
			<td colspan="2"><br/><cfmodule template="../../../customtags/putline.cfm" linetype="thin" linecolor="#Request.GetColors.InputHBgcolor#" /></td>
		</tr>
		
	 <!--- num_days --->
			<tr>
				<td align="RIGHT">Number of Days:</td>
				<td style="background-color: ###Request.GetColors.formreq#;"></td>
			 	<td>
				<input type="text" name="num_days"  value="#attributes.num_days#" class="formfield" size="7" maxlength="15"/></td>
			</tr>		
	
	<!--- Content ---->
		<tr>
			<td align="RIGHT">Downloadable File:</td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
		 	<td>
			<input type="text" name="content_url" value="#attributes.content_url#" size="40" maxlength="100" class="formfield"/>  <a href="JavaScript: newWindow = openWin('#self#?fuseaction=home.admin&select=image&type=Download&fieldname=content_url&fieldvalue=#attributes.content_url#&user=#attributes.user_id#', 'images', 'width=520,height=290,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=0,resizable=1'); newWindow.focus()" class="formtextsmall">File Manager</a>
			</td>
		</tr> 
					
	<!--- access_count --->
			<tr>
				<td align="RIGHT">Access Count:</td>
				<td style="background-color: ###Request.GetColors.formreq#;"></td>
			 	<td>
				<input type="text" name="access_count"  value="#attributes.access_count#" class="formfield"  size="7" maxlength="15"/></td>
			</tr>	

</cfif>

<cfif attributes.prod_type is "certificate">
<tr>
			<td align="RIGHT" class="formtitle"><br/>Certificate Info&nbsp;</td>
			<td colspan="2"><br/><cfmodule template="../../../customtags/putline.cfm" linetype="thin" linecolor="#Request.GetColors.InputHBgcolor#" /></td>
		</tr>
		
	 <!--- num_days --->
			<tr>
				<td align="RIGHT">Days Active:</td>
				<td></td>
			 	<td>
				<input type="text" name="num_days"  value="#attributes.num_days#" class="formfield" size="7" maxlength="15"/></td>
			</tr>	
</cfif>

		
<!--- MEMBERSHIPS ========================================================= --->
<cfif attributes.prod_type is "membership">		
<tr>
			<td align="RIGHT" class="formtitle"><br/>Membership Info&nbsp;</td>
			<td colspan="2"><br/><cfmodule template="../../../customtags/putline.cfm" linetype="thin" linecolor="#Request.GetColors.InputHBgcolor#" /></td>
		</tr>

	 <!--- Access_keys --->
		<tr>
			<td align="RIGHT">Access Keys:</td>
			<td></td>
		 	<td>
				<select name="Access_Keys" size="3" multiple="multiple" class="formfield">
				<option value="0" #doSelected(attributes.Access_Keys,'')#>none</option>
				<cfloop query="qry_get_accesskeys">
				<option value="#accesskey_ID#" #doSelected(ListFind(attributes.Access_keys, accesskey_ID))#>#name#</option>
				</cfloop>
				</select>
			</td></tr>		

	 <!--- num_days --->
			<tr>
				<td align="RIGHT">Number of Days:</td>
				<td></td>
			 	<td>
				<input type="text" name="num_days"  value="#attributes.num_days#" class="formfield" size="7" maxlength="15"/></td>
			</tr>		
					
	<!--- Recur ---->
			<tr>
				<td align="RIGHT">Auto Renewing:</td>
				<td></td>
			 	<td><input type="radio" name="Recur" value="1" #doChecked(attributes.Recur)#  onclick="javascript:editform.Recur_Product_ID.disabled=false;" />Yes  
&nbsp;<input type="radio" name="Recur" value="0" #doChecked(attributes.Recur,0)#  onclick="javascript:editform.Recur_Product_ID.options[0].selected=true;editform.Recur_Product_ID.disabled=true;" /> No </td>
			</tr>		
			</tr> 
			
<!--- List of membership products --->
<cfquery name="member_prods" datasource="#Request.ds#" username="#Request.user#" password="#Request.pass#" >
	SELECT Product_ID, Name FROM #Request.DB_Prefix#Products
	WHERE Prod_Type = 'membership'
	AND Product_ID <> #attributes.product_id#
</cfquery>	
	
			<tr>
				<td align="RIGHT" valign="top">Renew to Different Product:</td>
				<td></td>
			 	<td>
				<select name="Recur_Product_ID" size="1" <cfif attributes.Recur is 0>disabled="disabled"</cfif> class="formfield">
				<option value="0" #doSelected(attributes.Recur_Product_ID,'')#>&nbsp;&nbsp;</option>
				<cfloop query="member_prods">
				<option value="#member_prods.Product_ID#" #doSelected(attributes.Recur_Product_ID,member_prods.product_ID)#>#member_prods.name#</option>
				</cfloop>
				</select>
				<span class="formtextsmall"><br/>For use with Recurring Products only. Use this field for a low-priced trial membership that can only be purchased once. When this membership expires, it will be renewed using the product listed here. Leave blank for memberships that just auto-renew themselves.</span>
				</td>
			</tr>		
</cfif><!--- prod type is membership --->			

		<tr>
			<td colspan="2">&nbsp;</td>
			<td><br/>
			<input type="submit" name="frm_submit" value="Update Pricing" class="formbutton"/> 
			<input type="reset" value="Clear" class="formbutton"/>			
	</td>
	
	</tr>
	</form>	
	
	<cfinclude template="../../../includes/form/put_requiredfields.cfm">
	
	
			
<cfprocessingdirective suppresswhitespace="no">
<script type="text/javascript">
objForm = new qForm("editform");

objForm.required("NotSold,Mult_Min,ShowOrderBox,VertOptions,ShowPrice,showDiscounts,showPromotions");

objForm.Min_Order.description = "minimum order quantity";
objForm.NotSold.description = "sell this item";
objForm.ShowOrderBox.description = "show order box";
objForm.VertOptions.description = "vertical options";
objForm.ShowPrice.description = "show price";
objForm.showDiscounts.description = "show discounts";
objForm.showPromotions.description = "show promotions";


objForm.NumInStock.description = "number in stock";
objForm.reorder_level.description = "reorder level";

<cfif attributes.prod_type is "product">
	objForm.required("shipping,Giftwrap");
	objForm.Freight_Dom.description = "freight cost (domestic)";
	objForm.Freight_Intl.description = "freight cost (international)";
	objForm.Pack_Length.description = "package length";
	objForm.Pack_Width.description = "package width";
	objForm.Pack_Height.description = "package height";	
	
	objForm.Freight_Dom.validateNumeric();
	objForm.Freight_Intl.validateNumeric();
	objForm.Pack_Length.validateNumeric();
	objForm.Pack_Width.validateNumeric();
	objForm.Pack_Height.validateNumeric();
	objForm.Weight.validateNumeric();
	
	objForm.Pack_Width.createDependencyTo("Pack_Length");
	objForm.Pack_Height.createDependencyTo("Pack_Length");
	
	objForm.Pack_Length.enforceDependency();
	
<cfelseif attributes.prod_type is "membership">
	objForm.required("Recur,num_days");
	objForm.num_days.validateNumeric();
	objForm.num_days.description = "Number of Days";
	objForm.Recur.description = "Auto Renewing";
<cfelseif attributes.prod_type is "download">
	objForm.required("num_days,content_url,access_count");
	objForm.num_days.description = "Number of Days";
	objForm.content_url.description = "Downloadable File";	
	objForm.access_count.description = "Access Count";	
	objForm.access_count.validateNumeric();
	objForm.num_days.validateNumeric();
<cfelseif attributes.prod_type is "certificate">
	objForm.required("num_days");
	objForm.num_days.description = "Number of Days";
	objForm.num_days.validateNumeric();
</cfif>

objForm.Min_Order.validateNumeric();
objForm.Base_Price.validateNumeric();
objForm.Retail_Price.validateNumeric();
objForm.Wholesale.validateNumeric();
objForm.NumInStock.validateNumericfloat();
objForm.reorder_level.validateNumeric();
objForm.sale_end.validateDate();
objForm.sale_start.validateDate();


qFormAPI.errorColor = "###Request.GetColors.formreq#";
</script>
</cfprocessingdirective>


<form action="#self#?fuseaction=product.admin&do=list#request.token2#" method="post">			
	<tr>
		<td align="center" colspan="3">
<cfmodule template="../../../customtags/putline.cfm" linetype="thin" linecolor="#Request.GetColors.InputHBgcolor#" width="98%" />	<br/>	
		<input type="hidden" name="act" value="choose"/>
		<input type="hidden" name="cid" value="#iif(len(attributes.cid),attributes.cid,0)#"/>
		<input type="submit" name="DONE" value="Back to Product List" class="formbutton"/>
		<br/><br/>
		</td>
	</tr>
	</form>
		
	</table> 
</cfoutput>		
</cfmodule>		

