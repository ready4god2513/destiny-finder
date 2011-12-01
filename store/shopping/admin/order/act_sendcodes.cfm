
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This sends an email to the customer with their gift certificate codes. Called from shopping\admin\index.cfm --->

<!--- Initialize the content of the message --->
<cfset LineBreak = Chr(13) & Chr(10)>
<cfset Message = "The following gift certificates you purchased are now active and can be used for purchases in our store:" & LineBreak & LineBreak>

<!--- Loop through the list of gift cert codes --->
<cfloop query="GetCerts">

	<cfset Message = Message & "#LSCurrencyFormat(CertAmount)# Gift Certificate: #Cert_Code#" & LineBreak>
	
	<cfquery name="UpdateCert" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
		UPDATE #Request.DB_Prefix#Certificates
		SET Valid = 1
		WHERE Cert_ID = #Cert_ID#
	</cfquery>

</cfloop>

<cfinvoke component="#Request.CFCMapping#.global" UID="#GetCust.User_ID#" 
	method="sendAutoEmail" Email="#GetCust.Email#" MergeName="#GetCust.Firstname# #GetCust.Lastname#" 
	MailAction="GiftCertPurchase" MergeContent="#Message#">


<cfquery name="UpdateOrder" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	UPDATE #Request.DB_Prefix#Order_No
	SET CodesSent = 1
	WHERE Order_No = #attributes.Order_No#
</cfquery>

<!--- Redo the order queries --->
<cfinclude template="qry_order.cfm">