<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the final receipt for the order, clears the temporary tables. Called by shopping.checkout (step=receipt) --->

<center>
	 <cfoutput>
<table border="1" cellspacing="" cellpadding="10" class="formbg">


<tr>
    <td colspan="2" align="CENTER" valign="MIDDLE" bgcolor="###Request.GetColors.InputHBgcolor#"><div class="formheader"><b><font color="###Request.GetColors.InputHText#">Order Submitted!</font></b></div></td>
</tr>

<tr>
 <td colspan="2" align="center"><br/>

	<b><blockquote><div class="formtext"><p>Your order has been submitted and has been assigned Order Number #(New_OrderNo + get_Order_Settings.BaseOrderNum)#. <cfif len(attributes.Offline)><br/>#get_order_Settings.OfflineMessage#</cfif></p></cfoutput>


<!--------------->
	<cfif Session.CheckoutVars.Download>
	<cfset linkURL = "#Request.SecureURL##self#?fuseaction=users.manager">
	<strong>Download Instructions</strong><br/>
Your purchase will be available for download at <cfoutput>#Request.StoreURL#</cfoutput>. <br/>Sign on and go to the My Account page or follow this link <cfoutput><a href="#XHTMLFormat('#linkURL##Request.Token2#')#">#linkURL#</a></cfoutput>.
	</cfif>


<p>Please print this invoice for your records. </p>

<!--- Mail order notification to customer and/or administrator --->
<cfinclude template="post_processing/act_mailorder.cfm">

<cfif get_Order_Settings.Emailuser>
<cfif EmailCDone>
<p>You should receive an email confirmation as well within a couple minutes.</p>
<cfelse>
<p>We were not able to email you a confirmation due to an internal error.</p>
</cfif>
</cfif>

<cfoutput>
<cfif get_Order_Settings.EmailAdmin AND NOT EmailADone>
<p>We were not able to email the merchant your order information, you may want to email them directly at <a href="mailto:#get_Order_Settings.OrderEmail#">#get_Order_Settings.OrderEmail#</a> to let them know the order was placed.</p>
</cfif>
</b></div></blockquote>

</cfoutput>

<cfmodule template="../order/put_order.cfm" Order_No="#New_OrderNo#" Type="Customer">

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

