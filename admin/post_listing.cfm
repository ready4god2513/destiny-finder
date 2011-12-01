
<!--- QUERY FOR LISTING --->

<cfquery name="qblogs" datasource="#APPLICATION.DSN#">
	SELECT *
	FROM blogs
	ORDER BY blog_active ASC,blog_publish_date DESC
</cfquery>

<!--- SET VARIABLES DEPENDANT UPON PAGE LISTING TYPE, BY GATEWAY OR AN "ALL PAGES" LISTING --->

	<!--- TITLE OF LISTING--->
	<cfset VARIABLES.title = "Blogs">
	<!--- NAME OF EACH COLUMN SEPERATED BY COMMAS --->
	<cfset VARIABLES.column_headings = "Title,Author,Date,Approved">
	<!--- THE URL FOR THE "ADD NEW - " LINK AT THE TOP OF THE PAGE...LEAVE BLANK ( "" )IF NOT NEEDED  --->
	<cfset VARIABLES.add_new_link = "">


<!--- NUMBER OF COLUMN HEADINGDS --->
<cfset VARIABLES.columns = "4">
<!--- WIDTHS FOR EACH COLUMN SEPERATED BY COMMAS--->
<cfset VARIABLES.column_widths = "158,157,115,60">


<cfif isDefined('URL.memo')>

	<cfmodule template="customtags/rss_xml.cfm">
	<cfmodule template="customtags/facebook_xml.cfm">
	<cfmodule template="customtags/twitter_xml.cfm">

</cfif>


<cf_ct_admin_template title="#VARIABLES.title#" columns="#VARIABLES.columns#" column_widths="#VARIABLES.column_widths#" column_headings="#VARIABLES.column_headings#" add_new_link="#VARIABLES.add_new_link#" sortable_container="pageContainer" top_section="" xml_update="">
	
	
	<div id="pageContainer">
	
	
	<cfquery name="qMaxBlogs" datasource="#APPLICATION.DSN#">
		SELECT blog_id FROM Blogs
	</cfquery>

	<cfset VARIABLES.maxrows = 50>
	<cfmodule template="customtags/pagination.cfm" 
		max_recordcount="#qMaxBlogs.recordcount#"
		max_display="#VARIABLES.maxrows#"
		page_url="blog_listing.cfm"
	>

	<!--- 
	<div style="width:500px; font-size: 11px;">
	Sort By: 
	<select name="sort_by">
		<option value="author">Author</option>
		<option value="date">Date</option>
	</select>
	
	<div style="clear:both;"></div>
	</div> --->
	
	<cfoutput query="qBlogs" startrow="#start_row#" maxrows="#VARIABLES.maxrows#">
	
	<div id="" style="border:1px solid ##D8D8D8; margin-bottom:2px;padding:2px;">
		
			<!--- FOR EVERY COLUMN SET EACH STYLE ELEMENT NEEDS TO ADDRESS THE APPROPRIATE WIDTH AS ASSIGNED ABOVE, THIS IS DONE BY SETTING THE LISTGETAT # TO IT'S RESPECTIVE COLUMN PLACEHOLDER, 1 IS FOR THE FIRST COLUMN, 2 IS FOR THE SECOND, AND SO ON. --->
			<div id="name_column" style="width:#ListGetAt(VARIABLES.column_widths, 1)#px;">
			<a href="blog.cfm?blog_id=#qBlogs.blog_id#"><img src="images/edit.gif" />&nbsp;
			<cfif LEN(qBlogs.blog_title) GT 22>
				#Left(qBlogs.blog_title,19)#...
			<cfelse>
				#qBlogs.blog_title#
			</cfif>
			</a></div>
			<div id="column" style="width:#ListGetAt(VARIABLES.column_widths, 2)#px;">
				
					<cfquery name="qUser" datasource="#APPLICATION.DSN#">
						SELECT user_first_name,user_last_name,user_id
						FROM users
						WHERE user_id = #qBlogs.blog_user_id#
					</cfquery>

					<cfset VARIABLES.author_name = "#qUser.user_last_name#, #qUser.user_first_name#">

								
					<cfif LEN(VARIABLES.author_name) GT 23>
						#LEFT(VARIABLES.author_name,20)#...
					<cfelse>
						#VARIABLES.author_name#
					</cfif>
					

			</div>
			<div id="column" style="width:#ListGetAt(VARIABLES.column_widths,3)#px;">
				#DateFormat(qBlogs.blog_publish_date,'mm-dd-yy')#
			</div>
			<div id="column" style="width:#ListGetAt(VARIABLES.column_widths, 4)#px;"><cfif qBlogs.blog_active EQ 1><img src="images/action_check.gif" /><cfelse><img src="images/action_disabled.gif" /></cfif></div>
				<div style="clear:both;"></div>
		
		</div>
		

	
	</cfoutput>
	</div>
	
</cf_ct_admin_template>