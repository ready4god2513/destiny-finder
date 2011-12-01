<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Settings for Cybercash gateway. Called from dsp_process.cfm --->

		<tr><td colspan="3" align="center" class="formtitle">Cybercash Payment Processing<br/><br/></td></tr>

<cfoutput>

		<tr>
			<td align="RIGHT">CyberCash Server </td>
			<td style="background-color: ###Request.GetColors.formreq#;" width="3">&nbsp;</td>
			<td>
			<input type="text" name="CCServer" value="#attributes.CCServer#" size="50" maxlength="75" class="formfield"/>
			</td>	
		</tr>
		
		<tr>
			<td align="RIGHT">Merchant ID </td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
			<td>
			<input type="text" name="Username" value="#attributes.Username#" size="20" maxlength="50" class="formfield"/>
			</td>	
		</tr>
		
		<tr>
			<td align="RIGHT">Merchant Key </td>
			<<td style="background-color: ###Request.GetColors.formreq#;"></td>
			<td>
			<input type="Password" name="Password" value="#attributes.Password#" size="20" maxlength="75" class="formfield"/>
			</td>	
		</tr>
		
		<tr>
			<td align="RIGHT">Transaction Type </td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
			<td>
			<select name="Transtype" size="1" class="formfield">
				<option value="mauthcapture" #doSelected(attributes.Transtype,'mauthcapture')#>mauthcapture (Immediate Funds Transfer)</option>
	   			<option value="mauthonly" #doSelected(attributes.Transtype,'mauthonly')#>mauthonly (Deferred Funds Transfer)</option></select>
			</td>	
		</tr>
</cfoutput>

