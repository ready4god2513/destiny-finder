<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!---  This page is called by access.admin&membership=RecurringReport and retrieves list of memberships that will recur sorted by date.--->

<cfquery name="Get_Memberships"  datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
		SELECT M.*, U.UserName, U.Email, U.CardisValid, U.CardExpire, U.Disable, P.Name AS ProductName, P.Base_Price AS Price, RP.Name AS RecurProductName, RP.Base_Price AS RecurPrice
		FROM ((#Request.DB_Prefix#Memberships M 
				INNER JOIN #Request.DB_Prefix#Users U ON M.User_ID = U.User_ID) 
				LEFT JOIN #Request.DB_Prefix#Products P ON M.Product_ID = P.Product_ID)
				LEFT JOIN #Request.DB_Prefix#Products RP ON M.Recur_Product_ID = RP.Product_ID
		WHERE  M.Recur = 1
		ORDER BY M.Expire ASC, P.Name
</cfquery>


