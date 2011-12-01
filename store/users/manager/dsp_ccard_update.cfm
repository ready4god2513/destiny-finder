<!--- CFWebstore®, version 6.31 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Called from users.ccard circuit, displays form to allow the user to update their credit card information stored in their user record. Note that this credit card information is for informational purposes only and not used during checkout. --->

<cfparam name="attributes.message" default="">
<cfparam name="attributes.xfa_submit_ccard" default="fuseaction=users.ccard">

<cfinclude template="../qry_get_user.cfm">
	<cfloop list="CardType,NameOnCard,CardNumber,CardExpire,Cardzip" index="counter">
		<cfset "attributes.#counter#" = evaluate("qry_get_user." & counter)>
	</cfloop>
	
<cfif Not isDate(attributes.cardexpire)>
	<cfset attributes.cardexpire = now()>
</cfif>

<cfparam name="attributes.month" default="#Month(attributes.cardexpire)#">
<cfparam name="attributes.year" default="#Year(attributes.cardexpire)#">
	
<cfinclude template="../../shopping/qry_get_order_settings.cfm">	
<cfinclude template="../qry_get_user_extended_settings.cfm">

<cfhtmlhead text="
 <script type=""text/javascript"">
 <!--
 function CancelForm() {
 location.href='#Request.StoreURL##self#?fuseaction=users.manager&redirect=yes#request.token2#';
 }
 function DeleteForm() {
 location.href='#Request.StoreURL##self#?fuseaction=users.deleteccard&redirect=yes#request.token2#';
 }
 // --> 
 </script>
">

<cfoutput>
<form action="#XHTMLFormat('#request.self#?#attributes.xfa_submit_ccard##Request.Token2#')#"
 name="editform" method="post">
</cfoutput>
	
<cfmodule template="../../customtags/format_input_form.cfm"
box_title="Update Credit Card Information"
width="400"
>

	<cfinclude template="../../includes/form/put_message.cfm">

	<!--- Set type of cc form to use --->
	<cfset attributes.ccform="users">
	
	<cfinclude template="../../includes/form/put_space.cfm">
	<cfinclude template="../formfields/put_ccard.cfm">
	<cfinclude template="../../includes/form/put_space.cfm">
	
	<tr align="left">
    	<td></td><td></td>
		<td>
		<cfif get_User_Extended_Settings.UserCCardEdit><input type="submit" name="submit_ccard" value="Update" class="formbutton"/></cfif>
		<cfif get_User_Extended_Settings.UserCCardDelete><input type="button" name="Delete" value="Delete" onclick="DeleteForm();" class="formbutton"/></cfif>
		<input type="button" name="Cancel" value="Cancel" onclick="CancelForm();" class="formbutton"/></td>
	</tr>
</cfmodule>
</form>

<cfprocessingdirective suppresswhitespace="no">
<script type="text/javascript">
<!--
objForm = new qForm("editform");

objForm.required("nameoncard,CardType,CardNumber,CardZip");

objForm.nameoncard.description = "name on card";
objForm.CardType.description = "card type";
objForm.CardNumber.description = "card number";
objForm.CardZip.description = "billing address zip code";

objForm.CardNumber.validateCreditCard();

qFormAPI.errorColor = "<cfoutput>###Request.GetColors.formreq#</cfoutput>";
//-->
</script>
</cfprocessingdirective>
