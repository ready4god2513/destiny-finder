

<cfscript>

function ParseCSV(lstCSV) {

/*
Object:  	ParseCSV

Purpose:	Include to parse a CSV string named lstCSV and return in array
named aryCSV

Author:		Andy Ousterhout(ACO)

Date:		3/3/2002

Version:	V1.0

Usage:	CSV files have fields in a record separated by commas, ",".  However,
if a text field contains an embededd comma, the entire field is placed in
double quotes.  For example,

	00007,"Bear, Swimming",Test
	00008,"Frank ""The Animal"" Hooter", testing
	00009, Testing, "Frank ""The Animal"" Hooter"

	Should each result in 3 fields being parsed.


Change Record:
Who:		When:		Why:

*/

aryCSV = ArrayNew(1);

// Only do stuff if something passed ....
if (len(lstCSV) GT 0) {

// First, add a comma onto the end so that the search for ", and not "", always finds something unless bad CSV string.
// Then, replace any ",," with ", ," so that individual array elements will be found
// Last, replace any empty strings ("") with (" ") so they will be found

lstWork = Trim(lstCSV) & ",";
lstWork = replace(lstWork, ",", ", ", "ALL");
lstWork = replace(lstWork, """""", """ """, "ALL");

// Then loop thru string, parsing off to next comma and checking if complete field
// Note that if the field has imbedded quotes, this routine will create bad data.
// For example, [This is a test, "test"] will come through as ["This is a test, ""test""]
// and will be parsed into two fields, [This is a test, "] and ["test"]. The calling routine will
// need to handle the possibility that more fields will be returned then expected.

Do {

	// If Line starts with quote, next field is next quote+comma that is not part of a quote+quote+comma

		if (left(lstWork, 1) EQ '"') {
			tmpStr = Right(lstWork, len(lstWork)-1);
			EndPos = REFInd('([^"]",) | ("*"",)', tmpStr);

			// If nothing found, look for "", ending
			if (EndPos EQ 0) {
				EndPos=REFInd('([^"]",) | (["]*["",])', tmpStr);
				EndPos=REFInd('("",)', Mid(tmpStr, EndPos+1, len(tmpStr)))+EndPos;
			}

			// If still nothing found, Error.  Stop work immediately
			if (EndPos EQ 0) {
				lstwork = "";
				NextField = "";
			}
			Else {
				NextField = mid(trim(lstWork), 2, EndPos);
				if (len(lstWork)-(EndPos+2) EQ 0)
					lstwork = "";
				else
					lstWork = ltrim(right(lstWork, len(lstWork)-(EndPos+3)));
			}
		}
		else if (left(lstwork, 1) EQ ",") {
			lstWork = ltrim(right(lstWork, len(lstWork)-1));
			NextField = " ";
		}
		else {
			NextField = Trim(ListFirst(lstWork, ","));
			lstWork = LTrim(ListDeleteAt(lstWork, 1, ","));
		}

		//Append the new field, converting CSV's double quotes to single quotes
		ArrayAppend(aryCSV, Replace(NextField, '""', '"', "all"));
		//writeoutput(",[#lstwork#], [#NextField#]");
	}
	while (len(lstWork) GT 1);
}

return aryCSV;

}
</cfscript>




<cfscript>
/**
 * Converts an array of arrays to a CF Query Object.
 * 
 * @param Array 	 The array of arrays to be converted to a query object.  Assumes each array element contains array with same elements (Required)
 * @param fieldlist	 List of the fields for the array (Required)
 * @return Returns a query object. 
 * @author Mary Jo Sminkey (maryjo@cfwebstore.com) 
 */
function arrayOfArraysToQuery(theArray,fieldlist){
	var theQuery = queryNew(fieldlist);
	var i=0;
	var j=0;
	//if there's nothing in the array, return the empty query
	if(NOT arrayLen(theArray))
		return theQuery;
	//get the column names into an array =
	colNames = ListtoArray(fieldlist);
	//add the right number of rows to the query
	queryAddRow(theQuery, arrayLen(theArray));
	//for each element in the array, loop through the columns, populating the query
	for(i=1; i LTE arrayLen(theArray); i=i+1){
		rowData = theArray[i];
		for(j=1; j LTE arrayLen(colNames); j=j+1){
			querySetCell(theQuery, colNames[j], rowData[j], i);
		}
	}
	return theQuery;
}
</cfscript>



<!--- Not needed, now in the global functions for the store --->
<!--- <cfscript>
/**
 * Makes a row of a query into a structure.
 * 
 * @param query 	 The query to work with. 
 * @param row 	 Row number to check. Defaults to row 1. 
 * @return Returns a structure. 
 * @author Nathan Dintenfass (nathan@changemedia.com) 
 * @version 1, December 11, 2001 
 */
function queryRowToStruct(query){
	//by default, do this to the first row of the query
	var row = 1;
	//a var for looping
	var ii = 1;
	//the cols to loop over
	var cols = listToArray(query.columnList);
	//the struct to return
	var stReturn = structnew();
	//if there is a second argument, use that for the row number
	if(arrayLen(arguments) GT 1)
		row = arguments[2];
	//loop over the cols and build the struct from the query row
	for(ii = 1; ii lte arraylen(cols); ii = ii + 1){
		stReturn[cols[ii]] = query[cols[ii]][row];
	}		
	//return the struct
	return stReturn;
}
</cfscript> --->

