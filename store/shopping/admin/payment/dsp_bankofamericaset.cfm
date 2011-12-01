<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Settings for Bank of America eStores gateway. Called from dsp_process.cfm --->

<!--- settings:
		merchant_id (eStore Merchant ID) =  Username
		auto_settle (Y or N) = Autosettle or not 
		AVSCV2Check (0 or 1) = Flags if CV2 is passed
		CCServer = merchant user name - used for settlement transactions only
		Password = merchant password - used for settlement transactions only
 --->
 
<!--- Radio button defaults --->
<cfset attributes.Setting1 = iif(isNumeric(attributes.Setting1),Evaluate(DE('attributes.Setting1')),0)>
<cfset attributes.Transtype = iif(attributes.Transtype IS 'Y',Evaluate(DE('attributes.Transtype')),DE('N'))>


		<tr><td colspan="3" align="center" class="formtitle">Bank of America eStores Payment Processing<br/><br/></td></tr>

<cfoutput>
		<tr>
			<td align="RIGHT" width="35%" valign="baseline">Merchant ID </td>
			<td style="background-color: ###Request.GetColors.formreq#;" width="3">&nbsp;</td>
			<td width="65%">
			<input type="text" name="Username" value="#attributes.Username#" class="formfield" size="30" maxlength="150"/><br/>
			<span class="formtextsmall">Merchant ID should match the store id that you login<br/>to Bank of America's BMart.com web site with.</span>
			</td>	
		</tr>
		
		<tr>
			<td align="RIGHT" width="35%">CV2 Check </td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
			<td width="65%">
			<input type="radio" name="Setting1" value="1" #doChecked(attributes.Setting1)# /> Yes &nbsp;
			<input type="radio" name="Setting1" value="0" #doChecked(attributes.Setting1,0)# /> No</td>	
		</tr>
		
		<tr>
			<td align="RIGHT" width="35%">Auto Settle </td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
			<td width="65%">
			<input type="radio" name="Transtype" value="Y" #doChecked(attributes.Transtype,'Y')# /> Yes &nbsp;
			<input type="radio" name="Transtype" value="N" #doChecked(attributes.Transtype,'N')# /> No (authorize only, delay settlement)</td>	
		</tr>
		
		<tr>
			<td align="RIGHT" width="35%" valign="baseline">Merchant User Name </td>
			<td></td>
			<td width="65%">
			<input type="text" name="CCServer" class="formfield" value="#attributes.CCServer#" size="30" maxlength="150"/><br/>
			<span class="formtextsmall">REQUIRED if Auto Settle set to No.</span>
			</td>	
		</tr>
		
		<tr>
			<td align="RIGHT" width="35%" valign="baseline">Merchant Password </td>
			<td></td>
			<td width="65%">
			<input type="text" name="Password" class="formfield" value="#attributes.Password#" size="30" maxlength="150"/><br/>
			<span class="formtextsmall">REQUIRED if Auto Settle set to No.</span>
			</td>	
		</tr>
	
</cfoutput>



