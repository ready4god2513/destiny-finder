
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Retrieves the customer address from the temporary table. Called by act_newcustomer.cfm, act_update_tmp_orderinfo.cfm, dsp_addresses.cfm and from shipping\act_calc_shipping.cfm --->

<!---------
<cfif attributes.Customer_ID>

<cfquery name="GetCustomer" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
SELECT * FROM #Request.DB_Prefix#Customers 
WHERE Customer_ID = <cfqueryparam value="#attributes.Customer_ID#" cfsqltype="CF_SQL_INTEGER">
</cfquery>

<cfelse></cfif>
-------->
<cfquery name="GetCustomer" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
SELECT * FROM #Request.DB_Prefix#TempCustomer 
WHERE TempCust_ID = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Session.BasketNum#">
</cfquery>



