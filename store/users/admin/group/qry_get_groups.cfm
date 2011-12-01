
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Retrieves the list of Groups for the admin. Called by the fuseaction users.admin&group=list --->

<!--- initialize parameters --->
<cfloop index="namedex" list="gid,name,description,wholesale,discounts,promotions">
	<cfparam name="attributes.#namedex#" default="">
</cfloop>

<cfquery name="qry_get_groups" datasource="#Request.ds#" username="#Request.user#" password="#Request.pass#" >
	SELECT * FROM #Request.DB_Prefix#Groups
	WHERE 1 = 1
		<cfif trim(attributes.gid) is not "">
			AND Group_ID = #attributes.gid#
		</cfif>
		<cfif trim(attributes.name) is not "">
			AND Name Like '%#attributes.name#%'
		</cfif>
		<cfif trim(attributes.description) is not "">
			AND Description Like '%#attributes.description#%'
			</cfif>
		<cfif trim(attributes.wholesale) is not "">
			AND Wholesale = #attributes.wholesale#
		</cfif>
		<cfif attributes.discounts IS 1>
			AND Group_ID IN (SELECT DISTINCT Group_ID FROM Discount_Groups)
		<cfelseif attributes.discounts IS 0>
			AND Group_ID NOT IN (SELECT DISTINCT Group_ID FROM Discount_Groups)
		</cfif>
		<cfif attributes.promotions IS 1>
			AND Group_ID IN (SELECT DISTINCT Group_ID FROM Promotion_Groups)
		<cfelseif attributes.promotions IS 0>
			AND Group_ID NOT IN (SELECT DISTINCT Group_ID FROM Promotion_Groups)
		</cfif>
</cfquery>
		
