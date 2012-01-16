<cfparam name="ATTRIBUTES.page_name" default="Account">
<div class="subpage_banner">
	<div id="subpage_title"><cfoutput>#ATTRIBUTES.page_name#</cfoutput></div> 
</div>

<div class="body_content">
	<cfif (REQUEST.user_id GT 0)>              
		<div id="subpage_nav">  
			<ul> 
				<li><a href="/profile/?page=profiler" class="btn info">Profiler</a></li>
				<li><a href="/profile/?page=user" class="btn success">Account Settings</a></li>
			</ul>
		</div>
	</cfif>