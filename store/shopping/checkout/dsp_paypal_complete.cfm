<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the final receipt for the order, for orders completed through PayPal Standard. Called by shopping.checkout (step=paypal) --->

<center>
	 <cfoutput>
<table border="1" cellspacing="" cellpadding="10" class="formbg">


<tr>
    <td colspan="2" align="CENTER" valign="MIDDLE" bgcolor="###Request.GetColors.InputHBgcolor#"><div class="formheader"><b><font color="###Request.GetColors.InputHText#">Order Submitted!</font></b></div></td>
</tr>

<tr>
 <td colspan="2" align="center"><br/>

	<b><blockquote><div class="formtext"><p>Your order has been submitted and has been assigned Order Number #(GetOrderNum.Order_No + get_Order_Settings.BaseOrderNum)#.</p></cfoutput>


<!--------------->
	<cfif CheckDownloads.RecordCount>
	<cfset linkURL = "#Request.SecureURL##self#?fuseaction=users.manager">
	<strong>Download Instructions</strong><br/>
Your purchase will be available for download at <cfoutput>#Request.StoreURL#</cfoutput>. <br/>Sign on and go to the My Account page or follow this link <cfoutput><a href="#XHTMLFormat('#linkURL##Request.Token2#')#">#linkURL#</a></cfoutput>.
	</cfif>


<p>Please print this invoice for your records. </p>

<cfif get_Order_Settings.Emailuser>
<p>You should receive an email confirmation as well within a couple minutes.</p>
</cfif>

</b></div></blockquote>

<cfmodule template="../order/put_order.cfm" Order_No="#GetOrderNum.Order_No#" Type="Customer">

<!--- Page.Receipt to post marketing feedback (Overture, Pricegrabber, etc. code 
<cfmodule template="../../#request.self#"
	fuseaction="page.receipt"
	notitle="1">
--->

<cfoutput>
<br/>
<br/>
<div class="formtext">
<a href="#XHTMLFormat('#Request.StoreURL##self##Request.Token1#')#">
<b>Back to the Store</b></a></div>
<p>&nbsp;</p></center>
</td></tr></table>
</cfoutput>

