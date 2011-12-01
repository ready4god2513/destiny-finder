
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the form to add and edit page templates. Called by home.admin&catcore=add|edit --->

<!--- Initialize the values for the form --->
<cfset fieldlist="CatCore_ID,catcore_Name,passparams,template,category,products,features,page">

<cfswitch expression="#attributes.CatCore#">
		
	<cfcase value="add">
		<cfloop list="#fieldlist#" index="counter">
				<cfset setvariable("attributes.#counter#", "")>
		</cfloop>
		<cfset attributes.CatCore_id="0">	
		<cfset action="#self#?fuseaction=home.admin&CatCore=act&mode=i">
    	<cfset act_title="Add">	
			
	</cfcase>
			
	<cfcase value="edit">
		<!--- Set the form fields to values retrieved from the record --->		
		<cfloop list="#fieldlist#" index="counter">
				<cfset "attributes.#counter#" = evaluate("qry_get_catcore." & counter)>
		</cfloop>
				
		<cfset action="#self#?fuseaction=home.admin&CatCore=act&mode=u">
		<cfset act_title="Update">
				
	</cfcase>

</cfswitch>




<cfmodule template="../../customtags/format_admin_form.cfm"
	box_title="#act_title# Template"
	width="450"
	>

<cfoutput>
	<form name="editform" action="#action##request.token2#" method="post">
	
	
	<!--- CatCore ID --->
			<tr valign="top">
			<td align="right">CatCore ID:</td>
			<td><img src="#Request.AppSettings.defaultimages#/spacer.gif" alt="" height="1" width="4" /></td>
			<td><input type="hidden" name="CatCore_id" value="#attributes.CatCore_id#"/><cfif attributes.CatCore_id>#attributes.CatCore_id#<cfelse>New</cfif></td>
			</tr>
			
	<!--- Name --->
			<tr valign="top">
			<td align="right">Template Name:</td>
			<td style="background-color: ###Request.GetColors.formreq#;" width="3">&nbsp;</td>
			<td><input type="text" name="catcore_name" value="#attributes.catcore_name#" size="40" class="formfield"/></td>
			</tr>		
		
	<!--- Parameters --->
			<tr valign="top">
			<td align="right">Parameters:</td>
			<td></td>
			<td><input type="text" name="passparams" value="#attributes.passparams#" size="40" class="formfield"/>
			<br/><span class="formfieldsmall">List of parameters that this template accepts.</span>
			</td>
			</tr>			
			
	<!--- Template File --->
			<tr valign="top">
			<td align="right">Template File:</td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
			<td><input type="text" name="template" value="#attributes.template#" size="40" class="formfield"/>
			<br/><span class="formfieldsmall">Location of included template from site root.</span>
			</td>
			</tr>					
			
	<!--- Template Type --->
			<tr valign="top">
			<td align="right">Template Type:</td>
			<td></td>
			<td>		
			<table cellpadding="0" cellspacing="0" class="formtext" style="color:###Request.GetColors.InputTText#;">
				<tr>
					<td><input type="checkbox" name="template_type" value="products" #doChecked(attributes.products)# />
					products &nbsp;</td>
					<td><input type="checkbox" name="template_type" value="features" #doChecked(attributes.features)# />
					features &nbsp;</td>
				</tr>
				<tr>
					<td><input type="checkbox" name="template_type" value="category" #doChecked(attributes.category)# />
					used for categories</td>
					<td><input type="checkbox" name="template_type" value="page" #doChecked(attributes.page)# />
					used for pages</td>
				</tr>
			</table>
<span class="formfieldsmall">Check if this template uses these items.</span>
			</td>
			</tr>		
					
	<!----SUBMIT ---->
		<cfinclude template="../../includes/form/put_space.cfm">
	
		<tr>
			<td>&nbsp;</td><td></td>
			<td>			
	
			<input type="submit" name="submit" value="#act_title#" class="formbutton"/> 
			<input type="button" value="Cancel" onclick="javascript:window.history.go(-1);" class="formbutton"/>
			<cfif attributes.CatCore is "edit">
			<input type="submit" name="submit" value="Delete" class="formbutton" onclick="return confirm('Are you sure you want to delete this template?');"/></cfif>
	
			</td></tr>
			</form>
	</cfoutput>
			
<cfprocessingdirective suppresswhitespace="no">
<script type="text/javascript">
// initialize the qForm object
objForm = new qForm("editform");

// make these fields required
objForm.required("catcore_name,template");

qFormAPI.errorColor = "<cfoutput>###Request.GetColors.formreq#</cfoutput>";
</script>
</cfprocessingdirective>
			
</cfmodule>
