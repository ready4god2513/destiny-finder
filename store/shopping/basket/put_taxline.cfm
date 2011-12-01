<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This template is called to output the line with the tax cost for the order. Must be preceeded by a call to act_calc_tax.cfm. Called by dsp_basket.cfm --->

<!--- <cfdump var="#arrTaxTotals#"> --->

<cfscript>
	strTaxes = StructNew();
	
	for (i=1; i LTE ArrayLen(arrTaxTotals); i=i+1) {
		taxName = arrTaxTotals[i].Display;
		if (StructKeyExists(strTaxes, taxName)) {
			strTaxes[taxName] = strTaxes[taxName] + arrTaxTotals[i].TotalTax;
		}
		else if (arrTaxTotals[i].TotalTax IS NOT 0) {
			strTaxes[taxName] = arrTaxTotals[i].TotalTax;	
		}		
	}
</cfscript>

<!--- Now output the tax totals --->
<cfloop item="tx" collection="#strTaxes#">
	<!--- Output any taxes --->
	<cfoutput>
	<tr>
		<td colspan="3" align="right"><strong>#tx#:</strong>
		</td>
		<td align="right">#LSCurrencyFormat(strTaxes[tx])#</td>		
	</tr>
	</cfoutput>
</cfloop>

