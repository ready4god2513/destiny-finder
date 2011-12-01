<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the error message during the checkout process, such as when shipping cannot be calculated and checkout not allowed. Called by shopping.checkout (step=error)  ---->

<p>&nbsp;</p>
<cfmodule template="../../customtags/format_input_form.cfm"
box_title="Checkout Problem"
width="400"
required_fields="0">
	<tr><td align="center" class="formtitle">
	<br/><cfoutput>#message#</cfoutput><br/>
	<cfoutput>
	<form action="#XHTMLFormat('#self#?fuseaction=shopping.basket#request.token2#')#" method="post" class="margins">
	</cfoutput>
	<input type="submit" name="submit" value="Back to Shopping Cart" class="formbutton"/>
	</form>
	</td></tr>
</cfmodule>