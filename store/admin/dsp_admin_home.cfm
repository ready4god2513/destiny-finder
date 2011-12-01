<!--- CFWebstore®, version 6.20 --->

<!--- CFWebstore® is ©Copyright 1998-2008 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This is the page used to display the main admin home. It calls various sub-actions according to the users permissions.  Called by fuseaction=home.admin --->

<cfinclude template="qry_order_summary.cfm">

<table border="0" cellspacing="0" cellpadding="10" width="90%" align="center">
<tr>
	<td valign="top" class="mainpage" width="50%">
	<cfmodule template="../customtags/format_output_admin.cfm"
	box_title="Order Summary"
	width="95%"
	height="200"
	>
		<cfinclude template="dsp_order_summary.cfm">
	</cfmodule>
	</td>
	
	<td valign="top" class="mainpage" width="50%">
	<cfmodule template="../customtags/format_output_admin.cfm"
	box_title="Recent Orders"
	width="95%"
	height="200"
	headercolor="Yellow"
	><span class="mainpage">
	<cfinclude template="dsp_order_links.cfm">
	<br/>
	</span>
	</cfmodule>
	
	</td>
</tr>
<tr>
	<td valign="top" class="mainpage" width="50%">
	<cfmodule template="../customtags/format_output_admin.cfm"
	box_title="Pending Items"
	width="95%"
	height="150"
	headercolor="Yellow"
	><span class="mainpage">
	<cfinclude template="dsp_pending_items.cfm">
	<br/>
	</span>
	</cfmodule>
	</td>
	
	<td valign="top" class="mainpage" width="50%">
	<!--- <cfmodule template="../customtags/format_output_admin.cfm"
	box_title="CFWebstore Updates"
	width="95%"
	height="150"
	><span class="mainpage">
	<cfinclude template="put_webstore_info.cfm">
	</span>
	</cfmodule> --->
	
	</td>
</tr>

</table>