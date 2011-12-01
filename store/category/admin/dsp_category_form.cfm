
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the form to add and edit categories. Called by category.admin&category=add|edit --->

<cfinclude template="../../access/admin/accesskey/qry_get_accesskeys.cfm">
<cfinclude template="qry_get_catcores.cfm">

<cfinclude template="../../admin/colors/qry_get_colors.cfm">
<cfinclude template="../qry_get_cat_picklist.cfm">
<cfinclude template="qry_get_discounts.cfm">
<cfinclude template="qry_get_cat_discounts.cfm">

<cfset CurrDiscounts = ValueList(qry_Get_Cat_Discounts.Discount_ID)>
<cfset DiscountList = ValueList(qry_Get_Discounts.Discount_ID)>

<cfparam name="attributes.pid" default="0">
<cfset thispath = getcurrenttemplatepath()>
<cfset thisdirectory = getdirectoryfrompath(thispath)>

<!--- Initialize the values for the form --->
<cfset fieldlist="Catcore_ID,Name,Short_Desc,Long_Desc,Sm_Image,Lg_Image,Sm_Title,Lg_Title,Passparam,AccessKey,CColumns,PColumns,color_id,ProdFirst,Display,Priority,Highlight,sale,DateAdded,parentnames,metadescription,keywords,titletag">	
		
<cfswitch expression="#category#">
			
	<cfcase value="add">
		<cfloop list="#fieldlist#" index="counter">
			<cfset setvariable("attributes.#counter#", "")>
		</cfloop>
				
		<cfset attributes.CID = 0>
		<!--- Radio button defaults --->
		<cfset attributes.Highlight = 0>
		<cfset attributes.Sale = 0>
		<cfset attributes.ProdFirst = 0>
		<!--- Default page template --->
		<cfset attributes.Catcore_ID = 8>
		
		
		<cfset action="#self#?fuseaction=Category.admin&category=act&mode=i">
	    <cfset act_title="Add Category">
							
	</cfcase>
					
	<cfcase value="edit">
		<!--- Set the form fields to values retrieved from the record --->
		<cfloop list="#fieldlist#" index="counter">
			<cfset "attributes.#counter#" = evaluate("qry_get_category." & counter)>
		</cfloop>
				
		<cfset attributes.pid = qry_get_category.parent_id>
		<cfset action="#self#?fuseaction=Category.admin&Category=act&mode=u">
		<cfset act_title="Update Category">
	
	</cfcase>
</cfswitch>	
		

<cfinclude template="../../includes/imagepreview.js">
<cfinclude template="../../includes/charCount.js">
		
		
<cfoutput><form name="editform" action="#action##request.token2#" id="editform" method="post"></cfoutput>

<cfmodule template="../../customtags/format_admin_form.cfm"
	box_title="#act_title#"
	width="700"
	>
	
<cfoutput>

<!--- Parent ID --->
			<tr>
				<td align="RIGHT" width="20%">Category ID:</td>
				<td width="4">&nbsp;</td>
				<td>
				<cfif attributes.CID>
					#attributes.CID#
				<cfelse>
					NEW
				</cfif>
				<input type="hidden" name="CID" value="#attributes.CID#"/></td>
			</tr>

 <!--- Name --->
			<tr>
				<td align="RIGHT">Name:</td>
	
				<td style="background-color: ###Request.GetColors.formreq#;" width="3">&nbsp;</td>
		 <td>
			<input type="text" name="Name" value="#HTMLEditFormat(attributes.Name)#" size="40" maxlength="100" class="formfield"/>
			</td>
			</tr>
			
<!--- Parent ID --->
			<tr>
				<td align="RIGHT">Under Category:</td>
				<td></td>
				<td>
				<select name="PID"  class="formfield">
				<option value="0" #doSelected(attributes.pid,0)#>&raquo;</option>
				<cfloop query="qry_get_cat_picklist">
				<!--- Make sure the category cannot be listed underneath itself --->
				<cfif Not ListFind(ParentIDs, attributes.CID) AND Category_ID IS NOT attributes.CID>
				    <option value="#Category_ID#" class="formfield" #doSelected(attributes.pid,category_ID)#>
					&raquo;<cfif parentnames is not ""><cfif len(parentnames) gt 48>...</cfif>#Right(replace(parentnames,':','&raquo;'),45)#&raquo;</cfif>#Name#</option>
				 </cfif>
				</cfloop>
	 			</select>
				</td>
			</tr>		
			
 <!--- Display --->
			<tr>
				<td align="RIGHT">Display:</td>	
				<td></td>
				<td><input type="radio" name="Display" value="1" #doChecked(attributes.Display)# /> Yes  
				&nbsp;&nbsp;<input type="radio" name="Display" value="0" #doChecked(attributes.Display,0)# /> No<br/>
				<span class="formtextsmall">Turning off the category will also hide all products assigned to it.</span>
				</td>
			</tr>
			
 <!--- Highlight --->
			<tr>
				<td align="RIGHT">New:</td>	
				<td></td>
				<td><input type="radio" name="Highlight" value="1" #doChecked(attributes.Highlight)# /> Yes  
				&nbsp;&nbsp;<input type="radio" name="Highlight" value="0" #doChecked(attributes.Highlight,0)# /> No
				</td>
			</tr>
			
 <!--- Sale --->
			<tr>
				<td align="RIGHT">Sale:</td>	
				<td></td>
				<td><input type="radio" name="Sale" value="1" #doChecked(attributes.Sale)# /> Yes  
				&nbsp;&nbsp;<input type="radio" name="Sale" value="0" #doChecked(attributes.Sale,0)# /> No
				</td>
			</tr>
			
 <!--- Priority --->
			<tr>
				<td align="RIGHT">Priority:</td>
				<td></td>
				<td><input type="text" name="Priority" value="#doPriority(attributes.Priority,0)#" size="4" maxlength="10" class="formfield"/><span class="formtextsmall"> (1 is highest, 0 is none)</span>
				</td>
			</tr>
			
 <!--- Access Key --->
			<tr>
				<td align="RIGHT" valign="top"><br/>Access Key:</td>
				<td></td>
				<td><br/>
				<select name="AccessKey" class="formfield">
				<option value="0" #doSelected(attributes.accesskey,0)#>none</option>
				<cfloop query="qry_get_accesskeys">
				<option value="#accesskey_ID#" #doSelected(attributes.accesskey,qry_get_accesskeys.accesskey_ID)#>#name#</option>
				</cfloop>
				</select>	<br/>
				<span class="formtextsmall">The access key will also be applied to all products and features in this category.</span>		
			</td>
			</tr>

 <!--- Listing Title --->
			<tr>
				<td align="RIGHT" class="formtitle"><br/>Teaser&nbsp;</td>
				<td colspan="2"><br/><cfmodule template="../../customtags/putline.cfm" linetype="thin" linecolor="#Request.GetColors.InputHBgcolor#"/></td>
			</tr>
 			
 <!--- Small Title --->
			<tr>
				<td align="RIGHT">Title Image:</td>
				<td></td>
				<td><input type="text" name="Sm_Title" size="33" maxlength="100" value="#attributes.Sm_Title#" class="formfield"/> <a href="JavaScript: newWindow = openWin('#self#?fuseaction=home.admin&select=image&fieldname=Sm_Title&fieldvalue=#attributes.Sm_Title#', 'images', 'width=520,height=290,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=0,resizable=1'); newWindow.focus()" class="formtextsmall">Image Manager</a>
				</td>
			</tr>
			
 <!--- Small Image --->
			<tr>
				<td align="RIGHT">Image:</td>
				<td></td>
<td><input type="text" name="Sm_Image" size="33" maxlength="100" value="#attributes.Sm_Image#" class="formfield"/> <a href="JavaScript: newWindow = openWin('#self#?fuseaction=home.admin&select=image&fieldname=Sm_Image&fieldvalue=#attributes.Sm_Image#', 'images', 'width=520,height=290,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=0,resizable=1'); newWindow.focus()" class="formtextsmall">Image Manager</a>
				</td>
			</tr>		
							
 <!--- Short Description --->
			<tr>
				<td align="RIGHT" valign="top">Text:</td>
				<td></td>
				<td align="left">		
				<!--- If this is a demo store, don't allow link or flash uploads for security --->
				<cfset config = StructNew()>
				<cfif Request.DemoMode>
					<cfset config.LinkBrowser = "false">
				<cfelse>
					<cfset config.LinkBrowserURL = "../../../index.cfm?fuseaction=home.admin&select=image&type=File&fieldname=fckeditor">	
				</cfif>	
				<cfmodule 
					template="../../customtags/fckeditor/fckeditor.cfm" 
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
				<td align="RIGHT" class="formtitle"><br/>Heading&nbsp;</td>
				<td colspan="2"><br/><cfmodule template="../../customtags/putline.cfm" linetype="thin" linecolor="#Request.GetColors.InputHBgcolor#"/></td>
			</tr>
				
<!--- Large Title --->
			<tr>
				<td align="RIGHT">Title Image:</td>
				<td></td>
				<td><input type="text" name="Lg_Title" size="33" maxlength="100" class="formfield" value="#attributes.Lg_Title#"/> <a href="JavaScript: newWindow = openWin('#self#?fuseaction=home.admin&select=image&fieldname=Lg_Title&fieldvalue=#attributes.Lg_Title#', 'images', 'width=520,height=290,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=0,resizable=1'); newWindow.focus()" class="formtextsmall">Image Manager</a>
				</td>
			</tr>		
			
 <!--- Large Image --->
			<tr>
				<td align="RIGHT">Image:</td>
				<td></td>
				<td><input type="text" name="Lg_Image" size="33" maxlength="100" class="formfield" value="#attributes.Lg_Image#"/> <a href="JavaScript: newWindow = openWin('#self#?fuseaction=home.admin&select=image&fieldname=Lg_Image&fieldvalue=#attributes.Lg_Image#', 'images', 'width=520,height=290,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=0,resizable=1'); newWindow.focus()" class="formtextsmall">Image Manager</a>
				</td>
			</tr>			
	
 <!--- Long Description --->
			<tr>
				<td colspan="3" align="center"><br/>
				<!--- If this is a demo store, don't allow link or flash uploads for security --->
				<cfset config = StructNew()>
				<cfif Request.DemoMode>
					<cfset config.LinkBrowser = "false">
					<cfset config.FlashBrowser = "false">
				<cfelse>
					<cfset config.LinkBrowserURL = "../../../../index.cfm?fuseaction=home.admin&select=image&type=File&fieldname=fckeditor">
					<cfset config.FlashBrowser = "../../../../index.cfm?fuseaction=home.admin&select=image&type=Flash&dirname=/flash&fieldname=fckeditor">		
				</cfif>	
				<cfmodule 
					template="../../customtags/fckeditor/fckeditor.cfm" 
					instanceName="Long_Desc"
					height="500" 
					config="#config#"
					Value="#attributes.Long_Desc#"
					/>
			</td>
			</tr>
<!--- Line --->
			<tr>
				<td align="RIGHT" class="formtitle"><br/>Content&nbsp;</td>
				<td colspan="2"><br/><cfmodule template="../../customtags/putline.cfm" linetype="thin" linecolor="#Request.GetColors.InputHBgcolor#"/></td>
			</tr>				
			
 <!--- Format --->
			<tr>
				<td align="RIGHT">Template:</td>
				<td style="background-color: ###Request.GetColors.formreq#;"></td>
		<td>
			<select name="Catcore_ID" class="formfield">	
				<option value="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>			
				<cfloop query="qry_get_catCores">
				<option value="#Catcore_ID#" #doSelected(attributes.Catcore_ID,qry_get_catCores.Catcore_ID)#>#Catcore_Name#</option>
				</cfloop>
				</select>		
			</td>
			</tr>			
			
 <!--- Parameters --->
			<tr>
				<td align="RIGHT" valign="baseline">Parameters:</td>
				<td></td>
		 <td>
			<input type="text" name="Passparam" class="formfield" value="#attributes.Passparam#" size="40" maxlength="100"/>
			<cfif isdefined("qry_get_category.passparams") and len(qry_get_category.Passparams)>
			<br/>(<span class="formtextsmall">#qry_get_category.PassParams#)</span>
			</cfif>
			</td>
			</tr>

<!--- discounts --->
<cfif qry_get_discounts.RecordCount>
			<tr>
				<td align="RIGHT">Discounts:<br/><br/></td>
				<td></td>
				<td>
<select name="Discounts" class="formfield" size="#iif(qry_get_discounts.RecordCount LT 5,qry_get_discounts.RecordCount + 1,5)#" multiple="multiple">
	<option value="" #doSelected(Len(CurrDiscounts),0)#>None</option>
	<cfloop query="qry_get_discounts">
	<option value="#Discount_ID#" #doSelected(ListFind(CurrDiscounts, qry_get_discounts.Discount_ID))#>#Name#</option>
	</cfloop>
	</select>	</td>
			</tr>
</cfif>	
<input type="hidden" name="DiscountList" value="#DiscountList#"/>
<input type="hidden" name="CurrDiscounts" value="#CurrDiscounts#"/>
			
 <!--- Display Content before Subcategories --->
			<tr>
				<td align="RIGHT">Display First:</td>
				<td></td>
				<td><input type="radio" name="ProdFirst" value="0" #doChecked(attributes.ProdFirst,0)# /> Subcategories  
				&nbsp; <input type="radio" name="ProdFirst" value="1" #doChecked(attributes.ProdFirst)# /> Content
				</td>
			</tr>			
			
 <!--- Category Columns --->
			<tr>
				<td align="RIGHT">Custom Columns:</td>
	
				<td></td>
		 <td>
			<input type="text" name="CColumns"  class="formfield" value="#attributes.CColumns#"  size="3" maxlength="10"/> Sub-cats &nbsp; 
			<input type="text" name="PColumns" message=""  value="#attributes.PColumns#" required="NO" size="3" maxlength="10" class="formfield"/> Content
			</td>
			</tr>
			
<!--- Custom palette --->
			<tr>
				<td align="RIGHT">Custom Palette:</td>
				<td></td>
		 		<td>
				<select name="color_id" size="1"  class="formfield">
					<option value="" #doSelected(attributes.color_id,'')#>Default Palette</option>
					<cfloop query="qry_Get_Colors">
   						<cfif qry_Get_Colors.color_id IS NOT request.appsettings.color_id>
						<option value="#color_id#" #doSelected(attributes.color_id,qry_Get_Colors.color_id)#>#palette_name#</option>
						</cfif>
					</cfloop>
				</select>
				</td>
			</tr>
			
	<!--- Title Tag --->
			<tr>
				<td align="RIGHT" valign="top">HTML Title:</td>
				<td></td>
		 		<td><input type="text" name="titletag" size="60" maxlength="255" class="formfield" value="#attributes.titletag#"/><br/>
				<span class="formtextsmall">Title tag when displaying the category, for search engine placement.</span>
				</td>
			</tr>	
			
 <!--- Metatag Description --->
			<tr>
				<td align="RIGHT" valign="top">Meta Description:</td>
				<td></td>
		 		<td><textarea name="metadescription" id="metadescription" cols="46" rows="2" class="formfield" wrap="VIRTUAL" onkeyup="CheckFieldLength(metadescription, 'charcount', 'remaining', 255);" onkeydown="CheckFieldLength(metadescription, 'charcount', 'remaining', 255);" onmouseout="CheckFieldLength(metadescription, 'charcount', 'remaining', 255);">#attributes.metadescription#</textarea>
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
		 		<td><textarea name="Keywords" id="Keywords" cols="46" rows="2" class="formfield" wrap="VIRTUAL" onkeyup="CheckFieldLength(Keywords, 'charcount2', 'remaining2', 255);" onkeydown="CheckFieldLength(Keywords, 'charcount2', 'remaining2', 255);" onmouseout="CheckFieldLength(Keywords, 'charcount2', 'remaining2', 255);">#attributes.Keywords#</textarea><br/>
				<span class="formtextsmall">A comma delimited list (keyword1,keyword2,...) used by search engines.</span><br/>
				<small><span id="charcount2">#len(attributes.keywords)#</span> characters entered.   |   
				<span id="remaining2">#255-len(attributes.keywords)#</span> characters remaining.</small><br/>
				</td>
			</tr>
						
		<tr>
			<td colspan="2">&nbsp;</td>
			<td><br/>
			<input type="submit" name="frm_submit" value="#act_title#" class="formbutton"/> 			
			<input type="button" value="Cancel" onclick="javascript:window.history.go(-1);" class="formbutton"/>	
<cfif category is "edit">
		<input type="submit" name="frm_submit" value="Delete" class="formbutton"  onclick="return confirm('Are you sure you want to delete this category?');"/>
</cfif>
	</td>
	
	</tr>
</cfoutput>
	</cfmodule>
	</form>	

<cfprocessingdirective suppresswhitespace="no">
<script type="text/javascript">
objForm = new qForm("editform");

objForm.required("Name,Catcore_ID,Display,Highlight,Sale,ProdFirst");
objForm.Priority.description = "priority";
objForm.Highlight.description = "new";
objForm.ProdFirst.description = "display first";
objForm.PColumns.description = "content columns";
objForm.CColumns.description = "sub-category columns";
objForm.Catcore_ID.description = "category template";

objForm.Priority.validateNumeric();
objForm.Priority.validateRange('0','9999');
objForm.PColumns.validateRange('1','6');
objForm.CColumns.validateRange('1','6');

<cfoutput>
qFormAPI.errorColor = "###Request.GetColors.formreq#";
</cfoutput>

</script>
</cfprocessingdirective> 
