<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This is used to change the shopping cart settings. Called by shopping.admin&cart=edit --->

<cfmodule template="../../../customtags/format_admin_form.cfm"
	box_title="Shopping and Checkout Settings"
	width="550"
	>

	<cfoutput>
<form name="editform" action="#self#?fuseaction=shopping.admin&cart=save#request.token2#" method="post">

<!---- Checkout settings ----->	
<tr>
	<td align="RIGHT" class="formtitle" nowrap="nowrap"><br/>Shopping Options</td>
	<td colspan="2"><br/><cfmodule template="../../../customtags/putline.cfm" linetype="thin" linecolor="#Request.GetColors.InputHBgcolor#"/></td>
	</tr>

<!--- showbasket ---->
<tr><td align="RIGHT">Show Cart Between Orders:</td>
<td style="background-color: ###Request.GetColors.formreq#;" width="3">&nbsp;</td>
<td><input type="radio" name="showbasket" value="1" #doChecked(get_order_settings.showbasket)# /> Yes  
&nbsp;&nbsp; <input type="radio" name="showbasket" value="0" #doChecked(get_order_settings.showbasket,0)# /> No
</td></tr>


<!--- Custom Code - GIFTREGISTRY UPGRADE: added field to query. ------->
	<tr>
		<td align="RIGHT">Use Gift Registry:</td>
		<td style="background-color: ###Request.GetColors.formreq#;"></td>
		<td><input type="radio" name="giftregistry" value="1" #doChecked(Request.AppSettings.giftregistry)# /> Yes
		 &nbsp;&nbsp; <input type="radio" name="giftregistry" value="0" #doChecked(Request.AppSettings.giftregistry,0)# /> No </td>
	</tr>
<!--- end Custom Code ------>

<!--- Custom Code - GIFTWRAP UPGRADE: added field to query. ------->
	<tr>
		<td align="RIGHT">Offer Gift Wrapping:</td>
		<td style="background-color: ###Request.GetColors.formreq#;"></td>
		<td><input type="radio" name="giftwrap" value="1" #doChecked(get_order_settings.giftwrap)# /> Yes 
		&nbsp;&nbsp; <input type="radio" name="giftwrap" value="0" #doChecked(get_order_settings.giftwrap,0)# /> No </td>
	</tr>
<!--- end Custom Code ------>

	<tr>
		<td align="RIGHT">Use Coupons/Certificates:</td>
		<td style="background-color: ###Request.GetColors.formreq#;"></td>
		<td><input type="radio" name="coupons" value="1" #doChecked(get_order_settings.coupons)# /> Yes 
		&nbsp;&nbsp; <input type="radio" name="coupons" value="0" #doChecked(get_order_settings.coupons,0)# /> No </td>
	</tr>
	

<!---- Checkout settings ----->	
<tr>
	<td align="RIGHT" class="formtitle" nowrap="nowrap"><br/>Checkout Options</td>
	<td colspan="2"><br/><cfmodule template="../../../customtags/putline.cfm" linetype="thin" linecolor="#Request.GetColors.InputHBgcolor#"/></td>
	</tr>
	
	<tr>
		<td align="RIGHT">Min. Order Total:</td>
		<td style="background-color: ###Request.GetColors.formreq#;"></td>
		<td><input type="text" name="mintotal" class="formfield" value="#get_Order_Settings.mintotal#" size="9"/> </td>
	</tr>
<tr><td>&nbsp;</td><td colspan="2"><span class="formtextsmall">Checkout not allowed for basket totals below this amount.</span></td></tr>

<tr>
		<td align="RIGHT">International Orders:</td>
		<td style="background-color: ###Request.GetColors.formreq#;"></td>
		<td><input type="radio" name="AllowInt" value="1" #doChecked(get_Order_Settings.AllowInt)# />Yes 
			&nbsp; <input type="radio" name="AllowInt" value="0" #doChecked(get_Order_Settings.AllowInt,0)# />No </td>
	</tr>
<tr><td>&nbsp;</td><td colspan="2"><span class="formtextsmall">Sets if you will ship orders outside your home country. Be sure to configure the User and Shipping settings as appropriate.</span></td></tr>
	
	<tr>
		<td align="RIGHT">Skip Address Form:</td>
		<td style="background-color: ###Request.GetColors.formreq#;"></td>
		<td><input type="radio" name="SkipAddressForm" value="1" #doChecked(get_order_settings.SkipAddressForm)# /> Yes
		&nbsp;&nbsp; <input type="radio" name="SkipAddressForm" value="0" #doChecked(get_order_settings.SkipAddressForm,0)# /> No </td>
	</tr>
<tr><td>&nbsp;</td><td colspan="2"><span class="formtextsmall">Allows user to skip the address form if they have default addresses entered.</span></td></tr>

	<tr>
		<td align="RIGHT">Require Login to Checkout:</td>
		<td style="background-color: ###Request.GetColors.formreq#;"></td>
		<td><input type="radio" name="NoGuests" value="1" #doChecked(get_Order_Settings.NoGuests)# />Yes 
			&nbsp; <input type="radio" name="NoGuests" value="0" #doChecked(get_Order_Settings.NoGuests,0)# />No </td>
	</tr>
<tr><td>&nbsp;</td><td colspan="2"><span class="formtextsmall">Leave this turned off to allow guest checkouts.</span></td></tr>

	<tr>
		<td align="RIGHT">Use Gift Cards:</td>
		<td style="background-color: ###Request.GetColors.formreq#;"></td>
		<td><input type="radio" name="giftcard" value="1" #doChecked(get_order_settings.giftcard)# /> Yes 
		&nbsp;&nbsp; <input type="radio" name="giftcard" value="0" #doChecked(get_order_settings.giftcard,0)# /> No </td>
	</tr>
	
	<tr>
		<td align="RIGHT">Use Delivery Date:</td>
		<td style="background-color: ###Request.GetColors.formreq#;"></td>
		<td><input type="radio" name="delivery" value="1" #doChecked(get_order_settings.delivery)# /> Yes 
		&nbsp;&nbsp; <input type="radio" name="delivery" value="0" #doChecked(get_order_settings.delivery,0)# /> No </td>
	</tr>
	
	<tr>
		<td align="RIGHT">Allow Backorders?:</td>
		<td style="background-color: ###Request.GetColors.formreq#;"></td>
		<td><input type="radio" name="backorders" value="1" #doChecked(get_order_settings.backorders)# /> Yes
		&nbsp;&nbsp; <input type="radio" name="backorders" value="0" #doChecked(get_order_settings.backorders,0)# /> No </td>
	</tr>
	

	<tr>
		<td align="RIGHT">Base Order Number:</td>
		<td></td>
		<td><input type="text" name="baseordernum" value="#get_order_settings.baseordernum#" size="15" maxlength="50" class="formfield"/></td>
	</tr>
	
<!---- Checkout terms ----->	
<tr>
	<td align="RIGHT" class="formtitle" nowrap="nowrap"><br/>Terms Agreement</td>
	<td colspan="2"><br/><cfmodule template="../../../customtags/putline.cfm" linetype="thin" linecolor="#Request.GetColors.InputHBgcolor#"/></td>
	</tr>
<tr><td>&nbsp;</td><td colspan="2"><span class="formtextsmall">Enter text here if you have terms you wish the user to agree<br/>
to in order to complete the checkout process.</span></td></tr>
<tr>
		<td align="RIGHT"></td>
		<td></td>
		<td><textarea cols="35" rows="8" name="AgreeTerms" class="formfield">#HTMLEditFormat(get_order_settings.AgreeTerms)#</textarea></td>
	</tr>
	
<!---- custom checkout fields ----->	
<tr>
	<td align="RIGHT" class="formtitle" nowrap="nowrap"><br/>Custom Checkout Fields</td>
	<td colspan="2"><br/><cfmodule template="../../../customtags/putline.cfm" linetype="thin" linecolor="#Request.GetColors.InputHBgcolor#"/></td>
	</tr>
<tr><td>&nbsp;</td><td colspan="2"><span class="formtextsmall">These custom fields can be used to prompt the customer for additional information while checking out.<br/>
Example: "How did you hear about us?"</span></td></tr>

<!--- Custom text fields --->
<cfloop index="num" from="1" to="3">
<tr>
		<td align="RIGHT">Text Field #num# Label:</td>
		<td></td>
		<td><input type="text" name="CustomText#num#" value="#Evaluate('get_order_settings.CustomText#num#')#" size="50" maxlength="255" class="formfield"/></td>
	</tr>
	
<tr>
</cfloop>

<!--- Custom selectboxes --->
<cfloop index="num" from="1" to="2">
<tr>
		<td align="RIGHT">Selectbox #num# Label:</td>
		<td></td>
		<td><input type="text" name="CustomSelect#num#" value="#Evaluate('get_order_settings.CustomSelect#num#')#" size="50" maxlength="100" class="formfield"/></td>
	</tr>
	
<tr>
		<td align="RIGHT" valign="top">Selectbox #num# Choices:</td>
		<td></td>
		<td><textarea cols="30" rows="2" name="CustomChoices#num#" class="formfield">#Evaluate('get_order_settings.CustomChoices#num#')#</textarea></td>
	</tr>
	<tr><td colspan="2"></td><td><span class="formtextsmall">Comma-separated list of choices for the selectbox</span></td></tr>
	
</cfloop>
	
<tr>
		<td align="RIGHT" valign="top">Make these Required:</td>
		<td></td>
		<td>
		<!--- Text boxes --->
		<cfloop index="num" from="1" to="3">
		<input type="checkbox" name="Require_Text" value="CustomText#num#" class="formfield" #doChecked(ListFind(get_order_settings.CustomText_Req, 'CustomText' & num))# /> Text Field #num#&nbsp;&nbsp;
		</cfloop><br/>
		<!--- Select boxes --->
		<cfloop index="num" from="1" to="2">
		<input type="checkbox" name="Require_Select" value="CustomSelect#num#" class="formfield" #doChecked(ListFind(get_order_settings.CustomSelect_Req, 'CustomSelect' & num))#/> Selectbox #num#&nbsp;&nbsp;
		</cfloop>
		</td>
	</tr>
	
<!---- confirmations ----->	
<tr>
	<td align="RIGHT" class="formtitle"><br/>Email Confirmations</td>
	<td colspan="2"><br/><cfmodule template="../../../customtags/putline.cfm" linetype="thin" linecolor="#Request.GetColors.InputHBgcolor#"/></td>
	</tr>
	
	
	<tr>
		<td align="RIGHT">User Confirmation:</td>
		<td style="background-color: ###Request.GetColors.formreq#;"></td>
		<td><input type="radio" name="emailUser" value="1" #doChecked(get_order_settings.emailUser)# /> Yes 
		&nbsp;&nbsp; <input type="radio" name="emailUser" value="0" #doChecked(get_order_settings.emailUser,0)# /> No </td>
	</tr>
	
	<tr>
		<td align="RIGHT">Merchant Confirmation:</td>
		<td style="background-color: ###Request.GetColors.formreq#;"></td>
		<td><input type="radio" name="emailAdmin" value="1" #doChecked(get_order_settings.emailAdmin)# /> Yes
		&nbsp;&nbsp; <input type="radio" name="emailAdmin" value="0" #doChecked(get_order_settings.emailAdmin,0)# /> No </td>
	</tr>		
	
	<tr>
		<td align="RIGHT">Affiliate Confirmation:</td>
		<td style="background-color: ###Request.GetColors.formreq#;"></td>
		<td><input type="radio" name="emailaffs" value="1" #doChecked(get_order_settings.emailaffs)# /> Yes
		&nbsp;&nbsp; <input type="radio" name="emailaffs" value="0" #doChecked(get_order_settings.emailaffs,0)# /> No </td>
	</tr>	
	
	<tr>
		<td align="RIGHT">Drop-Shipper Emails:</td>
		<td style="background-color: ###Request.GetColors.formreq#;"></td>
		<td><input type="radio" name="emaildrop" value="1" #doChecked(get_order_settings.emaildrop)# /> Yes
		&nbsp;&nbsp; <input type="radio" name="emaildrop" value="0" #doChecked(get_order_settings.emaildrop,0)# /> No </td>
	</tr>	
	
	<tr>
		<td align="RIGHT">Email Drop-Shipper When:</td>
		<td></td>
		<td><input type="radio" name="EmailDropWhen" value="Placed" #doChecked(get_order_settings.EmailDropWhen,'Placed')# /> Placed
		 &nbsp;&nbsp; <input type="radio" name="EmailDropWhen" value="Processed" #doChecked(get_order_settings.EmailDropWhen,'Processed')# /> Processed  
		&nbsp;&nbsp; <input type="radio" name="EmailDropWhen" value="Filled" #doChecked(get_order_settings.EmailDropWhen,'Filled')# /> Filled 
		</td>
	</tr>	
	
	<tr>
		<td align="RIGHT">Order Email:</td>
		<td></td>
		<td><input type="text" name="orderemail" value="#get_order_settings.orderemail#" size="30" maxlength="50" class="formfield"/></td>	
	</tr>
	
	<tr>
		<td align="RIGHT">Drop-Shipper Email:</td>
		<td></td>
		<td><input type="text" name="dropemail" value="#get_order_settings.dropemail#" size="30" maxlength="50" class="formfield"/></td>	
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
objForm = new qForm("editform");

objForm.required("AllowInt,NoGuests,showbasket,giftregistry,giftwrap,coupons,SkipAddressForm,giftcard,delivery,backorders,emailUser,emailAdmin,emailaffs,emaildrop,EmailDropWhen");

objForm.orderemail.validateEmail();
objForm.dropemail.validateEmail();

objForm.mintotal.validateNumeric();

objForm.baseordernum.validateNumeric();

objForm.AllowInt.description = "allow international orders";
objForm.NoGuests.description = "require login to checkout";
objForm.mintotal.description = "minimum order total";
objForm.orderemail.description = "order email";
objForm.dropemail.description = "drop-shipper email";
objForm.baseordernum.description = "base order number";

objForm.orderemail.createDependencyTo("emailUser", "(this.value = '1') || (objForm.emailAdmin.getValue() = '1')");
objForm.dropemail.createDependencyTo("emaildrop", "1");

objForm.emailUser.enforceDependency();
objForm.emaildrop.enforceDependency();

qFormAPI.errorColor = "###Request.GetColors.formreq#";
</script>
</cfprocessingdirective>

</cfoutput>
</cfmodule>

