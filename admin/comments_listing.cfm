
<!--- QUERY FOR LISTING --->

<cfquery name="qComments" datasource="#APPLICATION.DSN#">
	SELECT comment_id,comment_name,comment_date,comment_approved,comment_blog_id
	FROM comments
	ORDER BY comment_date DESC
</cfquery>

<!--- SET VARIABLES DEPENDANT UPON PAGE LISTING TYPE, BY GATEWAY OR AN "ALL PAGES" LISTING --->

	<!--- TITLE OF LISTING--->
	<cfset VARIABLES.title = "Comments">
	<!--- NAME OF EACH COLUMN SEPERATED BY COMMAS --->
	<cfset VARIABLES.column_headings = "Name,Story,Date,Approved">
	<!--- THE URL FOR THE "ADD NEW - " LINK AT THE TOP OF THE PAGE...LEAVE BLANK ( "" )IF NOT NEEDED  --->
	<cfset VARIABLES.add_new_link = "">


<!--- NUMBER OF COLUMN HEADINGDS --->
<cfset VARIABLES.columns = "4">
<!--- WIDTHS FOR EACH COLUMN SEPERATED BY COMMAS--->
<cfset VARIABLES.column_widths = "180,135,115,60">



<cf_ct_admin_template title="#VARIABLES.title#" columns="#VARIABLES.columns#" column_widths="#VARIABLES.column_widths#" column_headings="#VARIABLES.column_headings#" add_new_link="#VARIABLES.add_new_link#" sortable_container="pageContainer" top_section="" xml_update="">
	<cfquery name="qMaxComments" datasource="#APPLICATION.DSN#">
		SELECT comment_id FROM Comments
	</cfquery>

	<cfset VARIABLES.maxrows = 50>
	<cfmodule template="customtags/pagination.cfm" 
		max_recordcount="#qMaxComments.recordcount#"
		max_display="#VARIABLES.maxrows#"
		page_url="comments_listing.cfm"
	>
	
	<div id="pageContainer">
	<cfoutput query="qComments" startrow="#start_row#" maxrows="#VARIABLES.maxrows#">
	
	<div id="" style="border:1px solid ##D8D8D8; margin-bottom:2px;padding:2px;">
		
			<!--- FOR EVERY COLUMN SET EACH STYLE ELEMENT NEEDS TO ADDRESS THE APPROPRIATE WIDTH AS ASSIGNED ABOVE, THIS IS DONE BY SETTING THE LISTGETAT # TO IT'S RESPECTIVE COLUMN PLACEHOLDER, 1 IS FOR THE FIRST COLUMN, 2 IS FOR THE SECOND, AND SO ON. --->
			<div id="name_column" style="width:#ListGetAt(VARIABLES.column_widths, 1)#px;">
			<a href="comment.cfm?comment_id=#qComments.comment_id#"><img src="images/edit.gif" />&nbsp;
			<cfif LEN(qComments.comment_name) GT 20>
				#Left(qComments.comment_name,17)#...
			<cfelse>
				#qComments.comment_name#
			</cfif>
			</a></div>
			<div id="column" style="width:#ListGetAt(VARIABLES.column_widths, 2)#px;">
				<cfquery name="qBlog" datasource="#APPLICATION.DSN#">
					SELECT blog_title
					FROM blogs
					WHERE blog_id = #qComments.comment_blog_id#
				</cfquery>
				
				<cfif LEN(qBlog.blog_title) GT 23>
					#LEFT(qBlog.blog_title,17)#...
				<cfelse>
					#qBlog.blog_title#
				</cfif>
			</div>
			<div id="column" style="width:#ListGetAt(VARIABLES.column_widths,3)#px;">
				#DateFormat(qComments.comment_date,'mm-dd-yy')# #TimeFormat(qComments.comment_date,'h:mm t')#
			</div>
			<div id="column" style="width:#ListGetAt(VARIABLES.column_widths, 4)#px;"><cfif qComments.comment_approved EQ 1><img src="images/action_check.gif" /><cfelse><img src="images/action_disabled.gif" /></cfif></div>
				<div style="clear:both;"></div>
		
		</div>
		

	
	</cfoutput>
	</div>
	
</cf_ct_admin_template>