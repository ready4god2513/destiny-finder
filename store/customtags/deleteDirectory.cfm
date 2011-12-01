<!---
	
	This library is part of the Common Function Library Project. An open source
	collection of UDF libraries designed for ColdFusion 5.0. For more information,
	please see the web site at:
		
		http://www.cflib.org
		
	Warning:
	You may not need all the functions in this library. If speed
	is _extremely_ important, you may want to consider deleting
	functions you do not plan on using. Normally you should not
	have to worry about the size of the library.
		
	License:
	This code may be used freely. 
	You may modify this code as you see fit, however, this header, and the header
	for the functions must remain intact.
	
	This code is provided as is.  We make no warranty or guarantee.  Use of this code is at your own risk.
--->

<!---
 Recursively delete a directory.
 
 @param directory 	 The directory to delete. (Required)
 @param recurse 	 Whether or not the UDF should recurse. Defaults to false. (Optional)
 @return Return a boolean. 
 @author Rick Root (&#114;&#105;&#99;&#107;&#64;&#119;&#101;&#98;&#119;&#111;&#114;&#107;&#115;&#108;&#108;&#99;&#46;&#99;&#111;&#109;) 
 @version 1, July 28, 2005 
--->
<cffunction name="deleteDirectory" returntype="boolean" output="false">
	<cfargument name="directory" type="string" required="yes" >
	<cfargument name="recurse" type="boolean" required="no" default="false">
	
	<cfset var myDirectory = "">
	<cfset var count = 0>

	<cfif right(arguments.directory, 1) is not Request.Slash>
		<cfset arguments.directory = arguments.directory & Request.Slash>
	</cfif>
	
	<cfdirectory action="list" directory="#arguments.directory#" name="myDirectory">

	<cfloop query="myDirectory">
		<cfif myDirectory.name is not "." AND myDirectory.name is not "..">
			<cfset count = count + 1><!--- <cfdump var="#myDirectory#"> --->
			<cfswitch expression="#myDirectory.type#">
			
				<cfcase value="dir">
					<!--- If recurse is on, move down to next level --->
					<cfif arguments.recurse>
						<cfset deleteDirectory(arguments.directory & myDirectory.name, arguments.recurse )>
					</cfif>
				</cfcase>
				
				<cfcase value="file">
					<!--- delete file --->
					<cfif arguments.recurse>
						<cffile action="delete" file="#arguments.directory##myDirectory.name#">
					</cfif>
				</cfcase>			
			</cfswitch>
		</cfif>
	</cfloop>
	<cfif count is 0 or arguments.recurse>
		<cfdirectory action="delete" directory="#arguments.directory#">
	</cfif>
	<cfreturn true>
</cffunction>
