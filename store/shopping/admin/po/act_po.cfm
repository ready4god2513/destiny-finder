
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Performs actions on purchase orders: add, edit and delete. Verifies the discount is not in use before deleting. Called by shopping.admin&po=act|add|ship and from order\act_maildrop.cfm --->

<cfswitch expression="#po#">

	<cfcase value="add">
	
		<!--- UUID to tag new inserts --->
		<cfset NewIDTag = CreateUUID()>
		<!--- Remove dashes --->
		<cfset NewIDTag = Replace(NewIDTag, "-", "", "All")>
		
		<!--- check to see if purchase order exists for this order|account combo --->
		<cfquery name="findPO"  datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" maxrows="1">
			SELECT Order_PO_ID FROM #Request.DB_Prefix#Order_PO
			WHERE Order_No = #attributes.Order_No#
			AND Account_ID = #attributes.account_ID#
		</cfquery>

		<cfif findpo.recordcount is 1>
		
			<cfset attributes.order_po_ID = findpo.order_po_ID>
		
		<cfelse>
		
	 		<cftransaction>
			
			<!--- Determine which PO for this order we are adding --->
			<cfquery name="Get_po_num" datasource="#Request.ds#" username="#Request.user#"  password="#Request.pass#">
			SELECT COUNT(Order_PO_ID) AS Po_Num 
			FROM #Request.DB_Prefix#Order_PO
			WHERE Order_No = #attributes.Order_No#
			</cfquery>
			
			<cfset NextPO = Get_po_num.Po_Num + 1>
			
			<cfquery name="GetPOID" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
			<cfif Request.dbtype IS "MSSQL">
				SET NOCOUNT ON
			</cfif>
			INSERT INTO #Request.DB_Prefix#Order_PO 
			(ID_Tag, Order_No, PO_No, Account_ID, PrintDate, PO_Open)
			VALUES
			('#NewIDTag#', #attributes.order_no#,
		     '#(Attributes.order_no + Get_Order_Settings.BaseorderNum)#-#NextPO#',
			 #Attributes.account_ID#,
			 #createodbcdate(now())#,
			 1)
			 <cfif Request.dbtype IS "MSSQL">
				SELECT @@Identity AS New_ID
				SET NOCOUNT OFF
			</cfif>
			</cfquery>	
	
			<cfif Request.dbtype IS NOT "MSSQL">
				<cfquery name="GetPOID" datasource="#Request.ds#" username="#Request.user#"  password="#Request.pass#">
				SELECT Order_PO_ID AS New_ID 
				FROM #Request.DB_Prefix#Order_PO
				WHERE ID_Tag = '#NewIDTag#'
				</cfquery>
			</cfif>
		
			</cftransaction>			
			
			<cfset attributes.Order_PO_id = GetPOID.New_ID>
		
		</cfif>
	</cfcase>

	
	<cfcase value="act">	
	
		<cfif submit is "delete">
		
			<cfquery name="Delete_PO" dbtype="ODBC" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
			DELETE FROM #Request.DB_Prefix#Order_PO 
			WHERE Order_PO_ID = #attributes.Order_po_ID#
			</cfquery>
				
		<cfelse>

			<cfquery name="Update_PO" datasource="#Request.ds#" username="#Request.user#" password="#Request.pass#">
			UPDATE #Request.DB_Prefix#Order_PO
				SET 	
				PO_No = '#Trim(attributes.po_no)#',
				PrintDate = #createODBCDate(attributes.printdate)#,
				Notes = '#attributes.notes#',
				PO_Status = '#attributes.po_status#',
				PO_Open = #attributes.po_open#	
				WHERE Order_PO_ID = #attributes.Order_PO_ID#
				</cfquery>

		</cfif>
	</cfcase>
	
	
	<cfcase value="ship">
	
		<!--- Update Order --->
		<cfquery name="Fill_PO" datasource="#Request.ds#" username="#Request.user#" password="#Request.pass#">
			UPDATE #Request.DB_Prefix#Order_PO
				SET 	
				Tracking = <cfif len(Trim(attributes.Tracking))>'#Trim(attributes.Tracking)#'<cfelse>NULL</cfif>,
				Shipper = '#attributes.Shipper#',
				ShipDate = #createODBCDate(attributes.ShipDate)#,
				PO_Status = '#attributes.po_status#',
				PO_Open = #attributes.po_open#,
				Notes = '#attributes.notes#'
				WHERE Order_PO_ID = #attributes.Order_PO_ID#
				</cfquery>

		<!--- If Email customer check, send email with tracking numbers --->	
		<cfif attributes.EmailCustomer is "1">
			<cfinclude template="../order/act_emailtrack.cfm"> 
		</cfif>	
		
	</cfcase>
	

</cfswitch>
			


