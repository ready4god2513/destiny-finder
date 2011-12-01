<cfscript>
/**
 * CSVFormat accepts the name of an existing query and converts it to csv format.
 * Updated version of UDF orig. written by Simon Horwith
 * 
 * @param query 	 The query to format. 
 * @param qualifer 	 A string to qualify the data with. 
 * @param columns 	 The columns ot use. Defaults to all columns. 
 * @return A CSV formatted string. 
 * @author Jeff Howden (jeff@members.evolt.org) 
 * @version 2, December 3, 2001 
 * modified November 16, 2006 by Mary Jo Sminkey for CFWebstore
 */
function CSVFormat(query)
{
  var returnValue = ArrayNew(1);
  var rowValue = '';
  var columns = query.columnlist;
  var datatypes = query.columnlist;
  var qualifier = '';
  var i = 1;
  var j = 1;
  if(ArrayLen(Arguments) GTE 2 AND Len(Arguments[2])) columns = Arguments[2];
  if(ArrayLen(Arguments) GTE 3 AND Len(Arguments[3])) datatypes = Arguments[3];
  if(ArrayLen(Arguments) GTE 4) qualifier = Arguments[4];
  
  returnValue[1] = columns;
  ArrayResize(returnValue, query.recordcount + 1);
  columns = ListToArray(columns);
  datatypes = ListToArray(datatypes);
  for(i = 1; i LTE query.recordcount; i = i + 1)
  {
    rowValue = ArrayNew(1);
    ArrayResize(rowValue, ArrayLen(columns));
    for(j = 1; j LTE ArrayLen(columns); j = j + 1)
    	if (datatypes[j] IS 'varchar') 
      		rowValue[j] = qualifier & query[columns[j]][i] & qualifier;
      	else
      		rowValue[j] = query[columns[j]][i];
    returnValue[i + 1] = ArrayToList(rowValue);
  }		
  returnValue = ArrayToList(returnValue, Chr(13));
  return returnValue;
}
</cfscript>
