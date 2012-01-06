<div class="subpage_banner">
	<div id="subpage_title">
		<cfif isDefined("ATTRIBUTES.page_name")>
			<cfoutput>#ATTRIBUTES.page_name#</cfoutput>
		<cfelse>
			Account
		</cfif>
	</div> 
</div>

<div class="body_content">
	<cfif (isDefined("SESSION.user_id") AND Len(SESSION.user_id) GT 0) AND (FindNoCase('profile',GetBaseTemplatePath()))>              
		<div id="subpage_nav">  
			<ul> 
				<li><a href="/profile/?page=profiler" class="btn info">Profiler</a></li>
				<li><a href="#" class="btn">Planner</a></li>
				<li><a href="#" class="btn">Activator</a></li>
			</ul>
		</div>
	</cfif>