
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This template is used for outputting the options for a product and is called by put_orderbox.cfm --->

<!--- It uses the GetProdOpts query run in qry_get_prod_info.cfm that retrieves the options for the current product --->

<!--- This determines the orientation to use for the options --->
<cfparam name="option_orientation" default="horizontal">

<cfif qry_Get_products.vertoptions>
	<cfset option_orientation = "vertical">
</cfif>

<!--- Initialize list of required options --->
<cfparam name="RequireList" default="">
<cfparam name="RequireNames" default="">

<cfloop query="GetProdOpts">
	<!--- Get the list of option choices --->
	<cfquery name="GetChoices" dbtype="query">
	SELECT * FROM qry_get_Opt_Choices
	WHERE Option_ID = #GetProdOpts.Option_ID#
	ORDER BY SortOrder
	</cfquery>
	
	<cfscript>
		OptionID = GetProdOpts.Option_ID;
		
		// Regular Product Option
		if (GetProdOpts.Std_ID IS 0) {
			// Custom Option 
			UserPrompt = GetProdOpts.Prompt;
			ShowOpt = GetProdOpts.Display;
			optRequired = GetProdOpts.Required;
			AddPrice = GetProdOpts.ShowPrice;
		}
		else {
			// Standard Option 
			UserPrompt = GetProdOpts.Std_Prompt;
			optRequired = GetProdOpts.Std_Required;
			AddPrice = GetProdOpts.Std_ShowPrice;
			if (GetProdOpts.Display AND GetProdOpts.Std_Display) 
				ShowOpt = 1;
			else
				ShowOpt = 0;
		}
		
		// Check if this option is turned on, continue if yes
		if (ShowOpt) {
		
			//Add required options to list 
			if (optRequired OR GetProdOpts.TrackInv) {
				RequireList = ListAppend(RequireList, "Option#OptionID#", "^");
				RequireNames = ListAppend(RequireNames, UserPrompt, "^");
			}
		
			//output the selectbox			
			if (NOT qry_Get_products.vertoptions)
				WriteOutput('<td valign="bottom">');
			else
				WriteOutput('<tr><td valign="top">');
			
			WriteOutput('<select name="Option' & OptionID & '" size="1" class="formfield">');
			WriteOutput('<option value="">' & UserPrompt);
			WriteOutput('</option>');	
				
			//loop through the list of option choices and output each
			for (i=1; i lte GetChoices.Recordcount; i=i+1) {
				// Check if using inventory tracking on option, if not put NA
				if (qry_Get_products.OptQuant IS OptionID) 
					OQuant = GetChoices.NumInStock[i];
				else
					OQuant = "NA";
				
				// Check if not displaying out of stock items, and option is out of stock
				if (Request.AppSettings.InvLevel IS NOT "None" AND NOT Request.AppSettings.OutOfStock AND OQuant IS NOT "NA" AND OQuant LTE 0)	
					DisplayIt = 0;
					
				// Otherwise, check if Option specifically turned off
				else if (GetChoices.Display[i] AND GetChoices.ItemDisplay[i])
					DisplayIt = 1;
				else
					DisplayIt = 0;
					
				// If choice turned on and in stock, output to the select box
				if (DisplayIt) {
					ChoicePrice = GetChoices.Price[i];
					ChoiceName = GetChoices.ChoiceName[i];
					
					// Append Price if selected 
					if (AddPrice IS "AddPrice" AND ChoicePrice GT 0) 
						OptDisplay = ChoiceName & ": +" & LSCurrencyFormat(ChoicePrice);
					else if (AddPrice IS "AddPrice" AND ChoicePrice LT 0)
						OptDisplay = ChoiceName & ": -" & LSCurrencyFormat(ChoicePrice);
					else if (AddPrice IS "Total" AND Session.Wholesaler is NOT 0 AND qry_Get_Products.Wholesale IS NOT 0)
						OptDisplay = ChoiceName & ": " & 
						 LSCurrencyFormat(qry_Get_Products.Wholesale[qry_Get_Products.currentrow] + ChoicePrice);
					else if (AddPrice IS "Total")
						OptDisplay = ChoiceName & ": " & 
						 LSCurrencyFormat(qry_Get_Products.Base_Price[qry_Get_Products.currentrow] + ChoicePrice);
					else
						OptDisplay = ChoiceName;
						
					WriteOutput('<option value="' & GetChoices.Choice_ID[i] & '">');
					WriteOutput(OptDisplay & '</option>');
				
				}				
			
			// end choices loop 
			}
		
			WriteOutput('</select>');

			if (option_orientation IS "horizontal")
				WriteOutput('</td>');			
			
			// end option display 
			}
				
		if (option_orientation IS "vertical")
			WriteOutput('</td></tr>');
		
	</cfscript>
	<!--- end product option loop  --->
</cfloop>
		
