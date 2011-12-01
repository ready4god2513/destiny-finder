<cfset obj_queries = CreateObject("component","site_modules.blog.cfcs.queries")>
<cfset qAuthors = obj_queries.author_list()>

<ul>
	<cfoutput query="qAuthors">
		<cfif qAuthors.user_id NEQ 0>
		<!--- USED IF YOU WANT TO DISPLAY ONLY AUTHORS WITH BLOG POSTS 
		<cfset qPosts = obj_queries.author_post_list(author_id="#qAuthors.user_id#",publish_date="1",addl_where="AND blog_active = 1")>
	
		<cfif qPosts.recordcount GT 0></cfif>
		--->
		
			<li>
				<a href="index.cfm?page=blog&author=#qAuthors.user_id#" class="<cfif NOT isDefined('URL.author') OR URL.author NEQ qAuthors.user_id>author_tip_link</cfif>">#qAuthors.user_first_name# #qAuthors.user_last_name#</a>
				<cfset qAuthor = obj_queries.author_detail(author_id="#qAuthors.user_id#")>
				<!--- <cfif LEN(qAuthor.user_description) GT 0>
					<div class="author_tip">
						<cfif LEN(qAuthor.user_image) GT 0>
							<img src="#qAuthor.user_image#" align="left">
						</cfif>
							#qAuthor.user_description#
					</div>
				</cfif>
				--->
			</li>
		</cfif>
	</cfoutput>
</ul>