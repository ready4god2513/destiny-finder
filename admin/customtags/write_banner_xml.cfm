<cfquery name="qRotating" datasource="#APPLICATION.DSN#">
	SELECT * 
	FROM Rotating
	WHERE rotating_active = 1
	ORDER BY rotating_sortorder ASC
</cfquery>


<cfxml variable="banners">
<banner>
	<globals 
		width="955" height="289" 
		currentItem="0" radius="0" randomize="false"
		showButtons="true" buttonPosition="right" buttonPadding="1" buttonMargin="2"
		buttonBgAlpha="0.6" currentButtonBgColor="#FFFFFF" currentButtonFontColor="#000000"
	/>
	<cfoutput query="qRotating">
		<item>
			<image>#qRotating.rotating_image#</image>
			<timer>6</timer>
			<cfif LEN(qRotating.rotating_link) GT 0>
			<link>#qRotating.rotating_link#</link>
			</cfif>
			<target>#qRotating.rotating_target#</target>
		</item>
	</cfoutput>
</banner>
</cfxml>


<cffile action="write"
    file="#APPLICATION.server_path#flash\banner\banner.xml"
    output="#ToString(Banners)#"
    nameconflict="overwrite">
	
