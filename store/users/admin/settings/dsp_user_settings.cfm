<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This is used to change the user settings. Called from users.admin&settings=save. --->

<cfmodule template="../../../customtags/format_admin_form.cfm"
	box_title="User Settings"
	width="550"
	>

	<cfoutput>
<form name="editform" action="#self#?fuseaction=users.admin&settings=save#request.token2#" method="post">

<tr>
	<td align="right" class="formtitle"><br/>Login Settings&nbsp;</td>
	<td colspan="2"><br/><cfmodule template="../../../customtags/putline.cfm" linetype="thin" linecolor="#Request.GetColors.InputHBgcolor#"/></td>
	</tr>
	
	<!--- Use Remember Me ----->
	<tr>
		<td align="right" nowrap="nowrap">Use Remember Me:</td>
		<td style="background-color: ###Request.GetColors.formreq#;" width="3">&nbsp;</td>
		<td><input type="radio" name="UseRememberMe" value="1" #doChecked(get_user_settings.UseRememberMe)# /> Yes 
		&nbsp;&nbsp; <input type="radio" name="UseRememberMe" value="0" #doChecked(get_user_settings.UseRememberMe,0)# /> No </td>
	</tr>
	<tr>
		<td colspan="2"></td>
		<td><span class="formtextsmall">Shows the checkbox on the login form to remember the user</span></td>
	</tr>
	
	<!--- Strict Logins ----->
	<tr>
		<td align="right" nowrap="nowrap">Strict Logins:</td>
		<td style="background-color: ###Request.GetColors.formreq#;"></td>
		<td><input type="radio" name="StrictLogins" value="1" #doChecked(get_user_settings.StrictLogins)# /> Yes
		&nbsp;&nbsp; <input type="radio" name="StrictLogins" value="0" #doChecked(get_user_settings.StrictLogins,0)# /> No </td>
	</tr>
	<tr>
		<td colspan="2"></td>
		<td><span class="formtextsmall">Only allow one person to login on an account at a time</span></td>
	</tr>
	
	<!--- Max Daily Logins ----->
	<tr>
		<td align="right" nowrap="nowrap">Max Daily Logins:</td>
		<td style="background-color: ###Request.GetColors.formreq#;"></td>
		<td><input type="text" name="MaxDailyLogins" size="10" maxlength="15" value="#get_user_settings.MaxDailyLogins#" class="formfield"/></td>
	</tr>
	<tr>
		<td colspan="2"></td>
		<td><span class="formtextsmall">Sets a maximum number of logins per user per day. Leave blank or 0 if not used.</span></td>
	</tr>
	
	<!--- Max Failures ----->
	<tr>
		<td align="right" nowrap="nowrap">Max Failed Logins:</td>
		<td style="background-color: ###Request.GetColors.formreq#;"></td>
		<td><input type="text" name="MaxFailures" size="10" maxlength="15" value="#get_user_settings.MaxFailures#" class="formfield"/></td>
	</tr>
	<tr>
		<td colspan="2"></td>
		<td><span class="formtextsmall">Sets a maximum number of failed logins. Locks user out for an hour if they exceed it to prevent hack attempts.</span></td>
	</tr>
	
<tr>
	<td align="right" class="formtitle"><br/>Address Settings&nbsp;</td>
	<td colspan="2"><br/><cfmodule template="../../../customtags/putline.cfm" linetype="thin" linecolor="#Request.GetColors.InputHBgcolor#"/></td>
	</tr>
	
	<!--- Use State List ----->
	<tr>
		<td align="right" nowrap="nowrap">Use State List:</td>
		<td style="background-color: ###Request.GetColors.formreq#;"></td>
		<td><input type="radio" name="UseStateList" value="1" #doChecked(get_user_settings.UseStateList)# /> Yes 
		 &nbsp;&nbsp; <input type="radio" name="UseStateList" value="0" #doChecked(get_user_settings.UseStateList,0)# /> No </td>
	</tr>
	<tr>
		<td colspan="2"></td>
		<td><span class="formtextsmall">Shows the drop-down list of states and provinces on address forms (for US and Canada)</span></td>
	</tr>
	
	<!--- Use State Box ----->
	<tr>
		<td align="right" nowrap="nowrap">Use State Box:</td>
		<td style="background-color: ###Request.GetColors.formreq#;"></td>
		<td><input type="radio" name="UseStateBox" value="1" #doChecked(get_user_settings.UseStateBox)# /> Yes 
		&nbsp;&nbsp; <input type="radio" name="UseStateBox" value="0" #doChecked(get_user_settings.UseStateBox,0)# /> No</td>
	</tr>
	<tr>
		<td colspan="2"></td>
		<td><span class="formtextsmall">Shows the free enter textbox for the state (region/county/etc)</span></td>
	</tr>
	
	<!--- Require County ----->
	<tr>
		<td align="right" nowrap="nowrap">Require County:</td>
		<td style="background-color: ###Request.GetColors.formreq#;"></td>
		<td><input type="radio" name="RequireCounty" value="1" #doChecked(get_user_settings.RequireCounty)# /> Yes
		 &nbsp;&nbsp; <input type="radio" name="RequireCounty" value="0" #doChecked(get_user_settings.RequireCounty,0)# /> No</td>
	</tr>
	<tr>
		<td colspan="2"></td>
		<td><span class="formtextsmall">If you enter counties for a state, this will require a user in the state(s) to select a county.</span></td>
	</tr>
	
	<!--- Use Country List ----->
	<tr>
		<td align="right" nowrap="nowrap">Use Country List:</td>
		<td style="background-color: ###Request.GetColors.formreq#;"></td>
		<td><input type="radio" name="UseCountryList" value="1" #doChecked(get_user_settings.UseCountryList)# /> Yes
		 &nbsp;&nbsp; <input type="radio" name="UseCountryList" value="0" #doChecked(get_user_settings.UseCountryList,0)# /> No </td>
	</tr>
	<tr>
		<td colspan="2"></td>
		<td><span class="formtextsmall">Shows the list of countries on address forms. If turned off, the home country will be used for all customers. </span></td>
	</tr>	
	
	<!--- Allow Shipping Address ----->
	<tr>
		<td align="right">Allow Shipping Address:</td>
		<td style="background-color: ###Request.GetColors.formreq#;"></td>
		<td><input type="radio" name="UseShipTo" value="1" #doChecked(get_user_settings.UseShipTo)# /> Yes
		 &nbsp;&nbsp; <input type="radio" name="UseShipTo" value="0" #doChecked(get_user_settings.UseShipTo,0)# /> No </td>
	</tr>
	<tr>
		<td colspan="2"></td>
		<td><span class="formtextsmall">Turns on the shipping address entry form, otherwise shipping is only allowed to the billing address</span></td>
	</tr>
	
	<!--- Residential Field ----->
	<tr>
		<td align="right">Use Residential Box:</td>
		<td style="background-color: ###Request.GetColors.formreq#;"></td>
		<td><input type="radio" name="UseResidential" value="1" #doChecked(get_user_settings.UseResidential)# /> Yes
		 &nbsp;&nbsp; <input type="radio" name="UseResidential" value="0" #doChecked(get_user_settings.UseResidential,0)# /> No </td>
	</tr>
	<tr>
		<td colspan="2"></td>
		<td><span class="formtextsmall">Displays a checkbox to set if addresses are residential, useful for more accurate API shipping rates (UPS, FedEx, Intershipper). If turned off, default is for all addresses set as residential.</span></td>
	</tr>

<tr>
	<td align="right" class="formtitle"><br/>Login Accounts&nbsp;</td>
	<td colspan="2"><br/><cfmodule template="../../../customtags/putline.cfm" linetype="thin" linecolor="#Request.GetColors.InputHBgcolor#"/></td>
	</tr>

	<!--- Use Email As Username ----->
	<tr>
		<td align="right" nowrap="nowrap">Use Email As Username:</td>
		<td style="background-color: ###Request.GetColors.formreq#;"></td>
		<td><input type="radio" name="EmailAsName" value="1" #doChecked(get_user_settings.EmailAsName)# /> Yes
		 &nbsp;&nbsp; <input type="radio" name="EmailAsName" value="0" #doChecked(get_user_settings.EmailAsName,0)# /> No </td>
	</tr>
	<tr>
		<td colspan="2"></td>
		<td><span class="formtextsmall">Use the customer's email address for their username</span></td>
	</tr>
		
	<!--- Use Group Code ----->
	<tr>
		<td align="right" nowrap="nowrap">Use Group Code:</td>
		<td style="background-color: ###Request.GetColors.formreq#;"></td>
		<td><input type="radio" name="UseGroupCode" value="1" #doChecked(get_user_settings.UseGroupCode)# /> Yes
		 &nbsp;&nbsp; <input type="radio" name="UseGroupCode" value="0" #doChecked(get_user_settings.UseGroupCode,0)# /> No </td>
	</tr>
	<tr>
		<td colspan="2"></td>
		<td><span class="formtextsmall">This gives the user a field when registering to enter the group code and automatically assign themselves to a group in your store.</span></td>
	</tr>
	
	<!--- Use Birthdate ----->
	<tr>
		<td align="right" nowrap="nowrap">Use Birthdate:</td>
		<td style="background-color: ###Request.GetColors.formreq#;"></td>
		<td><input type="radio" name="UseBirthdate" value="1" #doChecked(get_user_settings.UseBirthdate)# /> Yes
		 &nbsp;&nbsp; <input type="radio" name="UseBirthdate" value="0" #doChecked(get_user_settings.UseBirthdate,0)# /> No </td>
	</tr>
	<tr>
		<td colspan="2"></td>
		<td><span class="formtextsmall">Turns on the birthday field in the registration form</span></td>
	</tr>
	
	<!--- User Credit Cards ----->
	<tr>
		<td align="right">User Credit Cards:</td>
		<td style="background-color: ###Request.GetColors.formreq#;"></td>
		<td>
		<input type="radio" name="useCCard" value="1" #doChecked(get_user_settings.useCCard)#  />Yes 
		&nbsp;&nbsp; <input type="radio" name="useCCard" value="0" #doChecked(get_user_settings.useCCard,0)#  />No </td>
	</tr>
	<tr>
		<td colspan="2"></td>
		<td><span class="formtextsmall">For sites that wish to keep a credit card on file for repeated billing, puts a entry for it on the registration. Due to PCI Compliance regulations, this setting is only supported for Shift4 online processing which uses tokens and does not store actual credit card data.</span></td>
	</tr>	
	
	<!--- Subscribe ----->
	<tr>
		<td align="right">Subscribe Box:</td>
		<td style="background-color: ###Request.GetColors.formreq#;"></td>
		<td><input type="radio" name="ShowSubscribe" value="1" #doChecked(get_user_settings.ShowSubscribe)# /> Yes
		 &nbsp;&nbsp; <input type="radio" name="ShowSubscribe" value="0" #doChecked(get_user_settings.ShowSubscribe,0)# /> No </td>
	</tr>
	<tr>
		<td colspan="2"></td>
		<td><span class="formtextsmall">This turns on the checkbox on registration forms for the customer to subscribe to your mailing list</span></td>
	</tr>
	
	<!--- Email Confirmations ----->
	<tr>
		<td align="right">Email Confirmations:</td>
		<td style="background-color: ###Request.GetColors.formreq#;"></td>
		<td><input type="radio" name="UseEmailConf" value="1" #doChecked(get_user_settings.UseEmailConf)# /> Yes
		 &nbsp;&nbsp; <input type="radio" name="UseEmailConf" value="0" #doChecked(get_user_settings.UseEmailConf,0)# /> No </td>
	</tr>
	<tr>
		<td colspan="2"></td>
		<td><span class="formtextsmall">Sends an email confirmation to the user to activate the registration</span></td>
	</tr>
	
	<!--- Member Notifications ----->
	<tr>
		<td align="right">Member Notifications:</td>
		<td style="background-color: ###Request.GetColors.formreq#;"></td>
		<td><input type="radio" name="MemberNotify" value="1" #doChecked(get_user_settings.MemberNotify)# /> Yes
		 &nbsp;&nbsp; <input type="radio" name="MemberNotify" value="0" #doChecked(get_user_settings.MemberNotify,0)# /> No </td>
	</tr>
	<tr>
		<td colspan="2"></td>
		<td><span class="formtextsmall">Sends an email notification to the admin when a new login account is created</span></td>
	</tr>
	
	<!--- Affiliate Signups ----->
	<tr>
		<td align="right">Affiliate Signups:</td>
		<td style="background-color: ###Request.GetColors.formreq#;"></td>
		<td><input type="radio" name="AllowAffs" value="1" #doChecked(get_user_settings.AllowAffs)# /> Yes
		 &nbsp;&nbsp; <input type="radio" name="AllowAffs" value="0" #doChecked(get_user_settings.AllowAffs,0)# /> No 
		 &nbsp; Percentage: <input type="text" name="AffPercent" value="#(get_user_settings.AffPercent * 100)#" size="5" maxlength="15" class="formfield"/></td>
	</tr>
	<tr>
		<td colspan="2"></td>
		<td><span class="formtextsmall">Allows users to sign up as an affiliate. If turned off, affiliates can still be added by the admin. </span></td>
	</tr>
	
<tr>
	<td align="right" class="formtitle"><br/>Business Accounts&nbsp;</td>
	<td colspan="2"><br/><cfmodule template="../../../customtags/putline.cfm" linetype="thin" linecolor="#Request.GetColors.InputHBgcolor#"/></td>
	</tr>	
	
	<!--- Require Accounts ----->
	<tr>
		<td align="right">Require Accounts:</td>
		<td style="background-color: ###Request.GetColors.formreq#;"></td>
		<td><input type="radio" name="UseAccounts" value="1" #doChecked(get_user_settings.UseAccounts)# /> Yes
		 &nbsp;&nbsp; <input type="radio" name="UseAccounts" value="0" #doChecked(get_user_settings.UseAccounts,0)# /> No </td>
	</tr>
	<tr>
		<td colspan="2"></td>
		<td><span class="formtextsmall">This will require all users to create a business account</span></td>
	</tr>
	
	<tr>
		<td align="right">Account Signups:</td>
		<td style="background-color: ###Request.GetColors.formreq#;"></td>
		<td><input type="radio" name="AllowWholesale" value="1" #doChecked(get_user_settings.AllowWholesale)# /> Yes
		 &nbsp;&nbsp; <input type="radio" name="AllowWholesale" value="0" #doChecked(get_user_settings.AllowWholesale,0)# /> No </td>
	</tr>
	<tr>
		<td colspan="2"></td>
		<td><span class="formtextsmall">Allows any user to create a business account</span></td>
	</tr>
	
	<!--- Show Accounts ----->
	<tr>
		<td align="right">Show Accounts:</td>
		<td style="background-color: ###Request.GetColors.formreq#;"></td>
		<td><input type="radio" name="ShowAccount" value="1" #doChecked(get_user_settings.ShowAccount)# /> Yes
		 &nbsp;&nbsp; <input type="radio" name="ShowAccount" value="0" #doChecked(get_user_settings.ShowAccount,0)# /> No </td>
	</tr>
	<tr>
		<td colspan="2"></td>
		<td><span class="formtextsmall">This will display the user's business account information on the My Account page so they can edit it themsevles.</span></td>
	</tr>
	
	<!--- Show Directory ----->
	<tr>
		<td align="right">Show Directory:</td>
		<td style="background-color: ###Request.GetColors.formreq#;"></td>
		<td><input type="radio" name="ShowDirectory" value="1" #doChecked(get_user_settings.ShowDirectory)# /> Yes
		 &nbsp;&nbsp; <input type="radio" name="ShowDirectory" value="0" #doChecked(get_user_settings.ShowDirectory,0)# /> No </td>
	</tr>
	<tr>
		<td colspan="2"></td>
		<td><span class="formtextsmall">This will allow the user to view their information and change it for the Store Directory page (list of retailers)</span></td>
	</tr>	
	
	<!--- Account Notifications ----->
	<tr>
		<td align="right">Account Notifications:</td>
		<td style="background-color: ###Request.GetColors.formreq#;"></td>
		<td><input type="radio" name="UseEmailNotif" value="1" #doChecked(get_user_settings.UseEmailNotif)# /> Yes
		 &nbsp;&nbsp; <input type="radio" name="UseEmailNotif" value="0" #doChecked(get_user_settings.UseEmailNotif,0)# /> No </td>
	</tr>
	<tr>
		<td colspan="2"></td>
		<td><span class="formtextsmall">Sends an email notification to the admin when a business account is created</span></td>
	</tr>
	
	<!--- Use Terms ----->
	<tr>
		<td align="right">Use Terms:</td>
		<td style="background-color: ###Request.GetColors.formreq#;"></td>
		<td><input type="radio" name="UseTerms" value="1" #doChecked(get_user_settings.UseTerms)# /> Yes 
		&nbsp;&nbsp; <input type="radio" name="UseTerms" value="0" #doChecked(get_user_settings.UseTerms,0)# /> No </td>
	</tr>
	<tr>
		<td colspan="2"></td>
		<td><span class="formtextsmall">Adds the terms and conditions in the registration form that the user must agree to</span></td>
	</tr>
	
	<!--- Text for Terms ----->
	<tr>
		<td align="right" valign="top">Text for Terms:</td>
		<td></td>
		<td><textarea cols="30" rows="5" name="TermsText" class="formfield">#get_user_settings.TermsText#</textarea>	</td>
	</tr>
	<cfinclude template="../../../includes/form/put_space.cfm">
		
	<tr>
		<td>&nbsp;</td>
		<td></td>
		<td><input class="formbutton" type="submit" value="Save Changes"/>
		<input type="button" value="Cancel" onclick="javascript:window.history.go(-1);" class="formbutton"/>

		</td>
	</tr>
</form>

<cfprocessingdirective suppresswhitespace="no">
<script type="text/javascript">
<!--//
// initialize the qForm object
objForm = new qForm("editform");

objForm.required("UseRememberMe,EmailAsName,StrictLogins,UseStateList,UseStateBox,RequireCounty,UseCountryList,UseGroupCode,UseBirthdate,useCCard,UseEmailConf,MemberNotify,UseEmailNotif,UseShipTo,UseAccounts,ShowAccount,ShowDirectory,ShowSubscribe,UseTerms");

qFormAPI.errorColor = "###Request.GetColors.formreq#";
//-->
</script>
</cfprocessingdirective>

</cfoutput>
</cfmodule>

