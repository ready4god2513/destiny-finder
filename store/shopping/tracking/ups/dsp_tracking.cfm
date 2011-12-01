<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This page is called by the shopping.tracking fuseaction and used to display the order tracking form for UPS Tracking. --->

	<cfparam name="attributes.message" default="">

<!--- Hide the form if tracking information is being displayed --->
<cfif NOT isDefined("ShowTracking")>

<cfoutput>
<form name="tracking" action="#XHTMLFormat('#request.self#?fuseaction=shopping.tracking#request.token2#')#" method="post">
	
<cfmodule template="../../../customtags/format_input_form.cfm"
box_title="UPS OnLine<sup>&reg;</sup> Tools Tracking"
width="400"
required_fields="1"
>
	<tr>
		<td align="center" valign="top" width="100">
		<img src="images/icons/ups_colorlogo.jpg" alt="" width="68" height="68" border="0" /></td><td colspan="2">
		<br/>To track an order, please enter the order number
along with the zip code for the billing address used when placing your order.</td>
	</tr>
<tr><td colspan="3"><img src="#Request.AppSettings.defaultimages#/spacer.gif" alt="" height="3" width="1" /></td></tr>

	<cfif len(attributes.Message)>
	<tr>
		<td colspan="3" align="center" class="formerror">#attributes.Message#<br/><br/></td></tr>
	</cfif>
		
	<tr align="left">
		<td align="right" nowrap="nowrap">Order Number:</td>
		<td style="background-color: ###Request.GetColors.formreq#;" width="3">&nbsp;</td>
		<td align="left" width="95%"><input type="text" size="20" name="ordernum" class="formfield"/></td></tr>
		
	<tr align="left">
		<td align="right" nowrap="nowrap">Zip Code:</td>
		<td style="background-color: ###Request.GetColors.formreq#;" width="3">&nbsp;</td>
		<td align="left"><input type="text" size="20" name="zipcode" class="formfield"/></td></tr>

	
	<tr align="left"><td colspan="3"><br/>
	<input type="checkbox" name="Agree" value="1"/> 
	By selecting this box and the Track button, I agree to the following Terms and Conditions. 
	<input type="submit" name="submit_tracking" value="Track" class="formbutton"/>
	<input type="button" value="Cancel" onclick="javascript:window.history.go(-1);" class="formbutton"/></td></tr>	
	

	<tr align="left">
    	<td colspan="3"><br/>“NOTICE: The UPS package tracking systems accessed via this service (the “Tracking Systems”) and tracking information obtained through this service (the “Information”) are the private property of UPS. UPS authorizes you to use the Tracking Systems solely to track shipments tendered by or for you to UPS for delivery and for no other purpose. Without limitation, you are not authorized to make the Information available on any web site or otherwise reproduce, distribute, copy, store, use or sell the Information for commercial gain without the express written consent of UPS. This is a personal service, thus your right to use the Tracking Systems or Information is non-assignable. Any access or use that is inconsistent with these terms is unauthorized and strictly prohibited.”</td></tr>
		
<tr align="left"><td colspan="3" align="center"><br/>
<i>UPS, UPS brandmark, and the Color Brown are trademarks of<br/>
United Parcel Service of America, Inc. All Rights Reserved.</i></td></tr>

</cfmodule>

</form>
</cfoutput>

<cfprocessingdirective suppresswhitespace="no">
<script type="text/javascript">
<!--
objForm = new qForm("tracking");

objForm.required("ordernum,zipcode");

objForm.ordernum.description = "Order Number";

objForm.Agree.validateNotNull('You must agree to the Terms and Conditions to track your order.');

qFormAPI.errorColor = "<cfoutput>###Request.GetColors.formreq#</cfoutput>";
//-->
</script>
</cfprocessingdirective>	
	
	

<cfelse>

	<table class="formtext" cellpadding="3" cellspacing="3"><tr>
    	<td colspan="3"><br/>“NOTICE: The UPS package tracking systems accessed via this service (the “Tracking Systems”) and tracking information obtained through this service (the “Information”) are the private property of UPS. UPS authorizes you to use the Tracking Systems solely to track shipments tendered by or for you to UPS for delivery and for no other purpose. Without limitation, you are not authorized to make the Information available on any web site or otherwise reproduce, distribute, copy, store, use or sell the Information for commercial gain without the express written consent of UPS. This is a personal service, thus your right to use the Tracking Systems or Information is non-assignable. Any access or use that is inconsistent with these terms is unauthorized and strictly prohibited.”</td></tr>
		
<tr><td width="50"><br/>
<cfoutput>
<img src="#Request.AppSettings.defaultimages#/icons/ups_smlogo.jpg" alt="" width="32" height="32" border="0" align="left" /></cfoutput>
</td><td colspan="3"><br/>
<i>UPS, UPS brandmark, and the Color Brown are trademarks of<br/>
United Parcel Service of America, Inc. All Rights Reserved.</i></td></tr></table>

</cfif>