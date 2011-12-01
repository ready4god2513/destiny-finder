
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Query for emails --->

<!--- by both user and order --->
<cfparam name="attributes.verified" default="">
<cfparam name="attributes.subscribe" default="">
<cfparam name="attributes.GID" default="">
<cfparam name="attributes.wholesale" default="">
<cfparam name="attributes.affiliate" default="">

<!--- by user --->
<cfparam name="attributes.un" default="">
<cfparam name="attributes.uid" default="">
<cfparam name="attributes.customer_ID" default="0">
<cfparam name="attributes.acct" default="">
<cfparam name="attributes.lastLogin" default="">
<cfparam name="attributes.lastLogin_is" default="">
<cfparam name="attributes.created" default="">
<cfparam name="attributes.created_is" default="">
<cfparam name="attributes.member" default="0">

<!--- by order --->
<cfparam name="attributes.product_ID" default="">
<cfparam name="attributes.SKU" default="">
<cfparam name="attributes.dateOrdered" default="">
<cfparam name="attributes.dateFilled" default="">
<cfparam name="attributes.dateOrdered_is" default="">
<cfparam name="attributes.dateFilled_is" default="">


<!--- Run query if submitted --->
<cfif attributes.customer_id>

	<cfquery name="qry_GetEmails" datasource="#Request.DS#" 
	username="#Request.user#" password="#Request.pass#">
	SELECT Distinct C.Email  
	FROM #Request.DB_Prefix#Customers C 
	LEFT JOIN #Request.DB_Prefix#Users U ON C.User_ID = U.User_ID
	WHERE C.Email <> '' 
	AND C.Customer_ID = #attributes.customer_id#
	</cfquery>
	
<cfelseif len(attributes.un) OR len(attributes.uid) OR attributes.email is "write" OR isdefined("submit")>

	<cfif len(attributes.product_ID) or len(attributes.SKU) or 
	len(attributes.dateOrdered) or len(attributes.dateFilled)>
		<cfset OrderSearch = 1>
	<cfelse>
		<cfset OrderSearch = 0>
	</cfif>


<cfquery name="qry_GetEmails" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	SELECT DISTINCT Email,
	<cfif attributes.member is 1>M.Start, M.Expire,</cfif>
	 U.Username, U.Password, U.EmailLock, U.LastLogin, U.Created			
	FROM
		<cfif OrderSearch>
			((#Request.DB_Prefix#Order_Items O 
				INNER JOIN #Request.DB_Prefix#Order_No N ON O.Order_No = N.Order_No)
 			INNER JOIN #Request.DB_Prefix#Users U ON N.User_ID = U.User_ID)
		<cfelse>
		   	#Request.DB_Prefix#Users U 
		</cfif>
		<cfif attributes.member is 1>
			INNER JOIN #Request.DB_Prefix#Memberships M ON M.User_ID = U.User_ID 
		</cfif>	
		<cfif len(attributes.acct)>
			LEFT JOIN #Request.DB_Prefix#Account A ON A.User_ID = U.User_ID
		</cfif>

	WHERE		
		U.EmailIsBad = 0
		<cfif len(attributes.un)>
			and U.Username = '#attributes.un#'
		</cfif>
		<cfif len(attributes.uid)>
			and U.User_ID = #attributes.uid#
		</cfif>
		<cfif len(attributes.verified)>
			AND U.EmailLock <cfif attributes.verified is 1>= 'verified'<cfelse><> 'verified'
			AND U.EmailLock <> ''</cfif>
		</cfif>		

		<cfif len(attributes.subscribe)>
			AND U.Subscribe = #attributes.subscribe#
		</cfif>
		<cfif len(attributes.GID)>
			AND U.Group_ID = #attributes.GID#
		</cfif>
		<cfif len(attributes.acct)>
			AND A.Account_ID <cfif attributes.acct is 1>IS NOT NULL<cfelse>IS NULL</cfif>
		</cfif>
		<cfif len(attributes.affiliate)>
			AND U.Affiliate_ID <cfif attributes.affiliate is 1><><cfelse>=</cfif> 0
		</cfif>
		<!---
		<cfif len(attributes.affiliate) AND  fullsearch>
			AND N.Affiliate <cfif attributes.affiliate is 1><><cfelse>=</cfif> 0
		</cfif>--->
		<cfif len(attributes.wholesale)>
			and U.Wholesale = #attributes.wholesale#
		</cfif>
		<cfif len(attributes.lastLogin) AND isDate(attributes.lastLogin)>
			AND U.LastLogin <cfif attributes.lastLogin_is is "after"> > <cfelseif attributes.lastLogin_is is "before"> < <cfelse> = </cfif> #createODBCdate(attributes.lastLogin)#
		</cfif>
		<cfif len(attributes.created) AND isDate(attributes.created)>
			AND U.Created <cfif attributes.created_is is "after"> > <cfelseif attributes.created_is is "before"> < <cfelse> = </cfif> #createODBCdate(attributes.created)#
		</cfif>
		<cfif attributes.member is 1>
			AND (M.Start <= #createODBCdate(Now())# OR M.Start is null)
			AND (M.Expire >= #createODBCdate(Now())# OR M.Expire is null)
			and (M.Suspend_Begin_Date IS NULL
			OR	M.Suspend_Begin_Date >= #createODBCdate(Now())#)
		</cfif>
		<cfif len(attributes.product_ID)>
			AND O.Product_ID = #Val(attributes.product_ID)#
		</cfif>
		<cfif len(attributes.SKU)>
			AND O.SKU = '#attributes.SKU#'
		</cfif>
		<cfif len(attributes.dateOrdered) AND isDate(attributes.dateOrdered)>
			AND N.DateOrdered <cfif attributes.dateOrdered_is is "after"> > <cfelseif attributes.dateOrdered_is is "before"> < <cfelse> = </cfif> #createODBCdate(attributes.dateOrdered)#
		</cfif>
		<cfif len(attributes.dateFilled) AND isDate(attributes.dateFilled)>
			AND N.DateFilled <cfif attributes.dateFilled_is is "after"> > <cfelseif attributes.dateFilled_is is "before"> < <cfelse> = </cfif>  #createODBCdate(attributes.dateFilled)#
		</cfif>
</cfquery>
	


	
</cfif>


