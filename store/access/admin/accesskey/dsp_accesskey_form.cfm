<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the form to add and edit access keys: add, update, delete. Called by access.admin&accessKey=add/edit --->

<!--- Initialize the values for the form --->
<cfset fieldlist="AccessKey_ID,Name,system">

<cfswitch expression="#attributes.accesskey#">
		
	<cfcase value="add">
		<cfloop list="#fieldlist#" index="counter">
				<cfset setvariable("attributes.#counter#", "")>
		</cfloop>
		<cfset attributes.accesskey_id="0">	
		<cfset action="#self#?fuseaction=access.admin&AccessKey=act&mode=i">
    	<cfset act_title="Add">	
			
	</cfcase>
			
	<cfcase value="edit">
		<!--- Set the form fields to values retrieved from the record --->		
		<cfloop list="#fieldlist#" index="counter">
				<cfset "attributes.#counter#" = evaluate("qry_get_accesskey." & counter)>
		</cfloop>
				
		<cfset action="#self#?fuseaction=access.admin&AccessKey=act&mode=u">
		<cfset act_title="Update">
				
	</cfcase>

</cfswitch>

<cfmodule template="../../../customtags/format_admin_form.cfm"
	box_title="#act_title# Access Key"
	width="450"
	>
	
<cfoutput>
	<form name="editform" action="#action##request.token2#" method="post">
	
	<!--- AccessKey ID --->
			<tr valign="top">
			<td align="right">AccessKey ID:</td>
			<td><img src="#Request.AppSettings.defaultimages#/spacer.gif" alt="" height="1" width="4" /></td>
			<td><input type="hidden" name="AccessKey_id" value="#attributes.AccessKey_id#" required="no"/><cfif attributes.AccessKey_id>#attributes.AccessKey_id#<cfelse>New</cfif></td>
			</tr>
			
	<!--- Name --->
			<tr valign="top">
			<td align="right">Name:</td>
			<td style="background-color: ###Request.GetColors.formreq#;" width="3">&nbsp;</td>
			<td><input type="text" name="name" value="#attributes.Name#" size="35" class="formfield"/></td>
			</tr>
		
	<!----SUMBIT ---->
		<cfinclude template="../../../includes/form/put_space.cfm">
	
		<tr>
			<td>&nbsp;</td><td></td>
			<td>			
			<cfif attributes.system is not 1>
			<input type="submit" name="submit" value="#act_title#" class="formbutton"/> 
			<input type="button" value="Cancel" onclick="javascript:window.history.go(-1);" class="formbutton"/>
			<cfif attributes.accesskey is "edit">
			<input type="submit" name="submit" value="Delete" class="formbutton" onclick="return confirm('Are you sure you want to delete this access key?');" /></cfif>
			</cfif>
			</td></tr>
			</form>
	</cfoutput>
			
<cfprocessingdirective suppresswhitespace="no">
<script type="text/javascript">
objForm = new qForm("editform"); 
objForm.required("name"); 
qFormAPI.errorColor = "<cfoutput>###Request.GetColors.formreq#</cfoutput>"; 
</script>
</cfprocessingdirective>
			
</cfmodule>
