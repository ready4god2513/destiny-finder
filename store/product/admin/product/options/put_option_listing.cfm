
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Used to display the current options for a product, with buttons to edit or delete the option. Called from product\admin\product\dsp_options_form.cfm --->

<!--- This entire page runs for each option --->
<cfloop query="qry_Get_Options">

	<cfset StandOpt = iif(qry_get_options.Std_ID IS NOT 0, 1, 0)>
	<cfset optnum = qry_get_options.Option_ID>
	
	<!--- Get the list of option choices --->
	<cfquery name="getChoices" dbtype="query">
	SELECT * FROM qry_get_Opt_Choices
	WHERE Option_ID = #optnum#
	ORDER BY SortOrder
	</cfquery>
	
	<!--- Checks if this option is being used for inventory tracking on any orders --->
	<cfquery name="CheckInvUse" datasource="#Request.ds#" username="#Request.user#" password="#Request.pass#" maxrows="1">
		SELECT OptChoice FROM #Request.DB_Prefix#Order_Items OI, 
		#Request.DB_Prefix#Products P, #Request.DB_Prefix#Product_Options PO
		WHERE PO.Option_ID =  <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#optnum#">
		AND PO.Option_ID = P.OptQuant
		AND P.Product_ID = OI.Product_ID
		AND OI.OptChoice <> 0 
	</cfquery>
	
	<cfoutput>
	
	<tr><td width="30%" align="right"><b>
		
		<cfif len(getChoices.SKU)>SKUs</cfif>
			
		<cfif len(getChoices.SKU) AND qry_Get_Options.TrackInv>/</cfif>
			
		<cfif qry_Get_Options.TrackInv>INV</cfif>

		</b></td>
		<td align="left">
	<select name="Option_List" size="1">
		
	<!--- First item in the list is given the same value as the first option choice, but displays the Option Prompt message  --->
	<option value="#getChoices.Choice_ID[1]#"><cfif len(qry_Get_Options.Prompt)>#qry_Get_Options.Prompt#<cfelse>#qry_Get_Options.Std_Prompt#</cfif></option>
		<cfloop query="getChoices">
			<!--- Output the list of options --->
			<option value="#getChoices.Choice_ID#">#getChoices.ChoiceName#</option>
		</cfloop>
	</select></td>

		<!--- display button to edit the option. Each button is named with the option number --->
		<td><input type="submit" value="Edit" onclick="setoption(#optnum#,#StandOpt#,'Edit')" class="formbutton"/> 
		<cfif NOT CheckInvUse.RecordCount>
			<input type="submit" value="Delete" onclick="setoption(#optnum#,#StandOpt#,'Delete')" class="formbutton"/>
		<cfelse>
			<input type="button" value="Delete" class="formbutton"  onclick="alert('This option is in use for inventory tracking. You must remove any orders for this product before you can delete it.');"/>
		</cfif>
		</td></tr>
	
	</cfoutput>

</cfloop>



