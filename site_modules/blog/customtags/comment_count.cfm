<cfparam name="ATTRIBUTES.fancy_display" default="0">

<cfset obj_queries = CreateObject("component","site_modules.blog.cfcs.queries")>
<cfset qComments = obj_queries.comment_list(blog_id="#ATTRIBUTES.blog_id#")> 

<cfoutput>
	<cfif qComments.recordcount GT 0>
		<cfif ATTRIBUTES.fancy_display EQ 1>
			<div class="comment_count">
			#qComments.recordcount#
			</div>
		<cfelse>
			#qComments.recordcount#
		</cfif>
		
	</cfif>

</cfoutput>