<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Inserts customer form fields. Called during checkout from the shopping\checkout\customer\dsp_addresses.cfm, shopping\checkout\customer\dsp_customer.cfm and shopping\checkout\customer\dsp_shipto.cfm templates. Also used during user registration on the users\dsp_account_form.cfm and users\dsp_member_form.cfm and to update customer records from  users\dsp_customer_form.cfm. --->

<cfhtmlhead text="<script type='text/javascript' src='includes/initialcaps.js'></script>">

<!--- If counties found, create related selectbox code --->
<cfif GetCounties.RecordCount AND get_User_Settings.UseStateList>
	<cfinclude template="put_countyscripts.cfm">
	<cfset ShowCounties = "yes">
<cfelse>
	<cfset ShowCounties = "no">
</cfif>

<cfparam name="attributes.mode" default="contact"><!--- billto, customer --->

<cfoutput>
 	<tr align="left">
   	 	<td align="right">First Name:</td>
		<td style="background-color: ###Request.GetColors.formreq#;" width="3">&nbsp;</td>
   	 	<td><input type="text" size="30" name="FirstName" value="#HTMLEditFormat(attributes.FirstName)#" class="formfield" maxlength="50"
onblur="javascript:changeCase(this.form.FirstName)"/>
	 	</td></tr>

 	<tr align="left">
   	 	<td align="right">Last Name: </td>
		<td style="background-color: ###Request.GetColors.formreq#;"></td>
   	 	<td><input type="text"  size="30"name="LastName" value="#HTMLEditFormat(attributes.LastName)#" class="formfield" maxlength="100" onblur="javascript:changeCase(this.form.LastName)"/></td></tr>	


  	<tr align="left">
    	<td align="right">Company: </td>
		<td></td>
    	<td><input type="text" size="30" name="Company" value="#HTMLEditFormat(attributes.Company)#" class="formfield" maxlength="150"/></td></tr>


	<tr align="left">
    	<td align="right">Address: </td>
		<td style="background-color: ###Request.GetColors.formreq#;"></td>
    	<td><input type="text"  size="30" name="Address1" value="#HTMLEditFormat(attributes.Address1)#" class="formfield" maxlength="150" onblur="javascript:changeCase(this.form.Address1)"/>
		</td></tr>
		
	<tr align="left">
    	<td align="right" valign="baseline"></td>
		<td></td>
    	<td><input type="text" size="30" name="Address2" value="#HTMLEditFormat(attributes.Address2)#" class="formfield" maxlength="150" onblur="javascript:changeCase(this.form.Address2)"/></td></tr>	
		
	<tr align="left">
    	<td align="right">City: </td>
		<td style="background-color: ###Request.GetColors.formreq#;"></td>
    	<td><input type="text" size="30" name="City" value="#HTMLEditFormat(attributes.City)#" class="formfield" maxlength="150" onblur="javascript:changeCase(this.form.City)"/></td></tr>

<cfif get_User_Settings.UseStateList>
	<tr align="left">
		<td align="right" valign="baseline">State/Province: </td>	
		<td style="background-color: ###Request.GetColors.formreq#;"></td>
	    <td><select name="State" size="1" class="formfield" <cfif ShowCounties>onchange="objForm.County.populate(stcCounties[objForm.State.getValue()], null, null, stcBlank);"</cfif>>
			<option value="">Unlisted/None</option>
   			<option value="">___________________</option>
		<cfloop query="GetStates">
   			<option value="#Abb#" #doSelected(attributes.State,Abb)#>#Name# (#Abb#)</option>
		</cfloop></select>
		</td></tr>
<cfelse>
	<tr style="display:none"><td colspan="3">
	<input type="hidden" name="State" value="Unlisted"/>
	</td></tr>
	
</cfif>

<cfif get_User_Settings.UseStateBox>
	<tr align="left">
	    <td align="right"><cfif NOT get_User_Settings.UseStateList>State/Region:</cfif></td>
		<td></td>
		<td><input type="text" name="State2" value="#HTMLEditFormat(attributes.State2)#" size="30" maxlength="50" class="formfield"/>
		<cfif get_User_Settings.UseStateList><span class="formtextsmall"><br/>Enter here if not listed above</span></cfif></td></tr>
<cfelse>
	<tr style="display:none"><td colspan="3">
	<input type="hidden" name="State2" value=""/>
	</td></tr>
</cfif>

<cfif ShowCounties>
	<tr align="left">
    	<td align="right">County: </td>
		<td <cfif get_User_Settings.RequireCounty>style="background-color: ###Request.GetColors.formreq#;"</cfif>></td>
    	<td><select name="County" class="formfield">
	<option value="">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; </option>
	<option value=""></option><option value=""></option><option value=""></option><option value=""></option><option value=""></option></select></td></tr>
<cfelse>
	<tr style="display:none"><td colspan="3">
	<input type="hidden" name="County" value=""/>
	</td></tr>
</cfif>

	<tr align="left">
	    <td align="right">Zip/Postal Code: </td>
		<td style="background-color: ###Request.GetColors.formreq#;"></td>
    	<td><input type="text" name="Zip" value="#HTMLEditFormat(attributes.Zip)#"  size="30" maxlength="50" class="formfield" /></td></tr>
<cfif get_User_Settings.UseCountryList>
	<tr align="left">
    	<td align="right">Country: </td>
		<td style="background-color: ###Request.GetColors.formreq#;"></td>
    	<td>
		<select name="Country" size="1" class="formfield">
			<option value="#Request.AppSettings.HomeCountry#">#ListGetAt(Request.AppSettings.HomeCountry, 2, "^")#</option>
 			<option value="#Request.AppSettings.HomeCountry#">___________________</option>
		<cfloop query="GetCountries">
   			<option value="#Abbrev#^#Name#" #doSelected(attributes.Country,"#Abbrev#^#Name#")#>#Left(Name,28)#</option>
		</cfloop>
		</select></td></tr>		
<cfelse>
	<tr style="display:none"><td colspan="3">
	<input type="hidden" name="Country" value="#Request.AppSettings.HomeCountry#"/>
	</td></tr>
</cfif>
	<tr align="left">
	    <td align="right">Phone: </td>
		<td <cfif attributes.mode is "customer">style="background-color: ###Request.GetColors.formreq#;"</cfif>></td>
   	 	<td><input type="text" name="Phone" value="#HTMLEditFormat(attributes.Phone)#" size="30" maxlength="50" class="formfield"/></td></tr>


<cfif attributes.mode is "account">
	<tr align="left">
	    <td align="right">Other Phone: </td>
		<td></td>
   	 	<td><input type="text" name="Phone2" value="#HTMLEditFormat(attributes.Phone2)#" size="30" maxlength="50" class="formfield"/></td></tr>
	
  	<tr align="left">
    	<td align="right">Fax: </td>
		<td></td>
    	<td><input type="text" size="30" name="Fax" value="#HTMLEditFormat(attributes.Fax)#" class="formfield" maxlength="50"/></td></tr>

<cfelseif attributes.mode is not "shipto" and fuseaction is not "users.member">
	<tr align="left">
	    <td align="right">E-Mail: </td>
		<td <cfif attributes.mode is "customer">style="background-color: ###Request.GetColors.formreq#;"</cfif>></td>
   	 	<td><input type="text" name="email" value="#HTMLEditFormat(attributes.email)#" size="30" maxlength="150" class="formfield"/></td></tr>
</cfif>

<cfif get_User_Settings.UseResidential>
	<tr align="left">
	    <td align="right">A Residence?: </td>
		<td style="background-color: ###Request.GetColors.formreq#;"></td>
   	 	 <td><input type="radio" name="residence" value="1" #doChecked(attributes.residence)# /> Yes
		  &nbsp;&nbsp;<input type="radio" name="residence" value="0" #doChecked(attributes.residence,0)# /> No
		</td></tr>
<cfelse>
	<tr style="display:none"><td colspan="3">
	<input type="hidden" name="residence" value="1"/>
	</td></tr>
</cfif>


</cfoutput>

