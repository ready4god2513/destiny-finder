<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the form to update the UPS Settings for the store. Called by shopping.admin&shipping=ups --->

<cfinclude template="qry_fedex_settings.cfm">
<cfinclude template="../../../../queries/qry_getcountries.cfm">
<cfinclude template="../../../../queries/qry_getstates.cfm">

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
	box_title="FedEx<sup>&reg;</sup> Shipping Settings"
	width="550"
	>
	
	<cfoutput>
	<form action="#self#?fuseaction=shopping.admin&shipping=fedex#request.token2#"  method="post" name="fedex">

	<cfinclude template="../../../../includes/form/put_space.cfm">

		<tr>
			<td align="right" valign="top" width="35%">Maximum Package Weight:</td>
			<td style="background-color: ###Request.GetColors.formreq#;" width="3">&nbsp;</td>
			<td width="65%">
			<input type="text" name="MaxWeight" size="7" maxlength="15" value="#GetFedEx.MaxWeight#" class="formfield"/>
			</td>	
		</tr>
		
		<tr>
			<td align="right" valign="top" width="35%">Units of Measurement:</td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
			<td width="65%">
			<select name="UnitsofMeasure" size="1" class="formfield">
			<option value="LBS/IN" #doSelected(GetFedEx.UnitsofMeasure,"LBS/IN")#>Pounds/Inches</option>
			<option value="KGS/CM" #doSelected(GetFedEx.UnitsofMeasure,"KGS/CM")#>Kilograms/Centimeters</option>
			</select>
			</td>	
		</tr>
		<tr><td colspan="2"></td><td class="formtextsmall">
		Should match the units in the Main Settings. 
		</td></tr>
		
		<tr>
			<td align="right" valign="top" width="35%">FedEx Account No:</td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
			<td width="65%">
			<input type="text" name="AccountNo" size="10" maxlength="20" value="#GetFedex.AccountNo#" class="formfield"/>
			</td>	
		</tr>
<!--- 		
		<tr>
			<td align="right" valign="top" width="35%">Meter Number:</td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
			<td width="65%">
			<input type="text" name="MeterNum" size="10" maxlength="20" value="#GetFedex.MeterNum#" class="formfield"/>
			</td>	
		</tr> --->
		<tr>
			<td align="right" valign="top" width="35%">Package Type:</td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
			<td width="65%">
			<select name="Packaging" size="1" class="formfield">
			<cfloop query="GetFedExPackages">
			<option value="#FedEx_Code#" #doSelected(GetFedEx.Packaging,FedEx_Code)#>#Description#</option>
			</cfloop>
			</select>
			</td>	
		</tr>
		
		<tr>
			<td align="right" valign="top" width="35%">Dropoff Method:</td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
			<td width="65%">
			<select name="Dropoff" size="1" class="formfield">
			<cfloop query="GetFedExDropoff">
			<option value="#FedEx_Code#" #doSelected(GetFedEx.Dropoff,FedEx_Code)#>#Description#</option>
			</cfloop>
			</select>
			</td>	
		</tr>
				
		<tr>
			<td align="RIGHT">Shipper's Zip/Postal Code:</td>
			<td></td>
			<td>
			<input type="text" name="OrigZip" value="#GetFedEx.OrigZip#" size="20" maxlength="20" class="formfield"/>
			</td>	
		</tr>
		<tr><td colspan="2"></td><td class="formtextsmall">
Required for countries that use postal codes<br/> (e.g. US and CA).
</td></tr>

		<tr>
			<td align="RIGHT">Shipper's State/Province:</td>
			<td></td>
			<td>
			<select name="OrigState" size="1" class="formfield">
			<option value="" #doSelected(GetFedEx.OrigState,"")#>Unlisted/None</option>
   			<option value="">___________________</option>
		<cfloop query="GetStates">
   			<option value="#Abb#" #doSelected(GetFedEx.OrigState,Abb)#>#Name# (#Abb#)</option>
		</cfloop></select>
			</td>	
		</tr>
		<tr><td colspan="2"></td><td class="formtextsmall">
Required for United States and Canada.
</td></tr>
		
		<tr>
			<td align="right" valign="top" width="35%">Shipper's Country:</td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
		<td><select name="OrigCountry" size="1" class="formfield">
		<cfloop query="GetCountries">
   			<option value="#Abbrev#" #doSelected(GetFedEx.OrigCountry,Abbrev)#>#Left(Name,28)#</option>
		</cfloop>
		</select></td>
		</tr>
		
		<tr>
			<td align="right" valign="top" width="35%">Shippers Used:</td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
			<td width="65%">
			<input type="checkbox" name="UseGround" value="1" #doChecked(GetFedEx.UseGround)# />FedEx Ground<sup>&reg;</sup> 
&nbsp;&nbsp;<input type="checkbox" name="UseExpress" value="1" #doChecked(GetFedEx.UseExpress)# />FedEx Express<sup>&reg;</sup>
			</td>	
		</tr>
			<tr><td colspan="2"></td><td class="formtextsmall">
This setting will override any selected methods in the FedEx<sup>&reg;</sup> Methods. Turning off a shipper will result in faster shipping rate calculations.
</td></tr>

		<tr>
			<td align="right" valign="top">Log Transactions:</td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
<td><input type="radio" name="Logging" value="1" #doChecked(GetFedEx.Logging)# />On 
&nbsp;<input type="radio" name="Logging" value="0" #doChecked(GetFedEx.Logging,0)# />Off</td>	
		</tr>	
		
		<tr>
			<td align="right" valign="top">Debug:</td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
<td><input type="radio" name="Debug" value="1" #doChecked(GetFedEx.Debug)# />On 
&nbsp;<input type="radio" name="Debug" value="0" #doChecked(GetFedEx.Debug,0)# />Off</td>	
		</tr>	

		<tr>
			<td colspan="2"></td>
			<td><input type="submit" name="submit_fedex" value="Save" class="formbutton"/> 
			<input type="button" value="Cancel" onclick="javascript:CancelForm();" class="formbutton"/>
			</td>	
		</tr>	
	</form>
	
</cfoutput>	
</cfmodule>


<cfprocessingdirective suppresswhitespace="no">
<script type="text/javascript">
objForm = new qForm("fedex");

objForm.required("MaxWeight,AccountNo,Dropoff,Packaging,Debug");

objForm.MaxWeight.validateNumeric();
objForm.MaxWeight.validateExp("parseInt(this.value) < 1");

objForm.MaxWeight.description = "maximum weight";
objForm.AccountNo.description = "FedEx Account Number";
objForm.OrigZip.description = "Shipper Zip/Postal Code";
objForm.OrigState.description = "Shipper State/Province";

objForm.OrigState.createDependencyTo("OrigCountry", "US"); 
objForm.OrigState.createDependencyTo("OrigCountry", "CA");

objForm.OrigZip.createDependencyTo("OrigCountry", "US"); 
objForm.OrigZip.createDependencyTo("OrigCountry", "AU");
objForm.OrigZip.createDependencyTo("OrigCountry", "CA");
objForm.OrigZip.createDependencyTo("OrigCountry", "FR");
objForm.OrigZip.createDependencyTo("OrigCountry", "DE");
objForm.OrigZip.createDependencyTo("OrigCountry", "MX");
objForm.OrigZip.createDependencyTo("OrigCountry", "NZ");
objForm.OrigZip.createDependencyTo("OrigCountry", "PR");
objForm.OrigZip.createDependencyTo("OrigCountry", "GB");

objForm.OrigCountry.enforceDependency();


qFormAPI.errorColor = "<cfoutput>###Request.GetColors.formreq#</cfoutput>";
</script>
</cfprocessingdirective>