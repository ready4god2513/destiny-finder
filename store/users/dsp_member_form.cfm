<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This Member form provides an easy user registration form for sites. it is called by the users.member fuseaction

This form can be used as the default user registration form. This form collects both log-in info and address info on a single form unlike the normal registration process which has users first register then fill out a customer form. The store can be set to use this sign-up page rather than the default registration system by changing the following variable on the fbx_settings.cfm template in the root directory (at around line 108):

	Change: 	<CFPARAM NAME="request.reg_form" DEFAULT="register">  
	to be:  	<CFPARAM NAME="request.reg_form" DEFAULT="member"> 

The form has several sections. Only information which is required by the store and missing from the users record is displayed.

	Sign-in (user) section:
		User_Name,Password,email,birthdate,subscribe,(agreement)
	Birthdate
	Group Code
	Customer section:
		FirstName,LastName,Company, Address1, Address2, city, state, state2, zip, 
		country, Phone,Fax
	Credit Card
	Subscribe
	Terms
------->

<cfparam name="attributes.Message" default="">
<cfparam name="attributes.xfa_success" default="#self#?fuseaction=users.manager">


<!--- if user is not logged in then we are adding a new Member ---->
<cfif not Session.User_ID>

	<cfset attributes.fieldlist="Username,Password,Verify,email,groupcode,birthdate,Subscribe,agree,FirstName,LastName,Company,Address1,Address2,City,County,State,State2,Zip,Country,Phone,Phone2,Fax,Residence,CardType,NameOnCard,CardNumber,CardExpire,CardZip,month,year,customer_id">

	<cfloop list="#attributes.fieldlist#" index="counter">
		<cfparam name="attributes.#counter#" default="">
	</cfloop>   
	
	<cfinclude template="../queries/qry_getstates.cfm">
	<cfinclude template="../queries/qry_getcounties.cfm">
	<cfinclude template="../queries/qry_getcountries.cfm">
	
	<cfset attributes.CardisValid = 0>
	<cfset attributes.customer_id = 0>
	<cfset act_title="New Member">

	
<!--- if user IS logged in then get their User info and the Customer info ---->
<cfelse>

	<cfset attributes.fieldlist="Username,Password,email,birthdate,Subscribe,customer_id,CardisValid,cardtype,NameOnCard,cardnumber,cardexpire,cardzip">

	<cfloop list="#attributes.fieldlist#" index="counter">
		<cfset "attributes.#counter#" = evaluate("qry_get_user." & counter)>
	</cfloop>
	
	<cfset attributes.Verify = attributes.password>
		
	<cfif attributes.customer_id is "0">
		<cfloop list="FirstName,LastName,company,address1,address2,city,county,state,state2,zip,country,phone,phone2,fax,residence" index="counter">
			<cfparam name="attributes.#counter#" default="">
		</cfloop>   
	
		<cfinclude template="../queries/qry_getstates.cfm">
		<cfinclude template="../queries/qry_getcounties.cfm">
		<cfinclude template="../queries/qry_getcountries.cfm">
	
	</cfif>
	
	<cfparam name="attributes.Verify" default="">
	<cfparam name="attributes.groupcode" default="">
	<cfparam name="attributes.month" default="#Month(attributes.cardexpire)#">
	<cfparam name="attributes.year" default="#Year(attributes.cardexpire)#">
	<cfparam name="attributes.agree" default="">
	
	<cfset act_title="Update Member Information">

</cfif>	


<cfoutput>
<form name="editform" action="#XHTMLFormat('#request.self#?#attributes.xfa_submit_member##request.token2#')#" 
method="post" <cfif get_User_Settings.UseTerms is 1 and Session.User_ID is 0> onsubmit="return checkCheckBox(editform)"</cfif> >

<input type="hidden" name="xfa_success" value="#HTMLEditFormat(attributes.xfa_success)#"/> 
<input type="hidden" name="customer_id" value="#HTMLEditFormat(attributes.customer_id)#"/>
</cfoutput>

<cfmodule template="../customtags/format_input_form.cfm"
box_title="#act_title#"
width="400">

<!--- Display error message if one exists --->
<cfinclude template="../includes/form/put_message.cfm">

<!--- Display login information if needed --->
<cfif not Session.User_ID>
	<tr><td colspan="3" class="formtitle">&nbsp;Sign in Information</td></tr> 
	<cfinclude template="formfields/put_login.cfm">
<cfelse>
	<cfoutput>
	<tr style="display:none"><td colspan="3">
	<input type="hidden" name="Username" value="#HTMLEditFormat(attributes.Username)#"/> 
	<input type="hidden" name="password" value="#HTMLEditFormat(attributes.password)#"/> 
	<input type="hidden" name="email" value="#HTMLEditFormat(attributes.email)#"/> 
	<input type="hidden" name="Verify" value="#HTMLEditFormat(attributes.password)#"/> 
	</td></tr>
	</cfoutput>
</cfif>	

<cfinclude template="formfields/put_birthdate.cfm">

<cfinclude template="formfields/put_groupcode.cfm">

<!--- CONTACT address info if missing --->
<cfif attributes.customer_id is "0">
	<tr align="left"><td colspan="3" class="formtitle"><br/>&nbsp;Contact Information</td></tr> 
	<cfinclude template="formfields/put_contact.cfm">
</cfif>

<!--- Credit Card info if used ---->
<cfif get_User_Settings.UseCCard AND NOT attributes.CardisValid>
	<cfset attributes.ccform="users">
	<tr align="left"><td colspan="3" class="formtitle"><br/>&nbsp;Billing Information</td></tr>
	<cfinclude template="../shopping/qry_get_order_settings.cfm">
	<cfinclude template="formfields/put_ccard.cfm">
</cfif>
	<cfoutput>
	<tr style="display:none"><td colspan="3">
	<input type="hidden" name="CardisValid" value="#attributes.CardisValid#"/>
	</td></tr>
	</cfoutput> 


<!--- Subscribe field if used ---->
<cfif not Session.User_ID>
	<cfinclude template="formfields/put_subscribe.cfm">
</cfif>

<!--- Terms if used ---->
<cfif not Session.User_ID>
	<cfinclude template="formfields/put_terms.cfm">
</cfif>

<cfinclude template="../includes/form/put_space.cfm">

	<tr align="left">
    	<td></td><td></td>
		<td>
		<cfif Session.User_ID>
		<input type="submit" name="submit_member" value="Update Information" class="formbutton"/>
		<cfelse>
		<input type="submit" name="submit_member" value="Submit" class="formbutton"/>
		</cfif>
		
		<input type="button" value="Cancel" onclick="javascript:window.history.go(-1);" class="formbutton"/>
		</td>
    	</tr>

</cfmodule>

</form>

<cfparam name="get_Order_Settings.usecvv2" default="0">

<cfprocessingdirective suppresswhitespace="no">
<script type="text/javascript">
<!--//
objForm = new qForm("editform");

objForm.required("email,Username,password,Verify<cfif attributes.customer_id IS 0>,FirstName,LastName,Address1,City,Zip</cfif><cfif not attributes.CardisValid AND get_User_Settings.UseCCard>,nameoncard,CardNumber</cfif>");
	
objForm.Username.description = "User Name";
<cfif attributes.customer_id IS 0>
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
<cfif NOT attributes.CardisValid AND get_User_Settings.UseCCard>
	objForm.nameoncard.description = "Name on Card";
	objForm.CardNumber.description = "Card Number";
	objForm.CardNumber.validateCreditCard();
</cfif>

<!--- comment out to allow "toll free" or other text in phone2 field
objForm.Phone.validatePhoneNumber();
objForm.Phone.validateFormat("Phone2");
 ---->
 
objForm.Verify.description = "re-entered password";
objForm.password.validatePassword('Verify',6,20);
objForm.email.validateEmail();

<cfif get_User_Settings.EmailAsName>
	objForm.email.focus();
<cfelse>
	objForm.Username.focus();
</cfif>

qFormAPI.errorColor = "<cfoutput>###Request.GetColors.formreq#</cfoutput>";
//-->
</script>
</cfprocessingdirective>
