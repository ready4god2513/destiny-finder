<div class="subpage_banner">
	<div id="subpage_title">
		<cfif isDefined("ATTRIBUTES.page_name")>
			<cfoutput>#ATTRIBUTES.page_name#</cfoutput>
		<cfelse>
			Account
		</cfif>
	</div>
	<cfif (isDefined("SESSION.user_id") AND Len(SESSION.user_id) GT 0) AND (FindNoCase('profile',GetBaseTemplatePath()))>              
		<div id="subpage_nav">  
			<ul> 
				<li><a href="/profile/?page=profiler"><span>Profiler</span></a></li>
				<li><a href="#"><span>Planner</span></a></li>
				<li><a href="#"><span>Activator</span></a></li>
			</ul>
		</div>
	</cfif>   
</div>

<div class="body_content">