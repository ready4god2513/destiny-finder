
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Performs the admin actions for accounts: add, update, delete. 
Called by product.admin&account=act --->

<cfswitch expression="#mode#">
	<cfcase value="i">
		<!--- ADD a new Account --->
		
		<!--- check to make sure the user is valid --->
		<cfquery name="finduser" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
			SELECT User_ID FROM #Request.DB_Prefix#Users
			WHERE Username = '#attributes.UName#'
		</cfquery>
		
		<cfif finduser.recordcount is 1 OR NOT len(Trim(attributes.UName))>
		
			<!--- Add the account record --->
			<cfset attributes.UID = iif(finduser.recordcount, finduser.User_ID, 0)>
			<cfset attributes.Acc_Account_ID = Application.objUsers.AddAccount(argumentcollection=attributes)>
		
		<cfelse>
		
			<cfset attributes.error_message = "Can not add this Account. Not a valid User">
			
		</cfif>
			
	</cfcase>
			
	<cfcase value="u">
		<cfif submit is "Delete">
			<!--- Delete Account --->
			<cfset attributes.error_message = "">
			
			<!--- See if Account is currently used in any orders or POs ---->
			<cfquery name="checkorders" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
				SELECT Order_No
				FROM #Request.DB_Prefix#Order_Items
				WHERE Dropship_Account_ID = #attributes.Acc_Account_ID#
			</cfquery>
			
			<cfif checkorders.recordcount gt 0>
				<cfset attributes.error_message = attributes.error_message &  "<br/>This account is assigned as a dropshipper on the following Order(s): " & valuelist(checkorders.order_no) >
			</cfif>
			
			
			<!--- See if Account is currently used in any orders or POs ---->
			<cfquery name="checkPOS" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
				SELECT PO_No
				FROM #Request.DB_Prefix#Order_PO
				WHERE Account_ID = #attributes.Acc_Account_ID#
			</cfquery>
			
			<cfif checkPOS.recordcount gt 0>
				<cfset attributes.error_message = attributes.error_message &  "<br/>This account is part of the following Purchase Order(s): " & valuelist(checkPOS.PO_no) >
			</cfif>	
			
			<cfif NOT len(attributes.error_message)>
				
			
				<!--- Remove account from product Manufacturer ----->
				<cfquery name="UpdateProdMfg" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
					UPDATE #Request.DB_Prefix#Products
					SET Mfg_Account_ID = NULL
					WHERE Mfg_Account_ID = #attributes.Acc_Account_ID#
				</cfquery>
				
					
				<!--- Remove account from product account/dropshipper ----->			
				<cfquery name="UpdateProdAcct" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
					UPDATE #Request.DB_Prefix#Products
					SET Account_ID = NULL
					WHERE Account_ID = #attributes.Acc_Account_ID#
				</cfquery>
				
				
				<cfquery name="delete_Account"  datasource="#Request.ds#" username="#Request.user#" password="#Request.pass#">
					DELETE FROM #Request.DB_Prefix#Account 
					WHERE Account_ID = #attributes.Acc_Account_ID#
				</cfquery>
			
			<cfelse>
			
				<cfset attributes.error_message = "This Account could not be deleted for the following reasons:<br/>" &  attributes.error_message >
			
			</cfif>		

								
		<cfelse>		
		<!--- Update Account --->
		
		<!--- check to make sure the user is valid --->
		<cfquery name="finduser" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
			SELECT User_ID FROM #Request.DB_Prefix#Users
			WHERE Username = '#attributes.UName#'
		</cfquery>
			
			<cfif finduser.recordcount is 1 OR NOT len(Trim(attributes.UName))>	
			
				<cfset attributes.UID = iif(finduser.recordcount, finduser.User_ID, 0)>
				<cfset Application.objUsers.UpdateAccount(argumentcollection=attributes)>
		
		<cfelse>
			
			<cfset attributes.error_message = "Could not update Account. Not a valid User">
		
		</cfif>	
		
		
		</CFIF>
	</cfcase>
			
</cfswitch>

	



		