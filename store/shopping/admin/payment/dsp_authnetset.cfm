<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Settings for Authorize.Net gateway. Called from dsp_process.cfm --->

		<tr><td colspan="3" align="center" class="formtitle">Authorize.Net v.3 Payment Processing<br/><br/></td></tr>

<cfoutput>
		<tr>
			<td align="RIGHT" width="35%">API Login ID </td>
			<td style="background-color: ###Request.GetColors.formreq#;" width="3">&nbsp;</td>
			<td width="65%">
			<input type="text" name="Username" value="#attributes.Username#" size="20" maxlength="50" class="formfield"/>
			</td>	
		</tr>
		
		<tr>
			<td align="RIGHT">Transaction Key </td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
			<td>
			<input type="Password" name="Password" value="#attributes.Password#" size="20" maxlength="75" class="formfield"/>
			</td>	
		</tr>
		
		
		<tr>
			<td align="RIGHT">Transaction Type </td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
			<td>
			<select name="Transtype" size="1" class="formfield">
				<option value="AUTH_CAPTURE" #doSelected(attributes.Transtype,'AUTH_CAPTURE')#>NA (Normal Authorization)</option>
	   			<option value="AUTH_ONLY" #doSelected(attributes.Transtype,'AUTH_ONLY')#>AO (Authorization Only)</option></select>
			</td>	
		</tr>
</cfoutput>


