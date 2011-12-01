

<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Updates the main site settings. Called by home.admin&settings=save --->

<!--- Initialize the values received by the form --->
<cfset fieldlist="DS,sitename,Merchant,HomeCountry,MerchantEmail,Webmaster,DefaultImages,Editor,MoneyUnit,InvLevel,WeightUnit,SizeUnit,ItemSort,OrderButtonText,OrderButtonImage,collectionname,locale,metadescription,keywords,email_server,email_port,email_user,email_pass,sitelogo,Default_Fuseaction,CurrExchange,CurrExLabel">	
	
<!--- Set text fields defaults to blanks --->		
<cfloop list="#fieldlist#" index="counter">
	<cfparam name="attributes.#counter#" default="">
</cfloop>

<cfset fieldlist="ShowInStock,OutofStock,ShowRetail,UseSES,UseVerity,CColumns,PColumns,MaxProds,prodRoot,CachedProds,featureRoot,maxFeatures,color_id,admin_new_window,wishlists">	
	
<!--- Set numeric field defaults to 0 --->		
<cfloop list="#fieldlist#" index="counter">
	<cfparam name="attributes.#counter#" default="0">
</cfloop>


<!--- Change carriage returns to HTML breaks --->
<cfset HTMLBreak = Chr(60) & 'br/' & Chr(62)>
<cfset LineBreak = Chr(13) & Chr(10)>
<cfset attributes.Merchant = Replace(Trim(attributes.Merchant), LineBreak, HTMLBreak & LineBreak, "ALL")>

<cfset attributes.CColumns = iif(attributes.CColumns LTE 1, 1, "#attributes.CColumns#")>
<cfset attributes.PColumns = iif(attributes.PColumns LTE 1, 1, "#attributes.PColumns#")>



<cfif NOT isNumeric(Trim(attributes.MaxProds))>
	<cfset attributes.MaxProds = 9999>
<cfelse>
	<cfset attributes.MaxProds = attributes.MaxProds>
</cfif>

<cfif NOT isNumeric(Trim(attributes.maxFeatures))>
	<cfset attributes.maxFeatures = 9999>
<cfelse>
	<cfset attributes.maxFeatures = attributes.maxFeatures> 
</cfif>

<!--- If MySQL, replace backslashes in the filepath --->
<!--- <cfif Request.dbtype IS "MySQL">
	<cfset attributes.FilePath = Replace(attributes.FilePath, "\", "\\", "All")>
</cfif> --->

<!--- Check for email server username and password. Put onto the server address for proper authentication --->
<cfif len(attributes.email_user) AND len(attributes.email_pass)>
	<cfset attributes.email_server = "#attributes.email_user#:#attributes.email_pass#@#attributes.email_server#">
</cfif>

<cfquery name="EditSettings" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
UPDATE #Request.DB_Prefix#Settings
SET 
SiteName = '#attributes.sitename#',
SiteLogo = '#attributes.sitelogo#',
Merchant = '#attributes.Merchant#',
HomeCountry = '#attributes.HomeCountry#',
Locale = '#attributes.Locale#',
MerchantEmail = '#attributes.MerchantEmail#',
Email_Server = '#attributes.email_server#',
Email_Port = <cfif len(attributes.email_port)>#attributes.email_port#,<cfelse>NULL,</cfif>
Webmaster = '#attributes.Webmaster#',
<!--- Editor = '#attributes.Editor#', --->
DefaultImages = '#attributes.DefaultImages#',
<!--- FilePath = '#attributes.FilePath#',
MimeTypes = '#attributes.MimeTypes#', --->
MoneyUnit = '#Trim(attributes.MoneyUnit)#',
WeightUnit = '#Trim(attributes.WeightUnit)#',
SizeUnit = '#Trim(attributes.SizeUnit)#',
InvLevel = '#attributes.InvLevel#',
ShowRetail = #attributes.ShowRetail#,
ShowInStock = #attributes.showinstock#,
OutofStock = #attributes.OutofStock#,
CurrExchange = '#attributes.CurrExchange#',
CurrExLabel = <cfif len(attributes.CurrExLabel)>'#Trim(attributes.CurrExLabel)#',<cfelse>NULL,</cfif>
ItemSort = '#attributes.ItemSort#',
OrderButtonText = '#Trim(attributes.OrderButtonText)#',
OrderButtonImage = '#Trim(attributes.OrderButtonImage)#',
UseSES = #attributes.UseSES#,
UseVerity = #attributes.UseVerity#,
Metadescription = <cfif len(attributes.metadescription)>'#Trim(metadescription)#',<cfelse>NULL,</cfif>
Keywords = <cfif len(attributes.keywords)>'#Trim(keywords)#',<cfelse>NULL,</cfif>
CollectionName = '#attributes.CollectionName#',
CColumns = <cfif len(Attributes.CColumns) AND Attributes.CColumns GTE 1>#Attributes.CColumns#,<cfelse>1,</cfif>
PColumns = <cfif len(Attributes.PColumns) AND Attributes.PColumns GTE 1>#Attributes.PColumns#,<cfelse>1,</cfif>
ProdRoot = <cfif len(attributes.prodRoot)>#attributes.prodRoot#,<cfelse>NULL,</cfif>
MaxProds = <cfif len(attributes.MaxProds)>#attributes.MaxProds#,<cfelse>NULL,</cfif>
CachedProds = #attributes.CachedProds#,
FeatureRoot = <cfif len(attributes.featureRoot)>#attributes.featureRoot#,<cfelse>NULL,</cfif>
MaxFeatures = <cfif len(attributes.maxFeatures)>#attributes.maxFeatures#,<cfelse>NULL,</cfif>
Admin_New_Window = #attributes.admin_new_window#,
Wishlists = #attributes.wishlists#,
Color_ID = #Attributes.Color_ID#,
Default_Fuseaction =  <cfif len(attributes.Default_Fuseaction)>'#attributes.Default_Fuseaction#'<cfelse>NULL</cfif>
</cfquery>


<!--- Turn on Shipping for Home Country --->
<cfquery name="EditShipping" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	UPDATE #Request.DB_Prefix#Countries
	SET Shipping = 1
	WHERE Abbrev = '#ListGetAt(attributes.HomeCountry,1,"^")#'
</cfquery>

<!--- Get New Settings --->
<cfset Request.Cache = CreateTimeSpan(0, 0, 0, 0)>
<cfinclude template="../../queries/qry_getsettings.cfm">
<cfinclude template="../../queries/qry_getcolors.cfm">
<cfinclude template="../../queries/qry_getcountries.cfm">



