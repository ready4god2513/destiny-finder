
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Performs the admin actions for page templates: add, update, delete. Called by home.admin&catcore=act --->

<cfparam name="attributes.c_products" default="0">
<cfparam name="attributes.c_features" default="0">
<cfparam name="attributes.c_category" default="0">
<cfparam name="attributes.c_page" default="0">

<cfif isdefined("attributes.template_type")>
	<cfloop index="i" list="#attributes.template_type#">
		<cfset "attributes.c_#i#" = 1>
	</cfloop>
</cfif>


<cfswitch expression="#mode#">

	<cfcase value="i">

		<cftransaction isolation="SERIALIZABLE">

			<cfquery name="getnum" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
			SELECT MAX(CatCore_ID) AS maxnum FROM #Request.DB_Prefix#CatCore
			</cfquery>
			
			<cfquery name="Addcatcore" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
			INSERT INTO #Request.DB_Prefix#CatCore 
			(CatCore_ID, Catcore_Name, PassParams, Template, Products, Features, Category, Page)
			VALUES
			(#iif(isNumeric(getnum.maxnum), getnum.maxnum+1, 1)#,
			'#Attributes.catcore_Name#',
			'#Attributes.passparams#',
			'#Attributes.template#',
			 #attributes.c_products#,
			 #attributes.c_features#,
			 #attributes.c_category#,
			 #attributes.c_page#
			 )
			</cfquery>	
			
		</cftransaction>		

	</cfcase>
			
	<cfcase value="u">
	
		<cfif submit is "delete">
		
<!--- Confirm that the palette is not being used
			in any Features, Categories, Products or Pages --->	
			<cfset attributes.error_message = "">	
				
				<cfquery name="check_categories"  datasource="#Request.ds#" 
				username="#Request.user#" password="#Request.pass#">
				SELECT Category_ID FROM #Request.DB_Prefix#Categories
				WHERE CatCore_ID = #CatCore_ID#
				</cfquery>
				
				<cfif check_categories.recordcount gt 0>
					<cfset attributes.error_message = attributes.error_message &  "<br/>Template used in Category #valuelist(check_categories.Category_ID)#. Please delete or edit them first.">
				</cfif>

				<cfquery name="check_pages"  datasource="#Request.ds#" 
				username="#Request.user#" password="#Request.pass#">
				SELECT Page_ID FROM #Request.DB_Prefix#Pages
				WHERE CatCore_ID = #CatCore_ID#
				</cfquery>
				
				<cfif check_pages.recordcount gt 0>
					<cfset attributes.error_message = attributes.error_message &  "<br/>Template used in Page(s) #valuelist(check_pages.page_ID)#. Please delete or edit them first.">
				</cfif>		
						
				
			<cfif NOT len(attributes.error_message)>
			
				<cfquery name="deleteCatCore" dbtype="ODBC" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
				DELETE FROM #Request.DB_Prefix#CatCore 
				WHERE CatCore_ID = #CatCore_ID#
				</cfquery>
			
			<cfelse>
			
				<cfset attributes.error_message = "This Category Template could not be deleted for the following reasons:<br/>" &  attributes.error_message >
			
			</cfif>		
					
				
		<cfelse>
			<cfquery name="Addcatcore" datasource="#Request.DS#" 
			username="#Request.user#" password="#Request.pass#">
			UPDATE #Request.DB_Prefix#CatCore 
			SET Catcore_Name = '#Attributes.catcore_Name#',
			PassParams = '#Attributes.passparams#',
			Template = '#Attributes.template#',
			Products = #attributes.c_products#,
			Features = #attributes.c_features#,
			Category = #attributes.c_category#,
			Page = #attributes.c_page# 
			WHERE CatCore_ID = #Attributes.CatCore_ID#
			</cfquery>	

		</cfif>
	</cfcase>

</cfswitch>
			


