<cfsetting enablecfoutputonly="yes"><cfprocessingdirective suppresswhitespace="Yes">
<!--- -->
<fusedoc fuse="FBX_fusebox30_CF50_lite.CFM" specification="2.0">
	<responsibilities>
		I am an FB3-style core file that implements a subset of the FB3 Standard API.
	</responsibilities>
	<properties>
		<property name="version" value="3.0 Lite" />
		<property name="build" value="0.99 Beta" />
		<history author="John Quarto-vonTivadar" date="27 Sep 2001" email="jcq@mindspring.com">Portions of code contributed by Steve Nelson, Hal Helms, Jeff Peters, Nat Papovich, Patrick McElhaney, Fred Sanders, Bill Wheatley and Stan Cox.</history>
		<history author="Nat Papovich" date="Oct 2001" email="mcnattyp@yahoo.com" type="Update">Converted to cfscripting, bug fixes for final release.</history>
		<history author="Nat Papovich" date="Nov 2001" email="mcnattyp@yahoo.com" type="Update" />
		<history author="Lee Bjork Borkman" date="Aug 2002" email="bjork@bjork.net" type="Update">Optimizing for performance, preserving all API variables</history>
	</properties>
		<history author="Lee Bjork Borkman" date="10 Aug 2002" email="bjork@bjork.net" type="Update">Fixed a few incompatibilities and inconsistencies.  Thanks, Nat.</history>
		<history author="Lee Bjork Borkman" date="10 Aug 2002" email="bjork@bjork.net" type="Update">Another minor optimisation following the compatibility fixes</history>
		<history author="Lee Bjork Borkman" date="11 Aug 2002" email="bjork@bjork.net" type="Update">Added the runAction() function for easing the immediate-execution calls.  Thanks Bert Dawson and Patrick McElhaney</history>
		<history author="Lee Bjork Borkman" date="11 Aug 2002" email="bjork@bjork.net" type="Update">Now sets rootPath and currentPath variables without the redundant "./", so these values are now the same as those produced by the Fusebox.org core.</history>
		<history author="Lee Bjork Borkman" date="11 Aug 2002" email="bjork@bjork.net" type="Update">Now sets API variables BEFORE running the home fbx_settings, if possible.</history>
		<history author="Lee Bjork Borkman" date="11 Aug 2002" email="bjork@bjork.net" type="Update">Now fixes the bug in which the Home circuit never has IsTargetCircuit=TRUE.</history>
		<history author="Lee Bjork Borkman" date="11 Aug 2002" email="bjork@bjork.net" type="Update">Removed support for several FB3 API variables in order to make Lite and fast core.</history>
	</properties>
	<io>
		<out>
			<structure name="fusebox" scope="variables" comments="this is the public API of variables that should be treated as read-only">
				<boolean name="isHomeCircuit" default="FALSE" />
				<boolean name="isTargetCircuit" default="FALSE" />
				<string name="fuseaction" comments="will be assigned a literal value of 'fusebox.defaultfuseaction' if attributes.fuseaction comes in as 'circuit.' with no fuseaction passed." />
				<string name="homeCircuit" />
				<string name="targetCircuit" />
				<string name="thisLayoutPath" />
				<boolean name="suppressErrors" default="FALSE" />
				<string name="currentPath" />
				<string name="rootPath" />
			</structure>
			<structure name="FB_" comments="Internal use only. Please treat the FB_ as a reserved structure, not to be touched.">
			</structure>
		</out>
	</io>
</fusedoc> 
--->


<!--- Initialize API and internal variables --->
<cfscript>
    fusebox = structNew();
    fusebox.IsHomeCircuit=TRUE;
    fusebox.IsTargetCircuit=FALSE;
    fusebox.thislayoutpath="";
    fusebox.suppressErrors=FALSE;
    fusebox.Circuits=structNew();
    fusebox.currentPath="";
    fusebox.rootPath="";
    
    FB_=structNew();
    FB_.patharray=arrayNew(2);
    FB_.settingsDone = FALSE;
    
    if (NOT IsDefined("attributes"))
        attributes=structNew();
    StructAppend(attributes, url, "no");
    StructAppend(attributes, form, "no");
</cfscript>

<!--- Get all circuit alias-to-path definitions --->
<cftry>
    <cfinclude template="fbx_Circuits.cfm"> 
    <cfcatch>
		<cfif fusebox.suppressErrors>
			<cfoutput>
                The fusebox framework could not find the home circuit's fbx_Circuits.cfm.
            </cfoutput>
            <cfabort>
		<cfelse>
            <cfrethrow>
        </cfif>
	</cfcatch>
</cftry>

<cfif NOT isDefined("attributes.fuseaction")>
    <!---Include the home circuit's fbx_settings, needed here to get the default attributes.fuseaction --->
    <cftry>
    	<cfinclude template="fbx_Settings.cfm">
    	<cfcatch type="missingInclude">
    		<cfif fusebox.suppressErrors>
    			<cfoutput>
                    The fusebox framework could not find the home circuit fbx_Settings.cfm.
                </cfoutput>
                <cfabort>
    		<cfelse>
                <cfrethrow>
            </cfif>
    	</cfcatch>
    </cftry>
    <cfset FB_.settingsDone=TRUE>
</cfif>

<!--- Convert the fully-qualified fuseaction into separate circuit and fuseactionaction variables--->
<cftry>
	<cfscript>
    	FB_.rawFA = attributes.fuseaction; //preserve the original fuseaction
        if (ListLen(FB_.rawFA, '.') is 2) {
    	//circuit.fuseaction specified, so set fusebox.fuseaction and fusebox.circuit
    		fusebox.fuseaction = ListLast( FB_.rawFA, '.' );
        	fusebox.targetCircuit = ListFirst( FB_.rawFA, '.');
        } else {
        	fusebox.circuit = ListFirst( FB_.rawFA, '.');
        	if (ListLen(FB_.rawFA, '.') is 1 and Right(FB_.rawFA,1) is '.')
        	//circuit only specified, no fuseaction such as "fuseaction=circuit."
        		fusebox.fuseaction = "fusebox.defaultfuseaction";
            else
        		fusebox.fuseaction = ListGetAt( FB_.rawFA, 2, '.');
                //throw a deliberate error
        }
        FB_.fullPath=ListRest(fusebox.Circuits[fusebox.targetCircuit], "/"); 
        FB_.targetDepth=ListLen(FB_.fullPath ,"/")+1;
        if (FB_.targetDepth eq 1)
            fusebox.isTargetCircuit=TRUE;
	</cfscript>
	<cfcatch>
		<!--- This error should not be suppressed. --->
		<cfoutput>
            The variable "attributes.fuseaction" is not available
            or the fusebox framework could not find the circuit you requested:
           <!---  "#fusebox.circuit#" --->.
        </cfoutput>
        <cfthrow message="#cfcatch.message#" detail="#cfcatch.detail#">
        <cfabort>
	</cfcatch>
</cftry>


<!--- Initialise API variables prior to desscent --->
<cfscript>
    FB_.currentDepth=1;
    FB_.pathArray[1][1]="";
    FB_.pathArray[1][2]="";
    fusebox.currentPath="";
    fusebox.rootPath="";
</cfscript>


<cfif NOT FB_.settingsDone>
    <!---Include the home circuit's fbx_settings, needed here to get the default attributes.fuseaction --->
    <cftry>
    	<cfinclude template="fbx_Settings.cfm">
    	<cfcatch type="missingInclude">
    		<cfif fusebox.suppressErrors>
    			<cfoutput>
                    The fusebox framework could not find the home circuit fbx_Settings.cfm.
                </cfoutput>
                <cfabort>
    		<cfelse>
                <cfrethrow>
            </cfif>
    	</cfcatch>
    </cftry>
    <cfset FB_.settingsDone=TRUE>
</cfif>



<!--- Descend through the circuits, from the home to the target --->
<cfloop list="#FB_.fullpath#" index="aPath" delimiters="/">

    <!--- Calculate internal variables and API variables as we go down --->
	<cfscript>
        FB_.currentDepth=FB_.currentDepth+1;
    	fusebox.currentPath="#fusebox.currentPath##aPath#/";
    	fusebox.IsHomeCircuit=FALSE;
    	fusebox.rootPath="#fusebox.rootPath#../";
        FB_.pathArray[FB_.currentDepth][1]=fusebox.rootPath;
        FB_.pathArray[FB_.currentDepth][2]=fusebox.currentPath;
        fusebox.IsTargetCircuit=(FB_.currentDepth EQ FB_.targetDepth);
	</cfscript>
    
    <!--- Include each circuit's fbx_settings --->
    <cftry>
        <cfinclude template="#fusebox.currentPath#fbx_Settings.cfm">		
		<cfcatch type="missingInclude">
            <cfif fusebox.suppressErrors>
    			<cfoutput>
                    I could not find #fusebox.currentPath#fbx_Settings.cfm
                    (or one of its components such as an included fuse).
                </cfoutput>
                <cfabort>
    		<cfelse>
                <cfrethrow>
            </cfif>
        </cfcatch>		
	</cftry>

</cfloop>

<!--- Include the target fbx_switch, and capture the output# --->
<cftry>
	<cfsavecontent variable="fusebox.layout">
		<cfoutput><cfinclude template="#fusebox.currentPath#fbx_Switch.cfm"></cfoutput>
	</cfsavecontent>
	<cfcatch type="missingInclude">
		<cfif fusebox.suppressErrors>
			<cfoutput>
                I could not find #fusebox.currentPath#fbx_Switch.cfm
                (or one of its components such as an included fuse) in the "#fusebox.circuit#" circuit.
            </cfoutput>
            <cfabort>
		<cfelse>
            <cfrethrow>
        </cfif>
	</cfcatch>
</cftry> 

<!--- Ascend from the target circuit up to home, adding layout wrappers --->
<cfloop index="FB_.currentDepth" from="#FB_.targetDepth#" to="1" step="-1">

        <!--- Calculate API and internal variables as we go back up --->
		<cfscript>
    		fusebox.IsTargetCircuit = (FB_.currentDepth EQ FB_.targetDepth);
    		fusebox.IsHomeCircuit=(FB_.currentDepth EQ 1);    
    		fusebox.ThisLayoutPath=FB_.pathArray[FB_.currentDepth][2];
    		fusebox.currentPath=fusebox.thislayoutpath;
    		fusebox.rootPath=FB_.pathArray[FB_.currentDepth][1];
		</cfscript>
        
        <!--- Get the location of the layout file --->
	 	<cftry> 
			<cfinclude template="#fusebox.thislayoutpath#fbx_Layouts.cfm">
	 		<cfcatch>
				<cfset fusebox.layoutfile = ""><cfset fusebox.layoutdir = "">
			</cfcatch>
	 	</cftry>
        
        <!--- Wrap this circuit's layout around the accumulating content --->
		<cftry>
			<cfif Len(fusebox.layoutfile)>
                <cfset fusebox.thislayoutpath="#fusebox.thislayoutpath##fusebox.layoutdir#">
				<cfsavecontent variable="fusebox.layout">	
					<cfoutput><cfinclude template="#fusebox.thislayoutpath##fusebox.layoutfile#"></cfoutput>
				</cfsavecontent>
			</cfif>
    		<cfcatch type="missingInclude">
    			<cfif fusebox.suppressErrors>
    				<cfoutput>
                        I could not find the layoutfile
                        #fusebox.thislayoutpath##fusebox.layoutfile#
                        specified by #fusebox.thislayoutpath#fbx_Layouts.cfm.
                    </cfoutput>
                    <cfabort>
    			<cfelse>
                    <cfrethrow>
                </cfif>
    		</cfcatch>
		</cftry>
</cfloop>

<!--- Finally, output the totally-nested layout --->
<cfoutput>#trim(fusebox.layout)#</cfoutput>

</cfprocessingdirective><cfsetting enablecfoutputonly="no">