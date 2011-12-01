<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Confirm delete of a product review. Called by fuseaction=product.reviews&do=delete --->
	
<p>&nbsp;</p>
	
<cfmodule template="../../customtags/format_input_form.cfm"
	box_title="Delete Product Review"
	width="400"
	required_fields="0"
	align="center"
	>
	
	<tr><td align="center">
		<br/>This will permanently remove your product review!<br/>Are you sure you want to continue?<br/>
	</td></tr>
	
	<cfoutput>
	<tr><td align="center">
	<form action="#XHTMLFormat('#self#?fuseaction=product.reviews&do=update&delete=#qry_get_review.Review_ID##request.token2#')#" method="post" class="margins">
	<input type="hidden" name="XFA_success" value="fuseaction=product.reviews&do=manager">
	<input type="hidden" name="Product_ID" value="#qry_get_review.Product_ID#">
	<input type="submit" name="submit_delete" value="  Yes  " class="formbutton"/> 
	<input type="submit" name="submit_cancel" value="  No  " class="formbutton"/> 
	</form>
	</td></tr>	
	</cfoutput>

</cfmodule>	