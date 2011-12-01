<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Updated 04-30-2008 to use the Federal Exchange Rates --->
<!--- http://www.newyorkfed.org/markets/fxrates/WebService/v1_0/FXWS.wsdl --->

<!--- Get List of Locales --->
<cfinclude template="../queries/qry_getlocales.cfm">

<!--- Displays a price in multiple currencies. Assumes incoming number in local currency.

price: 		price in site default currency
country: 	country name to calculate exchange rate for
type: 		local|international
RateHrs:	HOURS before the currency exchange rate expire
--->
<cfparam name="attributes.RateHrs" default="24">
<cfparam name="attributes.country" default="US">
<cfparam name="attributes.price" default="0">
<cfparam name="attributes.type" default="local">
<cfparam name="attributes.Refresh" default="no">

<!--- Translate Country to Locale --->
<cfquery name="getnewLocale" dbtype="query">
	SELECT Name FROM GetLocales
	WHERE CurrExchange LIKE '#attributes.country#'
</cfquery>

<cfset locale = getnewLocale.Name>

<!--- 1) Create application exchange rates if they do not exist. --->
<cfif not structKeyExists(application,"ExchangeRates") OR attributes.Refresh>
	<cfset application.ExchangeRates = structNew()>
</cfif>

<!--- 2) Check if THIS exchange rate exists --->
<cfif not structKeyExists(application.ExchangeRates,locale)>
	<cfset application.ExchangeRates[locale] = structNew()>
	<cfset application.ExchangeRates[locale].rate = 1>
	<cfset application.ExchangeRates[locale].date = ''>
</cfif>
	
<!--- 3) GET the current exchange rate if it doesn't exist OR RateHrs are past --->
<cfif application.ExchangeRates[locale].date is '' OR DateAdd('h',attributes.RateHrs,application.ExchangeRates[locale].date) lt now()>

	<!--- Get Currency Code for current and new Locales --->
	<cfset localCurr = Left(LSCurrencyFormat(10, "international"),3)>
	<cfset newlocale = SetLocale(locale)>
	<cfset newCurr = Left(LSCurrencyFormat(10, "international"),3)>
	
	<cftry>
		
		<cfinvoke webservice="http://www.newyorkfed.org/markets/fxrates/WebService/v1_0/FXWS.cfc?wsdl" method="getLatestNoonRate" returnvariable="noonrate">
			<cfinvokeargument name="currency_code" value="#newCurr#" />
		</cfinvoke>
		
		<cfscript>
			excRate = XmlParse(noonrate);
			excRate = excRate.XmlRoot;
			FindRate = XMLSearch(excRate, "//frbny:OBS_VALUE/");
			theRate = FindRate[1].XMLText;
			FindCurr = XMLSearch(excRate, "//frbny:CURR/");
			theCurr = FindCurr[1].XMLText;
			
			//check if the rate is returned in USD, if not convert
			if (theCurr IS NOT "USD") {
				theRate = 1/theRate;
			}
		</cfscript>
		
		<!--- If the local currency is not US, perform the additional calculations --->
		<cfif localCurr IS NOT "USD">
			
			<cfinvoke webservice="http://www.newyorkfed.org/markets/fxrates/WebService/v1_0/FXWS.cfc?wsdl" method="getLatestNoonRate" returnvariable="noonrate2">
				<cfinvokeargument name="currency_code" value="#localCurr#" />
			</cfinvoke>
			
			<cfscript>
				excRate2 = XmlParse(noonrate2);
				excRate2 = excRate2.XmlRoot;
				FindRate2 = XMLSearch(excRate2, "//frbny:OBS_VALUE/");
				theRate2 = FindRate2[1].XMLText;
				FindCurr2 = XMLSearch(excRate2, "//frbny:CURR/");
				theCurr2 = FindCurr2[1].XMLText;
				
				//check if the rate is returned in USD, if so, convert as we need the inverse
				if (theCurr2 IS "USD") {
					theRate2 = 1/theRate2;
				}
			</cfscript>
			
			<!--- Convert the original USD rate to desired rate --->
			<cfset theRate = (theRate * theRate2)>
		
		</cfif>
	
		<cfset application.ExchangeRates[locale].rate = theRate>
		<cfset application.ExchangeRates[locale].date = now()>	
	
	<cfcatch>
	<cfthrow message="Currency exchange rate not available." type="service_timeout">
	</cfcatch>
	</cftry>
   
</cfif>

<!--- 4) Calculate  --->
<cfset newNumber = attributes.price * application.ExchangeRates[locale].rate>

<!---
<cfoutput>#newNumber# = #attributes.price# * #application.ExchangeRates[attributes.locale].rate#</cfoutput>
--->

<!--- 5) Format the number --->
<cfset newlocale = SetLocale(locale)>

<cfset temp = setvariable("caller.#attributes.country#_Price", LSCurrencyFormat(newNumber, attributes.type))>

<cfset done = SetLocale(request.appsettings.locale)>

