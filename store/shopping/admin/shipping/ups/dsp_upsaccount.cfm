<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the form for registering with UPS if an account number was not provided. Called by shopping.admin&shipping=upsregister --->

<cfprocessingdirective suppresswhitespace="no">
<cfhtmlhead text="
<script language=""JavaScript"">
		function CancelForm () {
		location.href = ""#self#?fuseaction=shopping.admin&shipping=settings&redirect=yes#request.token2#"";
		}
	</script>
">
</cfprocessingdirective>

<cfhtmlhead text="<script type='text/javascript' src='includes/initialcaps.js'></script>">

<cfparam name="errormessage" default="">

<cfmodule template="../../../../customtags/format_admin_form.cfm"
	box_title="UPS OnLine&reg; Tools Licensing & Registration Wizard - Step 3a"
	width="550"
	required_Fields="0"
	>
	
	<cfoutput>
	<form action="#self#?fuseaction=shopping.admin&shipping=upsregister#request.token2#" method="post" name="ups">
	<input type="hidden" name="debug" value="yes"/>
	
	<cfset attributes.fieldlist="ContactName,Title,Company,Address1,Address2,City,State,Zip,Country,Phone,Email,Website">
	<cfloop list="#attributes.fieldlist#" index="counter">
		<input type="hidden" name="#counter#" value="#Evaluate("attributes.#counter#")#"/>
	</cfloop>
	
	

	<cfinclude template="../../../../includes/form/put_space.cfm">

		<tr>
			<td align="center" valign="top" width="100"><img src="images/icons/ups_colorlogo.jpg" alt="" width="68" height="68" border="0" /></td>


		<td><br/>You did not provide A UPS Account number with your registration for UPS OnLine Tools. If you have a UPS account number, please enter it below and click Finish. <br/><br/>

<div align="center">UPS Account Number: <input type="text" size="10" name="AccountNo" value="#attributes.AccountNo#" class="formfield" maxlength="6"/></div>

<input type="hidden" name="NoAccount" value="yes"/>
	<br/><br/>If you do not have a UPS Account, you may choose to open one at UPS.com or by having UPS contact you. If you choose not to open a UPS account at this time, click Finish to complete your UPS OnLine Tools registration.<br/><br/> 

To open a UPS Account at UPS.com, <a href="https://www.ups.com/account/us/start?loc=en_US" target="_blank"><b>click here</b></a>.<br/><br/>
	
<input type="checkbox" name="ContactMe" value="1"/> By checking this box, I am requesting that UPS contact me about opening a UPS account. <br/><br/>

 If you do not want to open a UPS account at this time, click Finish to complete your UPS OnLine Tools registration.<br/><br/>

 		<div align="center">
		<input type="submit" name="submit_ups" value="Finish" class="formbutton"/> 
		<input type="button" value="Cancel" onclick="javascript:CancelForm();" class="formbutton"/></div>
		</td>


<tr><td colspan="2" align="center"><br/>
<i>UPS, UPS brandmark, and the Color Brown are trademarks of<br/>
United Parcel Service of America, Inc. All Rights Reserved.</i></td></tr>
</td></tr></table>

</form>
</cfoutput>

</cfmodule>


