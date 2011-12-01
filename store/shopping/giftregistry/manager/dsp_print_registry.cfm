
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This page is used to display a printable version of the gift registry. Called by shopping.giftregistry&manage=print --->
<cfoutput>
<table width="650" cellspacing="0" cellpadding="4" style="border-collapse: collapse" align="center">
  <tr>
  	<cfif len(request.appsettings.sitelogo)>
		<td class="printregistry">
			<img src="#request.StoreURL##Request.AppSettings.DefaultImages#/#request.appsettings.sitelogo#" alt="" />
		</td><td class="printregistry" valign="top">
	<cfelse>
		<td colspan="2" class="printregistry">
	</cfif>
	<span style="font-size: large;">#request.AppSettings.siteName# Gift Registry</span><br/>
	#Request.AppSettings.Merchant#<br/>
	Customer Support: <a href="mailto:#request.appsettings.merchantemail#">#request.appsettings.merchantemail#</a></td>
  </tr>
  <tr>
    <td class="printregistry" width="50%"><em>Registrant</em>: #qry_get_giftregistry.Registrant#
	<cfif len(qry_get_giftregistry.OtherName)><br/>Co-Registrant: #qry_get_giftregistry.OtherName#</cfif></td>
    <td class="printregistry"><em>Event Date</em>: #DateFormat(qry_get_giftregistry.Event_Date,'MM/DD/YYYY')#</td>
  </tr>
  <tr>
    <td colspan="2" class="printregistry"><em>Notes</em>: <br/><br/>&nbsp;</td>
  </tr>
 </cfoutput>
  <tr>
    <td colspan="2" class="printregistry" align="center">
	<table width="100%" cellspacing="0" cellpadding="4" style="border-collapse: collapse">
      <tr>
        <th class="printregistry" align="left" nowrap="nowrap">Item Number</th>
        <th class="printregistry" align="left" nowrap="nowrap">Product Description</th>
        <th class="printregistry" align="right" nowrap="nowrap">Still Need</th>
        <th class="printregistry" align="right" nowrap="nowrap">Price</th>
      </tr>
	  <cfoutput query="qry_get_items">
	  <cfinclude template="../qry_check_item.cfm">
		<cfif NOT CheckProd.Recordcount>
			<cfset disable = "yes">
		<cfelseif CheckProd.OptQuant IS NOT 0 AND (CheckProd.OptQuant IS NOT qry_get_items.OptQuant OR NOT CheckOptions.RecordCount)>
			<cfset disable = "yes">
		<cfelse>
			<cfset disable = "no">
		</cfif>
	<cfif NOT disable>
      <tr>
        <td class="printregistry" align="left" valign="top">#SKU#</td>
        <td class="printregistry" align="left" valign="top">#Name#</td>
        <td class="printregistry" align="right" valign="top">#Evaluate(Quantity_Requested - Quantity_Purchased)#</td>
        <td class="printregistry" align="right" valign="top">#LSCurrencyFormat(Price+OptPrice+AddonMultP)#</td>
      </tr>
	  </cfif>
	  </cfoutput>
    </table>	</td>
  </tr>
</table>
