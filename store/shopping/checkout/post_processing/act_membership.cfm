
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Checks if the product ordered is a membership or download, and saves information to the membership table. Called by checkout\act_save_order.cfm 

UPGRADE for Membership Auto-Renewal. This page also called from access/admin/membership/act_bill_recuring.cfm. This page was altered to accept a different User_ID
--->


<!--- Passed from order page - This says if the membership has been billed
and should be activated immediately. It SHOULD BE SET TO 0 FOR A LIVE STORE.--->
<cfparam name="membership_valid" default="0"> 
<!--- DEBUG: The following alternative can be used for testing purposes 
<cfset membership_valid = 1> --->

<cfparam name="User_ID" default="#Session.User_ID#">
<cfinclude template="../../../users/qry_get_user.cfm">


<!--- First, query the Products table to get Product Information. --->
<cfquery name="GetMembershipInfo"  datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" Maxrows="1">
SELECT Prod_Type, Base_Price, Num_Days, Access_Keys, Access_Count, Recur, Recur_Product_ID, Name
FROM #Request.DB_Prefix#Products
WHERE Product_ID = <cfqueryparam value="#qry_Get_Basket.Product_ID#" cfsqltype="CF_SQL_INTEGER">
</cfquery>

<!--- Check for old Membership. --->
<cfquery name="GetOldMembership" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" Maxrows="1">
SELECT Membership_ID, Expire, Recur, Date_Ordered, Product_ID, Access_Count
FROM #Request.DB_Prefix#Memberships
WHERE (Product_ID = <cfqueryparam value="#qry_get_basket.Product_ID#" cfsqltype="CF_SQL_INTEGER">
OR Recur_Product_ID = <cfqueryparam value="#qry_get_basket.Product_ID#" cfsqltype="CF_SQL_INTEGER">)
AND User_ID = <cfqueryparam value="#User_ID#" cfsqltype="CF_SQL_INTEGER">
ORDER BY Expire DESC
</cfquery>


<!--- If a product is a Trial Membership, DISALLOW repurchasing of same trial membership. ---->
<cfif GetMembershipInfo.Prod_Type is "membership" AND GetMembershipInfo.recur_product_ID GT 0 AND GetOldMembership.recordcount>

	<!--- Document in User Notes ---->	
	<cfquery name="UpdateFraudUser" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	UPDATE #Request.DB_Prefix#Users 
	SET AdminNotes = '#DateFormat(Now(),"mm/dd/yy")#: Attempted repurchase of trial Membership ID #GetOldMembership.membership_ID#. <br/>#qry_get_user.AdminNotes#'
	WHERE User_ID = <cfqueryparam value="#User_ID#" cfsqltype="CF_SQL_INTEGER">
	</cfquery>		
	
	<cfquery name="GetComments" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	SELECT Comments FROM #Request.DB_Prefix#Order_No
	WHERE Order_No = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#New_OrderNo#">
	</cfquery>		
	
	<!--- Update Order Comments with invalid membership notice. ---->	
	<cfquery name="UpdateFraudUser" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	UPDATE #Request.DB_Prefix#Order_No 
	SET Comments = 'SORRY! Your trial membership is invalid. Our records show a previous #GetMembershipInfo.Name# starting on #DateFormat(GetOldMembership.Date_Ordered,"mm/dd/yy")#.<br/>#GetComments.Comments#'
	WHERE Order_No = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#New_OrderNo#">
	</cfquery>		
	
<cfelse>

	<!--- FREE MEMBERSHIPS/DOWNLOADS - we have to set the valid flag to 'Yes'. --->
	<!--- Determine Item Price --->
	<cfset ProdPrice = qry_get_basket.Price +  qry_get_basket.OptPrice - qry_get_basket.QuantDisc - qry_get_basket.DiscAmount + qry_Get_Basket.AddonMultP>
	<!--- If not free product, check if a promotional item --->
	<cfif ProdPrice GT 0 AND qry_get_basket.PromoQuant eq qry_get_basket.Quantity>
		<cfset ProdPrice = ProdPrice - qry_get_basket.PromoAmount>
	</cfif>
	
	<cfif ProdPrice LTE 0 AND Qry_Get_User.CardisValid>
		<cfset approve_membership = 1>
	<cfelse>
		<cfset approve_membership = membership_valid>
	</cfif>

	<!--- REPURCHASING OF TRIAL MEMBERSHIPS -  To prevent members from creating multiple user accounts, 
	we're also going to check if the credit card has EVER been used to purchase this product by 
	another user. --->
	<cfif GetMembershipInfo.prod_type is "membership" AND GetMembershipInfo.recur_product_ID GT 0 AND isDefined("crypt.value")>
		
		<!--- Check if current CC has been used to purchase this membership product in the past. --->  
		<cfquery name="CheckCCMembership" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" maxrows="1">
		SELECT M.Membership_ID, U.User_ID, U.Username
		FROM #Request.DB_Prefix#Memberships M
		INNER JOIN #Request.DB_Prefix#Users U ON M.User_ID = U.User_ID
		WHERE M.Product_ID = <cfqueryparam value="#qry_get_basket.Product_ID#" cfsqltype="CF_SQL_INTEGER">
		AND U.EncryptedCard = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#crypt.value#">
		</cfquery>		

		<!--- If Fraud detected, Make Note on User Record & suspend user. --->
		<cfif checkCCMembership.recordcount>
		
			<!--- <cfquery name="UpdateFraudUser" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
			UPDATE #Request.DB_Prefix#Users 
			SET AdminNotes = '#DateFormat(Now(),"mm/dd/yy")#: Trial membership purchase with credit card previously used by User #CheckCCMembership.user_ID# - #CheckCCMembership.UserName#. User suspended.<br/> #qry_get_user.AdminNotes#',
			Disable = 1
			WHERE User_ID = <cfqueryparam value="#User_ID#" cfsqltype="CF_SQL_INTEGER">
			</cfquery>		 --->
			
			<!--- Update Order Comments with invalid membership notice. ---->	
			<cfquery name="UpdateFraudUser" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
			UPDATE #Request.DB_Prefix#Order_No 
			SET Comments = 'The credit card on this order has already been used previously to purchase a trial membership. Your membership will be inactive until reviewed by the store administrator.<br/>#GetComments.Comments#'
			WHERE Order_No = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#New_OrderNo#">
			</cfquery>	
					
			<cfset approve_membership = 0>
			
			<cfmail to="#get_order_settings.OrderEmail#"
        		from="#GetCustomer.Email#"
        		subject="Repeat Trial Membership Purchased"
				server="#request.appsettings.email_server#" port="#request.appsettings.email_port#">
				<cfmailparam name="Message-id" value="<#CreateUUID()#@#ListGetAt(request.appsettings.merchantemail, 2, "@")#>">
				<cfmailparam name="Reply-To" Value="#GetCustomer.Email#">
				The credit card used to purchase the trial membership on Order ###(New_OrderNo + Get_Order_Settings.BaseOrderNum)# has been used previously for another trial membership purchase. 
				Please review the order to determine whether to approve or cancel the membership selected. 
			</cfmail>
	
		</cfif><!--- previous card purchase --->

	</cfif> <!--- No repurchasing of trial memberships --->


	<!--- Calculate Starting date and expiration date. First check to see if there is a 
	current membership. If so, the start day will be the day after the current expiration.
	If not, the start date is now. --->
	<cfset start_date = Now()>

	<cfif GetOldMembership.recordcount AND isDate(GetOldMembership.expire)>

		<cfif DateCompare(GetOldMembership.expire, start_date) GTE 0>
			<cfset start_date = DateAdd("d", 1, getoldmembership.expire)>
		</cfif>

		<!--- Turn off 'Renew' for all old memberships with this product ID --->
		<cfquery name="TurnOffRenews" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
		UPDATE #Request.DB_Prefix#Memberships 
		SET Recur = 0
		WHERE (Product_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#qry_get_basket.Product_ID#">
		OR Recur_Product_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#qry_get_basket.Product_ID#">)
		AND User_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#User_ID#">
		</cfquery>	
	
	</cfif> 

	<cfset duration = GetMembershipInfo.num_days * qry_get_basket.Quantity>
	<cfset expire_date = DateAdd("d", duration , start_date)>
	
		<!--- If extending membership, UPDATE EXPIRATION and Access_Count
		same product & Membership not expired. ---->
	<cfif GetOldMembership.Product_ID IS qry_get_basket.Product_ID AND isDate(GetOldMembership.expire) AND DateCompare(GetOldMembership.expire,now()) GTE 0>
	
		<cfquery name="AddMembership" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
		UPDATE #Request.DB_Prefix#Memberships 
		SET Expire = <cfqueryparam cfsqltype="CF_SQL_TIMESTAMP" value="#expire_date#">,
		Recur = <cfqueryparam cfsqltype="#Request.SQL_Bit#" value="#GetMembershipInfo.Recur#">,
		Access_Count = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#GetMembershipInfo.Access_Count#"> + 
						<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#GetOldMembership.Access_Count#">,
		Valid = 1
		WHERE Membership_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#GetOldMembership.Membership_ID#">
		</cfquery>
	
	<cfelse>
	
	
	<!--- Add product to membership table.--->
	<cfquery name="AddMembership" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	INSERT INTO #Request.DB_Prefix#Memberships 
		(User_ID, Order_ID, Product_ID, Membership_Type, AccessKey_ID, Date_Ordered, Start, Time_Count, 
		Expire, Recur, Recur_Product_ID, Access_Count, Valid)	
	VALUES (<cfqueryparam value="#User_ID#" cfsqltype="CF_SQL_INTEGER">, 
	<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#New_OrderNo#">, 
	<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#qry_get_basket.Product_ID#">,
	<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#GetMembershipInfo.Prod_Type#">,
	<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#GetMembershipInfo.Access_Keys#" null="#YesNoFormat(NOT len(GetMembershipInfo.Access_Keys))#">,
	<cfqueryparam cfsqltype="CF_SQL_TIMESTAMP" value="#Now()#">,
	<cfqueryparam cfsqltype="CF_SQL_TIMESTAMP" value="#start_date#">,
	<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#GetMembershipInfo.num_days#" null="#YesNoFormat(NOT isNumeric(GetMembershipInfo.num_days))#">,
	<cfqueryparam cfsqltype="CF_SQL_TIMESTAMP" value="#expire_date#">,
	<cfqueryparam cfsqltype="#Request.SQL_Bit#" value="#iif(isBoolean(GetMembershipInfo.Recur), GetMembershipInfo.Recur, 0)#">,
	<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#iif(isNumeric(GetMembershipInfo.Recur_Product_ID), GetMembershipInfo.Recur_Product_ID, 0)#">,
	<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#GetMembershipInfo.Access_count#">,
	<cfqueryparam cfsqltype="#Request.SQL_Bit#" value="#approve_membership#">)
	</cfquery>
	
	</cfif>

	<!--- Reset login permissions if membership valid  --->
	<cfif approve_membership>
		<!--- Get user information --->
		<!--- NOTE: when run as a scheduled service, lookup by user_ID --->
		<cfquery name="qry_get_user" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" maxrows=1>
			SELECT U.User_ID, U.Password, U.Username, U.Group_ID, U.Permissions, C.FirstName, 
			C.LastName, CardisValid, CardExpire, CardNumber, EncryptedCard, EmailIsBad
			FROM #Request.DB_Prefix#Users U
			LEFT JOIN #Request.DB_Prefix#Customers C On C.Customer_ID = U.Customer_ID
			WHERE U.User_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#user_id#">
		</cfquery>
		<!--- Run if this membership is for current user --->
		<cfif user_id IS Session.User_ID>
			<cfinclude template="../../../users/login/act_set_login_permissions.cfm">
		</cfif>
	</cfif>
	
	<!--- If this is a recurring membership we need to save the cc info in the user record --->
	<cfif offlinePayment is "Online" AND not len(attributes.Offline) AND NOT isDefined("PayPal") AND GetMembershipInfo.recur_product_ID GT 0>
	
		<!---- Get User CC Info ----->
		<cfquery name="GetUserCard" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" maxrows=1>
		SELECT CardisValid, EncryptedCard, CardExpire
		FROM #Request.DB_Prefix#Users
		WHERE User_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#user_id#">
		</cfquery>
		
		<!--- If card is expired OR bad OR does not exist, update ---->
		<cfif NOT len(GetUserCard.EncryptedCard) OR GetUserCard.CardisValid is 0 OR Not isDate(GetUserCard.CardExpire) OR DateCompare(GetUserCard.CardExpire,now(),'m') lt 1>
		
			<cfif NOT isDefined("crypt.value")>
				<cfmodule template="../../../customtags/crypt.cfm" string="#CardNumber#" key="#Request.encrypt_key#">
			</cfif>
			
			<!--- Convert expiration date to a true date --->
			<cfscript>
				if (ListLen(cardexp, "/" IS 2)) {
					cardMonth = ListGetAt(cardexp,1,"/");
					cardYear = ListGetAt(cardexp,2,"/");
					tempdate = CreateDate(cardYear, cardMonth, "1");
					lastday = DaysInMonth(tempdate);
					expirationdate = CreateDate(cardYear, cardMonth, lastday);
				}
				else {
					expirationdate = Now();
					}
			</cfscript>
		
			<cfquery name="UpdateCardInfo" datasource="#Request.DS#" username="#Request.user#" 
			password="#Request.pass#">
			UPDATE #Request.DB_Prefix#Users 
			SET 
			CardType = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#CardType#">,
			NameOnCard = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#NameOnCard#">,
			CardNumber = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="XXXXXXXXXXXX#right(cardnumber,4)#">,
			EncryptedCard = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#crypt.value#">,
			CardExpire = <cfqueryparam cfsqltype="CF_SQL_TIMESTAMP" value="#expirationdate#">,
			CardisValid = 1
			WHERE User_ID = <cfqueryparam value="#User_ID#" cfsqltype="CF_SQL_INTEGER">
			</cfquery>		
			
		</cfif>
	
	</cfif>
	
</cfif><!--- Disallow purchasing of same trial membership --->	
	


