<cfparam name="ATTRIBUTES.page_name" default="Account">
<div class="subpage_banner">
	<div id="subpage_title"><cfoutput>#ATTRIBUTES.page_name#</cfoutput></div> 
</div>

<div class="body_content">
	<cfif (REQUEST.user_id GT 0)>              
		<div id="subpage_nav">  
			<ul> 
				<li><a href="/profile/?page=profiler" class="btn info">Profiler</a></li>
				<li><a href="#" class="btn disabled">Planner</a></li>
				<li><a href="#" class="btn disabled">Activator</a></li>
			</ul>
		</div>
	</cfif>