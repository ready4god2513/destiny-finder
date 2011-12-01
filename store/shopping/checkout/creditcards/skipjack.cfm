<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Skipjack custom tag --->

<cfparam name="attributes.CVV2" default="">

<cfinclude template="../../../product/admin/import_export/import_functions.cfm">

<cfset amount = DecimalFormat(attributes.amount)>
 
		<cfhttp url="#attributes.ccserver#" method="post">
		
			<!--- Required Fields --->
			<cfhttpparam name="Serialnumber" TYPE="FormField" VALUE="#attributes.UniqueID#">
			<cfhttpparam name="Transactionamount" TYPE="FormField" value="#amount#">
			<cfhttpparam name="Orderstring" TYPE="FormField" value="1~1~0.00~1~N~||">
			<cfhttpparam name="Ordernumber" TYPE="FormField" value= "#attributes.invoicenum#">
			<cfhttpparam name="sjname" TYPE="FormField" value="#attributes.nameoncard#">
			<cfhttpparam name="Email" TYPE="FormField" value="#attributes.email#">
			<cfhttpparam name="Streetaddress" TYPE="FormField" value="#attributes.address#">
			<cfhttpparam name="City" TYPE="FormField" value="#attributes.city#">
			<cfhttpparam name="State" TYPE="FormField" value="#attributes.state#">
			<cfhttpparam name="Zipcode" TYPE="FormField" value="#attributes.zip#">
			<cfhttpparam name="Accountnumber" TYPE="FormField" value="#attributes.cardnumber#">
			<cfhttpparam name="Month" TYPE="FormField" value="#attributes.month#">
			<cfhttpparam name="Year" TYPE="FormField" value="#attributes.year#">
			<cfhttpparam name="Shiptophone" TYPE="FormField" value="#attributes.shiptophone#">
			
			<!--- Optional Fields --->
			<cfhttpparam name="CVV2" TYPE="FormField" value="#attributes.CVV2#">

		</cfhttp>

<!--- Parse content from skipjack return post --->

<cfscript>
	ParsedResults = StructNew();
	ParsedResults.Message = '';
	
	LineDelims = chr(13) & chr(10);
	FileContentLines = ListToArray(CFHTTP.FileContent, LineDelims);
	
	//Make sure we found a two-line CSV
	if (ArrayLen(FileContentLines) LT 2 OR NOT FindNoCase("AuthCode",CFHTTP.FileContent)) {
		ParsedResults.Message = CFHTTP.FileContent;
		}
	else {
		// Now get the list of headers and the cooresponding data
		HeaderData = ParseCSV(FileContentLines[1]);
		ReturnData = ParseCSV(FileContentLines[2]);
		
		//Save into structure of values
		for (i=1; i lte ArrayLen(HeaderData); i=i+1) { 
		// get variable name
		VarName = HeaderData[i];
		if (Left(VarName,2) IS "sz") {
			VarName = Right(VarName, Len(VarName)-2);
			}
		StructInsert(ParsedResults, VarName, ReturnData[i]);	
		}
	
	}
	
</cfscript>


<!---  <cfoutput>#HTMLEditFormat(CFHTTP.FileContent)#</cfoutput>  --->

<!----------------------------------------------------------------------
	Set caller query object
  ---------------------------------------------------------------------->
<cfset "Caller.#attributes.queryname#" = ParsedResults>


