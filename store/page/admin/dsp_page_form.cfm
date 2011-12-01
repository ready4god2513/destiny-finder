
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Initialize the values for the form --->
<cfset fieldlist="page_url,Display,Page_title,PageAction,Page_name,sm_title,Lg_image,Lg_title,catcore_ID,Passparam,color_ID,PageText,Priority,system,href_attributes,accesskey,parent_id,title_priority,metadescription,keywords,titletag">	
		
<cfswitch expression="#do#">
			
	<cfcase value="add">
		<cfloop list="#fieldlist#" index="counter">
			<cfset setvariable("attributes.#counter#", "")>
		</cfloop>
		<cfset attributes.Page_ID = 0>
		<cfset attributes.Title_Priority = 0>
		<cfset action="#self#?fuseaction=Page.admin&do=act&mode=i">
		<cfset act_title="Insert Page">	
	</cfcase>
					
	<cfcase value="edit">
		<!--- Set the form fields to values retrieved from the record --->
		<cfloop list="#fieldlist#" index="counter">
			<cfset "attributes.#counter#" = evaluate("qry_get_page." & counter)>
		</cfloop>			
		<cfset action="#self#?fuseaction=Page.admin&do=act&mode=u">
		<cfset act_title="Update Page">
	</cfcase>

</cfswitch>

<cfinclude template="qry_get_pages.cfm">
<cfinclude template="../../access/admin/accesskey/qry_get_accesskeys.cfm">
<cfinclude template="../../admin/colors/qry_get_colors.cfm">
<cfinclude template="../../includes/imagepreview.js">
<cfinclude template="../../includes/charCount.js">

<cfquery name="qry_get_catCores"  datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	SELECT * FROM #Request.DB_Prefix#CatCore 
	WHERE Page = 1
</cfquery>

<cfprocessingdirective suppresswhitespace="no">
<script type="text/javascript">
	function NoDelete() {
		alert('This page has children under it, so cannot be deleted until they are moved.');
		return false;	
	}
</script>
</cfprocessingdirective>
		


<cfmodule template="../../customtags/format_admin_form.cfm"
	box_title="#act_title#"
	width="725"
	>

<cfoutput>
	<!--- Table --->
	<form name="editform" action="#action##request.token2#" method="post">
	<input type="hidden" name="Page_ID" value="#attributes.page_id#"/>

			
	<!--- Listing Title --->
		<tr>
			<td align="RIGHT" class="formtitle"><br/>Menu Listing&nbsp;</td>
			<td colspan="2"><br/><cfmodule template="../../customtags/putline.cfm" linetype="thin" linecolor="#Request.GetColors.InputHBgcolor#" /></td>
			</tr>
			
	<!--- Name --->
		<tr>
			<td align="RIGHT" width="23%">Name in menu:</td>
			<td style="background-color: ###Request.GetColors.formreq#;" width="3">&nbsp;</td>
			<td><input type="text" name="page_name" value="#HTMLEditFormat(attributes.Page_name)#" size="51" maxlength="100" class="formfield"/><br/>
			</td></tr>			
			
 	<!--- Small Title --->
		<tr>
			<td align="RIGHT">Menu Image:</td>
			<td></td>
			<td><input type="text" name="Sm_Title" size="33" maxlength="100" class="formfield" value="#attributes.Sm_Title#"/> 
<a href="JavaScript: newWindow = openWin('#self#?fuseaction=home.admin&select=image&fieldname=Sm_Title&fieldvalue=#attributes.Sm_Title#', 'images', 'width=520,height=290,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=0,resizable=1'); newWindow.focus()" class="formtextsmall">Image Manager</a>
			</td></tr>
			
		<!--- Internal Link --->
		<tr>
			<td align="RIGHT" valign="baseline">Shortcut Link:</td>
			<td></td>
			<td>
			<cfif attributes.system is 1>
			<strong>#attributes.pageAction#</strong> (system page, not editable)
			<input type="hidden" name="pageAction" value="#attributes.pageAction#"/>		
			<cfelse>
			<input type="text" name="pageAction" value="#attributes.pageAction#" size="33" maxlength="30" class="formfield"/>
			</cfif>
			<br/>
			<span class="formtextsmall">Shortcut page link in the form of 'fuseaction=page.shortcut'.</span>
			<br/>
			</td></tr>

	 <!--- Title --->
		<tr>
			<td align="RIGHT" valign="baseline">Link to URL:</td>
			<td></td>
			<td>			
			<cfif attributes.system is 1>
			#attributes.page_url# (system page, not editable)
			<input type="hidden" name="page_url" value="#attributes.page_url#"/>
			<cfelse>
			<input type="text" name="page_url" message="" value="#attributes.page_url#" size="51" maxlength="75" class="formfield"/><br/>
			<span class="formtextsmall">Leave blank to auto-fill this page. 'None' for no link.</span>
			</cfif>
			<br/>
			</td></tr>
			
	 <!--- Title --->
		<tr>
			<td align="RIGHT" valign="baseline">HREF Attributes:</td>
			<td></td>
			<td>
			
			<input type="text" name="href_attributes" value="#HTMLEditFormat(attributes.href_attributes)#" size="33" maxlength="50" class="formfield"/><br/>
			<span class="formtextsmall">(eg: target='_blank' to open page in new window)</span>
			<br/>
			</td></tr>

	<!--- Display --->
		<tr>
			<td align="RIGHT">Display in Menu:</td>
			<td></td>
			<td><input type="radio" name="Display" value="1" #doChecked(attributes.Display)# /> Yes  
			&nbsp;&nbsp;<input type="radio" name="Display" value="0" #doChecked(attributes.Display,0)# /> No
			</td></tr>
			
 	<!--- Submenu of (parent_ID) --->
			<tr>
				<td align="RIGHT">Menu Position:</td>
				<td></td>
				<td>
				<select name="Parent_id" class="formfield">
				<option value="0" #doSelected(attributes.Parent_id,0)#>Default Page Menu</option>
				<option value="HEADER" #doSelected(attributes.Title_Priority)#>
				Make this a Header Menu</option>
				<cfloop query="qry_get_Pages">
					<cfif page_id is not attributes.page_id AND page_id is not 0 AND title_priority is not 0>
						<option value="#Page_ID#" #doSelected(attributes.Parent_id,qry_get_Pages.Page_ID)#>
						<cfif page_id>List Under </cfif>#page_name#</option>
					</cfif>
				</cfloop>
				</select>			
			</td>
			</tr>	
			
	<!--- priority --->
		<tr>
			<td align="RIGHT">Priority:</td>
			<td></td>
			<td>
			<cfif attributes.Parent_id is attributes.page_id>
			<cfset attributes.priority = attributes.title_priority></cfif>
			<input type="text" name="Priority" class="formfield" value="#doPriority(attributes.Priority,0)#" size="4" maxlength="10"/> <span class="formtextsmall">(1 is highest, 0 is none)</span>
			</td></tr>
			
 <!--- Access Key --->
			<tr>
				<td align="RIGHT">Access Key:</td>
				<td></td>
				<td>
				<!--- Hide if the Member's Only page --->
				<cfif attributes.Page_ID IS NOT 7>
					<select name="AccessKey" class="formfield">
					<option value="0" #doSelected(attributes.accesskey,0)#>none</option>
					<cfloop query="qry_get_accesskeys">
					<option value="#accesskey_ID#" #doSelected(attributes.accesskey,qry_get_accesskeys.accesskey_ID)#>#name#</option>
					</cfloop>
					</select>		
				<cfelse>
					Not available for this page
					<input type="hidden" name="AccessKey" value="#attributes.accesskey#"/>
				</cfif>	
			</td>
			</tr>
								
	<!--- Listing Title --->
		<tr>
			<td align="RIGHT" class="formtitle"><br/>Page Content&nbsp;</td>
			<td colspan="2"><br/><cfmodule template="../../customtags/putline.cfm" linetype="thin" linecolor="#Request.GetColors.InputHBgcolor#" /></td>
			</tr>
				
			
	<!--- Page_title --->
		<tr>
			<td align="RIGHT">Title on Page:</td>
			<td></td>
			<td><input type="text" name="page_title" message=""  value="#HTMLEditFormat(attributes.Page_title)#" size="51" maxlength="75" class="formfield"/><br/>
			</td></tr>
			
	<!--- Large Title --->
		<tr>
			<td align="RIGHT">Title Image:</td>
			<td></td>
			<td><input type="text" name="Lg_Title" size="33" maxlength="100" class="formfield" value="#attributes.Lg_Title#"/> <a href="JavaScript: newWindow = openWin('#self#?fuseaction=home.admin&select=image&fieldname=Lg_Title&fieldvalue=#attributes.Lg_Title#', 'images', 'width=520,height=290,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=0,resizable=1'); newWindow.focus()" class="formtextsmall">Image Manager</a>
			</td></tr>		
			
	<!--- Large Image --->
		<tr>
			<td align="RIGHT">Image:</td>
			<td></td>
			<td><input type="text" name="Lg_Image" size="33" maxlength="100" class="formfield" value="#attributes.Lg_Image#"/> <a href="JavaScript: newWindow = openWin('#self#?fuseaction=home.admin&select=image&fieldname=Lg_Image&fieldvalue=#attributes.Lg_Image#', 'images', 'width=520,height=290,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=0,resizable=1'); newWindow.focus()" class="formtextsmall">Image Manager</a>
			</td></tr>			
			
	<!--- Long Description --->
		<tr>
			<td colspan="3" align="center">							
				<br/>
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
					instanceName="PageText"
					height="500" 
					config="#config#"
					Value="#attributes.PageText#"
					/>
			</td>
			</tr>
			
 <!--- Template --->
	<tr>
			<td align="RIGHT">Template:</td>
			<td></td>
			<td>
			<select name="Catcore_ID" class="formfield">			
				<option value="" #doSelected('')#>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>
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
			<input type="text" name="Passparam" value="#attributes.PassParam#" size="50" maxlength="100" class="formfield"/>
			<cfif isdefined("qry_get_page.passparams") and len(qry_get_page.passparams)>
			<br/><span class="formtextsmall">#qry_get_page.PassParams#</span>
			</cfif>

			</td></tr>
			
<!--- Title Tag --->
			<tr>
				<td align="RIGHT" valign="top">HTML Title:</td>
				<td></td>
		 		<td><input type="text" name="titletag" size="60" maxlength="255" class="formfield" value="#attributes.titletag#"/><br/>
				<span class="formtextsmall">Title tag when displaying this page, for search engine placement.</span>
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
			
			
	<!--- Custom palette --->
		<tr>
			<td align="RIGHT">Custom Palette:</td>
			<td></td>
	 		<td>
				<select name="color_id" size="1" class="formfield">
					<option value="" #doSelected(attributes.color_id,'')#>Default Palette</option>
					<cfloop query="qry_Get_Colors">
   						<cfif qry_Get_Colors.color_id IS NOT request.appsettings.color_id>
						<option value="#color_id#" #doSelected(attributes.color_id,qry_Get_Colors.color_id)#>#palette_name#</option>
						</cfif>
					</cfloop>
				</select>
			</td></tr>

		<tr>
			<td colspan="2">&nbsp;</td>
			<td><br/>
			<input type="submit" name="frm_submit" value="#act_title#" class="formbutton"/> 			
			<input type="button" value="Cancel" onclick="javascript:window.history.go(-1);" class="formbutton"/> 		
<cfif attributes.do is "edit" and qry_get_Page.system is not 1>
	<cfif qry_get_children.recordcount>
		<input type="button" name="JS" value="Delete" onclick="javascript:NoDelete();" class="formbutton"/>
	<cfelse>
		<input type="submit" name="frm_submit" value="Delete" class="formbutton" onclick="return confirm('Are you sure you want to delete this page?');"/>
	</cfif>
</cfif>
	</td>
	
	</tr>

	</form>	

</cfoutput>
</cfmodule>

<cfoutput>
<cfprocessingdirective suppresswhitespace="no">
<script type="text/javascript">
objForm = new qForm("editform");

objForm.required("page_name,Display");
objForm.Priority.description = "priority";
objForm.page_name.description = "page name";

objForm.Priority.validateNumeric();
objForm.Priority.validateRange('0','9999');

qFormAPI.errorColor = "###Request.GetColors.formreq#";
</script>
</cfprocessingdirective>
</cfoutput>
