
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Performs actions on discounts: add, edit and delete. Verifies the discount is not in use before deleting. Called by product.admin&discount=act --->

<cfif len(Trim(attributes.Amount1))>
	<cfset attributes.Amount = attributes.Amount1> 
	<cfset attributes.Type2 = 1>
<cfelse>
	<cfset attributes.Amount = Evaluate(attributes.Amount2/100)>
	<cfset attributes.Type2 = 2>
</cfif>

<cfif NOT len(Trim(attributes.MaxOrder))>
	<cfset attributes.MaxOrder = 999999999>
<cfelse>
	<cfset attributes.MaxOrder = attributes.MaxOrder>
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
			INSERT INTO #Request.DB_Prefix#Discounts
				(Type1, Type2, Type3, Type4, Type5, Coup_Code, OneTime, AccessKey, Name, 
				Display, Amount, MinOrder, MaxOrder, StartDate, EndDate)
			VALUES(
				 #attributes.Type1#,
				 #attributes.Type2#,
				 #attributes.Type3#,
				 #attributes.Type4#,
				 #attributes.Type5#,
				 <cfif len(Trim(attributes.Coup_Code))>'#Trim(attributes.Coup_Code)#',<cfelse>NULL,</cfif>
				 #attributes.OneTime#,
				 #attributes.AccessKey#,
				'#Trim(attributes.Name)#',
				'#Attributes.Display#',
				 #Attributes.Amount#,
				 #attributes.MinOrder#,
				 #Attributes.MaxOrder#,
				 <cfif isDate(attributes.StartDate)>#CreateODBCDate(attributes.StartDate)#,<cfelse>NULL,</cfif>
				 <cfif isDate(attributes.EndDate)> #CreateODBCDate(attributes.EndDate)#<cfelse>NULL</cfif>)
			</cfquery>				
			
			<cfquery name="Get_id" datasource="#Request.ds#" username="#Request.user#"  password="#Request.pass#">
				SELECT MAX(Discount_ID) AS maxid 
				FROM #Request.DB_Prefix#Discounts
				</cfquery>
		
			<cfset attributes.Discount_ID = get_id.maxid>
			
		</cftransaction>
			
		<cfif attributes.Type3 IS 0>
			<cfset attributes.XFA_success="fuseaction=product.admin&discount=products&discount_id=#attributes.Discount_ID#&cid=0">
		<cfelseif attributes.Type3 IS 1>
			<cfset attributes.XFA_success="fuseaction=product.admin&discount=categories&discount_id=#attributes.Discount_ID#&pid=0">
		</cfif>
			
	</cfcase>			
		
	<cfcase value="u">
		<cfif submit is "Delete">				

			<!--- Delete any assigned products --->
			<cfquery name="DeleteProducts" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
			DELETE FROM #Request.DB_Prefix#Discount_Products
			WHERE Discount_ID = #attributes.Discount_ID#
			</cfquery>

			<!--- Delete any assigned categories --->
			<cfquery name="DeleteCategories" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
			DELETE FROM #Request.DB_Prefix#Discount_Categories
			WHERE Discount_ID = #attributes.Discount_ID#
			</cfquery>
			
			<!--- Delete any assigned user groups --->
			<cfquery name="DeleteGroups" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
			DELETE FROM #Request.DB_Prefix#Discount_Groups
			WHERE Discount_ID = #attributes.Discount_ID#
			</cfquery>

			<!--- Finally, remove the discount --->
			<cfquery name="DeleteDiscount" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
				DELETE FROM #Request.DB_Prefix#Discounts
				WHERE Discount_ID = #attributes.Discount_ID#
			</cfquery>			
							
		<cfelse><!---- EDIT ---->
		
			<cfquery name="UpdDiscount" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
			UPDATE #Request.DB_Prefix#Discounts
			SET Type1 = #attributes.Type1#,
			Type2 = #attributes.Type2#,
			Type4 = #attributes.Type4#,
			Type5 = #attributes.Type5#,
			Coup_Code = <cfif len(Trim(attributes.Coup_Code))>'#Trim(attributes.Coup_Code)#',<cfelse>NULL,</cfif>
			OneTime = #attributes.OneTime#,
			AccessKey = #attributes.AccessKey#,
			Name = '#Trim(attributes.Name)#',
			Display = '#attributes.Display#',
			Amount = #attributes.Amount#,
			MinOrder = #attributes.MinOrder#,
			MaxOrder = #attributes.MaxOrder#,
			StartDate =  <cfif isDate(attributes.StartDate)>#CreateODBCDate(attributes.StartDate)#,<cfelse>NULL,</cfif>
			EndDate =  <cfif isDate(attributes.EndDate)>#CreateODBCDate(attributes.EndDate)#<cfelse>NULL</cfif>
			WHERE Discount_ID = #attributes.Discount_ID#
			</cfquery>

			
			<!---- If discount has been changed to all users, delete any records in the Discount_Groups table ------>
			<cfif attributes.Type5 IS 0>
	
				<cfquery name="DeleteGroups" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
				DELETE FROM #Request.DB_Prefix#Discount_Groups
				WHERE Discount_ID = #attributes.Discount_ID#
				</cfquery>
				
			</cfif><!---- all user discount --->
			
		</cfif><!---- update ---->
	
	</cfcase>

</cfswitch>	


<!----- RESET Discount Application query ---->
<cflock scope="APPLICATION" timeout="15" type="EXCLUSIVE">
	<cfinvoke component="#Request.CFCMapping#.shopping.discounts" method="getallDiscounts"
		returnvariable="Application.GetDiscounts">	
</cflock>	

<!----- RESET Cached group queries ---->
<cfinclude template="act_reset_group_queries.cfm">
	
	

