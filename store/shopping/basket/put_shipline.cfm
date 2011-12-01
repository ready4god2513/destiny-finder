<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This template is called to output the line with the shipping cost. Called by dsp_basket.cfm --->

<!--- If store is set to combine shipping and freight, add freight amount to shipping --->
<cfif NOT ShipSettings.ShowFreight AND TotalFreight IS NOT 0>
	<cfset ShipCost = ShipCost + TotalFreight>
	<cfset TotalFreight = 0>
</cfif>


<cfif ShipCost>
<cfoutput>
<tr>
	<td colspan="3" align="right"><strong><cfif ListFind('UPS,FedEx,USPS',ShipSettings.ShipType)>#ShipSettings.ShipType# </cfif>Shipping:</strong></td>
	<td align="right">#LSCurrencyFormat(ShipCost)#</td>
</tr>
</cfoutput>
</cfif>

<cfif TotalFreight>
<cfoutput>
<tr>
	<td colspan="3" align="right"><strong>Freight Costs:</strong></td>
	<td align="right">#LSCurrencyFormat(TotalFreight)#</td>
</tr>
</cfoutput>
</cfif>