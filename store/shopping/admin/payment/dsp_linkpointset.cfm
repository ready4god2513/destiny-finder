<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Settings for Linkpoint gateway. Called from dsp_process.cfm --->

		<tr><td colspan="3" align="center" class="formtitle">LinkPoint Payment Processing<br/><br/></td></tr>

<cfoutput>
		<tr>
			<td align="RIGHT">Store Name </td>
			<td style="background-color: ###Request.GetColors.formreq#;" width="3">&nbsp;</td>
			<td>
			<input type="text" name="Username" value="#attributes.Username#" size="20" maxlength="50" class="formfield"/>
			<br/><span class="formtextsmall">(This is your Store ID)</span>
			</td>	
		</tr>
		
		<tr>
			<td align="RIGHT">Path to Private Key </td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
			<td>
			<input type="text" name="Password" value="#attributes.Password#" size="50" maxlength="75" class="formfield"/>
			<br/><span class="formtextsmall">(Example: c:\\winnt\\system32\\123456.pem)</span>
			</td>	
		</tr>
		
		<tr>
			<td align="RIGHT">Host Address </td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
			<td>
			<input type="text" name="CCServer" value="#attributes.CCServer#" size="50" maxlength="75" class="formfield"/>
			<br/><span class="formtextsmall">(example: secure.linkpt.net)</span>
			</td>	
		</tr>
		
		<tr>
			<td align="RIGHT">Host Port </td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
			<td>
			<input type="text" name="Setting1" value="#attributes.Setting1#" size="30" maxlength="75" class="formfield"/>
			<br/><span class="formtextsmall">(Example: 1139)</span>
			</td>	
		</tr>
		
		
		<tr>
			<td align="RIGHT">Transaction Type </td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
			<td>
			<select name="Transtype" size="1" class="formfield">
			<option value="S" #doSelected(attributes.Transtype,'S')#>S (Sale)</option>
	   		<option value="A" #doSelected(attributes.Transtype,'A')#>A (Authorize)</option>
			</select>
			</td>	
		</tr>
</cfoutput>
