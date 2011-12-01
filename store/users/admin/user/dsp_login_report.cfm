<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Display Logins for the last 30 days --->



<cfmodule template="../../../customtags/format_output_admin.cfm"
	box_title="Last User Login Activity"
	width="600"
	>
<cfoutput>	
<div class="cat_text_small" align="center">As of #Dateformat(now(),"mmmm d, yyyy")# at #TimeFormat(now(),"hh:mm tt")# </div>
<br/>
<table border="0" cellpadding="0" cellspacing="5" width="100%" class="formtext" align="center" style="color:###Request.GetColors.OutputTText#;">
</cfoutput>
<tr>
	<th colspan="2">User</th>
	<th>Last Login</th>
	<th>Total Activity</th>
</tr>
<tr><td colspan="4" bgcolor="gray"></td></tr>

<cfoutput query="Login_Report">
<tr>
	<cfif username is email>
		<td colspan="2" <cfif emaillock is not "verified" and emaillock is not "">bgcolor="yellow"<cfelseif emailisbad is "1">bgcolor="red"</cfif>><a href="#self#?fuseaction=users.admin&user=summary&UID=#user_id##Request.Token2#">#email#</a></td>		
	<cfelse>
		<td<cfif disable is "1"> bgcolor="red"</cfif>><a href="#self#?fuseaction=users.admin&user=summary&UID=#user_id##Request.Token2#">#username#</a></td>
		<td	<cfif emaillock is not "verified" and emaillock is not "">bgcolor="yellow"<cfelseif emailisbad is "1">bgcolor="red"</cfif>><a href="#self#?fuseaction=users.admin&email=write&UID=#user_id##Request.Token2#" target="email">#email#</a> </td>
	</cfif>			
	
	<td>&nbsp; <strong>#LoginsDay#</strong> login<cfif LoginsDay IS NOT 1>s</cfif> on #Dateformat(LastLogin,"mm/dd/yyyy")# &nbsp;</td>
	<td>&nbsp; #LoginsTotal# login<cfif LoginsTotal IS NOT 1>s</cfif> since #Dateformat(Created,"mm/dd/yyyy")#</td>
</tr>
</cfoutput>
</table>
<br/>
<div align="center"><input type="button" value="Back" onclick="javascript:window.history.go(-1);" class="formbutton"/></div>
<br/>
</cfmodule>
