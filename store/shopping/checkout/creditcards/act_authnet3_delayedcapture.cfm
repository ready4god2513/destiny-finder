
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This template is used to complete the payment processing on an order using Authorize.Net. The order must have been previously authorized. It looks up the authorization number and bills.  Called from shopping\admin\act_billing.cfm

	Required: Order_no
	
--->

<!--- Retrive Authorize.Net settings --->
<cfquery name="GetSettings" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" maxrows="1">
SELECT Password, Transtype, Username 
FROM #Request.DB_Prefix#CCProcess
</cfquery>

<!--- Look up the Order Info --->
<cfquery name="GetOrderTx" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" maxrows="1">
SELECT Order_No, AuthNumber, OrderTotal, Notes, TransactNum
FROM #Request.DB_Prefix#Order_No
WHERE Order_No = <cfqueryparam value="#attributes.Order_no#" cfsqltype="CF_SQL_INTEGER"> 
AND AuthNumber <> '0'
AND Paid = 0
AND Void = 0
</cfquery>


<!--- if record found, process the payment --->
<cfif GetOrderTx.recordcount is 1>

	<CF_AuthNetCapture30
		QUERYNAME="Results"
		LOGIN="#GetSettings.Username#"
	     PASSWORD="#GetSettings.Password#"
	     AMOUNT="#GetOrderTx.OrderTotal#"
	     TransactNum="#GetOrderTx.TransactNum#">

	<!--- Debug --->
	<!--- <cfdump var="#Result#"> --->
	
	<cfset thedate = dateformat(now(),"mm/dd/yy")>

	<!---If the message is approved, continue processing the order---->
	<cfif Results.response_code IS 1>
  
  		<cfquery name="OrderPaid" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">	
			UPDATE #Request.DB_Prefix#Order_No
			SET Paid = 1,			
			Notes = 'SETTLED #thedate#: #GetOrderTx.Notes#',
			Admin_Name = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Session.Realname#">,
			Admin_Updated = <cfqueryparam cfsqltype="CF_SQL_TIMESTAMP" value="#Now()#">
			WHERE Order_No = <cfqueryparam value="#attributes.Order_no#" cfsqltype="CF_SQL_INTEGER">
		</cfquery>
		
	<cfelse>
  		<cfset ErrorMessage = Results.response_text>
  		
		<cfquery name="OrderPaid" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">	
			UPDATE #Request.DB_Prefix#Order_No
			SET 
			Notes = 'CC billing failed on #thedate#: #ErrorMessage#  #GetOrderTx.Notes#',
			Admin_Name = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Session.Realname#">,
			Admin_Updated = <cfqueryparam cfsqltype="CF_SQL_TIMESTAMP" value="#Now()#">
			WHERE Order_No = <cfqueryparam value="#attributes.Order_no#" cfsqltype="CF_SQL_INTEGER">
		</cfquery>
			
	</CFIF>
			
</cfif>
