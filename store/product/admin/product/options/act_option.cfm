
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Performs the functions for a product option: add, edit, delete. Called by product.admin&option=act|delete --->


<cfparam name="attributes.cid" default="">
<cfparam name="attributes.std_id" default="0">

<!--- New code to make sure there is at least one selection in the option --->

<cfif mode IS NOT "d" AND NOT attributes.Std_ID AND NOT len(attributes.ChoiceName1)>
	
	<cfmodule template="../../../../customtags/format_admin_form.cfm"
		box_title="Product Options"
		width="400"
		required_fields="0"
		>
		
			<tr><td align="center" class="formtitle">
		<br/>
		
	An option must have at least one selection!
	<p>	
	
	<table><cfoutput>
		<tr>
			<td>
			<form action="#self#?fuseaction=Product.admin&do=options&product_id=#attributes.product_id#<cfif attributes.cid is not "">&cid=#attributes.cid#</cfif>#request.token2#" method="post">
			<input class="formbutton" type="submit" value="Back to Options"/>
		</form>		
			</td>

		</tr></cfoutput>
	</table>	
	</cfmodule>

<cfelse>

	<cfswitch expression="#mode#">
		<cfcase value="i">
			
			<cfif NOT isNumeric(attributes.Priority) OR attributes.Priority IS 0>
				<cfset attributes.Priority = 9999>
			</cfif>
	
			<cfif attributes.Std_ID>
	
				<cftransaction isolation="SERIALIZABLE">					
					<cfquery name="InsertOption" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
					INSERT INTO #Request.DB_Prefix#Product_Options
						(Product_ID, Std_ID, Prompt, OptDesc, ShowPrice, Display, Priority, TrackInv, Required)
					VALUES
						(#attributes.Product_ID#, #attributes.Std_ID#, 
						NULL, NULL, NULL, #attributes.Display#, 
						#attributes.Priority#, 0, 1)
					</cfquery>	
					
					<cfquery name="getNewID" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
						SELECT MAX(Option_ID) AS newid 
						FROM #Request.DB_Prefix#Product_Options
					</cfquery>
				
					<cfset attributes.option_id = getNewID.newid>

				</cftransaction>
		
			<cfelse><!---- custom option ---->
					
				<cftransaction isolation="SERIALIZABLE">
					
					<cfquery name="InsertOption" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
					INSERT INTO #Request.DB_Prefix#Product_Options
						(Product_ID, Std_ID, Prompt, OptDesc, ShowPrice, Display, Priority, TrackInv, Required)
					VALUES
						(#attributes.Product_ID#, 0, '#Trim(attributes.Prompt)#', 
						<cfif len(Trim(attributes.OptDesc))>'#Trim(attributes.OptDesc)#',<cfelse>NULL,</cfif>
						'#attributes.ShowPrice#', #attributes.Display#, 
						#attributes.Priority#,
						0, #attributes.Required#)
					</cfquery>	
				
					<cfquery name="getNewID" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
						SELECT MAX(Option_ID) AS newid 
						FROM #Request.DB_Prefix#Product_Options
					</cfquery>
				
					<cfset attributes.option_id = getNewID.newid>
					
				</cftransaction>
				
			</cfif><!---- custom option ---->
			
		</cfcase>		
				
				
		<cfcase value="u">
			
			<cfif NOT isNumeric(attributes.Priority) OR attributes.Priority IS 0>
				<cfset attributes.Priority = 9999>
			</cfif>
			
			<cfif attributes.Std_ID>
				
				<cfquery name="UpdateOption" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
				UPDATE #Request.DB_Prefix#Product_Options
				SET Display = #attributes.Display#,
				Priority = #attributes.Priority#
				WHERE Option_ID = #attributes.Option_ID#
				</cfquery>	
									
			<cfelse><!---- custom option ---->
			
				<cfquery name="UpdateOption" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
				UPDATE #Request.DB_Prefix#Product_Options
				SET Prompt = '#Trim(attributes.Prompt)#',
				OptDesc = <cfif len(Trim(attributes.OptDesc))>'#Trim(attributes.OptDesc)#',<cfelse>NULL,</cfif>
				ShowPrice = '#attributes.ShowPrice#',
				Display = #attributes.Display#,
				Priority = #attributes.Priority#,
				Required = #attributes.Required#
				WHERE Option_ID = #attributes.Option_ID#
				</cfquery>
				
			</cfif><!---- custom option check---->
			
		</cfcase>		
		
		<cfcase value="d">
	
		<!--- Delete option and option choices --->
		<cftransaction isolation="SERIALIZABLE">
			<cfquery name="DeleteOption" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
			DELETE FROM #Request.DB_Prefix#ProdOpt_Choices
				WHERE Option_ID = #attributes.Option_ID#
			</cfquery>
			
			<cfquery name="DeleteOption" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
			DELETE FROM #Request.DB_Prefix#Product_Options
				WHERE Option_ID = #attributes.Option_ID#
			</cfquery>
				
			<!--- Check if this option was using quantities previously --->
			<cfquery name="UpdateProduct" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
			UPDATE #Request.DB_Prefix#Products
			SET OptQuant = 0
			WHERE Product_ID = #attributes.Product_ID#
			AND OptQuant = #attributes.option_ID#
			</cfquery>
			
		</cftransaction>
				
		</cfcase>	
	
	</cfswitch>	
	
	<!--- If not a delete or standard option, run the option choices functions --->
	<cfif mode IS NOT "d" AND NOT attributes.Std_ID>
		
		<!--- Check if this option used for inventory tracking --->
		<cfset TotalStock = 0>
	
		<cfloop index="i" from="1" to="#attributes.num#">
			<cfscript>
				//Process the form fields 
				ChoiceName = attributes['ChoiceName' & i];
				Price = attributes['Price' & i];
				Price = iif(isNumeric(Price), trim(Price), 0);
				
				Weight = attributes['Weight' & i];
				Weight = iif(isNumeric(Weight), trim(Weight), 0);
				
				SortOrder = attributes['SortOrder' & i];
				if (NOT isNumeric(SortOrder) OR SortOrder IS 0)
					SortOrder = 9999;
				
				//Check if SKUs entered and allowed for this option
				if (NOT isDefined("attributes.OtherSKUs"))
					SKU = attributes['SKU' & i];
				else
					SKU = '';
				
				NumInStock = attributes['NumInStock' & i];
				NumInStock = iif(isNumeric(NumInStock), trim(NumInStock), 0);
				
				Display = iif(isDefined("attributes.Display#i#"),1,0);
				Delete = iif(isDefined("attributes.Delete#i#"),1,0);
				
				Choice_ID = iif(isDefined("attributes.Choice_ID#i#"),Evaluate(De("attributes.Choice_ID#i#")),0);

			</cfscript>
			
		<!--- Run delete functions if update and not standard option --->
		<cfif mode IS "u" AND (Delete OR NOT len(Trim(ChoiceName)))>
		<!--- remove this option choice from the product choice lists --->
			<cfquery name="DeleteProdChoice" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
				DELETE FROM #Request.DB_Prefix#ProdOpt_Choices
				WHERE Choice_ID = #Choice_ID#
				AND Option_ID = #attributes.option_ID#
			</cfquery>
			
		<!--- If delete not checked, and there is a choice ID, run update --->
		<cfelseif NOT Delete AND Choice_ID IS NOT 0>
			<cfquery name="UpdOptChoice" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
				UPDATE #Request.DB_Prefix#ProdOpt_Choices
				SET ChoiceName = '#Trim(ChoiceName)#',
				Price = #Price#,
				Weight = #Weight#,
				SKU = '#Trim(SKU)#',
				NumInStock = #NumInStock#,
				SortOrder = #SortOrder#,
				Display = #Display#
				WHERE Option_ID = #attributes.option_ID#
				AND Choice_ID = #Choice_ID#
			</cfquery>
			
			<cfset TotalStock = TotalStock + NumInStock>
			
		<!--- Otherwise, run insert --->
		<cfelseif NOT Delete AND len(Trim(ChoiceName))>
			<cftransaction isolation="SERIALIZABLE">
			<!--- If update, get new ID --->
			<cfif mode IS "u">
				<cfquery name="getNewID" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
				SELECT MAX(Choice_ID) + 1 AS newid FROM #Request.DB_Prefix#ProdOpt_Choices
				WHERE Option_ID = #attributes.Option_ID#
				</cfquery>
				<cfset newID = iif(len(getNewID.newid),getNewID.newid,1)>
			<cfelse>
				<cfset newID = i>
			</cfif>
			
			<cfquery name="InsOptChoice" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
				INSERT INTO #Request.DB_Prefix#ProdOpt_Choices
				(Option_ID, Choice_ID, ChoiceName, Price, Weight, SKU, NumInStock, SortOrder, Display)
				VALUES (
				#attributes.option_id#, #newID#, '#Trim(ChoiceName)#', 
				#Price#, #Weight#, '#Trim(SKU)#', #NumInStock#, 				
				#SortOrder#, #Display# )
			</cfquery>
	
			<cfset TotalStock = TotalStock + NumInStock>
			
			</cftransaction>
		</cfif>
		
		</cfloop>
	
		<!--- Check if inventory was entered or required. If yes, update the product option and product --->
		<cfif (TotalStock IS NOT 0 AND NOT isDefined("attributes.OtherInv")) OR isDefined("attributes.TrackInv")>
			<cfquery name="UpdateOption" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
				UPDATE #Request.DB_Prefix#Product_Options
				SET TrackInv = 1,
				Required = 1
				WHERE Option_ID = #attributes.Option_ID#
			</cfquery>
			
			<cfquery name="UpdateProduct" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
			UPDATE #Request.DB_Prefix#Products
			SET OptQuant = #attributes.option_ID#, 
			NuminStock = #TotalStock#
			WHERE Product_ID = #attributes.Product_ID#
			</cfquery>
			
		<cfelse>
			<!--- Check if this option was using quantities previously --->
			<cfquery name="UpdateProduct" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
			UPDATE #Request.DB_Prefix#Products
			SET OptQuant = 0
			WHERE Product_ID = #attributes.Product_ID#
			AND OptQuant = #attributes.option_ID#
			</cfquery>	
			
			<cfquery name="UpdateOption" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
			UPDATE #Request.DB_Prefix#Product_Options
			SET TrackInv = 0
			WHERE Option_ID = #attributes.Option_ID#
			</cfquery>		
		
		</cfif>
	
	</cfif>
		
		
	
	<!---- If this is a standard ID, proceed to Options form ---->	
	<cfif attributes.Std_ID>
	
		<cflocation url="#self#?fuseaction=product.admin&option=std2&option_id=#attributes.option_id#&product_id=#attributes.product_id#&cid=#attributes.cid##Request.Token2#" addtoken="No">
	
	</cfif>	
		
	

	<cfmodule template="../../../../customtags/format_admin_form.cfm"
		box_title="Product Options"
		width="400"
		required_fields = "0"
		>
		
	<cfoutput>		
		<tr>
		<form action="#self#?fuseaction=Product.admin&do=options&product_id=#attributes.product_id#<cfif attributes.cid is not "">&cid=#attributes.cid#</cfif>#request.token2#" method="post">
			<td align="center" class="formtitle">
			<br/>
			Option
			<cfif mode is "d">
				Deleted
				<cfelse>				
					<cfif mode is "i">Added<cfelse>Updated</cfif>
				</cfif>			
				<br/><br/>
				<input class="formbutton" type="submit" value="Back to Options"/>
				<br/><br/>
		</td>
		</form>	
		</tr>
	</cfoutput>
						
	</cfmodule> 

</cfif>