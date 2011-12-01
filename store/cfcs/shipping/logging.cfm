<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Developed for use with CFWebstore e-commerce (www.cfwebstore.com) --->

<!--- Requires CFMX 6 or higher --->

<!--- This code is owned by Dogpatch Software and may not be distributes or reused without permission --->


<!-------------------- BEGIN LOGGING FUNCTION ----------------------------->
<cffunction name="LogXML" returntype="boolean" hint="Used to log XML transactions to a file." access="package" output="No">

<cfargument name="stringin" default="" required="Yes">
<cfargument name="logfile" default="" required="Yes">
<cfargument name="type" default="Request Sent" required="No">

	<cfscript>
		var success = 1;
		var stringtoadd = '';
		var DateStamp = DateFormat(Now(), "mm/dd/yyyy");
		
		DateStamp = DateStamp & " " & Timeformat(Now(), "HH:mm") & Chr(10);		
		stringtoadd = UCase(arguments.type) & " #DateStamp#";
		stringtoadd = stringtoadd & Trim(arguments.stringin) & Chr(10);

	</cfscript>
	
	<cftry> 
		<cffile action="APPEND" file="#arguments.logfile#" output="#stringtoadd#" addnewline="Yes">
	<cfcatch>success = 0;</cfcatch>
	</cftry>	
	

<cfreturn success>

</cffunction>
<!-------------------- END LOGGING FUNCTION ----------------------------->
