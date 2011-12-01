
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This template updates the temp_customer table with the other order info from the shipping page. Called by shopping.checkout (step=shipping) --->

<!--- Clear any previous totals for this basket --->
<cfquery name="DeleteTotals" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
DELETE FROM #Request.DB_Prefix#TempOrder
WHERE BasketNum = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Session.BasketNum#">
</cfquery>

<cfset Affiliate = Session.Affiliate>
<cfset Referrer = Session.Referrer>

<cfset Comments = iif(isDefined("attributes.Comments"), "trim(attributes.Comments)", DE(''))>
<cfset Delivery = iif(isDefined("attributes.Delivery"), "trim(attributes.Delivery)", DE(''))>
<cfset GiftCard = iif(isDefined("attributes.GiftCard"), "trim(attributes.GiftCard)", DE(''))>

<!--- Custom textbox fields --->
<cfloop index="x" from="1" to="3">
	<cfset variables['customtext' & x] = iif(isDefined("attributes.CustomText#x#"),Trim(Evaluate(De("attributes.CustomText#x#"))),DE(''))>
</cfloop>
<!--- Custom selectbox fields --->
<cfloop index="x" from="1" to="2">
	<cfset variables['customselect' & x] = iif(isDefined("attributes.CustomSelect#x#"),Trim(Evaluate(De("attributes.CustomSelect#x#"))),DE(''))>
</cfloop>


<!--- Store totals for this order in database --->
<cfquery name="AddTotals" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
INSERT INTO #Request.DB_Prefix#TempOrder
(BasketNum, Affiliate, Referrer, GiftCard, Delivery, Comments, 
<!--- Custom textbox fields --->
<cfloop index="num" from="1" to="3">
	CustomText#num#,
</cfloop>
<!--- Custom selectbox fields --->
<cfloop index="num" from="1" to="2">
	CustomSelect#num#, 
</cfloop> 
DateAdded)

VALUES
(<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Session.BasketNum#">,
<cfqueryparam value="#Affiliate#" cfsqltype="CF_SQL_INTEGER">,
<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Referrer#">,
<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Giftcard#" null="#YesNoFormat(NOT len(Giftcard))#">,
<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Delivery#" null="#YesNoFormat(NOT len(Delivery))#">,
<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Comments#" null="#YesNoFormat(NOT len(Comments))#">,
<!--- Custom textbox fields --->
<cfloop index="x" from="1" to="3">
	<cfset entry = trim(variables['customtext' & x])>
	<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#entry#" null="#YesNoFormat(NOT len(entry))#">,
</cfloop>
<!--- Custom selectbox fields --->
<cfloop index="x" from="1" to="2">
	<cfset entry = trim(variables['customselect' & x])>
	<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#entry#" null="#YesNoFormat(NOT len(entry))#">,
</cfloop> 
<cfqueryparam cfsqltype="CF_SQL_TIMESTAMP" value="#Now()#">)
</cfquery>

