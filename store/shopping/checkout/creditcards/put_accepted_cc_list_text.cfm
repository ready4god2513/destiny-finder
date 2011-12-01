
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays a list of the credit cards allowed. Not currently in use --->

<!--- Get list of credit cards --->
<cfquery name="GetCards" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
SELECT CardName FROM #Request.DB_Prefix#CreditCards
WHERE Used = 1
</cfquery>

<!--- Make comma-separated list of card names --->
<cfset CardList = ValueList(GetCards.CardName)>
<!--- Determine number of cards --->
<cfset Num = GetCards.RecordCount>
<!--- Get Last card name --->
<cfset LastCard = ListGetAt(CardList, Num)>
<!--- Get second to last card name --->
<cfset SecLastCard = ListGetAt(CardList, Num-1)>
<!--- Remove last card name from list --->
<cfset CardList = ListDeleteAt(CardList, Num)>
<!--- Set last item in list to last two card names separated by "and" --->
<cfset CardList = ListSetAt(CardList, Num-1, SecLastCard & " and " & LastCard)>
<!--- Replace commas with commas and spaces --->
<cfset CardList = Replace(CardList, ",", ", ", "ALL")>

<!--- Output result --->
<cfoutput>#CardList#</cfoutput>


