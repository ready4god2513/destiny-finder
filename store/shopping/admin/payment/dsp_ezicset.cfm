<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Settings for EZIC payment processing. Called from dsp_process.cfm --->

		<tr><td colspan="3" align="center" class="formtitle">EZIC Payment Processing<br/><br/></td></tr>

<cfoutput>
		<tr>
			<td align="RIGHT" width="44%">Merchant Account Number </td>
			<td style="background-color: ###Request.GetColors.formreq#;" width="3">&nbsp;</td>
			<td width="60%">
			<input type="text" name="Password" value="#attributes.Password#" size="30" maxlength="75" class="formfield"/>
			</td>	
		</tr>
		
		<tr>
			<td align="RIGHT">Transaction Type </td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
			<td>
			<select name="Transtype" size="1" class="formfield">
			<option value="S" #doSelected(attributes.Transtype,'S')#>Sale</option>
	   		<option value="A" #doSelected(attributes.Transtype,'A')#>Authorize</option>
			</select>
			</td>	
		</tr>
</cfoutput>

