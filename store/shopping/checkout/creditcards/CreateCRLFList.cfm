
	<cfif NOT ThisTag.HasEndTag>
		<cfabort showerror="You need to supply a closing &lt;CF_CreateCrLfList&gt; tag.">
	</cfif>  
	
	<cfif ThisTag.ExecutionMode is "End">
		<cfparam name="ATTRIBUTES.Result" default="">
		<cfparam name="ATTRIBUTES.Options" default="">
		<cfset fulltrim=(ListFindNoCase(attributes.Options,"TRIM") NEQ 0)>
		<cfif attributes.Result is "" and IsDefined("ATTRIBUTES.Name")>
			<cfset attributes.Result = attributes.Name>
		</cfif>
		<cfset CRLF = Chr(13) & Chr(10)>
		<cfset output = "">
		<cfloop index="line" list="#ThisTag.GeneratedContent#" delimiters="#CRLF#">
			<cfif fulltrim>
				<cfset line=Trim(Replace(line,Chr(9)," ","ALL"))>
			<cfelse>
				<cfset line=RTrim(line)>
				<cfif Replace(line,Chr(9),"","ALL") is "">
					<cfset line="">
				</cfif>
			</cfif>
			<cfif line is not "">
				<cfif attributes.Result EQ "">
					<cfoutput>#line##CRLF#</cfoutput>
				<cfelse>
					<cfset output = output & line & CRLF>
				</cfif>
			</cfif>
		</cfloop>
		<cfif attributes.Result NEQ "">
			<cfset "Caller.#attributes.Result#" = output>
		</cfif>
		<cfset ThisTag.GeneratedContent = "">
	</cfif>
