
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the main product form to add or edit a product. Called by product.admin&do=add|edit --->

<cfinclude template="../../../admin/colors/qry_get_colors.cfm">
<cfinclude template="../../../access/admin/accesskey/qry_get_accesskeys.cfm">

<!---- current selected category ---->
<cfparam name="attributes.cid" default="">

<!---- get list of categories that hold products ---->
<cfset attributes.catcore_content = "Products">
<cfinclude template="../../../category/qry_get_cat_picklist.cfm">

<cfset type1="manufacturer">
<cfinclude template="../../../users/account/qry_get_vendors.cfm">		

<!--- Initialize the values for the form --->
<cfset fieldlist="Product_ID,Name,short_desc,long_desc,sm_image,lg_image,enlrg_image,sm_title,lg_title,passparam,color_id,display,priority,accesskey,Highlight,sale,Hot,Reviewable,UseforPOTD,dateadded,prod_type,mfg_account_id,metadescription,keywords,titletag,user_id">	
		
		<cfswitch expression="#attributes.do#">
			
			<cfcase value="add">
			
				<cfloop list="#fieldlist#" index="counter">
					<cfset setvariable("attributes.#counter#", "")>
				</cfloop>

				<cfset attributes.cid_list = attributes.cid>
				<cfset current_cats = "">	
				<cfset attributes.related_products = "">	
				<cfset act_title="Add Product">	
						
				<cfset attributes.product_id = 0>	
				
				<!--- Radio button defaults --->
				<cfset attributes.Highlight = 0>
				<cfset attributes.Sale = 0>
				<cfset attributes.Hot = 0>
		
				<cfset action="#self#?fuseaction=Product.admin&do=act&mode=i">
			 
				<cfset act_button ="Add Product">	
				
				<!--- Check user's access level to set user id for images --->
				<cfmodule template="../../../access/secure.cfm"	keyname="product" requiredPermission="1">				
				<cfif NOT ispermitted>
					<cfset attributes.user_id = Session.User_ID>
				</cfif>
			
			</cfcase>
					
			<cfcase value="edit">
				<!--- Set the form fields to values retrieved from the record --->				
				<cfloop list="#fieldlist#" index="counter">
					<cfset "attributes.#counter#" = evaluate("qry_get_product." & counter)>
				</cfloop>
				
				<cfset action="#self#?fuseaction=Product.admin&do=act&mode=u">
				<cfset id = attributes.product_id>
				
				<cfif isdefined("attributes.dup")>
					<cfset act_title="Copy Product">	
				<cfelse>
					<cfset act_title="Update Product - #attributes.name#">	
				</cfif>
				
				<cfset act_button ="Update Product">	
				
				<cfinclude template="qry_get_product_cats.cfm">
				<cfset attributes.CID_LIST = valuelist(qry_get_product_cats.category_id)>
				<cfset current_cats = attributes.CID_LIST>

			</cfcase>
		</cfswitch>
		
<cfif attributes.cid is not "">
	<cfset action="#action#&cid=#attributes.cid#">
</cfif>	

<cfinclude template="../../../includes/imagepreview.js">
<cfinclude template="../../../includes/charCount.js">

<cfhtmlhead text="
	<script language=""JavaScript"">
		function CancelForm () {
		location.href = ""#self#?fuseaction=product.admin&do=list&cid=#attributes.cid#&redirect=yes#request.token2#"";
		}
	</script>
">
	
<cfmodule template="../../../customtags/format_admin_form.cfm"
	box_title="#act_title#"
	Width="700"
	menutabs="#iif(attributes.do is "edit", DE("yes"), DE("no"))#">


	<cfif attributes.do is "edit">
		<cfinclude template="dsp_menu.cfm">
	</cfif>
	
	<cfoutput>
	
	<!--- Table --->
	<table border="0" cellpadding="0" cellspacing="4" width="100%" class="formtext"
	style="color:###Request.GetColors.InputTText#">
	<form name="editform" action="#action##request.token2#" method="post">
	<input type="hidden" name="dateadded" value="#attributes.dateadded#"/>

	<!--- Product ID --->
			<tr>
				<td align="RIGHT">Product ID:</td>
				<td width="4">&nbsp;</td>
				<td colspan="3">
				<cfif attributes.Product_iD>
					#attributes.Product_ID#
				<cfelse>
					NEW
				</cfif>
				<input type="hidden" name="product_id" value="#attributes.product_id#"/></td>
			</tr>
			
			
 <!--- Name --->
			<tr>
				<td align="RIGHT">Name:</td>
				<td style="background-color: ###Request.GetColors.formreq#;" width="3">&nbsp;</td>
		 		<td colspan="3"><input type="text" name="Name" value="#HTMLEditFormat(attributes.name)#" size="58" maxlength="100" class="formfield"/>
			</td>
			</tr>
			
 <!--- prod_type --->
		<tr>
			<td align="RIGHT">Product Type:</td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
			<td colspan="3">
			<select name="prod_type" class="formfield">
			<option value="product" #doSelected(attributes.prod_type,'product')#>product</option>
			<option value="membership" #doSelected(attributes.prod_type,'membership')#>membership</option>
			<option value="download" #doSelected(attributes.prod_type,'download')#>download</option>
			<option value="certificate" #doSelected(attributes.prod_type,'certificate')#>certificate</option>
			</select>
			</td>
			</tr>
						
 <!--- manufacturer account ID --->
		<tr>
			<td align="RIGHT">Manufacturer:</td>
			<td></td>
			<td colspan="3">
			<select name="mfg_account_ID" class="formfield">
			<option value="" #doSelected(attributes.mfg_account_ID,'')#></option>
			<cfloop query="qry_get_vendors">
			<option value="#account_ID#" #doSelected(attributes.mfg_account_ID,qry_get_vendors.account_ID)#>#Account_name#</option>
			 </cfloop>
			</select>
			</td>
			</tr>			
			
 <!--- display --->
			<tr>
				<td align="RIGHT">Display:</td>
				<td style="background-color: ###Request.GetColors.formreq#;"></td>
				<td colspan="3"><input type="radio" name="display" value="1" #doChecked(attributes.display)# /> Yes  
				&nbsp;&nbsp;<input type="radio" name="display" value="0" #doChecked(attributes.display,0)# /> No
			</td>
			</tr>			
			
			
 <!--- Category_id --->		
			<tr>
				<td align="RIGHT" valign="top">Category:
				<br/><br/><span class="formtextsmall">CTRL + Click to<br/>select multiple<br/>categories.</span>
				</td>
				<td></td>
				<td colspan="3">
				<select name="CID_list" size="#iif(qry_get_cat_picklist.RecordCount LT 20,Ceiling(qry_get_cat_picklist.RecordCount/2),10)#" multiple="multiple" class="formfield">				
				<cfloop query="qry_get_cat_picklist">
				<option value="#category_id#" #doSelected(ListFind(attributes.cid_list,category_ID))#>
				&raquo;<cfif parentnames is not ""><cfif len(parentnames) gt 100>...</cfif>#Right(replace(parentnames,':','&raquo;'),100)#&raquo;</cfif>#Name#</option>
				</cfloop>
	 			</select>
				<input type="hidden" name="current_cats" value="#current_cats#"/>	
				</td>
			</tr>			
			
 <!--- priority --->
			<tr>
				<td align="RIGHT">Priority:</td>
				<td></td>
				<td colspan="3"><input type="text" name="Priority" value="#doPriority(attributes.Priority,0)#" size="4" maxlength="10" class="formfield"/> <span class="formtextsmall">(1 is highest, 0 is none)</span>
				</td>
			</tr>		
			
 <!--- AccessKey --->
			<tr>
				<td align="RIGHT">AccessKey:</td>
				<td></td>
				<td colspan="3">
			 	<select name="AccessKey" class="formfield">
				<option value="0" #doSelected(attributes.accesskey,0)#>none</option>
				<cfloop query="qry_get_accesskeys">
				<option value="#accesskey_ID#" #doSelected(attributes.accesskey,qry_get_accesskeys.accesskey_ID)#>#name#</option>
				</cfloop>
	 			</select>
			</td>
			</tr>
				
 <!--- highlight --->
			<tr>
				<td align="RIGHT">New:</td>
				<td></td>
				<td><input type="radio" name="Highlight" value="1" #doChecked(attributes.Highlight)# /> Yes  
				&nbsp;&nbsp;<input type="radio" name="Highlight" value="0" #doChecked(attributes.Highlight,0)# /> No
				</td>
				
<!--- Product reviews --->				
				<td align="right">Allow Reviews:</td>
				<td><input type="radio" name="Reviewable" value="1" #doChecked(attributes.Reviewable)# /> Yes  
				&nbsp;&nbsp;<input type="radio" name="Reviewable" value="0" #doChecked(attributes.Reviewable,0)# /> No</td>
			</tr>
			
<!--- sale --->
			<tr>
				<td align="RIGHT">Sale:</td>	
				<td></td>
				<td><input type="radio" name="sale" value="1" #doChecked(attributes.sale)# /> Yes  
				&nbsp;&nbsp;<input type="radio" name="sale" value="0"#doChecked(attributes.sale,0)# /> No</td>

				<!--- Product of the Day setting --->
				<td align="right">Use for Prod. of Day:</td>
				<td><input type="radio" name="UseforPOTD" value="1" #doChecked(attributes.UseforPOTD)# /> Yes 
				&nbsp;&nbsp;<input type="radio" name="UseforPOTD" value="0" #doChecked(attributes.UseforPOTD,0)# /> No</td>
			</tr>			
			
<!--- hot --->
			<tr>
				<td align="RIGHT">Hot:</td>	
				<td></td>
				<td colspan="3"><input type="radio" name="hot" value="1" #doChecked(attributes.hot)# /> Yes 
				&nbsp;&nbsp;<input type="radio" name="hot" value="0" #doChecked(attributes.hot,0)# /> No
		
			</td>
			</tr>						
			
<!--- Listing Title --->
			<tr>
				<td align="RIGHT" class="formtitle"><br/>Teaser&nbsp;</td>
				<td colspan="4"><br/><cfmodule template="../../../customtags/putline.cfm" linetype="thin" linecolor="#Request.GetColors.InputHBgcolor#"/></td>
			</tr>

 <!--- Small Title --->
			<tr>
				<td align="RIGHT">Title Image:</td>
				<td></td>
				<td colspan="3"><input type="text" name="Sm_Title" size="33" maxlength="100" class="formfield" value="#attributes.Sm_Title#"/> <a href="JavaScript: newWindow = openWin('#self#?fuseaction=home.admin&select=image&fieldname=Sm_Title&fieldvalue=#attributes.Sm_Title#&dirname=/products&user=#attributes.user_ID#', 'images', 'width=520,height=290,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=0,resizable=1'); newWindow.focus()" class="formtextsmall">Image Manager</a>
				</td>
			</tr>
			
 <!--- Small Image --->
			<tr>
				<td align="RIGHT">Image:</td>
				<td></td>
<td colspan="3"><input type="text" name="Sm_Image" size="33" maxlength="100" class="formfield" value="#attributes.Sm_Image#"/> <a href="JavaScript: newWindow = openWin('#self#?fuseaction=home.admin&select=image&fieldname=Sm_Image&fieldvalue=#attributes.Sm_Image#&dirname=/products&user=#attributes.user_ID#', 'images', 'width=520,height=290,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=0,resizable=1'); newWindow.focus()" class="formtextsmall">Image Manager</a>
				</td>
			</tr>		
							
 <!--- Short Description --->
			<tr>
				<td align="RIGHT" valign="top">Text:</td>
				<td></td>
				<td align="left" colspan="3">		
				<cfset config = StructNew()>
				<cfset config.ImageBrowserURL = "../../../../index.cfm?fuseaction=home.admin&select=image&fieldname=fckeditor&dirname=/products&user=#attributes.user_ID#">	
				<!--- If this is a demo store, don't allow link or flash uploads for security --->
				<cfif Request.DemoMode>
					<cfset config.LinkBrowser = "false">
					<cfset config.FlashBrowser = "false">
				<cfelse>
					<cfset config.LinkBrowserURL = "../../../../index.cfm?fuseaction=home.admin&select=image&type=File&fieldname=fckeditor&user=#attributes.user_ID#">
					<cfset config.FlashBrowser = "../../../../index.cfm?fuseaction=home.admin&select=image&type=Flash&dirname=/flash&fieldname=fckeditor&user=#attributes.user_ID#">		
				</cfif>				
				<cfmodule 
					template="../../../customtags/fckeditor/fckeditor.cfm" 
					instanceName="short_desc"
					height="150" 						
					toolbarSet="Basic" 
					config="#config#"
					Value="#attributes.Short_Desc#"
					/>
				</td>
			</tr>
			
			
 <!--- Listing Title --->
			<tr>
				<td align="RIGHT" class="formtitle"><br/>Detail&nbsp;</td>
				<td colspan="4"><br/><cfmodule template="../../../customtags/putline.cfm" linetype="thin" linecolor="#Request.GetColors.InputHBgcolor#"/></td>
			</tr>
				
<!--- Large Title --->
			<tr>
				<td align="RIGHT">Title Image:</td>
				<td></td>
				<td colspan="3"><input type="text" name="Lg_Title" size="33" maxlength="100" class="formfield" value="#attributes.Lg_Title#"/> <a href="JavaScript: newWindow = openWin('#self#?fuseaction=home.admin&select=image&fieldname=Lg_Title&fieldvalue=#attributes.Lg_Title#&dirname=/products&user=#attributes.user_ID#', 'images', 'width=520,height=290,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=0,resizable=1'); newWindow.focus()" class="formtextsmall">Image Manager</a>
				</td>
			</tr>		
			
 <!--- Large Image --->
			<tr>
				<td align="RIGHT" valign="top">Image:</td>
				<td></td>
				<td colspan="3">
				<input type="text" name="Lg_Image" size="33" maxlength="255" class="formfield" value="#attributes.Lg_Image#"/>
				<cfif ListLen(attributes.Lg_Image)>
					<cfset linkImage = ListGetAt(attributes.Lg_Image,1)>
				<cfelse>
					<cfset linkImage = attributes.Lg_Image>
				</cfif>
				<a href="JavaScript: newWindow = openWin('#self#?fuseaction=home.admin&select=image&fieldname=Lg_Image&fieldvalue=#linkImage#&dirname=/products&user=#attributes.user_ID#', 'images', 'width=520,height=290,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=0,resizable=1'); newWindow.focus()" class="formtextsmall">Image Manager</a><br/>
				<span class="formtextsmall">You can enter a comma separated list of images to rotate through different images.</span>
				</td>
			</tr>		
			
<!--- Enlarged Image --->
			<tr>
				<td align="RIGHT" valign="top">Enlargement:</td>
				<td></td>
				<td colspan="3"><input type="text" name="Enlrg_Image" size="33" maxlength="100" class="formfield" value="#attributes.Enlrg_Image#"/> <a href="JavaScript: newWindow = openWin('#self#?fuseaction=home.admin&select=image&fieldname=Enlrg_Image&fieldvalue=#attributes.Enlrg_Image#&dirname=/products&user=#attributes.user_ID#', 'images', 'width=520,height=290,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=0,resizable=1'); newWindow.focus()" class="formtextsmall">Image Manager</a><br/>
			<span class="formtextsmall">Enlarged view of the product that will pop up when the regular image is clicked on.<br/>
			Cannot be used if multiple product images entered.</span>
				</td>
			</tr>	
				
			
 <!--- Long Description --->
			<tr>
				<td colspan="5" align="center">		
				<br/>	
				<cfset config = StructNew()>
				<cfset config.ImageBrowserURL = "../../../../index.cfm?fuseaction=home.admin&select=image&fieldname=fckeditor&dirname=/products&user=#attributes.user_ID#">	
				<!--- If this is a demo store, don't allow link or flash uploads for security --->
				<cfif Request.DemoMode>
					<cfset config.LinkBrowser = "false">
					<cfset config.FlashBrowser = "false">
				<cfelse>
					<cfset config.LinkBrowserURL = "../../../../index.cfm?fuseaction=home.admin&select=image&type=File&fieldname=fckeditor&user=#attributes.user_ID#">
					<cfset config.FlashBrowser = "../../../../index.cfm?fuseaction=home.admin&select=image&type=Flash&dirname=/flash&fieldname=fckeditor&user=#attributes.user_ID#">		
				</cfif>			
				<cfmodule 
					template="../../../customtags/fckeditor/fckeditor.cfm" 
					instanceName="Long_Desc"
					height="500"
					config="#config#"
					Value="#attributes.Long_Desc#"
					/>
			</td>
			</tr>			
			
 			<!--- Parameters --->
			<tr>
				<td align="RIGHT" valign="baseline">Parameters:</td>
				<td></td>
		 <td colspan="3">
			<input type="text" name="Passparam" value="#attributes.Passparam#" size="40" maxlength="100" class="formfield"/>
			<!--- Product Reviews Parameters --->
			<br/><span class="formtextsmall">PubImagesTitle=text, RelatedProdTitle=text, RelatedFeatTitle=text </span>
			</td>
			</tr>

<!--- Title Tag --->
			<tr>
				<td align="RIGHT" valign="top">HTML Title:</td>
				<td></td>
		 		<td colspan="3"><input type="text" name="titletag" size="60" maxlength="255" class="formfield" value="#attributes.titletag#"/><br/>
				<span class="formtextsmall">Title tag when displaying the product detail page, for search engine placement.</span>
				</td>
			</tr>

 <!--- Metatag Description --->
			<tr>
				<td align="RIGHT" valign="top">Meta Description:</td>
				<td></td>
		 		<td colspan="3"><textarea name="metadescription" id="metadescription" cols="46" rows="2" class="formfield" wrap="VIRTUAL" onkeyup="CheckFieldLength(metadescription, 'charcount', 'remaining', 255);" onkeydown="CheckFieldLength(metadescription, 'charcount', 'remaining', 255);" onmouseout="CheckFieldLength(metadescription, 'charcount', 'remaining', 255);">#attributes.metadescription#</textarea>
				<br/>
				<span class="formtextsmall">Description heavy in key and title words used by search engines.</span><br/>
				<small><span id="charcount">#len(attributes.metadescription)#</span> characters entered.   |   
				<span id="remaining">#255-len(attributes.metadescription)#</span> characters remaining.</small><br/>
				</td>
			</tr>
			
 <!--- Keywords --->
			<tr>
				<td align="RIGHT" valign="top">Keywords:</td>
				<td></td>
		 		<td colspan="3"><textarea name="Keywords" id="Keywords" cols="46" rows="2" class="formfield" wrap="VIRTUAL" onkeyup="CheckFieldLength(Keywords, 'charcount2', 'remaining2', 255);" onkeydown="CheckFieldLength(Keywords, 'charcount2', 'remaining2', 255);" onmouseout="CheckFieldLength(Keywords, 'charcount2', 'remaining2', 255);">#attributes.Keywords#</textarea><br/>
				<span class="formtextsmall">A comma delimited list (keyword1,keyword2,...) used by search engines.</span><br/>
				<small><span id="charcount2">#len(attributes.keywords)#</span> characters entered.   |   
				<span id="remaining2">#255-len(attributes.keywords)#</span> characters remaining.</small><br/>
				</td>
			</tr>
			
			

			
<!--- Custom palette --->
			<tr>
				<td align="RIGHT">Custom Palette:</td>
				<td></td>
		 		<td colspan="3">
				<select name="color_id" size="1" class="formfield" class="formfield">
					<option value="" #doSelected(attributes.color_id,'')#>Default Palette</option>
					<cfloop query="qry_Get_Colors">
   						<cfif qry_Get_Colors.color_id IS NOT request.appsettings.color_id>
						<option value="#color_id#" #doSelected(attributes.color_id,qry_Get_Colors.color_id)#>#palette_name#</option>
						</cfif>
					</cfloop>
				</select>
				</td>
			</tr>
			
			
		<tr>
			<td colspan="2">&nbsp;</td>
			<td colspan="3"><br/>
			<input type="submit" name="frm_submit" value="#act_button#" class="formbutton"/> 			
			<input type="button" value="Cancel" onclick="CancelForm();" class="formbutton"/> 		
<cfif do is "edit">
		<input type="submit" name="frm_submit" value="Delete" class="formbutton" onclick="return confirm('Are you sure you want to delete this product?\n All associated information and options will be deleted.');"/>
</cfif>
	</td>
	
	</tr>
	</form>	

<cfprocessingdirective suppresswhitespace="no">
<script type="text/javascript">
objForm = new qForm("editform");

objForm.required("Name,display,Highlight,sale,hot");

objForm.Highlight.description = "new";

objForm.Priority.validateNumeric();
objForm.Priority.validateRange('0','9999');

qFormAPI.errorColor = "###Request.GetColors.formreq#";
</script>
</cfprocessingdirective>

<cfif attributes.do IS NOT "add" AND attributes.do IS NOT "copy">
<form action="#self#?fuseaction=product.admin&do=list#request.token2#" method="post">
	<tr>
		<td align="center" colspan="5">
<cfmodule template="../../../customtags/putline.cfm" linetype="thin" linecolor="#Request.GetColors.InputHBgcolor#" width="98%" /><br/>	
		<input type="hidden" name="act" value="choose"/>
		<input type="hidden" name="cid" value="#iif(len(attributes.cid),attributes.cid,0)#"/>
		<input type="submit" name="DONE" value="Back to Product List" class="formbutton"/><br/><br/>
		</td>
    </tr>
    </form>
</cfif>

</cfoutput>		
</cfmodule>	
	
