<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Settings for Verisign PayFlow Pro processing. Called from dsp_process.cfm --->

		<tr><td colspan="3" align="center" class="formtitle">Verisign PayFlow Pro Payment Processing<br/><br/></td></tr>

<cfoutput>
		<tr>
			<td align="RIGHT">Merchant Login ID </td>
			<td style="background-color: ###Request.GetColors.formreq#;" width="3">&nbsp;</td>
			<td>
			<input type="text" name="Username" value="#attributes.Username#" size="20" maxlength="50" class="formfield"/>
			</td>	
		</tr>
		
		<tr>
			<td align="RIGHT">Password </td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
			<td>
			<input type="Password" name="Password" value="#attributes.Password#" size="20" maxlength="75" class="formfield"/>
			</td>	
		</tr>
		
		<tr>
			<td align="RIGHT">Host Address </td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
			<td>
			<input type="text" name="CCServer" value="#attributes.CCServer#" size="50" maxlength="75" class="formfield"/>
			</td>	
		</tr>
		<tr><td>&nbsp;</td><td colspan="2"><span class="formtextsmall">Use "payflowpro.paypal.com" for live transactions and "pilot-payflowpro.paypal.com" for testing.</span></td></tr>
		
		<tr>
			<td align="RIGHT">Partner </td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
			<td>
			<input type="text" name="Setting1" value="#attributes.Setting1#" size="30" maxlength="75" class="formfield"/>
			</td>	
		</tr>
		<tr><td>&nbsp;</td><td colspan="2"><span class="formtextsmall">Typically this will just be "PayPal"</span></td></tr>
				
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
