<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Calls the UPS registration tool and displays the license agreement. Called by shopping.admin&shipping=upslicense --->

<!--- Get USPS Access License --->

<cfinvoke component="#Request.CFCMapping#.shipping.upssecurity" 
	method="getUPSLicense" 
	returnvariable="License"
	country="US"
	language="EN"
	debug="no">
	
<!--- Output debug if returned --->
<cfif len(License.Debug)>
	<cfinvoke component="#Request.CFCMapping#.global" method="putDebug" debugtext="#License.Debug#">
</cfif>

<cfprocessingdirective suppresswhitespace="no">
<cfhtmlhead text="
<script language=""JavaScript"">
		function CancelForm () {
		location.href = ""#self#?fuseaction=shopping.admin&shipping=settings&redirect=yes#request.token2#"";
		}
		function openWin( windowURL, windowName, windowFeatures ) { 
			return window.open( windowURL, windowName, windowFeatures ) ; 
			} 
		function PrintLicense () {
			window.open('#self#?fuseaction=shopping.admin&shipping=upslicense&print=yes#request.token2#', 'print');
		}
	</script>
">
<cfif isDefined("attributes.print")>
<cfhtmlhead text="
<script language=""JavaScript"">
	window.print();
	</script>
">
	<cfset formwidth="650">
<cfelse>
	<cfset formwidth="550">
</cfif>
</cfprocessingdirective>


<cfmodule template="../../../../customtags/format_admin_form.cfm"
	box_title="UPS OnLine&reg; Tools Licensing & Registration Wizard - Step 2"
	width="#formwidth#"
	required_Fields="0"
	>
	
	<cfoutput>
	<form action="#self#?fuseaction=shopping.admin&shipping=upslicense#request.token2#" method="post" name="ups">

	<cfinclude template="../../../../includes/form/put_space.cfm">

		<tr>
			<td align="center" valign="top" width="100"><img src="images/icons/ups_colorlogo.jpg" alt="" width="68" height="68" border="0" /></td>

<cfif License.Success>

	<cfset Session.License = License.Text>

	<cfif isDefined("attributes.print")>
		<td><pre class="formtext">#License.text#</pre><br/><br/>
			
		<div align="center"><input type="button" name="Close" value="Close" onclick="javascript:window.close();" class="formbutton"/> 
		</div>
		</td>
	
	<cfelse>
	
		<td><br/>#License.text#<br/><br/>
			
		<div align="center"><input type="radio" name="agree" value="Yes" />Yes, I Do Agree 
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="agree" value="No"/>No, I Do Not Agree<br/><br/>

		<input type="button" name="Print" value="Print" onclick="javascript:PrintLicense();" class="formbutton"/> 
		<input type="submit" name="submit_ups" value="Next" class="formbutton"/> 
		<input type="button" value="Cancel" onclick="javascript:CancelForm();" class="formbutton"/>
		</div>
		</td>

	</cfif>


<cfelse>
<td><span class="FormError">#License.ErrorMessage#</span><br/><br/>
<div align="center"><input type="button" value="Back" onclick="javascript:CancelForm();" class="formbutton"/></div></td>

</cfif>


</tr>

<tr><td colspan="2" align="center"><br/>
<i>UPS, UPS brandmark, and the Color Brown are trademarks of<br/>
United Parcel Service of America, Inc. All Rights Reserved.</i></td></tr>

</form>

<cfprocessingdirective suppresswhitespace="no">
<script type="text/javascript">
objForm = new qForm("ups");

objForm.agree.validateNotNull('Please indicate if you agree or not to the UPS end-user license.');

qFormAPI.errorColor = "<cfoutput>###Request.GetColors.formreq#</cfoutput>";
</script>
</cfprocessingdirective>

</cfoutput>	
</cfmodule>
