<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This page is run to check that if a coupon or certificate code is entered, that the code is a valid one. Called by shopping.checkout (step=shipping) and shopping/basket/act_recalc.cfm --->

<cfparam name="codeerror" default="1">
<cfparam name="attributes.Coupon" default="">

<cfset CheckCode = Trim(attributes.Coupon)>

<!--- Check if a code is entered --->
<cfif len(CheckCode)>
	
	<!--- Check for a discount or promotion based on the code --->
	<cfquery name="GetDiscount" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
		SELECT Discount_ID, StartDate, EndDate 
		FROM #Request.DB_Prefix#Discounts
		WHERE Coup_Code = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#CheckCode#">
		<cfif Session.User_ID IS NOT 0>
		AND (OneTime = 0 OR Coup_Code NOT IN 
				(SELECT Disc_Code FROM #Request.DB_Prefix#Order_Items I, #Request.DB_Prefix#Order_No N
				WHERE I.Order_No = N.Order_No AND I.Disc_Code IS NOT NULL
			 	AND I.Disc_Code <> '' 
				AND N.User_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#Session.User_ID#">) )	
		</cfif>
		AND (StartDate IS NULL OR StartDate <= #createODBCdate(now())#)
		AND (EndDate IS NULL OR EndDate >= #createODBCdate(now())#)
	</cfquery>
	
	<cfquery name="GetPromotion" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
		SELECT Promotion_ID, StartDate, EndDate 
		FROM #Request.DB_Prefix#Promotions
		WHERE Coup_Code = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#CheckCode#">
		<cfif Session.User_ID IS NOT 0>
		AND (OneTime = 0 OR Coup_Code NOT IN 
				(SELECT Disc_Code FROM #Request.DB_Prefix#Order_Items I, #Request.DB_Prefix#Order_No N
				WHERE I.Order_No = N.Order_No AND I.Disc_Code IS NOT NULL
			 	AND I.Disc_Code <> '' AND N.User_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#Session.User_ID#"> ) )	
		</cfif>
		AND (StartDate IS NULL OR StartDate <= #createODBCdate(now())#)
		AND (EndDate IS NULL OR EndDate >= #createODBCdate(now())#)
	</cfquery>
	
	<cfif GetDiscount.RecordCount OR GetPromotion.RecordCount>
		<cfset codeerror = 0>
		<!--- Update session --->
		<cfset Session.Coup_Code = CheckCode>
		
	<!--- Check for a certificate if no discount found --->
	<cfelse>
		<!--- Delete any previous coupon that might have been saved --->
		<cfset Session.Coup_Code = "">
		
		<cfset OrderDiscount = 0>
		<cfinclude template="../../basket/act_calc_giftcert.cfm">
		
		<!--- If certificate found, turn off error. --->
		<cfif GApproved>
			<cfset codeerror = 0>
			<!--- Update session --->
			<cfset Session.Gift_Cert = CheckCode>
		</cfif>	
	
	</cfif>
	
<cfelse>
	<!--- No coupon code entered --->
	<cfset codeerror = 0>
	
</cfif>
