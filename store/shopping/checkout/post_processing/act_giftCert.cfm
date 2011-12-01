<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Adding a new gift certificate, generate the code and email it to the customer if approved order --->

<!--- Passed from order page - This says if the membership has been billed
and should be activated immediately. It SHOULD BE SET TO 0 FOR A LIVE STORE.--->
<cfparam name="membership_valid" default="0"> 
<!--- DEBUG: The following alternative can be used for testing purposes 
<cfset membership_valid = 1>--->

<!--- First, query the Products table to get gift cert Information. --->
<cfquery name="GetCertInfo"  datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" Maxrows="1">
SELECT Num_Days
FROM #Request.DB_Prefix#Products
WHERE Product_ID = <cfqueryparam value="#qry_Get_Basket.Product_ID#" cfsqltype="CF_SQL_INTEGER">
</cfquery>

<cfset LineBreak = Chr(13) & Chr(10)>
<cfset Message = "Your gift certificate(s) will be active for #GetCertInfo.Num_Days# days. Any unused balance can be applied on your next order." & LineBreak & LineBreak>

<cfset CertPrice = qry_get_basket.Price + qry_get_basket.OptPrice - qry_get_basket.QuantDisc + qry_get_basket.AddonMultP>

<!--- Generate a new gift certificate for each quantity ordered --->
<cfloop index="num" from="1" to="#qry_get_basket.Quantity#">
	<cfinclude template="../../admin/certificate/act_generate_code.cfm">
	
	<cfquery name="AddCert" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
			INSERT INTO #Request.DB_Prefix#Certificates
			(Cert_Code, Cust_Name, CertAmount, InitialAmount, Order_No, StartDate, EndDate, Valid)
			VALUES (
			<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Cert_Code#">,
			<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#GetCustomer.FirstName# #GetCustomer.LastName#">,
			<cfqueryparam cfsqltype="CF_SQL_DOUBLE" value="#CertPrice#">,
			<cfqueryparam cfsqltype="CF_SQL_DOUBLE" value="#CertPrice#">,
			<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#New_OrderNo#">,
			#CreateODBCDate(Now())#, #CreateODBCDate(DateAdd("d", GetCertInfo.Num_Days, Now()))#,
			<cfqueryparam cfsqltype="#Request.SQL_Bit#" value="#membership_valid#">)
	</cfquery>	
	
	<cfset Message = Message & "#LSCurrencyFormat(CertPrice)# Gift Certificate: #Cert_Code#" & LineBreak>
	
</cfloop>

	<cfset Message = Message & LineBreak & "Thanks for shopping with us!" & LineBreak>
<!--- Send an email with the user's gift certificates if auto-approved. Otherwise, admin will need to approve the gift certs and send them to the user. --->

<cfif membership_valid>

	<cftry>
	
		<cfinvoke component="#Request.CFCMapping#.global" UID="#Session.User_ID#" 
			method="sendAutoEmail" Email="#GetCustomer.Email#" MailAction="GiftCertPurchase" MergeContent="#Message#">
 	
		<cfcatch type="ANY">
			<cfset codenotsent = "yes">
		</cfcatch>
	</cftry>
</cfif>

<!--- Codes not sent to the customer. Update the order --->
<cfif NOT membership_valid OR isDefined("codenotsent")>
	<cfquery name="updOrder" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	UPDATE #Request.DB_Prefix#Order_No
	SET CodesSent = 0
	WHERE Order_No = #New_OrderNo#
	</cfquery>
</cfif>


