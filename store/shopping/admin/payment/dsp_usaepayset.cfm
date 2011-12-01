<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Settings for USAepay gateway. Called from dsp_process.cfm --->

<!--- USAepay settings:
		USAepay KEY =  Username
		Command  = Transtype 
sale, credit, void, authonly, capture, postauth, check and checkcredit. Default is sale.
		AVSCV2Check (YES or NO) = CV2 is passed if provided
 --->
 
<!--- Radio button defaults --->
<cfset attributes.Setting1 = iif(attributes.Setting1 IS 'YES',Evaluate(DE('attributes.Setting1')),DE('NO'))>
<cfset attributes.Transtype = iif(attributes.Transtype IS 'sale',Evaluate(DE('attributes.Transtype')),DE('authonly'))>

		<tr><td colspan="3" align="center" class="formtitle">USAepay Payment Processing<br/><br/></td></tr>

<cfoutput>
		<tr>
			<td align="RIGHT" width="35%">USAepay Merchant Key</td>
			<td style="background-color: ###Request.GetColors.formreq#;" width="3">&nbsp;</td>
			<td width="65%">
			<input type="text" name="Username" value="#attributes.Username#" class="formfield" size="30" maxlength="75"/>
			</td>	
		</tr>
		
		<tr>
			<td align="RIGHT" width="35%">Transaction Type </td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
			<td width="65%">
			<input type="radio" name="Transtype" value="sale" #doChecked(attributes.Transtype,'sale')# /> Sale &nbsp;
			<input type="radio" name="Transtype" value="authonly" #doChecked(attributes.Transtype,'authonly')# /> Authorize Only</td>	
		</tr>

		<tr>
			<td align="RIGHT" width="35%">AVS CV2 Check </td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
			<td width="65%">
			<input type="radio" name="Setting1" value="YES" #doChecked(attributes.Setting1,'YES')# /> Yes &nbsp;
			<input type="radio" name="Setting1" value="NO" #doChecked(attributes.Setting1,'NO')# /> No</td>	
		</tr>
		
</cfoutput>



