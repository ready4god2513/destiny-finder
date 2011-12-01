<cfparam name="ATTRIBUTES.max_display" default="100">
<cfparam name="ATTRIBUTES.max_recordcount" default="">
<cfparam name="ATTRIBUTES.page_url" default="">
<cfparam name="URL.page" default="1">
<cfparam name="URL.start_row" default="1">

<cfoutput>
	
	<cfset VARIABLES.page_count =  ceiling(ATTRIBUTES.max_recordcount / ATTRIBUTES.max_display) >
	<div style="width:500px; font-size: 11px;">
	Page: 
	<cfset VARIABLES.start_row = 1 >
	<cfloop from="1" To="#VARIABLES.page_count#" index="i">
		<cfoutput><a href="#ATTRIBUTES.page_url#?start_row=#VARIABLES.start_row#&page=#i#"><cfif isDefined('url.page') AND url.page EQ i><strong>[#i#]</strong><cfelse>#i#</cfif></a>&nbsp;</cfoutput>
		<cfset VARIABLES.start_row = VARIABLES.start_row + ATTRIBUTES.max_display >
	</cfloop>
	
		<cfif isDefined('url.start_row')>
			<cfset CALLER.start_row = url.start_row>
		</cfif>
		
	<div style="clear:both;"></div>
	</div>
</cfoutput>

