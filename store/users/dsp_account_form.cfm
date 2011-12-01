<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This page is used to both to register users with new accounts and add/edit account information for current users. If the user is registering for the first time, it displays User, customer and account fields. If a user is already logged in, it shows only account info to be added or edited. Called by the users.account fuseaction
--->

<cfparam name="attributes.Message" default="">
<cfparam name="Box_title" default="Update Account">

	
<cfinclude template="../queries/qry_getstates.cfm">
<cfinclude template="../queries/qry_getcounties.cfm">
<cfinclude template="../queries/qry_getcountries.cfm">
	
<cfif not qry_get_user.recordcount or qry_get_user.accountID is '' or qry_get_user.accountID is 0>
	
	<!---if this form is not submitting to itself, initialize fields --->
		<cfset attributes.fieldlist="Username,Password,birthdate,groupcode,agree,verify,Email,FirstName,LastName,Company,Address1,Address2,City,County,State,State2,Zip,Country,Phone,Phone2,Fax,Residence,Email,Acc_Account_Name,Acc_Description,Acc_logo,Acc_Policy,Acc_type1,Acc_rep,acc_web_url,Acc_terms,Acc_Map_URL,subscribe,CardType,NameOnCard,CardNumber,CardExpire,CardZip,month,year">
	<cfloop list="#attributes.fieldlist#" index="counter">
		<cfparam name="attributes.#counter#" default="">
	</cfloop>   	
	<cfif attributes.acc_web_url is "">
		<cfset attributes.acc_web_url = "http://">
	</cfif>
	
	<cfset Box_title="New Account">
</cfif>


<cfset attributes.CardisValid = 0>
	
<cfinclude template="../queries/qry_getpicklists.cfm">

<!--- <cfinclude template="../includes/imagepreview.js"> --->

<cfoutput>
	<form name="editform" action="#XHTMLFormat('#self#?#attributes.xfa_submit_account##request.token2#')#" method="post" 
	<cfif get_User_Settings.UseTerms is 1> onsubmit="return checkCheckBox(editform)"</cfif> >
</cfoutput>

<cfmodule template="../customtags/format_input_form.cfm"
box_title="#Box_title#"
width="450">

<cfinclude template="../includes/form/put_message.cfm">

<cfoutput>
  	<tr align="left">
    	<td align="right" width="25%">Account Name: </td>
		<td style="background-color: ###Request.GetColors.formreq#;" width="3">&nbsp;</td>
    	<td><input type="text" size="40" name="Acc_Account_Name" value="#HTMLEditFormat(attributes.Acc_Account_Name)#" class="formfield"/></td></tr>

	<tr align="left">
    	<td align="right" valign="top">Type of Account: </td>
		<td style="background-color: ###Request.GetColors.formreq#;"></td>
    	<td align="left">
		<select name="Acc_type1" size="1" class="EditField">
			<option value="retailer" #doSelected(attributes.acc_type1,"retailer")#>retailer</option>
			<cfmodule template="../customtags/form/dropdown.cfm"
			mode="valuelist"
			valuelist="#qry_getPicklists.acc_type1#"
			selected="#attributes.acc_type1#"
			/>
            </select>
		</td></tr>	
</cfoutput>	
<cfinclude template="../includes/form/put_space.cfm">

<cfif Session.User_ID is 0>
	<tr align="left">
    	<td colspan="3" class="formtitle">Log in</td></tr> 
	<cfinclude template="formfields/put_login.cfm">
	<cfinclude template="formfields/put_birthdate.cfm">
	<cfinclude template="formfields/put_groupcode.cfm">
	<cfinclude template="../includes/form/put_space.cfm">
</cfif>


<!--- contact ---> 	
<cfif not qry_get_user.recordcount OR not qry_get_user.customer_id OR 
		(isdefined('qry_get_account') AND qry_get_account.customer_ID lt 1) >
	<tr align="left">
    	<td colspan="3" class="formtitle">Contact</td></tr> 
		
	<cfset attributes.mode="account">
	<cfinclude template="formfields/put_contact.cfm">	
	<cfinclude template="../includes/form/put_space.cfm">
</cfif>


<!--- Credit Card info if used ---->
<cfif Session.User_ID is 0 and get_User_Settings.UseCCard>
	<cfset attributes.ccform="users">
	<tr align="left"><td colspan="3" class="formtitle">Billing Information</td></tr>
	<cfinclude template="../shopping/qry_get_order_settings.cfm">
	<cfinclude template="formfields/put_ccard.cfm">
	<cfinclude template="../includes/form/put_space.cfm">
</cfif>

<cfoutput>

<!--- The following Account fields are OPTIONAL. If your company does not use them, simply comment them out. --->
	<tr align="left">
    	<td colspan="3" class="formtitle">Account Profile</td></tr> 
		
	<tr align="left">
	  	<td align="right" valign="top">Description of business</td>
    	<td></td>
		<td align="left"><textarea cols="40" name="Acc_Description" rows="6" class="formfield">#HTMLEditFormat(attributes.Acc_Description)#</textarea>
		</td></tr>		
		

<!--- 	<tr>
    	<td align="right" valign="top">Logo: </td>
    	<td></td>
		<td align="left">
		<input name="Acc_logo" value="#HTMLEditFormat(attributes.Acc_logo)#" size="30" maxlength="100" class="formfield" />
		</td></tr> --->

   <!--- Web URL --->		
	<tr align="left">
		<td align="right">Company URL:</td>
		<td></td>
		<td><input type="text" name="acc_web_url" value="#HTMLEditFormat(attributes.acc_web_url)#" size="40" maxlength="100" class="formfield" /></td>
	</tr>
	
   <!--- Map URL --->		
	<tr align="left">
		<td align="right">Store Map:</td>
		<td></td>
		<td><input type="text" name="Acc_map_url" value="#HTMLEditFormat(attributes.acc_map_url)#" size="40" class="formfield" /><br/>
			<span class="formtextsmall">Link to a map of your store location (google, etc.)</span>
		</td>
	</tr>			
			
	<tr align="left">
		<td align="right" valign="top">Policy: </td>
		<td></td>
    	<td align="left">
			<textarea cols="30" name="Acc_Policy" rows="6" class="formfield">#HTMLEditFormat(attributes.Acc_Policy)#</textarea></td></tr>	

			
		<tr align="left">
    	<td align="right" valign="top">Your Rep: </td>
		<td></td>
    	<td align="left">
		<select name="Acc_rep" size="1" class="formfield">
			<cfmodule template="../customtags/form/dropdown.cfm"
			mode="valuelist"
			valuelist="#qry_getPicklists.acc_rep#"
			selected="#attributes.acc_rep#"
			/>
            </select>
		</td></tr>			
		
	  	<tr align="left">
    	<td align="right">Account Terms: </td>
		<td></td>
    	<td><input type="text" size="30" maxlength="50" name="Acc_terms" value="#HTMLEditFormat(attributes.Acc_terms)#" class="formfield"/></td></tr>

		
</cfoutput>


<!--- Subscribe field if used ---->
<cfif not Session.User_ID>
	<cfinclude template="formfields/put_subscribe.cfm">
</cfif>


<!---- ACCEPT AND SUBMIT --->
<cfif not qry_get_user.recordcount or qry_get_user.accountID is '' or qry_get_user.accountID is 0>
	<cfinclude template="formfields/put_terms.cfm">
</cfif>

<cfoutput>
	<tr align="left">
    	<td></td>
		<td></td>
		<td><br/><input type="submit" name="submit_account" value="Submit Account" class="formbutton"/> 
			<input type="button" value="Cancel" onclick="javascript:window.history.go(-1);" class="formbutton"/></td>
    	</tr>
</cfoutput>


</cfmodule>

</form>

<cfparam name="get_Order_Settings.usecvv2" default="0">

<cfprocessingdirective suppresswhitespace="no">
<script type="text/javascript">
<!--
objForm = new qForm("editform");

objForm.required("Acc_Account_Name<cfif Session.User_ID IS 0>,email,Username,password,Verify</cfif><cfif not qry_get_user.recordcount or not qry_get_user.customer_id>,FirstName,LastName,Address1,City,Zip</cfif><cfif Session.User_ID is 0 and not attributes.cardisvalid AND get_User_Settings.UseCCard>,nameoncard,CardNumber</cfif>");

<!--- comment out to allow "toll free" or other text in phone2 field
objForm.Phone.validatePhoneNumber();
objForm.Phone.validateFormat("Phone2");
 ---->

objForm.Acc_Account_Name.description = "Account Name";
<cfif NOT qry_get_user.recordcount OR NOT qry_get_user.customer_id>
	objForm.FirstName.description = "First Name";
	objForm.LastName.description = "Last Name";
	objForm.Address1.description = "Address";
	<cfif ShowCounties AND get_User_Settings.RequireCounty>
		requireCounties();
	</cfif>
	<!--- Require a state if the country is US or Canada --->
	objForm.State.createDependencyTo("Country", "US^United States");
	objForm.State.createDependencyTo("Country", "CA^Canada");
	objForm.Country.enforceDependency();
	
</cfif>
<cfif Session.User_ID IS 0>
	objForm.Username.description = "User Name";
	objForm.Verify.description = "re-entered password";
	objForm.password.validatePassword('Verify',6,20);
	objForm.email.validateEmail();
</cfif>
<cfif Session.User_ID IS 0 AND get_User_Settings.UseCCard>
	objForm.nameoncard.description = "Name on Card";
	objForm.CardNumber.description = "Card Number";
	objForm.CardNumber.validateCreditCard();
	
	<cfif get_Order_Settings.usecvv2>
		objForm.CVV2.description = "Card Check Code";
	</cfif>
</cfif>

objForm.Acc_Account_Name.focus();

qFormAPI.errorColor = "<cfoutput>###Request.GetColors.formreq#</cfoutput>";
//-->
</script>
</cfprocessingdirective>

