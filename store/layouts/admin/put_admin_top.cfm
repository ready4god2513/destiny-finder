
<style>
TD {
	FONT-SIZE: 11px; COLOR: #777777; FONT-FAMILY: Arial, Helvetica, Geneva, Verdana, sans-serif;
}
P {
	FONT-SIZE: 12px; COLOR: #777777; FONT-FAMILY: Arial, Helvetica, Geneva, Verdana, sans-serif;
}
</style>
<table border="0" cellspacing="0" cellpadding="0" width="100%">
<tr>
<td colspan="2" valign="top"><img src="images/admin/WVH_logo.jpg" alt="" border="0" /></td>
</tr>
<tr>
	<td width="195" valign="top" background="images/admin/uppernav_bkgd_purple.gif"><!--- <img src="images/uppernav_bkgd_purple.gif" width="195" height="25" alt="" border="0" />---><img src="images/admin/spacer.gif" width="195" height="25" alt="" border="0" /></td>
	<td valign="top" background="images/admin/uppernav_bkgd.gif">
			<table border="0" cellspacing="0" cellpadding="3" width="100%">
				<tr>
				<td align="center" valign="middle">
				<!--- Main Admin Navigation Here --->
				<cfoutput>
				<b><a href="#request.self#?fuseaction=home.admin&inframes=Yes#Request.Token2#" target="AdminContent">Admin Home</a>  |  <a href="#request.self##Request.Token1#" target="store">View Store</a>  |  <a href="#request.self#?fuseaction=users.logout&submit_logout=yes#Request.Token2#" target="_top">Logout</a>  <!--- |  <a href="documentation\cfwebstore.pdf" target="helpfile">Help/Documentation</a>---></b>
				</cfoutput>
</td>
				</tr>
			</table>
	</td>
</tr>
</table>

