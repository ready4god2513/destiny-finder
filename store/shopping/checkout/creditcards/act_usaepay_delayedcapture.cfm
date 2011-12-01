<!--- Processing for USAepay --->

<!--- Get USAepay Settings:
 Unique_ID = KEY ---->
<cfquery name="GetSettings" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" maxrows="1">
	SELECT Password, Transtype, Username FROM #Request.DB_Prefix#CCProcess
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


	<cfmodule template="usaepay-1.cfm"
		queryname="Results"
		KEY="#GetSettings.Username#"
		command="capture"
		AMOUNT="#GetOrderTx.OrderTotal#"
		refNum="#GetOrderTx.TransactNum#"
		TESTREQUEST="False"
		>
			 
	<!--- Debug --->
	<!--- <cfdump var="#Result#"> --->
	
	<cfset thedate = dateformat(now(),"mm/dd/yy")>

	<!---If the message is approved, continue processing the order---->
	<cfif Results.UMstatus is "Approved">
  
  		<cfquery name="OrderPaid" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">	
			UPDATE #Request.DB_Prefix#Order_No
			SET Paid = 1,
			Notes = 'SETTLED #thedate#: #GetOrderTx.Notes#',
			Admin_Name = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Session.Realname#">,
			Admin_Updated = <cfqueryparam cfsqltype="CF_SQL_TIMESTAMP" value="#Now()#">
			WHERE Order_No = <cfqueryparam value="#attributes.Order_no#" cfsqltype="CF_SQL_INTEGER">
		</cfquery>
		
	<cfelse>
  		<cfset ErrorMessage = Results.UMerror>
  		
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
