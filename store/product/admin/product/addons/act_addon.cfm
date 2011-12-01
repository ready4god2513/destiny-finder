
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Performs the functions for a product addon: add, edit, delete. Called by product.admin&addon=act|delete --->

<cfparam name="attributes.cid" default="">
<cfparam name="attributes.std_id" default="0">


<!---- prepare variables ------>
<cfif mode is not "d">

	<cfif NOT isNumeric(attributes.Priority) OR attributes.Priority IS 0>
		<cfset attributes.Priority = 9999>
	</cfif>

	<cfif NOT attributes.std_ID><!---- for custom Addon ---->
	
		<!--- Set price and weight --->
		<cfscript>
		Price = attributes.Price;
		Price = iif(isNumeric(Price), trim(Price), 0);
		
		Weight = attributes.Weight;
		Weight = iif(isNumeric(Weight), trim(Weight), 0);
		</cfscript>

	</cfif>
	
</cfif>


<cfswitch expression="#mode#">
	<cfcase value="i">

		<cfif attributes.Std_ID>
		
			<cfquery name="InsertAddon" datasource="#Request.DS#" 
			username="#Request.user#" password="#Request.pass#">
			INSERT INTO #Request.DB_Prefix#ProdAddons
				(Product_ID, Standard_ID, Prompt, AddonDesc, AddonType, Price, Weight,  
				Display, Priority, ProdMult, Required)
			VALUES
				(#attributes.Product_ID#, #attributes.Std_ID#, 
				NULL, NULL, NULL, NULL, NULL,  #attributes.Display#, #attributes.Priority#, 0, 0)
			</cfquery>
	
		<cfelse><!---- custom Addon ---->
				
				<cfquery name="InsertAddon" datasource="#Request.DS#" 
				username="#Request.user#" password="#Request.pass#">
				INSERT INTO #Request.DB_Prefix#ProdAddons
					(Product_ID, Standard_ID, Prompt, AddonDesc, AddonType, Price, Weight,  
					Display, Priority, ProdMult, Required)
				VALUES
					(#attributes.Product_ID#, 0, '#Trim(attributes.Prompt)#', 
					'#Trim(attributes.AddonDesc)#',	'#attributes.AddonType#',
					#Price#, #Weight#, #attributes.Display#, #attributes.Priority#, #attributes.ProdMult#, #attributes.Required#)
				</cfquery>
	
		</cfif><!---- custom Addon ---->
		
	</cfcase>			
			
			
	<cfcase value="u">
			
		<cfif attributes.Std_ID>
			
			<cfquery name="UpdateAddon" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
			UPDATE #Request.DB_Prefix#ProdAddons
			SET Standard_ID = #attributes.Std_ID#, 
			Display = #attributes.Display#,
			Priority = #attributes.Priority#
			WHERE Addon_ID = #attributes.Addon_ID#
			AND Product_ID = #attributes.Product_ID#
			</cfquery>	
								
		<cfelse><!---- custom option ---->
		
			<cfquery name="UpdateAddon" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
			UPDATE #Request.DB_Prefix#ProdAddons
			SET 
				Prompt = '#Trim(attributes.Prompt)#',
				AddonDesc = '#Trim(attributes.AddonDesc)#',
				AddonType = '#attributes.AddonType#',
				Price = #Price#,
				Weight = #Weight#,
				Display = #attributes.Display#,
				Priority = #attributes.Priority#,
				ProdMult = #attributes.ProdMult#,
				Required = #attributes.Required#
			WHERE Addon_ID = #attributes.Addon_ID#
			AND Product_ID = #attributes.Product_ID#
			</cfquery>
			
		</cfif><!---- custom Addon check---->
		
	</cfcase>
		
	
	
	<cfcase value="d">

		<cfquery name="DeleteAddon" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
		DELETE FROM #Request.DB_Prefix#ProdAddons
			WHERE Addon_ID = #attributes.Addon_ID#
			AND Product_ID = #attributes.Product_ID#
			</cfquery>
			
	</cfcase>	

</cfswitch>	

<cfmodule template="../../../../customtags/format_admin_form.cfm"
	box_title="Product Addons"
	width="400"
	required_fields = "0"
	>

<cfoutput>			
	<tr>
	<form action="#self#?fuseaction=Product.admin&do=addons&product_id=#attributes.product_id#<cfif attributes.cid is not "">&cid=#attributes.cid#</cfif>#request.token2#" method="post">
	<td align="center" class="formtitle">
		<br/>
		Addon
		<cfif mode is "d">
			Deleted
			<cfelse>				
				<cfif mode is "i">Added<cfelse>Updated</cfif>
			</cfif>	
			<br/><br/>
			<input class="formbutton" type="submit" value="Back to Addons"/>
			<br/><br/>
					
	</td></form></tr>
</cfoutput>
</cfmodule> 
