<h1>Server details</h1>
<cfdump var="#server#">
<h1>File Output Test</h1>
<!--- create a java file object --->
<cfset outFile = CreateObject("java", "java.io.File")>
<!--- path to the file we want to write --->
<cfset tempOutputFile = "#ExpandPath(".")#\#createUUID()#.txt">
<!--- initialize the file object with the path --->
<cfset outFile.init(tempOutputFile)>
<!--- can java write to this file? --->
<cfif NOT outFile.canWrite()>
        <!--- have coldfusion write to the file --->
        <cffile action="WRITE" file="#tempOutputFile#" output="This file was
written by Coldfusion using CFFILE">
        <!--- throw an error now, since coldfusion successfully wrote to the file --->
        <h3>Permission Problem</h3>
        <p>The canWrite() method of java's file object says it cannot write
to the file,
        but coldfusion had no problem.</p>
        <cfoutput><p>File: <a
href="#getFileFromPath(tempoutputfile)#">#getFileFromPath(tempoutputfile)#</a></p></cfoutput>
<cfelse>
        <h3>Java can write to this file!</h3>
        <cfoutput>#tempOutputFile#</cfoutput>
</cfif>