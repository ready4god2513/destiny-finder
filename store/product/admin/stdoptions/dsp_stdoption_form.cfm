
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the form for adding or editing a standard option. Called by product.admin&stdoption=add|edit --->

<!--- Initialize the values for the form --->
<cfset fieldlist="Std_Name,std_prompt,Std_Desc,Std_ShowPrice,std_display,std_required">
		
<cfswitch expression="#stdoption#">
			
	<cfcase value="add">
		<cfloop list="#fieldlist#" index="counter">
			<cfset setvariable("attributes.#counter#", "")>
		</cfloop>
		<cfset attributes.Std_ID = 0>	
		<!--- radio button defaults --->
		<cfset attributes.Std_Required = 0>
		<cfset attributes.Std_ShowPrice = "No">
		<!--- default inventory checks --->
		<cfset CheckInvUse.RecordCount = 0>
		
		<cfset action="#self#?fuseaction=product.admin&stdoption=act&mode=i">

	    <cfset act_title="New Standard Option">
		<cfset act_button="Add Option">	
	</cfcase>
					
	<cfcase value="edit">
		<!--- Set the form fields to values retrieved from the record --->
		<cfloop list="#fieldlist#" index="counter">
			<cfset "attributes.#counter#" = evaluate("qry_get_stdoption." & counter)>
		</cfloop>
				
		<cfset action="#self#?fuseaction=product.admin&StdOption=act&mode=u">
		<cfset act_title="Update Standard Option">
		<cfset act_button="Update Option">	
				
	</cfcase>
</cfswitch>

<!--- CF Form Checking work around ------->
<cfset attributes.required = attributes.std_required>

<cfif isdefined("attributes.product_id")>
	<cfset action="#action#&product_id=#attributes.product_id#">
</cfif>
<cfif isdefined("attributes.cid")>
	<cfset action="#action#&cid=#attributes.cid#">
</cfif>
	
<cfset startcheck = 2>	
<cfinclude template="put_stdoptions_js.cfm">

<cfmodule template="../../../customtags/format_admin_form.cfm"
	box_title="#act_title#"
	width="550"
	>
	
	<!--- Table --->
	<cfoutput>
	<form action="#action##request.token2#" method="post" onsubmit="return checkForm(this)">
		<input type="hidden" name="Std_ID" value="#attributes.std_id#"/>

<cfif NOT len(attributes.std_prompt)>
	<cfset attributes.Std_Prompt = "Choose One:">
</cfif>


 <!--- Name --->
		<tr>
			<td align="RIGHT">Name for this option:</td>
			<td style="background-color: ###Request.GetColors.formreq#;" width="3">&nbsp;</td>
		 	<td><input type="text" name="Std_Name" value="#HTMLEditFormat(attributes.Std_Name)#" size="30" class="formfield"/>
			<input type="hidden" name="Std_Name_required" value="The name for the option is required!"/>
			</td>
			</tr>			
			
 <!--- Prompt --->
		<tr>
			<td align="RIGHT">Message to display:</td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
		 	<td><input type="text" name="Std_Prompt" value="#HTMLEditFormat(attributes.std_Prompt)#" size="30" class="formfield"/>
				<input type="hidden" name="Std_Prompt_required" value="The message for the option is required!"/>
			</td>
			</tr>			
			
 <!--- Description --->
		<tr>
			<td align="RIGHT">Description in Cart:</td>
			<td></td>
		 	<td>
			<input type="text" name="Std_Desc"  value="#HTMLEditFormat(attributes.Std_Desc)#" size="30" class="formfield"/>
			</td>
			</tr>

 <!--- required --->
		<tr>
			<td align="RIGHT">Require a selection?</td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
		 	<td>
			<input type="radio" name="Required" value="1" #doChecked(attributes.Required)# /> Yes 
			&nbsp; <input type="radio" name="Required" value="0" #doChecked(attributes.Required,0)# /> No<br/>
			<span class="formtextsmall">(defaults to yes if you enter num in stock under the product) </span>
			</td>
			</tr>			
			
 <!--- display --->
		<tr>
			<td align="RIGHT">Display in store?</td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
		 	<td>
			<input type="radio" name="Std_Display" value="1" #doChecked(attributes.Std_Display)# /> Yes 
			&nbsp; <input type="radio" name="Std_Display" value="0" #doChecked(attributes.Std_Display,0)# /> No
			</td>
			</tr>			

 <!--- Show Price --->
		<tr>
			<td align="RIGHT">Show price on selections?</td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
		 	<td>
			<input type="radio" name="Std_ShowPrice" value="No" #doChecked(attributes.Std_ShowPrice,'No')# /> No 
			&nbsp;&nbsp; <input type="radio" name="Std_ShowPrice" value="AddPrice" #doChecked(attributes.Std_ShowPrice,'AddPrice')# /> Amount Added 
			&nbsp; <input type="radio" name="Std_ShowPrice" value="Total" #doChecked(attributes.Std_ShowPrice,'Total')# /> Total
			</td>
			</tr>
			
<cfif CheckInvUse.RecordCount>
		<tr>
			<td colspan="3"><br/><br/>
<strong>NOTE:</strong> This option is currently in use for inventory tracking on orders in the system. You will not be able to delete the option or any current option choices, but can hide them from being displayed in the store for new orders. The numbers in stock may still change according to actions made to any existing orders in the system. <br/>&nbsp;
			</td>
			</tr>
</cfif>

<!---================ TABLE =================--->			
		<tr>
			<td colspan="3">
	
				<table width="100%" class="formtext" style="color:###Request.GetColors.InputTText#">
	
<!---- Determine number of option choices --->
<cfset Number = iif(isDefined("qry_get_StdOpt_Choices.Recordcount"),Evaluate(DE('qry_get_StdOpt_Choices.Recordcount')),0) >

<cfif Number>
		<tr>
			<td align="left"><b>Choice Name</b></td>
			<td align="LEFT"><b>Price</b> <br/>
				<font size="-2">(Added to Base Price,<br/>
 				blank if 0)</font></td>
 			<td align="LEFT"><b>Weight</b> <br/>
				<font size="-2">(Added to Base Weight,<br/>
 				blank if 0)</font></td>
			<td align="center" valign="bottom"><b>Order</b></td>
			<td align="center" valign="bottom"><b>Show?</b></td>
			<td align="center" valign="bottom"><b>Delete</b></td>
		</tr>
		
	<cfloop query="qry_get_StdOpt_Choices">
		
		<input type="hidden" name="Choice_ID#currentrow#" value="#qry_get_StdOpt_Choices.choice_id#"/>
		<!--- If exist, display name and value in text input boxes --->
		<tr>
			<td align="left"><input type="text" name="ChoiceName#currentrow#" value="#HTMLEditFormat(qry_get_StdOpt_Choices.ChoiceName)#" size="25" maxlength="50" class="formfield"/></td>
<input type="hidden" name="ChoiceName#currentrow#_required" value="The choice name is required!"/>
			<td><input type="text" name="Price#currentrow#" value="<cfif qry_get_StdOpt_Choices.Price IS NOT 0>#NumberFormat(qry_get_StdOpt_Choices.Price, '0.00')#</cfif>" size="15" class="formfield"/></td>
<input type="hidden" name="Price#currentrow#_float" value="The selection price must be a number!"/>
			<td><input type="text" name="Weight#currentrow#" value="<cfif qry_get_StdOpt_Choices.Weight IS NOT 0>#NumberFormat(qry_get_StdOpt_Choices.Weight, '0.00')#</cfif>" size="15" class="formfield"/></td>
<input type="hidden" name="Weight#currentrow#_float" value="The selection weight must be a number!"/>
			<td align="center"><input type="text" name="SortOrder#currentrow#" value="#doPriority(qry_get_StdOpt_Choices.SortOrder)#" size="6" class="formfield"/></td>
<input type="hidden" name="SortOrder#currentrow#_float" value="The sort order must be a number!"/>
			<td align="center"><input type="checkbox" name="Display#currentrow#" class="formfield" #doChecked(qry_get_StdOpt_Choices.Display)#/></td>
			<td align="center">
			<input type="checkbox" name="Delete#currentrow#" class="formfield" <cfif CheckInvUse.RecordCount>disabled="disabled"</cfif>/></td>
			</tr>		
		</tr>
	</cfloop>
</cfif>

<cfset Start = Number + 1>

<!--- Prompt user for number of choices on this option --->
<cfprocessingdirective suppresswhitespace="no">
<script type="text/javascript">
    var num = prompt('How many <cfif Number>additional </cfif>selections do you want for this option?','<cfif Number>0<cfelse>1</cfif>');
if (num != null) {
num = parseInt(num);
	num += #Number#;
	document.write('<input type="hidden" name="num" value="' + num + '"/>\n');
<cfif NOT Number>
if (num <= 0) { num = 1}
document.write('<tr><td align="left" valign="bottom"><br/>\n');
		document.write('<b>Choice Name</b></td>\n');
		document.write('<td align="LEFT"><br/>\n');
		document.write('<b>Price</b><br/>\n');
		document.write('<font size="-2">\(Added to Base Price,<br/>leave blank if 0\)</font></td>\n');
document.write('<td align="LEFT"><br/>\n');
		document.write('<b>Weight</b><br/>\n');
		document.write('<font size="-2">\(Added to Base Weight,<br/>leave blank if 0\)</font></td>\n');
		document.write('<td align="center" valign="bottom"><br/><b>Order</b></td>\n');
		document.write('<td align="center" valign="bottom"><br/><b>Show?</b></td>\n');
		document.write('<td align="center" valign="bottom"><br/><b>Delete</b></td></tr>\n');
</cfif>		
	for (var i=#Start#; i<=num; i++){
	document.write('<tr><td align="left"><input type="text" name="ChoiceName' + i + '" size="25" maxlength="50" class="formfield"/></td>\n');
	document.write('<td><input type="text" name="Price' + i + '" size="15" class="formfield"/></td>\n');
document.write('<td><input type="text" name="Weight' + i + '" size="15" class="formfield"/></td>\n');
document.write('<td align="center"><input type="text" name="SortOrder' + i + '" size="6" class="formfield"/></td>\n');
document.write('<td align="center"><input type="checkbox" name="Display' + i + '" class="formfield" checked="checked" /></td>\n');
document.write('<td align="center"><input type="checkbox" name="Delete' + i + '" class="formfield"/></td></tr>\n');
document.write('<input type="hidden" name="Price' + i + '_float" value="The choice price must be a number!"/>');
document.write('<input type="hidden" name="Weight' + i + '_float" value="The choice weight must be a number!"/>');
document.write('<input type="hidden" name="SortOrder' + i + '_float" value="The sort order must be a number!"/>');
	}
}
else {
location.href = "#request.self#?fuseaction=product.admin&stdoption=list&redirect=yes#Request.Token2#";
}
    
    </script>
</cfprocessingdirective>

	</table></td></tr>				
	
		<tr>
			<td colspan="2">&nbsp;</td>
			<td><br/>
			<input type="submit" name="submit" value="#act_button#" class="formbutton"/>
			<input type="button" value="Cancel" onclick="CancelForm();" class="formbutton"/>
			
			<!--- disable delete option if used for inventory --->
			<cfif attributes.stdoption is "edit" AND NOT CheckInvUse.RecordCount>
				<input type="submit" name="submit" value="Delete" class="formbutton"  onclick="return confirm('Are you sure you want to delete this standard option?');"/>
			<cfelseif attributes.stdoption is "edit">
				<input type="button" value="Delete" class="formbutton"  onclick="alert('This option has been used for inventory tracking. You must remove any orders for those products before you can delete it.');"/>
			</cfif>
			</td>
		</tr>
		</form>	
		
</cfoutput>
	
</cfmodule>
	
