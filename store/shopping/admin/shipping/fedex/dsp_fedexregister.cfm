<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the form for registering with FedEx. Called by shopping.admin&shipping=fedexregister --->

<cfprocessingdirective suppresswhitespace="no">
<cfhtmlhead text="
<script language=""JavaScript"">
		function CancelForm () {
		location.href = ""#self#?fuseaction=shopping.admin&shipping=settings&redirect=yes#request.token2#"";
		}
	</script>
">
</cfprocessingdirective>

<cfhtmlhead text="<script type='text/javascript' src='includes/initialcaps.js'></script>">

<cfparam name="errormessage" default="">

<cfset attributes.fieldlist="FirstName,LastName,Company,Address1,Address2,City,State,Zip,Country,Phone,Email">

<cfif NOT isDefined("attributes.ContactName")>
<!--- Use default user information if first time loading form --->
	<cfinclude template="../../../checkout/customer/act_newcustomer.cfm">
	<cfinclude template="../../../checkout/customer/qry_get_tempcustomer.cfm">
	
	<cfloop list="#attributes.fieldlist#" index="counter">
		<cfset "attributes.#counter#" = evaluate("getcustomer." & counter)>
	</cfloop>
	
	<!--- If no customer country, set to home country for store --->
	<cfif NOT len(attributes.Country)>
		<cfset attributes.Country = Request.AppSettings.HomeCountry>
	</cfif>
	
	<cfset attributes.ContactName = "#attributes.FirstName# #attributes.LastName#">
	
	<cfset attributes.fieldlist2="Fax,AccountNo">
	<cfloop list="#attributes.fieldlist2#" index="counter">
		<cfset "attributes.#counter#" = "">
	</cfloop>

</cfif>


<cfinclude template="../../../../queries/qry_getstates.cfm">
<cfinclude template="../../../../queries/qry_getcountries.cfm">

<cfmodule template="../../../../customtags/format_admin_form.cfm"
	box_title="FedEx Subscription Request"
	width="550">
	
	<cfif len(ErrorMessage)>
	<tr>
		<td colspan="3" align="center" class="formerror"><br/><cfoutput>#ErrorMessage#</cfoutput><br/><br/></td></tr>
	</cfif>		
	
	<cfoutput>
	<form action="#self#?fuseaction=shopping.admin&shipping=fedexregister#request.token2#" method="post" name="fedex">
	<input type="hidden" name="debug" value="yes"/>

	<cfinclude template="../../../../includes/form/put_space.cfm">

		<tr><td align="right">Contact Name:</td>
		<td style="background-color: ###Request.GetColors.formreq#;" width="3">&nbsp;</td>
		<td><input type="text" size="30" name="ContactName" value="#attributes.ContactName#" class="formfield"  onblur="javascript:changeCase(this.form.ContactName)" maxlength="30"/></td></tr>
		<tr><td align="right">Company Name:</td>
		<td style="background-color: ###Request.GetColors.formreq#;"></td>
		<td><input type="text" size="30" name="Company" value="#attributes.Company#" class="formfield"  onblur="javascript:changeCase(this.form.Company)" maxlength="30"/></td></tr>
		<tr><td align="right">Street Address:</td>
		<td style="background-color: ###Request.GetColors.formreq#;"></td>
		<td><input type="text" size="30" name="Address1" value="#attributes.Address1#" class="formfield"  onblur="javascript:changeCase(this.form.Address1)"  maxlength="50"/></td></tr>
		<tr><td align="right">Address Line 2:</td>
		<td></td>
		<td><input type="text" size="30" name="Address2" value="#attributes.Address2#" class="formfield"  onblur="javascript:changeCase(this.form.Address2)"  maxlength="50"/></td></tr>
		<tr><td align="right">City:</td>
		<td style="background-color: ###Request.GetColors.formreq#;"></td>
		<td><input type="text" size="30" name="City" value="#attributes.City#" class="formfield"  onblur="javascript:changeCase(this.form.City)"  maxlength="50"/></td></tr>
		<tr><td align="right">State/Province:</td>
		<td style="background-color: ###Request.GetColors.formreq#;"></td>
	    <td><select name="State" size="1" class="formfield">
			<option value="">Unlisted/None</option>
   			<option value="">___________________</option>
		<cfloop query="GetStates">
   			<option value="#Abb#" #doSelected(attributes.State,Abb)#>#Name# (#Abb#)</option>
		</cfloop></select>
		</td></tr>
		<tr><td align="right">Country:</td>
		<td style="background-color: ###Request.GetColors.formreq#;"></td>
		<td><select name="Country" size="1" class="formfield">
			<option value="#ListGetAt(Request.AppSettings.HomeCountry, 1, "^")#">
			#ListGetAt(Request.AppSettings.HomeCountry, 2, "^")#</option>
 			<option value="#ListGetAt(Request.AppSettings.HomeCountry, 1, "^")#">___________________</option>
		<cfloop query="GetCountries">
   			<option value="#Abbrev#" #doSelected(ListGetAt(attributes.Country, 1, "^"),Abbrev)#>
			#Left(Name,28)#</option>
		</cfloop>
		</select></td></tr>
		<tr><td align="right">Postal Code:</td>
		<td style="background-color: ###Request.GetColors.formreq#;"></td>
		<td><input type="text" size="10" name="Zip" value="#attributes.Zip#" class="formfield"  maxlength="11"/></td></tr>
		<tr><td align="right">Phone Number:</td>
		<td style="background-color: ###Request.GetColors.formreq#;"></td>
		<td><input type="text" size="30" name="Phone" value="#attributes.Phone#" class="formfield"  maxlength="25"/></td></tr>
		<tr><td align="right">FAX Number:</td>
		<td></td>
		<td><input type="text" size="30" name="Fax" class="formfield" maxlength="25" value="#attributes.Fax#"/></td></tr>
		<tr><td align="right">Email Address:</td>
		<td style="background-color: ###Request.GetColors.formreq#;"></td>
		<td><input type="text" size="30" name="Email" value="#attributes.Email#" class="formfield"  maxlength="75"/></td></tr>
		<tr><td align="right">FedEx Account Number:</td>
		<td  style="background-color: ###Request.GetColors.formreq#;"></td>
		<td><input type="text" size="20" name="AccountNo" value="#attributes.AccountNo#" class="formfield" maxlength="20"/></td></tr>
		<tr><td colspan="2"></td><td class="formtextsmall">
		(No spaces or dashes)
		</td></tr>

<tr><td colspan="3" align="center"> <br/>

<div align="center">
	<input type="submit" name="submit_fedex" value="Next" class="formbutton"/> 
	<input type="button" value="Cancel" onclick="javascript:CancelForm();" class="formbutton"/>
</div>
			
</td></tr>

</form>
</cfoutput>	
</cfmodule>

<cfprocessingdirective suppresswhitespace="no">
<script type="text/javascript">

function _customValidation(){
   if( objForm.ContactName.getValue() == "" && objForm.Company.getValue() == "" ){
     objForm.ContactName.throwError("You must supply a value for either the contact or the company name.");
   }
}


objForm = new qForm("fedex");

objForm.required("Address1,City,Zip,Phone,Email,Country,AccountNo");

//objForm.ContactName.description = "contact name";
objForm.Address1.description = "street address";
objForm.Zip.description = "postal code";
objForm.AccountNo.description = "FedEx account number";

objForm.AccountNo.validateLength(9);

objForm.State.createDependencyTo("Country", "US");
objForm.State.createDependencyTo("Country", "CA");

objForm.Zip.createDependencyTo("Country", "US");
objForm.Zip.createDependencyTo("Country", "CA");

objForm.Country.enforceDependency();

objForm.Phone.validatePhoneNumber();

objForm.Email.validateEmail();

objForm.onValidate = _customValidation;

qFormAPI.errorColor = "<cfoutput>###Request.GetColors.formreq#</cfoutput>";
</script>
</cfprocessingdirective>

