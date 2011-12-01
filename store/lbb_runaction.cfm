<!--- -->
<fusedoc fuse="LBB_RunAction.cfm" specification="2.0">
	<responsibilities>
        I execute a given fuseaction immediately.
		I contain a subset of the FB3 core file's functionality.
        I am compatible with CF5 and later.
        This version now works with the Fusebox.org core, the FEX core, and Lee's Turbo core.
        NOTE: Neither Fusebox.org or Fusion/FEX make any claims about the compatibility of this template with their respective core files.
	</responsibilities>
	<properties>
		<property name="version" value="Standard/Turbo/Lite/FEX" />
		<property name="build" value="0.998 Beta" />
		<history author="Lee Bjork Borkman" date="09 Aug 2002" email="bjork@bjork.net" type="Create">Based upon the Lee's Turbo core file, which was in turn based on work done by John Quarto-vonTivadar, Steve Nelson, Hal Helms, Jeff Peters, Nat Papovich, Patrick McElhaney, Fred Sanders, Bill Wheatley, Erki Esken and Stan Cox.</history>
		<history author="Lee Bjork Borkman" date="10 Aug 2002" email="bjork@bjork.net" type="update">Added some conversion of FB_ internals to handle Fusebox.org core and FEX core</history>
		<history author="Lee Bjork Borkman" date="11 Aug 2002" email="bjork@bjork.net" type="update">Now includes the home fbx_settings, and initialises the complete FB3 API.</history>
		<history author="Lee Bjork Borkman" date="11 Aug 2002" email="bjork@bjork.net" type="Update">Now sets rootPath and currentPath variables without the redundant "./", so these values are now the same as those produced by the Fusebox.org core.</history>
		<history author="Lee Bjork Borkman" date="11 Aug 2002" email="bjork@bjork.net" type="Update">Now reads and destroys the nextAction variable.</history>
		<history author="Lee Bjork Borkman" date="11 Aug 2002" email="bjork@bjork.net" type="Update">Now sets API variables BEFORE running the home fbx_settings, if possible.</history>
		<history author="Lee Bjork Borkman" date="11 Aug 2002" email="bjork@bjork.net" type="Update">Now fixes the bug in which the Home circuit never has IsTargetCircuit=TRUE.</history>
		<history author="Lee Bjork Borkman" date="11 Aug 2002" email="bjork@bjork.net" type="Update">Now works with Lee's FB3-subset "Lite" core.</history>
		<history author="Lee Bjork Borkman" date="13 Aug 2002" email="bjork@bjork.net" type="Update">More optimisations, especially stack operations</history>
		<history author="Lee Bjork Borkman" date="15 Aug 2002" email="bjork@bjork.net" type="Update">Replaced rereplace() with left(len()) for another tiny speed boost.</history>
	</properties>
	<io>
		<in>
            <string name="fusebox.nextAction" scope="variables" comments="The fully-qualified name of the fuseaction to be executed.">
			<structure name="fusebox" scope="variables" comments="The standard FB3 API or subset.  See the FB3 core file for details." />
			<structure name="FB_" comments="The internal structure used by the FB3 core.  See the FB3 core file for details."/>
		</in>
	</io>
</fusedoc> 
--->

<cfscript>
    //preserve the original fuseaction, then destroy the nextAction variable
	FB_.rawFA = fusebox.nextAction; 
    structDelete(fusebox, "nextAction");


    // make sure crucial structures exist
	if (NOT isDefined("LB_")) {
		LB_ = structnew();
		LB_.stack = arraynew(1);
    }
	if (NOT isDefined("LB_.top")) {
		LB_.top = 0;
	}

	if (NOT isDefined("FB_.patharray")) {
		FB_.patharray = arraynew(2);
    }
    
    // Push the current Fusebox and FB strucutures onto the stack    
	LB_.stack[LB_.top + 1] = StructCopy(fusebox);
	LB_.stack[LB_.top + 2] = StructCopy(FB_);
	LB_.top = LB_.top + 2;
    
    // Initialize API and internal variables
    fusebox.IsHomeCircuit=TRUE;
    fusebox.IsTargetCircuit=FALSE;
    if (isdefined("FB_.ReverseCircuitPath"))
        fusebox.thisCircuit="";
    fusebox.thislayoutpath="";
    fusebox.currentPath="";
    fusebox.rootPath="";
	fusebox.customtagcall="yes";
    
</cfscript>


<!--- Convert the fully-qualified fuseaction into separate circuit and fuseactionaction variables--->
<cftry>
	<cfscript>
        if (ListLen(FB_.rawFA, '.') is 2) {
    	//circuit.fuseaction specified, so set fusebox.fuseaction and fusebox.circuit
    		fusebox.fuseaction = ListLast( FB_.rawFA, '.' );
        	fusebox.circuit = ListFirst( FB_.rawFA, '.');
        } else {
        	fusebox.circuit = ListFirst( FB_.rawFA, '.');
        	if (ListLen(FB_.rawFA, '.') is 1 and Right(FB_.rawFA,1) is '.')
        	//circuit only specified, no fuseaction such as "fuseaction=circuit."
        		fusebox.fuseaction = "fusebox.defaultfuseaction";
            else
        		fusebox.fuseaction = ListGetAt( FB_.rawFA, 2, '.');
                //throw a deliberate error
        }
        fusebox.targetCircuit=fusebox.circuit;
        FB_.fullPath=ListRest(fusebox.Circuits[fusebox.Circuit], "/"); 
        FB_.targetDepth=ListLen(FB_.fullPath ,"/")+1;
        fusebox.isTargetCircuit=(FB_.targetDepth eq 1);

	</cfscript>
	<cfcatch>
		<!--- This error should not be suppressed. --->
		<cfoutput>
            The variable "attributes.fuseaction" is not available
            or the fusebox framework could not find the circuit you requested:
            "#fusebox.circuit#".
        </cfoutput>
        <cfthrow message="#cfcatch.message#" detail="#cfcatch.detail#">
        <cfabort>
	</cfcatch>
</cftry>




<!--- Initialise API variables prior to desscent --->
<cfscript>
    FB_.currentDepth=1;
    fusebox.currentPath="";
    fusebox.rootPath="";
    
    // The following handles the internals of the FEX core (probably the fusebox.org core too)
    if (isDefined("FB_.ReverseCircuitPath")){
        LB_.ReverseCircuitPath = StructCopy(FB_.ReverseCircuitPath);
        if ( NOT structKeyExists(FB_.ReverseCircuitPath,"")) {
            for (LB_.name in FB_.ReverseCircuitPath){
                LB_.ReverseCircuitPath[ListRest(LB_.name, "/")]=LB_.ReverseCircuitPath[LB_.name];
            }
        }
        fusebox.thisCircuit=LB_.ReverseCircuitPath[""];    
        fusebox.homecircuit=fusebox.thisCircuit;
    }
</cfscript>


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



<!--- Descend through the circuits, from the home to the target --->
<cfloop list="#FB_.fullpath#" index="aPath" delimiters="/">

    <!--- Calculate internal variables and API variables as we go down --->
	<cfscript>
        FB_.currentDepth=FB_.currentDepth+1;
    	fusebox.currentPath="#fusebox.currentPath##aPath#/";
    	fusebox.IsHomeCircuit=FALSE;
    	fusebox.rootPath="#fusebox.rootPath#../";
        //FB_.reversePath=rereplace(fusebox.currentPath, "^(.*)/", "\1");
		FB_.reversePath=left(fusebox.currentPath, len(fusebox.currentPath)-1);
        fusebox.IsTargetCircuit=(FB_.currentDepth EQ FB_.targetDepth);
	</cfscript>
    
    <!--- Only proceed if the circuit is declared, or if using a Lite API --->
    <cfif NOT isDefined("FB_.ReverseCircuitPath") OR StructKeyExists(FB_.ReverseCircuitPath, FB_.reversePath)>
       <!---  <cftry>
            <cfset fusebox.thisCircuit=LB_.ReverseCircuitPath[FB_.reversePath]>
            <cfcatch> --->
                <cfif isDefined("FB_.ReverseCircuitPath")>
                    <cfset fusebox.thisCircuit="">
                </cfif>
          <!---   </cfcatch>
        </cftry> --->

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
        
    </cfif>
    
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

<cfoutput>#trim(fusebox.layout)#</cfoutput>

<cfset structDelete(fusebox, "customtagcall")>

<!--- point fusebox and FB_ to the structures at the top of the stack --->
<cfset FB_ = LB_.stack[LB_.top]>
<cfset fusebox = LB_.stack[LB_.top - 1]>

<!--- Move the top of the stack --->
<cfset LB_.top = LB_.top - 2>


