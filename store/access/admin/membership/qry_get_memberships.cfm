
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Retrieves the list of memberships for the admin. Called by the fuseaction access.admin&membership=list --->

<!--- Defaults for the filters --->
<cfparam name="attributes.IsExpired" default="ALL">
<cfparam name="attributes.IsUsed" default="ALL">
<cfparam name="attributes.Valid" default="">
<cfparam name="attributes.User" default="">
<cfparam name="attributes.UID" default="">
<cfparam name="attributes.membership_Type" default="">
<cfparam name="attributes.prod_type" default="">
<cfparam name="attributes.Product" default="">
<cfparam name="attributes.AccessKey" default="">

<cfparam name="attributes.Show" default="recent">

<cfquery name="qry_get_Memberships"  datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
		SELECT M.*, U.Username, U.CardisValid, U.CardExpire, U.Disable, P.Name AS product
		FROM ((#Request.DB_Prefix#Memberships M 
				LEFT JOIN #Request.DB_Prefix#Users U ON M.User_ID = U.User_ID) 
				LEFT JOIN #Request.DB_Prefix#Products P ON M.Product_ID = P.Product_ID)

		WHERE 1=1
		<cfif attributes.show is "recent">
			AND M.Date_Ordered >= #DateAdd("ww", -1, Now())#
		</cfif>
		<cfif attributes.IsExpired is "current">
			AND (M.Start <= #createODBCdate(now())# OR M.Start is null)
		<cfelseif attributes.IsExpired is "future">
			AND M.Start > #createODBCdate(now())#
		</cfif>		
		<cfif attributes.IsExpired is "current">
			AND (M.Expire >= #createODBCdate(now())# OR M.Expire is null)
			and (M.Suspend_Begin_Date IS NULL
				OR	M.Suspend_Begin_Date >= #createODBCdate(now())#)
		<cfelseif attributes.IsExpired is "expired">
			AND (M.Expire < #createODBCdate(now())#
				OR M.Suspend_Begin_Date < #createODBCdate(now())#)
		<cfelseif attributes.IsExpired is "suspended">
			and M.Suspend_Begin_Date IS NOT NULL
		<cfelseif attributes.IsExpired is "recur">
			and M.Recur = 1
		</cfif>		
		<cfif attributes.IsUsed is "yes">
			AND M.Access_Used >= M.Access_Count
		<cfelseif attributes.IsUsed is "no">
			AND M.Access_Used < M.Access_Count
		</cfif>	
		<cfif attributes.valid is "yes">
			AND M.Valid = 1
		<cfelseif attributes.valid is "no">
			AND M.Valid = 0
		</cfif>	
		<cfif attributes.User is not "">
			AND (U.Username like '%#User#%'
				 OR U.Email like '%#User#%')
		</cfif>	
		<cfif attributes.UID is not "">
			AND	M.User_ID = #attributes.UID#
		</cfif>	
		<cfif attributes.product is not "">
			AND P.Name like '%#product#%'
		</cfif>		
		<cfif attributes.AccessKey is not "">
			AND (M.AccessKey_ID LIKE '#attributes.AccessKey#'
			OR M.AccessKey_ID LIKE '#attributes.AccessKey#,%'
			OR M.AccessKey_ID LIKE '%,#attributes.AccessKey#'
			OR M.AccessKey_ID LIKE '%,#attributes.AccessKey#,%')
		</cfif>	
		<cfif attributes.prod_type is not "">
			AND P.Prod_Type = '#attributes.prod_type#'
		</cfif>	
		<cfif attributes.membership_type is not "">
			AND M.Membership_Type = '#attributes.membership_type#'
		</cfif>	
		
		<cfif attributes.show is "all">
		ORDER BY M.Membership_ID DESC
		<cfelseif attributes.IsExpired is "recur">
		ORDER BY M.Expire DESC
		<cfelse>
		ORDER BY M.Valid DESC, M.Start DESC, M.Product_ID
		</cfif>
</cfquery>

