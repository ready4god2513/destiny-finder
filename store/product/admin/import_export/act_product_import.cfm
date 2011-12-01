
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Process the file import. Called by product.admin&do=doimport --->

<cfif isDefined("attributes.submit_import")>

	<cfparam name="attributes.cid_list" default="">

	<cfscript>
		attributes.error_message = "";
		fieldlist = "";
		fieldtypes = "";
		importArray = ArrayNew(1);
		
		// Determine the column list 
		for (num=1; num lte 30; num=num+1) {
			colInfo = Evaluate("attributes.Field_#num#");
			if (len(colInfo)) {				
				colName = ListGetAt(colInfo, 1, "^");
				colType = ListGetAt(colInfo, 2, "^");
				fieldlist = ListAppend(fieldlist, colName);
				//determine the datatype
				if (ListFindNoCase('integer,tinyint', colType))
					datatype = 'integer';
				else if (ListFindNoCase('double,float', colType))
					datatype = 'double';
				else if (ListFindNoCase('bit', colType))
					datatype = 'bit';
				else if (ListFindNoCase('timestamp', colType))
					datatype = 'date';
				else 
					datatype = 'varchar';
				fieldtypes = ListAppend(fieldtypes, datatype);
			}
		}
		
		numfields = ListLen(fieldlist);
	
		// upload the csv file 
		// Determine current directory for images
		topPath = ExpandPath("*.*");
		theDirectory = GetDirectoryFromPath(topPath);
		
		theDirectory =  theDirectory & "files#request.slash#";	
	</cfscript>
	
	<!--- Remove old uploads --->
	<cftry>
		<cfdirectory action="LIST" directory="#theDirectory#" name="csv_list" sort="datelastmodified" filter="*.csv">
	
		<cfloop query="csv_list">
			<cfif csv_list.datelastModified lt dateAdd('n',-9,now())>
				<cffile action="DELETE" file="#theDirectory##csv_list.name#">
			</cfif>
		</cfloop>
		
		<cffile action="UPLOAD" filefield="importcsv" destination="#theDirectory#" nameconflict="MAKEUNIQUE" accept="text/csv,application/vnd.ms-excel">
		
		<!--- read in the csv file --->
		<cffile action="READ" file="#theDirectory##File.ServerFile#" variable="importdata">
	
	<cfcatch>
		<cfset attributes.error_message = "There was an error uploading the file to the server. You may not have permissions to the upload directory, or CFFILE and/or CFDIRECTORY are disabled on your server.">
	</cfcatch>
	</cftry>
	
	<cfif NOT len(attributes.error_message)>
	
		<cftry>
			<cfscript>	
				LineDelims = chr(13) & chr(10);
				
				FileContent = Replace(importdata, ",,", ", ,", "all");
				
				FileContentLines = ListToArray(FileContent, LineDelims);
				FileContentLength = ArrayLen(FileContentLines);
				 
				// Now loop through each record, dropping the header row if used 
				for (i=1; i lte FileContentLength; i=i+1) { 
					if (i IS NOT 1 OR attributes.headers IS "no") {
						RowData = ParseCSV(FileContentLines[i]);
						// Add the returned array to the array to import 
						ArrayAppend(importArray, RowData);
					}
				}	
				
				//convert the array of arrays to a query
				qryImport = arrayOfArraysToQuery(importArray, fieldlist);
			</cfscript>
				
			<!--- Convert to WDDX to pass on to the following page --->
			<cfwddx action="CFML2WDDX" input="#qryImport#" output="passinfo">
			
			<!--- <cffile action="DELETE" file="#Directory##File.ServerFile#"> --->
	
		<cfcatch>
		<cfset attributes.error_message = "There was an error parsing the CSV file. Please make sure your csv file is properly formed and you have selected the right database fields to import.">
		</cfcatch>
		</cftry>
	
	</cfif>
	
</cfif>