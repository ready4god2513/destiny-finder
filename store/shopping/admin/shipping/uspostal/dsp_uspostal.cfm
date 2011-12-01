<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the form to update the USPS Settings for the store. Called by shopping.admin&shipping=usps --->

<cfset GetUSPS = Application.objShipping.getUSPSSettings()>

<cfmodule template="../../../../customtags/format_admin_form.cfm"
	box_title="USPS Shipping Settings"
	width="450"
	>
	
	<cfoutput>
	<form action="#self#?fuseaction=shopping.admin&shipping=usps#request.token2#" name="usps" method="post">

	<cfinclude template="../../../../includes/form/put_space.cfm">

		<tr>
			<td align="right" valign="top" width="35%">Account User ID:</td>
			<td style="background-color: ###Request.GetColors.formreq#;" width="3">&nbsp;</td>
			<td width="65%">
			<input type="text" name="userid" size="20" maxlength="150" value="#GetUSPS.userid#" class="formfield"/>
			</td>	
		</tr>

		<tr>
			<td align="right" valign="top">Server:</td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
			<td>
			<input type="text" name="server" size="40" maxlength="150" value="#GetUSPS.server#" class="formfield"/>
			</td>	
		</tr>
		
		<tr>
			<td align="RIGHT">Shipper's Zip/Postal Code:</td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
			<td>
			<input type="text" name="MerchantZip" value="#GetUSPS.MerchantZip#" size="20" maxlength="20" class="formfield"/>
			</td>	
		</tr>
		
		<tr>
			<td align="right" valign="top" width="35%">Maximum Package Weight:</td>
			<td style="background-color: ###Request.GetColors.formreq#;">&nbsp;</td>
			<td width="65%">
			<input type="text" name="MaxWeight" size="7" maxlength="15" value="#GetUSPS.MaxWeight#" class="formfield"/>
			</td>	
		</tr>
		<tr><td colspan="2"></td><td class="formtextsmall">
		Maximum weight for a package. Shipments will be split into equal-sized packages if over this amount.
		</td></tr>
		
		<tr>
			<td align="right" valign="top">Use Address Verification:</td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
<td><input type="radio" name="UseAV" value="1" #doChecked(GetUSPS.UseAV)# />Yes 
&nbsp;<input type="radio" name="UseAV" value="0" #doChecked(GetUSPS.UseAV,0)# />No</td>	
		</tr>	
		<tr><td colspan="2"></td><td class="formtextsmall">
		Requires additional <a href="http://www.usps.com/webtools/webtoolsapirequestform.htm">registration</a> with U.S.P.S.
		</td></tr>
		
		<tr>
			<td align="right" valign="top">Log Transactions:</td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
<td><input type="radio" name="Logging" value="1" #doChecked(GetUSPS.Logging)# />On 
&nbsp;<input type="radio" name="Logging" value="0" #doChecked(GetUSPS.Logging,0)# />Off</td>	
		</tr>	
		
		<tr>
			<td align="right" valign="top">Debug:</td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
<td><input type="radio" name="Debug" value="1" #doChecked(GetUSPS.Debug)# />On 
&nbsp;<input type="radio" name="Debug" value="0" #doChecked(GetUSPS.Debug,0)# />Off</td>	
		</tr>	

		<tr>
			<td colspan="2"></td>
			<td><input type="submit" name="submit_usps" value="Save" class="formbutton"/> 
			<input type="button" value="Cancel" onclick="javascript:window.history.go(-1);" class="formbutton"/>
			</td>	
		</tr>	
	</form>
</cfoutput>
		
</cfmodule>

<cfprocessingdirective suppresswhitespace="no">
<script type="text/javascript">
objForm = new qForm("usps");

objForm.required("MaxWeight,UseAV,Debug,Logging");

objForm.MaxWeight.validateNumeric();
objForm.MaxWeight.validateExp("parseInt(this.value) < 1");

objForm.MaxWeight.description = "maximum weight";
objForm.MerchantZip.description = "Shipper Zip/Postal Code";
objForm.UseAV.description = "address verification";

qFormAPI.errorColor = "<cfoutput>###Request.GetColors.formreq#</cfoutput>";
</script>
</cfprocessingdirective>

