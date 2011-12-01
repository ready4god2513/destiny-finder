
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This is used to update the shopping cart settings. Called by shopping.admin&cart=save --->

<cfparam name="attributes.BaseOrderNum" default="0">
<cfparam name="attributes.Require_Text" default="">
<cfparam name="attributes.Require_Select" default="">

<cfif NOT isNumeric(attributes.MinTotal)>
	<cfset attributes.MinTotal = 0>
</cfif>

<!--- Initialize list of required custom fields --->
<cfset RequireTextList = "">
<cfset RequireSelectList = "">

<!--- Loop through the list of required custom fields and make sure something has been entered for the label of that field --->
<!--- textboxes --->
<cfif len(attributes.Require_Text)>
	<cfloop index="fieldnum" list="#attributes.Require_Text#">
		<cfset FieldText = attributes[fieldnum]>
		<cfif len(Trim(FieldText))>
			<cfset RequireTextList = ListAppend(RequireTextList, fieldnum)>
		</cfif>
	</cfloop>
</cfif>
<!--- selectboxes --->
<cfif len(attributes.Require_Select)>
	<cfloop index="fieldnum" list="#attributes.Require_Select#">
		<cfset FieldText = attributes[fieldnum]>
		<cfif len(Trim(FieldText))>
			<cfset RequireSelectList = ListAppend(RequireSelectList, fieldnum)>
		</cfif>
	</cfloop>
</cfif>

<cfquery name="EditOrderSettings" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	UPDATE #Request.DB_Prefix#OrderSettings
	SET Giftwrap = #attributes.Giftwrap#,
	Giftcard = #attributes.Giftcard#,
	Delivery = #attributes.Delivery#,
	Coupons = #attributes.Coupons#,
	Backorders = #attributes.Backorders#,
	ShowBasket = #attributes.showbasket#,
	MinTotal = #attributes.MinTotal#,
	NoGuests = #attributes.NoGuests#,
	AllowInt = #attributes.AllowInt#,
	SkipAddressForm = #attributes.SkipAddressForm#,
	BaseOrderNum = <cfif len(attributes.BaseOrderNum)>#attributes.BaseOrderNum#<cfelse>0</cfif>,
	AgreeTerms = <cfif len(Trim(attributes.AgreeTerms))>'#Trim(attributes.AgreeTerms)#'<cfelse>NULL</cfif>,
	<!--- custom textboxes --->
	<cfloop index="num" from="1" to="3">
	CustomText#num# = <cfif len(Trim(attributes['CustomText' & num]))>'#Trim(attributes['CustomText' & num])#'<cfelse>NULL</cfif>,
	</cfloop>
	<!--- custom selectboxes --->
	<cfloop index="num" from="1" to="2">
	CustomSelect#num# = 
		<cfif len(Trim(attributes['CustomSelect' & num]))>'#Trim(attributes['CustomSelect' & num])#'<cfelse>NULL</cfif>,
	CustomChoices#num# = <cfif len(Trim(attributes['CustomChoices' & num]))>
						'#Trim(Replace(attributes['CustomChoices' & num], " ", "", "All"))#'
						<cfelse>NULL</cfif>,
	</cfloop>
	CustomText_Req = <cfif len(RequireTextList)>'#RequireTextList#'<cfelse>NULL</cfif>,
	CustomSelect_Req = <cfif len(RequireSelectList)>'#RequireSelectList#'<cfelse>NULL</cfif>,
	EmailUser = #attributes.EmailUser#,
	EmailAdmin = #attributes.EmailAdmin#,
	EmailDrop = #attributes.EmailDrop#,
	EmailAffs = #attributes.EmailAffs#,
	EmailDropWhen = '#attributes.EmailDropWhen#',
	OrderEmail = <cfif len(Trim(attributes.OrderEmail))>'#Trim(attributes.OrderEmail)#'<cfelse>NULL</cfif>,
	DropEmail = <cfif len(Trim(attributes.DropEmail))>'#Trim(attributes.DropEmail)#'<cfelse>NULL</cfif>
</cfquery>

<cfquery name="EditMainSettings" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
UPDATE #Request.DB_Prefix#Settings
SET GiftRegistry = #attributes.giftregistry#
</cfquery>


<!--- Get New Settings --->
<cfset Request.Cache = CreateTimeSpan(0, 0, 0, 0)>
<cfinclude template="../../qry_get_order_settings.cfm">
<cfinclude template="../../../queries/qry_getsettings.cfm">



