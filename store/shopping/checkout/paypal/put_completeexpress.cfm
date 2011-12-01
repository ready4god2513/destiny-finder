
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Creates the form button for completing the express checkout function with PayPal. Will redirect to a function that sends the request to PayPal to complete the checkout process. Called from shopping/checkout/dsp_payment_options.cfm --->

	<tr>
		<td>
	<cfoutput>
	<form action="#XHTMLFormat('#request.self#?fuseaction=shopping.checkout&step=pp_complete#Request.Token2#')#" 
	method="post" class="margins">
	</cfoutput>
	Click to place your order using funds from your PayPal account and/or funding source you have indicated.<br/><br/>
	<div align="center"><input type="submit" name="SubmitPayment" value="Complete Order" class="formbutton"/></div>	
	</form>
		</td>
	</tr>

