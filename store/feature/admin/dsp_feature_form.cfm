
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the form to add and edit features. Called by feature.admin&feature=add|edit --->

<cfinclude template="../../queries/qry_getpicklists.cfm">
<cfinclude template="../../access/admin/accesskey/qry_get_accesskeys.cfm">
<cfinclude template="../../admin/colors/qry_get_colors.cfm">

<cfset attributes.permissions = "FEATURE">
<cfinclude template="../../users/qry_get_users.cfm">

<cfset attributes.catcore_content = "Features">
<cfinclude template="../../category/qry_get_cat_picklist.cfm">

<cfparam name="attributes.cid" default="">

<!--- Initialize the values for the form --->
<cfset fieldlist="feature_type,Name,Author,copyright,display,approved,start,expire,priority,accesskey,highlight,reviewable,display_title,Sm_Title,Sm_image,short_desc,lg_title,lg_image,long_desc,passparam,Color_iD,Created,metadescription,keywords,titletag">	
		
		<cfswitch expression="#feature#">
			
			<cfcase value="add">
				<cfloop list="#fieldlist#" index="counter">
					<cfset setvariable("attributes.#counter#", "")>
				</cfloop>
				<cfset attributes.Feature_id = 0>
				<cfset attributes.cid_list = attributes.cid>
				<cfset attributes.uid = Session.User_ID>
				
				<!--- Radio button defaults --->
				<cfset attributes.Highlight = 0>
		
				<cfset action="#self#?fuseaction=Feature.admin&Feature=act&mode=i">
			    <cfset act_title="Insert Feature">	
			</cfcase>
					
			<cfcase value="edit">
				<!--- Set the form fields to values retrieved from the record --->
				<cfloop list="#fieldlist#" index="counter">
					<cfset "attributes.#counter#" = evaluate("qry_get_feature." & counter)>
				</cfloop>
				<cfset attributes.uid = qry_get_Feature.user_id>
				<cfset action="#self#?fuseaction=Feature.admin&Feature=act&mode=u">
				<cfset act_title="Update Feature - #qry_get_feature.name#">
				<cfinclude template="qry_get_feature_cats.cfm">
				<cfset attributes.cid_list = valuelist(qry_get_Feature_cats.category_id)>
			</cfcase>
		</cfswitch>
		
<cfinclude template="../../includes/imagepreview.js">
<cfinclude template="../../includes/charCount.js">
		
<cfmodule template="../../customtags/format_output_admin.cfm"
	box_title="#act_title#"
	Width="700"
	menutabs="yes">


	<cfif attributes.feature is "edit">
		<cfinclude template="dsp_tab_menu.cfm">
	</cfif>
	
<cfoutput>
	<!--- Table --->
	<table border="0" cellpadding="0" cellspacing="4" width="100%" class="formtext" 
	style="color:###Request.GetColors.InputTText#">
	<form name="editform" action="#action#<cfif len(attributes.cid)>&cid=#attributes.cid#</cfif>#request.token2#" method="post">
	
<!--- Feature ID --->
			<tr>
				<td align="RIGHT" width="20%">Feature ID:</td>
				<td width="4">&nbsp;</td>
				<td>
				<cfif attributes.feature_iD>
					#attributes.Feature_ID#
				<cfelse>
					NEW
				</cfif>
				<input type="hidden" name="Feature_id" value="#attributes.feature_id#"/></td>
			</tr>

<!--- User_ID --->
	<cfparam name="ispermitted" default=1>
	<cfmodule template="../../access/secure.cfm"
	keyname="feature"
	requiredPermission="1,2"
	>
	<cfif ispermitted>		
	 	<tr>
			<td align="RIGHT">User:</td>
			<td style="background-color: ###Request.GetColors.formreq#;" width="3">&nbsp;</td>
			<td>

		 		<select name="UID" class="formfield">
				<option value="-1" #doSelected(feature,'add')#>select user...</option>
				<cfloop query="qry_get_users">
				<option value="#user_ID#" #doSelected(attributes.uid,qry_get_users.user_ID)#>#username#</option>
				 </cfloop>
				 </select>
			</td>
		</tr>
	<cfelse>
		<cfif feature is "add">
			<input type="hidden" name="UID" value="#Session.User_ID#"/>
		<cfelse>
			<input type="hidden" name="UID" value="#attributes.uid#"/>
		</cfif>
	</cfif>
			
 <!--- Type --->
			<tr>
				<td align="RIGHT">Type:</td>
				<td></td>
				<td>
			<select name="feature_type" size="1" class="formfield">
			<option value="" #doSelected(attributes.feature_type,'')#></option>
			<cfmodule template="../../customtags/form/dropdown.cfm"
			mode="valuelist"
			valuelist="#qry_getpicklists.feature_type#"
			selected="#attributes.feature_type#"
			>
	 		</select>
			</td>
			</tr>
			
 <!--- Title --->
			<tr>
				<td align="RIGHT">Title:</td>
				<td style="background-color: ###Request.GetColors.formreq#;"></td>
		 		<td><input type="text" name="Name" class="formfield" value="#HTMLEditFormat(attributes.Name)#" size="50" maxlength="100"/></td>
			</tr>
			
 <!--- Author --->
			<tr>
				<td align="RIGHT">Author:</td>
				<td></td>
				<td><input type="text" name="Author" value="#HTMLEditFormat(attributes.Author)#" class="formfield" size="50" maxlength="100"/></td>
			</tr>
			
 <!--- Copyright --->
			<tr>
				<td align="RIGHT">Copyright:</td>
				<td></td>
				<td><input type="text" name="copyright" value="#HTMLEditFormat(attributes.copyright)#" class="formfield" size="50" maxlength="100"/></td>
			</tr>
			
<!--- created --->
			<tr>
				<td align="RIGHT">Date:</td>
				<td></td>
				<td><cfmodule template="../../customtags/calendar_input.cfm" ID="calcreated" formfield="created" formname="editform" value="#dateformat(attributes.created,"mm/dd/yyyy")#" size="15" browser="#browsername#" bversion="#browserversion#" />
			</td>
			</tr>
			
<!--- Listing Title --->
			<tr>
				<td align="RIGHT" class="formtitle"><br/>Display&nbsp;</td>
				<td colspan="2"><br/><cfmodule template="../../customtags/putline.cfm" linetype="thin" linecolor="#Request.GetColors.InputHBgcolor#"/></td>
			</tr>
			
 <!--- Category_id --->		
			<tr>
				<td align="RIGHT">Category:</td>
				<td style="background-color: ###Request.GetColors.formreq#;"></td>
				<td>
			 	<select name="CID_list" size="3" multiple="multiple" class="formfield">				
				<cfloop query="qry_get_cat_picklist">
				<option value="#category_id#" #doSelected(ListFind(attributes.cid_list,category_ID))#>
				&raquo;<cfif parentnames is not ""><cfif len(parentnames) gt 100>...</cfif>#Right(replace(parentnames,':','&raquo;'),100)#&raquo;</cfif>#Name#</option>
				</cfloop>
	 			</select>		
				</td>
			</tr>
			
 <!--- display --->
			<tr>
				<td align="RIGHT">Display:</td>
				<td></td>
			 	<td><input type="radio" name="Display" value="1" #doChecked(attributes.Display)# /> Yes  
				&nbsp;&nbsp;<input type="radio" name="Display" value="0" #doChecked(attributes.Display,0)# /> No
				</td>
			</tr>
			
 <!--- approved --->
			<tr>
				<td align="RIGHT">Approved:</td>
				<td></td>
				<td>
				<!--- Set IsPermitted to feature_approve permission ---->
				<cfmodule template="../../access/secure.cfm"
				keyname="feature"
				requiredPermission="2"
				>
				 
				<cfif ispermitted>
					<input type="radio" name="approved" value="1" #doChecked(attributes.approved)# /> Yes  
					&nbsp;&nbsp;<input type="radio" name="approved" value="0" #doChecked(attributes.approved,0)# /> No
				
				<cfelse>
					<input type="hidden" name="approved" value="0"/>
					<cfif attributes.approved IS NOT "No">yes<cfelse>no</cfif>		
				</cfif>
						
				</td>
			</tr>
			
 <!--- start --->
			<tr>
				<td align="RIGHT">Start:</td>
				<td></td>
				<td><cfmodule template="../../customtags/calendar_input.cfm" ID="calstart" formfield="start" formname="editform" value="#dateformat(attributes.start,"mm/dd/yyyy")#" size="15" browser="#browsername#" bversion="#browserversion#" /></td>
			</tr>
			
 <!--- expire --->
			<tr>
				<td align="RIGHT">Expire:</td>
				<td></td>
				<td><cfmodule template="../../customtags/calendar_input.cfm" ID="calend" formfield="expire" formname="editform" value="#dateformat(attributes.expire,"mm/dd/yyyy")#" size="15" browser="#browsername#" bversion="#browserversion#" /></td>
			</tr>
			
 <!--- priority --->
			<tr>
				<td align="RIGHT">Priority:</td>
				<td></td>
				<td><input type="text" name="Priority" class="formfield" value="#doPriority(attributes.Priority,0)#" size="4" maxlength="10"/><span class="formtextsmall"> (1 is highest, 0 is none)</span>
				</td>
			</tr>
			
 <!--- AccessKey --->
			<tr>
				<td align="RIGHT">AccessKey:</td>
				<td></td>
				<td>
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
			</tr>
			
 <!--- Reviewable --->
			<tr>
				<td align="RIGHT">Allow Comments:</td>
				<td></td>
				<td><input type="radio" name="Reviewable" value="1" #doChecked(attributes.Reviewable)# /> Yes  
				&nbsp;&nbsp;<input type="radio" name="Reviewable" value="0" #doChecked(attributes.Reviewable,0)# /> No
				</td>
			</tr>
			
			
<!--- Listing Title --->
			<tr>
				<td align="RIGHT" class="formtitle"><br/>Teaser Listing&nbsp;</td>
				<td colspan="2"><br/><cfmodule template="../../customtags/putline.cfm" linetype="thin" linecolor="#Request.GetColors.InputHBgcolor#"/></td>
			</tr>
			
 <!--- display Title --->
			<tr>
				<td align="RIGHT">Display Title:</td>
				<td></td>
				<td><input type="radio" name="display_title" value="1" #doChecked(attributes.display_title)# /> Yes  
				&nbsp;&nbsp;<input type="radio" name="display_title" value="0" #doChecked(attributes.display_title,0)# /> No
				</td>
			</tr>			
 			
 <!--- Small Title --->
			<tr>
				<td align="RIGHT">Title Image:</td>
				<td></td>
				<td><input type="text" name="Sm_Title" size="30" maxlength="100" class="formfield" value="#attributes.Sm_Title#"/> <a href="JavaScript: newWindow = openWin('#self#?fuseaction=home.admin&select=image&fieldname=Sm_Title&fieldvalue=#attributes.Sm_Title#&dirname=/features', 'images', 'width=520,height=290,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=0,resizable=1'); newWindow.focus()" class="formtextsmall">Image Manager</a>
				</td>
			</tr>
			
 <!--- Small Image --->
			<tr>
				<td align="RIGHT">Image:</td>
				<td></td>
				<td><input type="text" name="Sm_Image" size="30" maxlength="100" class="formfield" value="#attributes.Sm_Image#"/> <a href="JavaScript: newWindow = openWin('#self#?fuseaction=home.admin&select=image&fieldname=Sm_Image&fieldvalue=#attributes.Sm_Image#&dirname=/features', 'images', 'width=520,height=290,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=0,resizable=1'); newWindow.focus()" class="formtextsmall">Image Manager</a>
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
					<cfset config.LinkBrowserURL = "../../../../index.cfm?fuseaction=home.admin&select=image&type=File&fieldname=fckeditor">	
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
				<td align="RIGHT" class="formtitle"><br/>Content Page&nbsp;</td>
				<td colspan="2"><br/><cfmodule template="../../customtags/putline.cfm" linetype="thin" linecolor="#Request.GetColors.InputHBgcolor#"/></td>
			</tr>
				
<!--- Large Title --->
			<tr>
				<td align="RIGHT">Title Image:</td>
				<td></td>
				<td><input type="text" name="Lg_Title" size="30" maxlength="100" class="formfield" value="#attributes.Lg_Title#"/> <a href="JavaScript: newWindow = openWin('#self#?fuseaction=home.admin&select=image&fieldname=Lg_Title&fieldvalue=#attributes.Lg_Title#&dirname=/features', 'images', 'width=520,height=290,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=0,resizable=1'); newWindow.focus()" class="formtextsmall">Image Manager</a>
				</td>
			</tr>		
			
 <!--- Large Image --->
			<tr>
				<td align="RIGHT" valign="baseline">Image or PDF:</td>
				<td></td>
				<td><input type="text" name="Lg_Image" size="30" maxlength="100" class="formfield" value="#attributes.Lg_Image#"/> <a href="JavaScript: newWindow = openWin('#self#?fuseaction=home.admin&select=image&fieldname=Lg_Image&fieldvalue=#attributes.Lg_Image#&dirname=/features', 'images', 'width=520,height=290,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=0,resizable=1'); newWindow.focus()" class="formtextsmall">Image Manager</a> &nbsp;  <a href="JavaScript: newWindow = openWin('#self#?fuseaction=home.admin&select=image&type=PDF&fieldname=Lg_Image&fieldvalue=#attributes.Lg_Image#&dirname=/features', 'images', 'width=520,height=290,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=0,resizable=1'); newWindow.focus()" class="formtextsmall">PDF Manager</a><br/>
<span  class="formtextsmall">If a .PDF file is uploaded, the file is displayed instead of the page below.</span>
				</td>
			</tr>			
			
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
					instanceName="Long_Desc"
					config="#config#"
					height="500" 
					Value="#attributes.Long_Desc#"
					/>
			</td>
			</tr>
			
 <!--- Parameters --->
			<tr>
				<td align="RIGHT" valign="top">Parameters:</td>
				<td></td>
		 <td>
			<input type="text" name="Passparam"  value="#attributes.Passparam#" class="formfield"  size="50" maxlength="100"/>
<cfif request.appsettings.featurereviews><br/><span class="formtextsmall">RelatedFeatTitle=text,RelatedProdTitle=Text</span></cfif>
			</td>
			</tr>
			
	<!--- Title Tag --->
			<tr>
				<td align="RIGHT" valign="top">HTML Title:</td>
				<td></td>
		 		<td><input type="text" name="titletag" size="60" maxlength="255" class="formfield" value="#attributes.titletag#"/><br/>
				<span class="formtextsmall">Title tag when displaying the feature, for search engine placement.</span>
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
				<select name="color_id" size="1" class="formfield" >
					<option value="" #doSelected(attributes.color_id,'')#>Default Palette</option>
					<cfloop query="qry_Get_Colors">
   						<cfif qry_Get_Colors.color_id IS NOT request.appsettings.color_id>
						<option value="#color_id#" #doSelected(attributes.color_id,qry_Get_Colors.color_id)#>#palette_name#</option>
						</cfif>
					</cfloop>
				</select>
				</td>
			</tr>
			
		<cfinclude template="../../includes/form/put_space.cfm">
			
		<tr>
			<td colspan="2">&nbsp;</td>
			<td>
			<input type="submit" name="frm_submit" value="<cfif feature is 'edit'>Update<cfelse>Add Feature</cfif>" class="formbutton"/> 			<input type="button" value="Cancel" onclick="javascript:window.history.go(-1);" class="formbutton"/> 	
<cfif Feature is "edit">
		<input type="submit" name="frm_submit" value="Delete" class="formbutton" onclick="return confirm('Are you sure you want to delete this feature?');"/>
</cfif>
	</td>
	</tr>
	<cfinclude template="../../includes/form/put_requiredfields.cfm">

	</form>	

<cfprocessingdirective suppresswhitespace="no">
<script type="text/javascript">
objForm = new qForm("editform");

objForm.required("Name,UID,Display");

objForm.UID.description = "user";
objForm.created.description = "date created";
objForm.start.description = "start date";
objForm.expire.description = "expiration date";

objForm.Priority.validate= true;
objForm.Priority.validateNumeric();
objForm.Priority.validateRange('0','9999');
objForm.start.validateDate();
objForm.created.validateDate();
objForm.expire.validateDate();

qFormAPI.errorColor = "###Request.GetColors.formreq#";
</script>
</cfprocessingdirective>

			</tr>
			</table>
	<table width="100%" cellspacing="4" border="0" cellpadding="0" class="formtext">	
		<tr><form action="#self#?fuseaction=feature.admin&feature=list&cid=#attributes.cid##request.token2#" method="post" enctype="multipart/form-data">
		<td align="center">

<cfmodule template="../../customtags/putline.cfm" linetype="thin" linecolor="#Request.GetColors.InputHBgcolor#"/>	<br/>	
		<input type="hidden" name="act" value="choose"/>
		<input type="submit" name="DONE" value="Back to Feature List" class="formbutton"/><br/><br/>
		</td></form>	
    </tr>
	</table> 
</cfoutput>		
			
<!--- close module --->
</cfmodule>
	