<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Confirm delete of a feature review. Called by fuseaction=feature.reviews&do=delete --->
	
<p>&nbsp;</p>
	
<cfmodule template="../../customtags/format_input_form.cfm"
	box_title="Delete Article Comment"
	width="400"
	required_fields="0"
	align="center"
	>
	
	<tr><td align="center">
		<br/>This will permanently remove your article comment!<br/>Are you sure you want to continue?<br/>
	</td></tr>

	<tr><td align="center">		
	<cfoutput>
	<form action="#XHTMLFormat('#self#?fuseaction=feature.reviews&do=update&delete=#Review_ID##request.token2#')#" method="post" class="margins">
	<input type="hidden" name="XFA_success" value="fuseaction=feature.reviews&do=manager">
	<input type="hidden" name="Feature_ID" value="#qry_get_review.Feature_ID#">
	<input type="submit" name="submit_delete" value="  Yes  " class="formbutton"/> 
	<input type="submit" name="submit_cancel" value="  No  " class="formbutton"/> 
	</form>
	</td></tr>	
	</cfoutput>

</cfmodule>	