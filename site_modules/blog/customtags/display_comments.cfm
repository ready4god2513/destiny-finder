<cfset obj_queries = CreateObject("component","site_modules.blog.cfcs.queries")>
<cfset qComments = obj_queries.comment_list(blog_id="#URL.blog_id#")> 

<div class="comments_wrapper">
<cfoutput query="qComments">
	<div class="comment">
		<div class="comment_author">
			#qComments.comment_name#
		</div><!-- class="comment_author" -->
		<div class="comment_time">
			#DateFormat(qComments.comment_date,'mm-dd-yyyy')# #TimeFormat(qComments.comment_date,'h:mm tt')#
		</div><!-- class="comment_time" -->
		<div class="comment_content">
			#qComments.comment_content#
		</div><!-- class="comment_content" -->
	</div><!-- class="comment" -->
</cfoutput>
</div><!-- class="comments_wrapper" -->