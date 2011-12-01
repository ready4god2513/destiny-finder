
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Performs the admin actions for color palettes: add, update, delete. Called by home.admin&colors=act --->


<cfswitch expression="#mode#">
	<cfcase value="i">
		
		<cfquery name="Addcolors" datasource="#Request.DS#" 
		username="#Request.user#" password="#Request.pass#">
		INSERT INTO #Request.DB_Prefix#Colors
		(Palette_Name, LayoutFile, Bgcolor, Bgimage, MainTitle, MainText, MainLink, MainVLink, 
		BoxHBgcolor, BoxHText, BoxTBgcolor, BoxTText, InputHBgcolor, InputHText, InputTBgcolor, InputTText, 
		OutputHBgcolor, OutputHText, OutputTBgcolor, OutputTText, OutputTAltcolor, LineColor, 
		HotImage, SaleImage, NewImage, MainLineImage, MinorLineImage, FormReq, FormReqOB, PassParam)
		VALUES
			('#Attributes.palette_name#',
			'#Attributes.layoutfile#',
			'#Attributes.Bgcolor#',
			'#Attributes.Bgimage#',
			'#Attributes.MainTitle#',
			'#Attributes.MainText#',
			'#Attributes.MainLink#',
			'#Attributes.MainVLink#',
			'#Attributes.BoxHBgcolor#',
			'#Attributes.BoxHText#',
			'#Attributes.BoxTBgcolor#',
			'#Attributes.BoxTText#',
			'#Attributes.InputHBgcolor#',
			'#Attributes.InputHText#',
			'#Attributes.InputTBgcolor#',
			'#Attributes.InputTText#',
			'#Attributes.OutputHBgcolor#',
			'#Attributes.OutputHText#',
			'#Attributes.OutputTBgcolor#',
			'#Attributes.OutputTText#',
			'#Attributes.OutputTAltcolor#',
			'#Attributes.linecolor#',
			'#Attributes.hotImage#',
			'#Attributes.saleImage#',
			'#Attributes.newImage#',
			'#Attributes.mainlineImage#',
			'#Attributes.minorLineImage#',
			'#Attributes.formreq#',
			'#Attributes.formreqOB#',
			'#Attributes.PassParam#'
			)
			</cfquery>	
		
	</cfcase>
			
	<cfcase value="u">
	
		<cfif submit is "Delete">
			
			<!--- Confirm that the palette is not being used
			in any Features, Categories, Products or Pages --->	
			<cfset attributes.error_message = "">	
				
				<cfquery name="check_categories"  datasource="#Request.ds#" 
				username="#Request.user#" password="#Request.pass#">
				SELECT Category_ID FROM #Request.DB_Prefix#Categories
				WHERE Color_ID = #attributes.color_ID#
				</cfquery>
				
				<cfif check_categories.recordcount gt 0>
					<cfset attributes.error_message = attributes.error_message &  "<br/>Palette used in Category #valuelist(check_categories.Category_ID)#. Please edit them first.">
				</cfif>

				<cfquery name="check_pages"  datasource="#Request.ds#" 
				username="#Request.user#" password="#Request.pass#">
				SELECT Page_ID FROM #Request.DB_Prefix#Pages
				WHERE Color_ID = #attributes.color_ID#
				</cfquery>
				
				<cfif check_pages.recordcount gt 0>
					<cfset attributes.error_message = attributes.error_message &  "<br/>Palette used in Page(s) #valuelist(check_pages.page_ID)#">
				</cfif>		
								
								
				<cfquery name="check_products"  datasource="#Request.ds#" 
				username="#Request.user#" password="#Request.pass#">
				SELECT Product_ID FROM #Request.DB_Prefix#Products
				WHERE Color_ID = #attributes.color_ID#
				</cfquery>
				
				<cfif check_products.recordcount gt 0>
					<cfset attributes.error_message = attributes.error_message &  "<br/>Palette used in Product(s) #valuelist(check_products.product_ID)#. Please edit them first.">
				</cfif>				
				
								
				<cfquery name="check_features"  datasource="#Request.ds#" 
				username="#Request.user#" password="#Request.pass#">
				SELECT Feature_ID FROM #Request.DB_Prefix#Features
				WHERE Color_ID = #attributes.color_ID#
				</cfquery>
				
				<cfif check_features.recordcount gt 0>
					<cfset attributes.error_message = attributes.error_message &  "<br/>Palette used in Feature(s) #valuelist(check_features.feature_ID)#. Please edit them first.">
				</cfif>
			
				
			<cfif NOT len(attributes.error_message)>
			
				<cfquery name="delete_colors"  datasource="#Request.ds#" 
				username="#Request.user#" password="#Request.pass#">
				DELETE FROM #Request.DB_Prefix#Colors WHERE
				Color_ID = #attributes.color_ID#
				</cfquery>
			
			<cfelse>
			
				<cfset attributes.error_message = "This Palette could not be deleted for the following reasons:<br/>" & attributes.error_message >
			
			</cfif>	
			
		<cfelse>
				
			<cfquery name="UpdateColors" datasource="#Request.DS#" username="#Request.user#" 
			password="#Request.pass#">
			UPDATE #Request.DB_Prefix#Colors
			SET 
			Palette_Name = '#Attributes.palette_name#',
			LayoutFile = '#Attributes.layoutfile#',
			Bgcolor = '#Attributes.Bgcolor#',
			Bgimage = '#Attributes.Bgimage#',
			MainTitle = '#Attributes.MainTitle#',
			MainText = '#Attributes.MainText#',
			MainLink = '#Attributes.MainLink#',
			MainVLink = '#Attributes.MainVLink#',
			BoxHBgcolor = '#Attributes.BoxHBgcolor#',
			BoxHText = '#Attributes.BoxHText#',
			BoxTBgcolor = '#Attributes.BoxTBgcolor#',
			BoxTText = '#Attributes.BoxTText#',
			InputHBgcolor = '#Attributes.InputHBgcolor#',
			InputHText = '#Attributes.InputHText#',
			InputTBgcolor = '#Attributes.InputTBgcolor#',
			InputTText = '#Attributes.InputTText#',
			OutputHBgcolor = '#Attributes.OutputHBgcolor#',
			OutputHText = '#Attributes.OutputHText#',
			OutputTBgcolor = '#Attributes.OutputTBgcolor#',
			OutputTText = '#Attributes.OutputTText#',
			OutputTAltcolor = '#Attributes.OutputTAltcolor#',
			LineColor = '#Attributes.linecolor#',
			HotImage = '#Attributes.hotImage#',
			MainLineImage = '#Attributes.mainlineimage#',
			MinorLineImage = '#Attributes.minorlineimage#',
			NewImage = '#Attributes.newimage#',
			SaleImage = '#Attributes.saleimage#',
			FormReq = '#Attributes.formreq#',
			FormReqOB = '#Attributes.formreqOB#',
			PassParam = '#Attributes.PassParam#'
			WHERE Color_ID = #Attributes.color_ID#
			</cfquery>

			<!--- Get New Settings --->
			<cfset Request.Cache = CreateTimeSpan(0, 0, 0, 0)>

			<cfinclude template="../../queries/qry_getsettings.cfm">

			<cfinclude template="../../queries/qry_getcolors.cfm">
			
			<!---- DOES NOT UPDATE color DIRECTORY OR FILES ---------->
		</cfif>

	</cfcase>
	
</cfswitch>
			
	

		
