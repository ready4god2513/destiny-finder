<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Users Email Lock Upgrade - This page presents a message to the user when they request an email with a new unlock code. --->


<cfmodule template="../customtags/format_output_box.cfm"
box_title="Email Confirmation Sent"
width="400"
align="Left"
>
<div class="formtitle" style="margin: 9px 9px 9px 9px;">
<cfoutput>
A confirmation email has been sent to #qry_get_user.Email#. 
<p>
<button class="formbutton" onclick="javascript:window.location.href='#request.self#?fuseaction=users.unlock&amp;redirect=yes#request.token2#';">&nbsp; Continue &nbsp;</button>
</p></div>
</cfoutput>
</cfmodule>