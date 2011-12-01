<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the form to modify the Intershipper settings. Called by shopping.admin&shipping=intershipper --->

<cfset GetInter = Application.objShipping.getIntShipSettings()>

<cfprocessingdirective suppresswhitespace="no">
<cfhtmlhead text="
<script language=""JavaScript"">
		function CancelForm () {
		location.href = ""#self#?fuseaction=shopping.admin&shipping=settings&redirect=yes#request.token2#"";
		}
	</script>
">
</cfprocessingdirective>

<cfmodule template="../../../../customtags/format_admin_form.cfm"
	box_title="Intershipper Settings"
	width="450"
	>
	
	<cfoutput>
	<form action="#self#?fuseaction=shopping.admin&shipping=intershipper#request.token2#"  method="post" name="editform">

	<cfinclude template="../../../../includes/form/put_space.cfm">

		<tr>
			<td align="right" valign="top">Shippers:</td>
			<td style="background-color: ###Request.GetColors.formreq#;" width="3">&nbsp;</td>
			<td>
			<select name="Carriers" size="4" multiple="multiple" class="formfield">
			<option value="ALL" #doSelected(ListFind(GetInter.Carriers,"ALL"))#>ALL</option>
			<option value="UPS" #doSelected(ListFind(GetInter.Carriers,"UPS"))#>United Parcel Service</option>
			<option value="USP" #doSelected(ListFind(GetInter.Carriers,"USP"))#>US Postal Service</option>
			<option value="ABF" #doSelected(ListFind(GetInter.Carriers,"ABF"))#>Airborne Express</option>
			<option value="FDX" #doSelected(ListFind(GetInter.Carriers,"FDX"))#>FedEx Express</option>
			<option value="DHL" #doSelected(ListFind(GetInter.Carriers,"DHL"))#>DHL Airways</option>
			</select>
			</td>	
		</tr>
	
		<tr>
			<td align="right" valign="top">Services</td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
			<td>
			<select name="Classes" size="4" multiple="multiple" class="formfield">
			<option value="ALL" #doSelected(ListFind(GetInter.Classes,"ALL"))#>ALL</option>
			<option value="1DY" #doSelected(ListFind(GetInter.Classes,"1DY"))#>One Day Service</option>
			<option value="2DY" #doSelected(ListFind(GetInter.Classes,"2DY"))#>Two Day Service</option>
			<option value="3DY" #doSelected(ListFind(GetInter.Classes,"3DY"))#>Three Day Service</option>
			<option value="GND" #doSelected(ListFind(GetInter.Classes,"GND"))#>Ground Service</option>
			</select>
			</td>	
		</tr>
		<tr>
			<td align="right" width="38%">Account User ID:</td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
			<td width="62%">
			<input type="text" name="userid" size="20" maxlength="150" value="#GetInter.userid#" class="formfield"/>
			</td>	
		</tr>
	
		<tr>
			<td align="right">Account Password:</td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
			<td>
			<input type="Password" name="Password" size="20" maxlength="50" value="#GetInter.Password#" class="formfield"/>
			</td>	
		</tr>
		
		<tr>
			<td align="right" valign="top" width="35%">Maximum Package Weight:</td>
			<td style="background-color: ###Request.GetColors.formreq#;">&nbsp;</td>
			<td width="65%">
			<input type="text" name="MaxWeight" size="7" maxlength="15" value="#GetInter.MaxWeight#" class="formfield"/>
			</td>	
		</tr>
		
		<tr>
			<td align="right" valign="top" width="35%">Units of Measurement:</td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
			<td width="65%">
			<select name="UnitsofMeasure" size="1" class="formfield">
			<option value="LBS/IN" #doSelected(GetInter.UnitsofMeasure,'LBS/IN')#>Pounds/Inches</option>
			<option value="KGS/CM" #doSelected(GetInter.UnitsofMeasure,'KGS/CM')#>Kilograms/Centimeters</option>
			</select>
			</td>	
		</tr>
		<tr><td colspan="2"></td><td class="formtextsmall">
		Should match the units in the Main Settings. 
		</td></tr>

		
		<tr>
			<td align="RIGHT">Shipper's Zip/Postal Code:</td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
			<td>
			<input type="text" name="MerchantZip" value="#GetInter.MerchantZip#" size="20" maxlength="20" class="formfield"/>
			</td>	
		</tr>
		
		<tr>
			<td align="right">Pickup Method</td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
			<td>
			<select name="Pickup" size="1" class="formfield">
			<option value="SCD" #doSelected(GetInter.Pickup,'SCD')#>Regularly Scheduled Pickup</option>
			<option value="DRP" #doSelected(GetInter.Pickup,'DRP')#>Counter Drop-off</option>
			<option value="PCK" #doSelected(GetInter.Pickup,'PCK')#>Special (On-Call) Pickup</option>
			</select>
			</td>	
		</tr>	
		
		<tr>
			<td align="right" valign="top">Log Transactions:</td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
			<td><input type="radio" name="Logging" value="1" #doChecked(GetInter.Logging)# />On 
			&nbsp;<input type="radio" name="Logging" value="0" #doChecked(GetInter.Logging,0)# />Off</td>	
		</tr>	
		
		<tr>
			<td align="right" valign="top">Debug:</td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
			<td><input type="radio" name="Debug" value="1" #doChecked(GetInter.Debug)# />On 
			&nbsp;<input type="radio" name="Debug" value="0" #doChecked(GetInter.Debug,0)# >Off</td>	
		</tr>	
		
		<cfinclude template="../../../../includes/form/put_space.cfm">

		<tr>
			<td colspan="2"></td>
			<td><input type="submit" name="submit_intershipper" value="Save" class="formbutton"/> 
			<input type="button" value="Cancel" onclick="javascript:CancelForm();" class="formbutton"/>
			</td>	
		</tr>	
	</form>
	</cfoutput>
</cfmodule>

<cfprocessingdirective suppresswhitespace="no">
<script type="text/javascript">
objForm = new qForm("editform");

objForm.required("userid,Password,MaxWeight,MerchantZip,Logging,Debug");

objForm.MaxWeight.validateNumeric();
objForm.MaxWeight.validateExp("parseInt(this.value) < 1");

objForm.MaxWeight.description = "maximum weight";
objForm.userid.description = "account ID";
objForm.MerchantZip.description = "shipper's zip code";

qFormAPI.errorColor = "<cfoutput>###Request.GetColors.formreq#</cfoutput>";
</script>
</cfprocessingdirective>