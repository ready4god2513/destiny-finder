<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the Sales Tax Report. Called by dsp_reports.cfm --->

<tr><td colspan="2" align="CENTER">
TAX REPORT - <cfoutput>#LSDateFormat(StartDate, "mmm d, yyyy")# - #LSDateFormat(ToDate, "mmm d, yyyy")#</cfoutput><br/>&nbsp;
</td></tr>

<cfif NOT taxesfound>
<tr><td align="center">No orders found for this date range.</td></tr>

<cfelse>

	<!--- State/Local Taxes --->
	<cfif StateTaxes.RecordCount>
		<tr><td align="center"><strong>STATE/LOCAL TAXES</strong></td></tr>
		
		<tr><td align="center">
		<cfoutput><table border="0" width="575" cellspacing="0" cellpadding="5" bgcolor="###Request.GetColors.OutputTbgcolor#" align="center" class="formtext" style="color:###Request.GetColors.OutputTText#"> </cfoutput>
		<tr><td><b>State</b></td>
		<td><b>Tax Type</b></td>
		<td><b>Taxed Sales</b></td>
		<td align="center"><b>State Tax</b></td>
		<td align="center"><b>Local Tax</b></td>
		</tr>
		<cfoutput query="StateTaxesTotal">
		<cfif CurrentRow MOD 2 IS 0>
			<tr>
		<cfelse>
			<tr bgcolor="###Request.GetColors.outputtaltcolor#">
		</cfif>
		<td>#Name#</td>
		<td>#CodeName#</td>
		<td align="center">#LSCurrencyFormat(Sales_Total)#</td>
		<td align="center">#LSCurrencyFormat(StateTax_Total)#</td>
		<td align="center">#LSCurrencyFormat(LocalTax_Total)#</td>
		</tr>
		</cfoutput>
		</table><br/>&nbsp;
		</td></tr>	
	</cfif>
	<!--- End State/Local Taxes --->
	
	<!--- County Taxes --->
	<cfif CountyTaxes.RecordCount>
		<tr><td align="center"><strong>COUNTY TAXES</strong></td></tr>
		
		<tr><td align="center">
		<cfoutput><table border="0" width="575" cellspacing="0" cellpadding="5" bgcolor="###Request.GetColors.OutputTbgcolor#" align="center" class="formtext" style="color:###Request.GetColors.OutputTText#"> </cfoutput>
		<tr><td><b>State</b></td>
		<td><b>County</b></td>
		<td><b>Tax Type</b></td>
		<td><b>Taxed Sales</b></td>
		<td align="center"><b>Tax Collected</b></td>
		</tr>
		<cfoutput query="CountyTaxesTotal">
		<cfif CurrentRow MOD 2 IS 0>
			<tr>
		<cfelse>
			<tr bgcolor="###Request.GetColors.outputtaltcolor#">
		</cfif>
		<td>#State#</td>
		<td>#County#</td>
		<td>#CodeName#</td>
		<td align="center">#LSCurrencyFormat(Sales_Total)#</td>
		<td align="center">#LSCurrencyFormat(Tax_Total)#</td>
		</tr>
		</cfoutput>
		</table><br/>&nbsp;
		</td></tr>	
	</cfif>
	<!--- End County Taxes --->
	
	<!--- Country Taxes --->
	<cfif CountryTaxes.RecordCount>
		<tr><td align="center"><strong>COUNTRY TAXES</strong></td></tr>
		
		<tr><td align="center">
		<cfoutput><table border="0" width="575" cellspacing="0" cellpadding="5" bgcolor="###Request.GetColors.OutputTbgcolor#" align="center" class="formtext" style="color:###Request.GetColors.OutputTText#"> </cfoutput>
		<tr><td><b>Country</b></td>
		<td><b>Tax Type</b></td>
		<td><b>Taxed Sales</b></td>
		<td align="center"><b>Tax Collected</b></td>
		</tr>
		<cfoutput query="CountryTaxesTotal">
		<cfif CurrentRow MOD 2 IS 0>
			<tr>
		<cfelse>
			<tr bgcolor="###Request.GetColors.outputtaltcolor#">
		</cfif>
		<td>#ListGetAt(Country, 2, "^")#</td>
		<td>#CodeName#</td>
		<td align="center">#LSCurrencyFormat(Sales_Total)#</td>
		<td align="center">#LSCurrencyFormat(Tax_Total)#</td>
		</tr>
		</cfoutput>
		</table><br/>&nbsp;
		</td></tr>	
	</cfif>
	<!--- End State/Local Taxes --->
	
	
	<!--- All Users Taxes --->
	<cfif AllUserTaxes.RecordCount>
		<tr><td align="center"><strong>TAX FOR ALL USERS</strong></td></tr>
		
		<tr><td align="center">
		<cfoutput><table border="0" width="500" cellspacing="0" cellpadding="5" bgcolor="###Request.GetColors.OutputTbgcolor#" align="center" class="formtext" style="color:###Request.GetColors.OutputTText#"> 
		</cfoutput>
		<td valign="top"><b>Tax Type</b></td>
		<td valign="top" align="center"><b>Taxed Sales</b></td>
		<td align="center"><b>Tax Collected</b></td>
		</tr>
		<cfoutput query="AllUserTaxes">
		<cfif CurrentRow MOD 2 IS 0>
			<tr>
		<cfelse>
			<tr bgcolor="###Request.GetColors.outputtaltcolor#">
		</cfif>
		<td>#CodeName#</td>
		<td align="center">#LSCurrencyFormat(AllUserTaxes.Sales_Sum)#</td>
		<td align="center">#LSCurrencyFormat(Tax_Sum)#</td>
		</tr>
		</cfoutput>
		</table><br/>&nbsp;
		</td></tr>	
	</cfif>
	<!--- End All Users Taxes --->
	
</cfif>

</td></tr>
