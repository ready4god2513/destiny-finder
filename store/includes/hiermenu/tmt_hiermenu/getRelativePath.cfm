<!--- 
/** 
* 
Return the relative path from startPath to destinationPath.
Paths can be system paths (C:\myroot\mydir\myfile.cfm) or url (http://www.mydomain/myfile.cfm).
Different kinds of paths (system and url) can't be mixed
* @access      public
* @output      suppressed 
* @param       startPath (string)            Required. Full starting path
* @param       destinationPath (string)      Required. Full destination path
* @return      string
* @author      Massimo Foti (massimo@massimocorner.com)
* @version     2.1, 2005-04-05
 */
  --->
<cffunction name="getRelativePath" access="public" output="false" returntype="string" hint="
Return the relative path from startPath to destinationPath.
Paths can be system paths (C:\myroot\mydir\myfile.cfm) or url (http://www.mydomain/myfile.cfm).
Different kinds of paths (system and url) can't be mixed">
	<cfargument name="startingPath" type="string" required="true" hint="Full starting path">
	<cfargument name="destinationPath" type="string" required="true" hint="Full destination path">
	<cfscript>
	// In case we have absolute local paths, turn backward to forward slashes
	var startPath = Replace(arguments.startingPath, "\","/", "ALL"); 
	var endPath = Replace(arguments.destinationPath, "\","/", "ALL"); 
	// Declare variables
	var i = 1;
	var j = 1;
	var endStr = "";
	var endBase = "";
	var commonStr = "";
	var retVal = "";
	var whatsLeft = "";
	var slashPos = "";
	var slashCount = 0;
	var dotDotSlash = "";
	// Be sure the paths aren't equal
	if(startPath NEQ endPath){
		// If the files are both inside the same base directory
		if(GetDirectoryFromPath(startPath) EQ GetDirectoryFromPath(endPath)){
			// It's a special case, we are done already
			return GetFileFromPath(endPath);
		}
		// If the starting path is longer, the destination path is our starting point
		if(Len(startPath) GT Len(endPath)){
			endStr = Len(endPath);
			endBase = GetDirectoryFromPath(endPath);
		}
		// Else the start path is the starting point
		else{
			endStr = Len(startPath);
			endBase = GetDirectoryFromPath(startPath);
		}
		// Check if the two paths share a base path and store it into the commonStr variable
		for(i;i LT endBase; i=i+1){
			// Compare one character at time
			if(Mid(startPath, i, 1) EQ Mid(endPath, i, 1)){
				commonStr = commonStr & Mid(startPath, i, 1);
			}
			else{
				break;
			}
		}
		// We just need the common base directory
		commonStr = GetDirectoryFromPath(commonStr);	
		// If there is a common base path, remove it
		if(Len(commonStr) GT 0){
			whatsLeft = Mid(startPath, Len(commonStr)+1, Len(startPath));
		}
		else{
			whatsLeft = startPath;
		}
		slashPos = Find("/", whatsLeft);
		// Count how many directories we have to climb
		while(slashPos NEQ 0){
			slashCount = slashCount + 1;
			slashPos = Find("/", whatsLeft, slashPos+1);
		}
		// Append "../" for each directory we have to climb
		for(j;j LTE slashCount; j=j+1){
			dotDotSlash = dotDotSlash & "../";
		}
		// Assemble the final path
		retVal = dotDotSlash & Mid(endPath, Len(commonStr)+1, Len(endPath));
	}
	// Paths are the same
	else{
		retVal = "";
	}
	return retVal;
	</cfscript>
</cffunction>