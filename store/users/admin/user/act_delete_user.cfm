
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Deletes Users. Called from act_user.cfm.

	Users are related to:
		features - do not allow deletion until features are changed
		account - do not allow, must be deleted separately
		customers -  do not allow, must be deleted separately
		products, addons, options - do not allow, must be deleted separately
	
		wishlists - delete all wishlist items
		memberships - delete all
---->

<cfinclude template="../../../shopping/qry_get_order_settings.cfm">

<cfset attributes.error_message = "">

<!--- Check for related features --->
<cfquery name="GetFeatures"  datasource="#Request.ds#" username="#Request.user#" password="#Request.pass#">
SELECT Feature_ID FROM #Request.DB_Prefix#Features
WHERE User_ID = #attributes.UID#
</cfquery>
	
<cfif GetFeatures.RecordCount IS NOT 0>
	<cfset attributes.error_message = attributes.error_message & "<br/>This user is assigned to features. Please delete or edit them first.">
</cfif>
	
	
<!--- Check for Account --->
<cfquery name="GetAccount"  datasource="#Request.ds#" username="#Request.user#" password="#Request.pass#">
SELECT Account_ID FROM #Request.DB_Prefix#Account
WHERE User_ID = #attributes.UID#
</cfquery>
	
<cfif GetAccount.RecordCount IS NOT 0>
	<cfset attributes.error_message = attributes.error_message & "<br/>This user has an Account. Please delete or edit the Account first.">
</cfif>

<!--- Check for Products --->
<cfquery name="GetProducts"  datasource="#Request.ds#" username="#Request.user#" password="#Request.pass#">
SELECT Product_ID FROM #Request.DB_Prefix#Products
WHERE User_ID = #attributes.UID#
</cfquery>
	
<cfif GetProducts.RecordCount IS NOT 0>
	<cfset attributes.error_message = attributes.error_message & "<br/>This user has products assigned. Please delete the products first.">
</cfif>

<!--- Check for Standard Options --->
<cfquery name="GetOptions"  datasource="#Request.ds#" username="#Request.user#" password="#Request.pass#">
SELECT Std_ID FROM #Request.DB_Prefix#StdOptions
WHERE User_ID = #attributes.UID#
</cfquery>
	
<cfif GetOptions.RecordCount IS NOT 0>
	<cfset attributes.error_message = attributes.error_message & "<br/>This user has standard options assigned. Please delete them first.">
</cfif>

<!--- Check for Standard Addons --->
<cfquery name="GetAddons"  datasource="#Request.ds#" username="#Request.user#" password="#Request.pass#">
SELECT Std_ID FROM #Request.DB_Prefix#StdAddons
WHERE User_ID = #attributes.UID#
</cfquery>
	
<cfif GetAddons.RecordCount IS NOT 0>
	<cfset attributes.error_message = attributes.error_message & "<br/>This user has standard addons assigned. Please delete them first.">
</cfif>

<!--- Check for Gift Registries --->
<cfquery name="GetRegistries"  datasource="#Request.ds#" username="#Request.user#" password="#Request.pass#">
SELECT GiftRegistry_ID FROM #Request.DB_Prefix#GiftRegistry
WHERE User_ID = #attributes.UID#
</cfquery>
	
<cfif GetRegistries.RecordCount IS NOT 0>
	<cfset attributes.error_message = attributes.error_message & "<br/>This user has gift registries set up. Please delete them first.">
</cfif>
	
	
<!--- Check for customer records --->
<cfquery name="GetCustomers"  datasource="#Request.ds#" username="#Request.user#" password="#Request.pass#">
SELECT Customer_ID FROM #Request.DB_Prefix#Customers
WHERE User_ID = #attributes.UID#
</cfquery>

<cfif GetCustomers.RecordCount>

	<cfset CustList = ValueList(GetCustomers.Customer_ID)>
	
		<cfquery name="checkorders" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
			SELECT (Order_No + #Get_Order_Settings.BaseOrderNum#) AS Order_Num
			FROM #Request.DB_Prefix#Order_No
			WHERE Customer_ID IN (#CustList#) 
			OR ShipTo IN (#CustList#)
		</cfquery>
		
	<cfif checkorders.RecordCount IS NOT 0>
		<cfset attributes.error_message = attributes.error_message & "<br/>This user has Customer address records used for order number(s) " & valuelist(checkorders.Order_Num) & ". Please delete or edit them first.">
	</cfif>

</cfif>
	
<cfif NOT len(attributes.error_message)>

	<cfset attributes.XFA_success = "fuseaction=users.admin&user=list">

	<!--- Check for any helpful votes by this user and remove --->
	<cfquery name="check_helpful"  datasource="#Request.ds#" username="#Request.user#" password="#Request.pass#">
		SELECT Review_ID, Helpful FROM #Request.DB_Prefix#ProductReviewsHelpful
		WHERE User_ID = #attributes.uid#
	</cfquery>
	
	<cfloop query="check_helpful">
		<cfquery name="Upd_review"  datasource="#Request.ds#" username="#Request.user#" password="#Request.pass#">
			UPDATE #Request.DB_Prefix#ProductReviews 
			SET Helpful_Total = Helpful_Total - 1
			<cfif check_helpful.Helpful IS NOT 0>, Helpful_Yes = Helpful_Yes - 1</cfif>
			WHERE Review_ID = #check_helpful.Review_ID#
		</cfquery>
	</cfloop>

	<!--- Now remove the helpful votes --->
	<cfquery name="delete_helpful_votes"  datasource="#Request.ds#" username="#Request.user#" password="#Request.pass#">
		DELETE FROM #Request.DB_Prefix#ProductReviewsHelpful
		WHERE User_ID = #attributes.uid#
	</cfquery>

	<!--- Delete any helpful votes for reviews this user made --->
	<cfquery name="delete_reviews_helpful"  datasource="#Request.ds#" username="#Request.user#" password="#Request.pass#">
		DELETE FROM #Request.DB_Prefix#ProductReviewsHelpful
		WHERE Review_ID IN (SELECT Review_ID FROM #Request.DB_Prefix#ProductReviews
									WHERE User_ID = #attributes.uid#)
	</cfquery>	
	
	<!--- Now delete the user's reviews --->
	<cfquery name="delete_productreviews"  datasource="#Request.ds#" username="#Request.user#" password="#Request.pass#">
		DELETE FROM #Request.DB_Prefix#ProductReviews
		WHERE User_ID = #attributes.uid#
	</cfquery>			

	<!--- Remove user id on any article comments --->
	<cfquery name="delete_FeatureReviews"  datasource="#Request.ds#" username="#Request.user#" password="#Request.pass#">
		UPDATE #Request.DB_Prefix#FeatureReviews
		SET User_ID = 0
		WHERE User_ID = #attributes.uid#
		</cfquery>		

	<cfif GetCustomers.RecordCount>
		<!--- remove any old card data ---->
		<cfquery name="delete_customers"  datasource="#Request.ds#" username="#Request.user#" password="#Request.pass#">
		DELETE FROM #Request.DB_Prefix#CardData 
		WHERE Customer_ID IN (#CustList#)
		</cfquery>
		
		<!--- remove customer ID from any Account Record ---->
		<cfquery name="UpdateAccounts" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
		UPDATE #Request.DB_Prefix#Account
		SET Customer_ID = 0
		WHERE Customer_ID IN (#CustList#)
		</cfquery>	
	</cfif>
	
	<cfquery name="delete_customers"  datasource="#Request.ds#" username="#Request.user#" password="#Request.pass#">
		DELETE FROM #Request.DB_Prefix#Customers 
		WHERE User_ID = #attributes.uid#
		</cfquery>

	<cfquery name="delete_WishList"  datasource="#Request.ds#" username="#Request.user#" password="#Request.pass#">
		DELETE FROM #Request.DB_Prefix#WishList 
		WHERE User_ID = #attributes.UID#
		</cfquery>
		
	<cfquery name="delete_Memberships"  datasource="#Request.ds#" username="#Request.user#" password="#Request.pass#">
		DELETE FROM #Request.DB_Prefix#Memberships 
		WHERE User_ID = #attributes.UID#
		</cfquery>
	
	<cfquery name="delete_users"  datasource="#Request.ds#" username="#Request.user#" password="#Request.pass#">
		DELETE FROM #Request.DB_Prefix#Users 
		WHERE User_ID = #attributes.uid#
		</cfquery>
	
<cfelse>
			
	<cfset attributes.error_message = "User #attributes.UID# could not be deleted for the following reasons:<br/>" &  attributes.error_message >
			
</cfif>			
	


