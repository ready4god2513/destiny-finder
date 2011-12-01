
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the form for adding or editing a standard option. Called by shopping.admin&stdoption=add|edit --->

<!--- Initialize the values for the form --->
<cfset fieldlist="Name,Short_Desc,Sm_Image,Price,Weight,Priority,Display">	
		
<cfswitch expression="#giftwrap#">
			
	<cfcase value="add">
		<cfloop list="#fieldlist#" index="counter">
			<cfset temp = setvariable("attributes.#counter#", "")>
		</cfloop>
		<cfset attributes.Giftwrap_ID = 0>	
		
		<cfset action="#request.self#?fuseaction=shopping.admin&giftwrap=act&mode=i">

	    <cfset act_title="New Gift Wrapping Option">
		<cfset act_button="Add Option">	
	</cfcase>
					
	<cfcase value="edit">
				
		<cfinclude template="qry_get_giftwrap.cfm"> 
		<!--- Set the form fields to values retrieved from the record --->
		<cfloop list="#fieldlist#" index="counter">
			<cfset "attributes.#counter#" = evaluate("qry_get_giftwrap." & counter)>
		</cfloop>
				
		<cfset action="#request.self#?fuseaction=shopping.admin&giftwrap=act&mode=u">
		<cfset act_title="Update Gift Wrapping">
		<cfset act_button="Update Option">	
				
	</cfcase>
</cfswitch>

<cfinclude template="../../../includes/imagepreview.js">

<cfmodule template="../../../customtags/format_admin_form.cfm"
	box_title="#act_title#"
	width="550"
	>
	
	<!--- Table --->
	<cfoutput>
	<form name="editform" action="#action##request.token2#" method="post">
		<input type="hidden" name="Giftwrap_ID" value="#attributes.Giftwrap_ID#"/>

 <!--- Name --->
		<tr>
			<td align="RIGHT">Name:</td>
			<td style="background-color: ###Request.GetColors.formreq#;" width="3">&nbsp;</td>
		 	<td><input type="text" name="Name" value="#HTMLEditFormat(attributes.Name)#" size="30" class="formfield"/>
			</td>
			</tr>			
			
 <!--- Small Image --->
			<tr>
				<td align="RIGHT">Image:</td>
				<td></td>
				<td><input type="text" name="Sm_Image" size="30" maxlength="100" class="formfield" value="#attributes.Sm_Image#"/> <a href="JavaScript: newWindow = openWin('#request.self#?fuseaction=home.admin&select=image&fieldname=Sm_Image&fieldvalue=#attributes.Sm_Image#', 'images', 'width=520,height=290,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=0,resizable=1'); newWindow.focus()" class="formtextsmall">Image Manager</a>
				</td>
			</tr>		
			
 <!--- Description --->
			<tr>
				<td align="RIGHT" valign="top">Description:</td>
				<td></td>
				<td align="left">
				<cfset config = StructNew()>
				<cfset config.LinkBrowser = "false">
				<cfset config.FlashBrowser = "false">				
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
			
						
 <!--- Base_price--->	
		<tr>
			<td align="RIGHT">Price:</td>
			<td></td>
		 	<td>
			<input type="text" name="Price"  class="formfield" value="#attributes.Price#" size="7" maxlength="15"/> #Request.AppSettings.MoneyUnit#
			</td></tr>	
			
 <!--- shipping  --->
		<tr>
			<td align="RIGHT">Weight:</td>
			<td></td>
			<td>
			<input type="text" name="Weight"  class="formfield" value="#iif(attributes.Weight IS NOT 0, DE("#attributes.Weight#"), DE(""))#" size="7" maxlength="15"/>
#Request.AppSettings.WeightUnit#
			</td></tr>
					
 <!--- priority --->
			<tr>
				<td align="RIGHT">Priority:</td>
				<td></td>
				<td><input type="text" name="Priority" class="formfield" value="#doPriority(attributes.Priority,0)#" size="4" maxlength="10"/><span class="formtextsmall"> (1 is highest, 0 is none)</span>
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
			
		<tr>
			<td colspan="2">&nbsp;</td>
			<td><br/>
			<input type="submit" name="submit" value="#act_button#" class="formbutton"/>
			<input type="button" value="Cancel" onclick="javascript:window.history.go(-1);" class="formbutton"/> 	
			
			<cfif attributes.giftwrap is "edit">
				<input type="submit" name="submit" value="Delete" class="formbutton"  onclick="return confirm('Are you sure you want to delete this option?');"/>
			</cfif>
			</td>
		</tr>
		</form>	
		
<cfprocessingdirective suppresswhitespace="no">
<script type="text/javascript">
objForm = new qForm("editform");

objForm.required("Name");

objForm.Priority.validateNumeric();
objForm.Priority.validateRange('0','9999');

qFormAPI.errorColor = "###Request.GetColors.formreq#";

</script>			
</cfprocessingdirective>	
		
</cfoutput>
	
</cfmodule>
	
