
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Performs the updates from the List Edit Form for Giftwraps. Called by Giftwrap.admin&do=actform --->

<cfloop index="Giftwrap_ID" list="#attributes.GiftwrapList#">

<cfset Price = Evaluate("attributes.Price#Giftwrap_ID#")>
<cfset Priority = Evaluate("attributes.Priority#Giftwrap_ID#")>
<cfset Display = iif(isDefined("attributes.Display#Giftwrap_ID#"),1,0)>

<cfif NOT len(Trim(Price))>
	<cfset Price = 0>
<cfelse>
	<!--- Replaced for Blue Dragon:
	<cfset Price = LSParseNumber(Price)> --->
	<cfset Price = Price> 
</cfif>

<cfif NOT isNumeric(Priority) OR Priority IS 0>
	<cfset Priority = 9999>
</cfif>

<cfquery name="UpdateGiftwrap" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
UPDATE #Request.DB_Prefix#Giftwrap
	SET Price = #Price#,
	Priority = #Priority#,
	Display = #Display#
	WHERE Giftwrap_ID = #Giftwrap_ID#
</cfquery>

</cfloop>



