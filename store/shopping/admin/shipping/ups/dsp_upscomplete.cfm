<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Completion screen for the UPS license and registration wizard. Called by shopping.admin&shipping=upsregister --->

<cfmodule template="../../../../customtags/format_admin_form.cfm"
	box_title="UPS OnLine&reg; Tools Licensing & Registration Wizard - Step 4"
	width="480"
	required_Fields="0"
	>
	
	<cfoutput>
	<form action="#self#?fuseaction=shopping.admin&shipping=settings#request.token2#"  method="post" name="ups">

	<cfinclude template="../../../../includes/form/put_space.cfm">

		<tr>
			<td align="center" valign="top" width="100"><img src="images/icons/ups_colorlogo.jpg" alt="" width="68" height="68" border="0" /></td>

			<td>
<b>Registration Successful!</b><br/><br/>

Thank you for registering to use the UPS OnLine® Tools.<br/><br/>

To learn more about the UPS OnLine Tools, please visit
<a href="http://www.ec.ups.com" target="_blank">www.ups.com</a>.<br/><br/>

Still handwriting your UPS shipping labels? UPS Internet
Shipping allows you to electronically prepare domestic and
international shipments from the convenience of any computer
with Internet access. To learn more or to begin using UPS
Internet Shipping, click <a href="http://ups.com/bussol/solutions/internetship.html" target="_blank">here</a>.

<div align="center"><br/><input type="submit" name="submit" value="Finish" class="formbutton"/></div>
</td></tr>

<tr><td colspan="2" align="center"><br/>
<i>UPS, UPS brandmark, and the Color Brown are trademarks of<br/>
United Parcel Service of America, Inc. All Rights Reserved.</i></td></tr>

</form>
</cfoutput>	
</cfmodule>

<cfset StructDelete(Session,"StartRegister")> 
<cfset StructDelete(Session,"License")> 
