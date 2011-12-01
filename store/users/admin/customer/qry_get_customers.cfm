
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Retrieves the list of Customers for the admin. Called by the fuseaction users.admin&customer=list --->

<!--- initialize parameters --->
<cfloop index="namedex" list="uid,custname,company,city,state,zip,country,phone,email,lastused,location,order,un">
	<cfparam name="attributes.#namedex#" default="">
</cfloop>

<!--- Use to show recent activity --->
<cfparam name="attributes.Show" default="recent">

<cfquery name="qry_get_Customers" datasource="#Request.ds#" username="#Request.user#" password="#Request.pass#" >
			SELECT C.*, U.Customer_ID AS billto, U.ShipTo, U.Username AS un
			FROM #Request.DB_Prefix#Customers C 
			LEFT JOIN #Request.DB_Prefix#Users U ON C.User_ID = U.User_ID
			WHERE 1 = 1
			<cfif attributes.show is "recent">
			AND C.LastUsed >= #DateAdd("ww", -1, Now())#
			</cfif>
			<cfif trim(attributes.uid) is not "">
				AND C.User_ID = #attributes.uid#
				</cfif>		
			<cfif trim(attributes.un) is not "">
				AND U.Username Like '%#attributes.un#%'
				</cfif>		
			<cfif trim(attributes.custname) is not "">
				AND (LastName Like '%#attributes.custname#%'
				OR FirstName Like '%#attributes.custname#%')
				</cfif>
			<cfif trim(attributes.company) is not "">
				AND Company Like '%#attributes.company#%'
				</cfif>
			<cfif trim(attributes.location) is not "">
				AND (Address1 Like '%#attributes.location#%' 
				OR Address2 Like '%#attributes.location#%' 
				OR City Like '%#attributes.location#%' 
				OR County Like '%#attributes.location#%'
				OR State Like '%#attributes.location#%'
				OR State2 Like '%#attributes.location#%'
				OR Zip Like '%#attributes.location#%'
				OR Country Like '%#attributes.location#%')
				</cfif>
			<cfif trim(attributes.phone) is not "">
				AND Phone Like '%#attributes.phone#%'
				</cfif>
			<cfif trim(attributes.email) is not "">
				AND C.Email Like '%#attributes.email#%'
				</cfif>
			<cfif trim(attributes.lastused) is not "" AND isDate(attributes.lastused)>
				AND C.LastUsed > #createODBCdate(attributes.lastused)#
				</cfif>
			<cfif trim(attributes.order) is not "">
				ORDER BY #attributes.order#
			<cfelse>
				ORDER BY C.Customer_ID DESC
			</cfif>
		</cfquery>
		
