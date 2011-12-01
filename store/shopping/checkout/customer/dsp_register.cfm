	<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the form for a new customer to create an account, or if allowed, to checkout as a guest. Called by shopping.checkout (step=register) --->

<!--- This page is used to prompt new customers to create an account. --->
<cfparam name="attributes.Subscribe" default="1">
 
<table border="0" width="80%" align="center">
<tr><td align="left">
<div align="justify" class="formtext">Registration allows you track your order, save your billing and shipping information for faster checkout and save items in your shopping bag between visits.
<cfif Session.CheckoutVars.Download><br/><br/>
To download your product after your purchase is complete you will simply sign in to the web site using the  information provided below.
</cfif><br/><br/>
</div>
</td>
</tr>
</table>


<cfmodule template="../../../#self#"
	fuseaction="users.newuser"
	xfa_submit_login="fuseaction=shopping.checkout&step=register"
	xfa_success="#self#?fuseaction=shopping.checkout&step=register"
	>
	<br/>
<!--- allow guest check-out IF there are no downloadable OR membership products AND guest orders are allowed. --->
<cfif get_Order_Settings.NoGuests is "0" AND NOT Session.CheckoutVars.Download AND NOT Session.CheckoutVars.Membership>
<br/>
<table border="0" width="80%" align="center" class="formtext">
<tr><td>
	If you don't want to create an account right now, you can continue checkout as a guest.
	<br/><br/>
	<cfoutput>
	<form action="#XHTMLFormat('#self#?fuseaction=shopping.checkout&step=shipping#Request.Token2#')#" method="post">
	</cfoutput>
	<div align="center"><input type="submit" value="Continue as a Guest" class="formbutton"></div>
	</form>
</td>
</tr>
</table>
</cfif>	

 