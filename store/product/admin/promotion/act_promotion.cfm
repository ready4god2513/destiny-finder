
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Performs actions on promotions: add, edit and delete. Called by product.admin&promotion=act --->

<cfif len(Trim(attributes.Amount1))>
	<cfset attributes.Amount = attributes.Amount1> 
	<cfset attributes.Type2 = 1>
<cfelse>
	<cfset attributes.Amount = Evaluate(attributes.Amount2/100)>
	<cfset attributes.Type2 = 2>
</cfif>

<cfif NOT len(Trim(attributes.Display))>
	<cfset attributes.Display = Trim(attributes.Name)>
<cfelse>
	<cfset attributes.Display = Trim(attributes.Display)>
</cfif>
			
<cfswitch expression="#mode#">
	<cfcase value="i">

		<cftransaction isolation="SERIALIZABLE">
		
			<cfquery name="Add_Record" datasource="#Request.ds#" username="#Request.user#"  password="#Request.pass#">
			INSERT INTO #Request.DB_Prefix#Promotions
				(Type1, Type2, Type3, Type4, Coup_Code, OneTime, AccessKey, Name, Display, Amount, 
				QualifyNum, DiscountNum, Multiply, Add_DiscProd, StartDate, EndDate, Disc_Product)
			VALUES(
				 #attributes.Type1#,
				 #attributes.Type2#,
				 #attributes.Type3#,
				 #attributes.Type4#,
				 <cfif len(Trim(attributes.Coup_Code))>'#Trim(attributes.Coup_Code)#',<cfelse>NULL,</cfif>
				 #attributes.OneTime#,
				 #attributes.AccessKey#,
				'#Trim(attributes.Name)#',
				'#Attributes.Display#',
				 #Attributes.Amount#,
				 #attributes.QualifyNum#,
				 #Attributes.DiscountNum#,
				 #Attributes.Multiply#,
				 #Attributes.Add_DiscProd#,
				 <cfif isDate(attributes.StartDate)>#CreateODBCDate(attributes.StartDate)#,<cfelse>NULL,</cfif>
				 <cfif isDate(attributes.EndDate)> #CreateODBCDate(attributes.EndDate)#,<cfelse>NULL,</cfif>
				0)
			</cfquery>				
			
			<cfquery name="Get_id" datasource="#Request.ds#" username="#Request.user#"  password="#Request.pass#">
				SELECT MAX(Promotion_ID) AS maxid 
				FROM #Request.DB_Prefix#Promotions
				</cfquery>
		
			<cfset attributes.Promotion_ID = get_id.maxid>

			<cfif attributes.Type1 IS NOT 4>			
			<cfset attributes.XFA_success= "fuseaction=product.admin&promotion=qual_products&promotion_id=#attributes.promotion_id#">
			<cfelse>
			<cfset attributes.XFA_success= "fuseaction=product.admin&promotion=disc_product&promotion_id=#attributes.promotion_id#">
			</cfif>
			
		</cftransaction>
				
		</cfcase>			
			
		<cfcase value="u">
			<cfif submit is "Delete">				

				<!--- Delete any assigned qualifying products --->
				<cfquery name="DeleteProducts" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
				DELETE FROM #Request.DB_Prefix#Promotion_Qual_Products
				WHERE Promotion_ID = #attributes.Promotion_ID#
				</cfquery>
				
				<!--- Delete any assigned user groups --->
				<cfquery name="DeleteGroups" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
				DELETE FROM #Request.DB_Prefix#Promotion_Groups
				WHERE Promotion_ID = #attributes.Promotion_ID#
				</cfquery>

				<!--- Finally, remove the promotion --->
				<cfquery name="DeletePromotion" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
					DELETE FROM #Request.DB_Prefix#Promotions
					WHERE Promotion_ID = #attributes.Promotion_ID#
				</cfquery>			
								
			<cfelse><!---- EDIT ---->
			
				<cfquery name="UpdPromotion" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
				UPDATE #Request.DB_Prefix#Promotions
				SET Type1 = #attributes.Type1#,
				Type2 = #attributes.Type2#,
				Type4 = #attributes.Type4#,
				Coup_Code = <cfif len(Trim(attributes.Coup_Code))>'#Trim(attributes.Coup_Code)#',<cfelse>NULL,</cfif>
				OneTime = #attributes.OneTime#,
				AccessKey = #attributes.AccessKey#,
				Name = '#Trim(attributes.Name)#',
				Display = '#attributes.Display#',
				Amount = #attributes.Amount#,
				QualifyNum = #attributes.QualifyNum#,
				DiscountNum = #attributes.DiscountNum#,
				Multiply = #Attributes.Multiply#,
				Add_DiscProd = #Attributes.Add_DiscProd#,
				StartDate = <cfif isDate(attributes.StartDate)>#CreateODBCDate(attributes.StartDate)#,<cfelse>NULL,</cfif>
				EndDate = <cfif isDate(attributes.EndDate)>#CreateODBCDate(attributes.EndDate)#<cfelse>NULL</cfif>
				WHERE Promotion_ID = #attributes.Promotion_ID#
				</cfquery>
	
				
				<!---- If promotion has been changed to all users, delete any records in the Promotion_Groups table ------>
				<cfif attributes.Type4 IS 0>
		
					<cfquery name="DeleteGroups" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
					DELETE FROM #Request.DB_Prefix#Promotion_Groups
					WHERE Promotion_ID = #attributes.Promotion_ID#
					</cfquery>
					
				</cfif><!---- all user promotion --->
				
			</cfif><!---- update ---->
		
		</cfcase>

	</cfswitch>	
	
	
	<!----- RESET Promotion Application query ---->
	<cflock scope="APPLICATION" timeout="15" type="EXCLUSIVE">
		<cfinvoke component="#Request.CFCMapping#.shopping.promotions" method="getallPromotions"
			returnvariable="Application.GetPromotions">	
	</cflock>	
		
	<!----- RESET Cached group queries ---->
	<cfinclude template="act_reset_group_queries.cfm">
	

		
