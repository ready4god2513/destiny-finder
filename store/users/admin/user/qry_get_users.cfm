
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Retrieves the list of Users for the admin. Called by the fuseaction users.admin&user=list|listform --->

<!--- initialize parameters --->
<cfloop index="namedex" list="uid,un,email,email_bad,subscribe,affiliate,cid,shipto,gid,account_id,birthdate,CardisValid,CardNumber,currentbalance">
	<cfparam name="attributes.#namedex#" default="">
</cfloop>

<cfparam name="attributes.Show" default="recent">
		
		
<cfquery name="qry_get_users"   datasource="#Request.ds#"	 username="#Request.user#"  password="#Request.pass#" >
 SELECT U.*, G.Name AS groupname, C.FirstName, C.LastName, 
    (SELECT COUNT(Account_ID) FROM #Request.DB_Prefix#Account Acc 
		WHERE Acc.User_ID = U.User_ID) as Accounts
 FROM ((#Request.DB_Prefix#Users U 
 			LEFT JOIN #Request.DB_Prefix#Groups G ON U.Group_ID = G.Group_ID)  
    	LEFT JOIN #Request.DB_Prefix#Customers C ON U.Customer_ID = C.Customer_ID)
    <cfif len(attributes.account_ID)>
    LEFT JOIN #Request.DB_Prefix#Account A ON A.User_ID = U.User_ID
    </cfif>
 WHERE 1 = 1
		<cfif attributes.show is "recent">
			AND U.LastLogin >= #DateAdd("ww", -1, Now())#
		</cfif>
		<cfif trim(attributes.uid) is not "">
			AND U.User_ID = #attributes.uid#
			</cfif>			
		<cfif trim(attributes.un) is not "">
			AND U.Username Like '%#attributes.un#%'
			</cfif>
		<cfif trim(attributes.email) is not "">
			AND U.Email Like '%#attributes.email#%'
			</cfif>
		<cfif trim(attributes.affiliate) is 0>
			AND U.Affiliate_ID = 0
		<cfelseif trim(attributes.affiliate) is 1>
			AND U.Affiliate_ID <> 0
		</cfif>
		<cfif trim(attributes.email_bad) is "bad">
			AND U.EmailIsBad = 1	</cfif>
		<cfif trim(attributes.email_bad) is "good">
			AND U.EmailIsBad = 0 
			AND (U.EmailLock = 'verified'
			OR U.EmailLock = '')</cfif>
		<cfif trim(attributes.email_bad) is "lock"> 
			AND U.EmailLock <> 'verified'</cfif>
		<cfif trim(attributes.subscribe) is not "">
			AND U.Subscribe = #attributes.subscribe#
			</cfif>
		<cfif trim(attributes.cid) is not "">
			AND (U.Customer_ID = #attributes.cid#
			OR U.ShipTo = #attributes.cid#)
			</cfif>
		<cfif trim(attributes.gid) is not "">
			AND U.Group_ID = #attributes.gid#
			</cfif>
		<cfif trim(attributes.account_id) is not "">
			AND A.Account_ID = #attributes.account_id#
			</cfif>
		<cfif trim(attributes.birthdate) is not "">
			AND U.Birthdate > #createODBCdate(attributes.birthdate)#
			</cfif>
		<cfif trim(attributes.CardisValid) is not "">
			AND U.CardisValid = #attributes.CardisValid#
			</cfif>
		<cfif trim(attributes.cardnumber) is not "">
			AND U.CardNumber <> ''
			</cfif>
		<cfif trim(attributes.currentbalance) is not "">
			AND U.CurrentBalance > #attributes.currentbalance#
			</cfif>
		ORDER BY U.User_ID DESC
	</cfquery>


