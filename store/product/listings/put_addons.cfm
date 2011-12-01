<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This template is used for outputting the addons for a product and is called by put_orderbox.cfm --->

<!--- It uses the GetProdAddons query run in qry_get_prod_info.cfm that retrieves all the addons for products on a page --->

<!--- initialize addon numbers  --->
<cfset numAddons = GetProdAddons.Recordcount>

<!--- Allows for current addons to be passed in, used for admin product editing --->
<cfparam name="selectedAddons" default="">

<cfloop index="addnum" from="1" to="#numAddons#">
	<cfscript>
		AddonID = GetProdAddons.Addon_ID[addnum];

		// get the prompt and Addon List, check if addon turned on, check for prices to be added
		if (GetProdAddons.Standard_ID[addnum] IS 0) {
			// Custom Addon
			UserPrompt = GetProdAddons.Prompt[addnum];
			ShowAddon = GetProdAddons.Display[addnum];
			AddType = GetProdAddons.AddonType[addnum];
			Required = GetProdAddons.Required[addnum];
			AddonDesc = GetProdAddons.AddonDesc[addnum];
		}
		else {
			// Standard Addon
			UserPrompt = GetProdAddons.Std_Prompt[addnum];
			AddType = GetProdAddons.Std_Type[addnum];
			Required = GetProdAddons.Std_Required[addnum];
			AddonDesc = GetProdAddons.Std_Desc[addnum];
			if (GetProdAddons.Display[addnum] AND GetProdAddons.Std_Display[addnum])
				ShowAddon = 1;
			else
				ShowAddon = 0;
		}	
		
		AddonValue = '';
		
		if (len(selectedAddons)) {
			for(i=1; i lte ListLen(selectedAddons, "^"); i=i+1) {
				theAddon = ListGetAt(selectedAddons, i, "^");
				if (Find(AddonDesc, theAddon))
					AddonValue = trim(replace(theAddon,AddonDesc & ":",""));		
				}		
			}
	</cfscript>
	
	<!--- Check if this addon is turned on, continue if yes  --->
	<cfif ShowAddon>
	
		<cfscript>
			//Add required addons to list
			if (Required) {
				RequireList = ListAppend(RequireList, "Addon#AddonID#", "^");
				RequireNames = ListAppend(RequireNames, UserPrompt, "^");
			}
			
			//Add quantity addons to numeric list
			if (AddType IS "quantity") {
				NumericList = ListAppend(NumericList, "Addon#AddonID#", "^");
				NumericNames = ListAppend(NumericNames, UserPrompt, "^");
			}
			
			// open the table cell for the addons
			WriteOutput('<tr><td valign="bottom"');
			
			if (extras GT 0)
				WriteOutput(' colspan="' & extras & '"');
			
			WriteOutput('>');
					
		</cfscript>
	
		<cfoutput>
			<cfif AddType IS "textbox">
				#UserPrompt#<br/>
				<input type="text" name="Addon#AddonID#" value="#AddonValue#" size="30" maxlength="150" class="formfield"/>
			<cfelseif AddType IS "calendar">
				<cfmodule template="../../customtags/calendar_input.cfm" ID="cal#AddonID#" formfield="Addon#AddonID#" formname="orderform#Product_ID#" prompt="#UserPrompt#" size="10" browser="#browsername#" bversion="#browserversion#" /><br/>
			<cfelseif AddType IS "checkbox">
				<input type="checkbox" name="Addon#AddonID#" value="yes" #doChecked(addonvalue,'Yes')# />#UserPrompt# 
			<cfelseif AddType IS "quantity">
				#UserPrompt#: <input type="text" name="Addon#AddonID#" value="#AddonValue#" size="5" maxlength="100" class="formfield" />
			<cfelseif AddType IS "textfield">
				#UserPrompt#<br/>
				<textarea cols="27" rows="5" name="Addon#AddonID#" class="formfield">#AddonValue#</textarea>	
			</cfif>	
		</cfoutput>
		
		<cfscript>
		//close the table cells and rows
		if (NOT vertoptions AND numAddons IS 0)
			WriteOutput('</td>');
		else 
			WriteOutput('</td></tr>');	
		</cfscript>
	
	</cfif>

</cfloop>

