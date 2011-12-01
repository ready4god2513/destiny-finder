<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Settings for Skipjack processor. Called from dsp_process.cfm --->

		<tr><td colspan="3" align="center" class="formtitle">Skipjack Payment Processing<br/><br/></td></tr>

<cfoutput>
		<tr>
			<td align="RIGHT" width="35%">Skipjack Server </td>
			<td style="background-color: ###Request.GetColors.formreq#;" width="3">&nbsp;</td>
			<td width="65%">
			<input type="text" name="CCServer" class="formfield" value="#attributes.CCServer#" size="30" maxlength="150"/>
			</td>	
		</tr>
		
		<tr>
			<td align="RIGHT" width="35%">Skipjack Serial Number </td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
			<td width="65%">
			<input type="Password" name="Username" class="formfield" value="#attributes.Username#" size="30" maxlength="100"/>
			</td>	
		</tr>

</cfoutput>

