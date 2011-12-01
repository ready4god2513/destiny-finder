<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Called from users.birthdate circuit, displays a form to allow the user to update their birthdate information. --->

	<cfparam name="attributes.message" default="">
	<cfparam name="attributes.xfa_submit_birthdate" default="fuseaction=users.birthdate">
	
	<cfinclude template="../qry_get_user.cfm">
	<cfset attributes.birthdate=qry_get_user.birthdate>
	
<cfhtmlhead text="
 <script type=""text/javascript"">
 <!--
 function CancelForm() {
 location.href='#Request.StoreURL##self#?fuseaction=users.manager&redirect=yes#request.token2#';
 }
 // --> 
 </script>
">
	
<cfoutput>
<form action="#XHTMLFormat('#request.self#?#attributes.xfa_submit_birthdate##request.token2#')#" method="post">
</cfoutput>
	
<cfmodule template="../../customtags/format_input_form.cfm"
box_title="Update Birth Date"
width="400"
>
	
	<cfinclude template="../../includes/form/put_message.cfm">
	
	<cfinclude template="../../includes/form/put_space.cfm">
	<cfinclude template="../formfields/put_birthdate.cfm">
	<cfinclude template="../../includes/form/put_space.cfm">
	
	<tr align="left">
    	<td></td><td></td>
		<td>
		<cfoutput><input type="hidden" name="subscribe" value="#qry_Get_User.Subscribe#"/></cfoutput>
		<input type="submit" name="submit_birthdate" value="Update" class="formbutton"/>
		<input type="button" name="Cancel" value="Cancel" onclick="CancelForm();" class="formbutton"/></td>
    </tr>

</cfmodule>
</form>

