
<!--- CREATED BY: Chad M. Adamson | webmaster@hostbranson.com --->

<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This template is used to complete the payment processing on an order using Linkpoint. The order must have been previously authorized. It looks up the authorization number and bills.  Called from shopping\admin\act_billing.cfm
Required: Order_no --->

<!--- Retrieve Linkpoint settings --->
<cfquery name="GetSettings" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" maxrows="1">
	SELECT CCServer, Password, Transtype, Username, Setting1 
	FROM #Request.DB_Prefix#CCProcess
</cfquery>

<!--- Look up the Order Info --->
<cfquery name="GetOrderTx" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" maxrows="1">
	SELECT Order_No, Card_ID, TransactNum, OrderTotal, Notes 
	FROM #Request.DB_Prefix#Order_No 
	WHERE Order_No = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#attributes.Order_no#">
	AND Paid = 0 AND Void = 0
</cfquery>

<!--- if record found, process the payment --->
<cfif GetOrderTx.recordcount is 1 AND GetOrderTx.TransactNum is not "">

  <cfquery name="GetCardData" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" maxrows="1">
  	SELECT * FROM #Request.DB_Prefix#CardData 
  	WHERE ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#GetOrderTx.Card_ID#">
  </cfquery>
  
  <cfset ordertype = "POSTAUTH">
  <cfset chargetotal = GetOrderTX.OrderTotal>
  <cfset cardnumber = GetCardData.CardNumber>
  <cfset cardexpmonth = GetCardData.Expires>
  <cfset cardexpyear = GetCardData.Expires>
  <cfset oID = GetOrderTX.TransactNum>
  
  <cfinclude template = "lpcfm.cfm">
  <cfinclude template = "status.cfm">
  <!---If the message is approved, continue processing the order---->
  
  <cfset thedate = dateformat(now(),"mm/dd/yy")>
  
  <cfif R_APPROVED IS "APPROVED">
    <cfquery name="OrderPaid" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	    UPDATE #Request.DB_Prefix#Order_No 
		SET Paid = 1, 
		Notes = 'SETTLED #thedate#: #GetOrderTx.Notes#',
		Admin_Name = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Session.Realname#">,
		Admin_Updated = <cfqueryparam cfsqltype="CF_SQL_TIMESTAMP" value="#Now()#">
		WHERE Order_No =  <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#attributes.Order_no#">
    </cfquery>
	
    <!---If the message is not approved ---->
    <cfelse>
    <cfset ErrorMessage = R_ERROR>
    <cfquery name="OrderPaid" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	    UPDATE #Request.DB_Prefix#Order_No 
		SET Notes = 'CC billing failed on #thedate#: #ErrorMessage# #GetOrderTx.Notes#', 
		Admin_Name = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Session.Realname#">,
		Admin_Updated = <cfqueryparam cfsqltype="CF_SQL_TIMESTAMP" value="#Now()#">
		WHERE Order_No =  <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#attributes.Order_no#">
    </cfquery>
  </cfif>
</cfif>

