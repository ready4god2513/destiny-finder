
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Saves the payment settings for the store. Called by shopping.admin&payment=cards --->

<!--- Enter credit card changes --->	
<cfquery name="EditCards" datasource="#Request.DS#" 
username="#Request.user#" password="#Request.pass#">
UPDATE #Request.DB_Prefix#CreditCards
SET Used = 1
WHERE ID IN (#attributes.CreditCards#)
</cfquery>	

<cfquery name="EditCards" datasource="#Request.DS#" 
username="#Request.user#" password="#Request.pass#">
UPDATE #Request.DB_Prefix#CreditCards
SET Used = 0
WHERE ID NOT IN (#attributes.CreditCards#)
</cfquery>	

<!--- Only save card data if using Shift4 processing --->
<cfif CCProcess IS NOT "Shift4OTN">
	<cfset attributes.StoreCardInfo = 0>
</cfif>


	<cfquery name="EditSettings" datasource="#Request.DS#" 
	username="#Request.user#" password="#Request.pass#">
	UPDATE #Request.DB_Prefix#OrderSettings
	SET AllowOffline = #attributes.AllowOffline#,
	StoreCardInfo = #attributes.StoreCardInfo#,
	UseCVV2 = #attributes.UseCVV2#,
	OnlyOffline = #attributes.OnlyOffline#,
	AllowPO = #attributes.AllowPO#,
	UsePayPal = #attributes.UsePayPal#,
	PayPalEmail = <cfif len(attributes.PayPalEmail)>'#Trim(attributes.PayPalEmail)#'<cfelse>NULL</cfif>,
	PayPalLog = #attributes.PayPalLog#,
	CCProcess = '#attributes.CCProcess#',
	UseBilling = #attributes.UseBilling#,
	OfflineMessage = <cfif len(attributes.OfflineMessage)>'#Trim(attributes.OfflineMessage)#'<cfelse>NULL</cfif>
	</cfquery>

	<!--- Get New Settings --->
	<cfset Request.Cache = CreateTimeSpan(0, 0, 0, 0)>
	<cfinclude template="../../qry_get_order_settings.cfm">

<!-----
	<cfmodule template="../../../customtags/format_admin_form.cfm"
		box_title="Payment Manager"
		width="350"
		required_fields="0"
		>
		
	<tr><td align="center" class="formtitle">
		<br/>
		Payment Options Saved
		<cfoutput>
		<form action="#self#?fuseaction=shopping.admin&payment=cards#request.token2#" method="post">
		</cfoutput>
		<input class="formbutton" type="submit" value="Continue"/>
		</form>	
			
	</td></tr>
	</cfmodule> 	
---->
