<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the terms the user must agree to during the checkout process. Called by shopping.checkout (step=terms)  ---->

	<p>&nbsp;</p>
		<cfmodule template="../../customtags/format_input_form.cfm"
		box_title="Terms of Purchase"
		width="500"
		required_fields="0"
		>
		<cfoutput>
			<tr><td align="center">			
			<form action="#XHTMLFormat('#self#?fuseaction=shopping.checkout&step=terms#request.token2#')#" 
			method="post" name="termsform" class="margins">
			<strong>You must agree to the following terms to continue:</strong><br/><br/>
			<textarea name="license" cols="45" rows="20" onfocus="this.blur();">#Replace(get_Order_Settings.AgreeTerms, Chr(13), "&nbsp;", "ALL")#
			</textarea><br/><br/>
			<input type="submit" name="agreetoterms" value="I Agree" class="formbutton"/>
			<input type="submit" name="CancelForm" value="Cancel" class="formbutton"/>
			</form>
			</td></tr>
		</cfoutput>
		</cfmodule>
		
