<div class="blog_wrapper">


<div class="blog_col_two">
	<a href="index.cfm?page=blog" class="home_link">HOME</a> 
	<a href="/feed.xml" class="subscribe_link">SUBSCRIBE/RSS</a>
<div class="clear"></div>

<cfif isDefined('URL.fileerror')>
	<cfset VARIABLES.create_account_message = "upload fail">
	<cfmodule template="customtags/site_notifications.cfm" message="#VARIABLES.create_account_message#">
</cfif>

	<cfif isDefined('URL.author')>
		
		
		<cfmodule template="customtags/author_detail.cfm">
	
	
	<cfelseif isDefined('URL.login')>
		
		
		<cfif REQUEST.user_id EQ 0>
		
			<cfmodule template="customtags/login_box.cfm"
				processing_url="index.cfm?page=blog&login=1"
				destination_url="index.cfm?page=blog&admin=1"
				create_account_option="0"
			>
			
		<cfelse>
		
			<cflocation url="index.cfm?page=blog&admin=1" addtoken="no">
			
		</cfif>
		
		
	<cfelseif isDefined('URL.admin')>
			
			
			
			<cfif REQUEST.user_id NEQ 0>
				<cfif isDefined('URL.edit_blog')>		

					<cfmodule template="customtags/write_blog.cfm">

				<cfelseif isDefined('URL.write')>
				
					<cfmodule template="customtags/write_blog.cfm">


				<cfelseif isDefined('URL.profile')>
				
					<cfmodule template="customtags/author_profile.cfm">

				<cfelseif isDefined('URL.blog_id')>
				
					<cfmodule template="customtags/display_blog.cfm" admin="1" author_id="#REQUEST.user_id#">

				<cfelse>
					
					<cfmodule template="customtags/author_admin.cfm">					
				
				</cfif>
			<cfelseif isDefined('URL.fileerror')>
			
				<cfmodule template="customtags/author_profile.cfm">
			
			<cfelse>
				<cflocation url="index.cfm?page=blog&login=1" addtoken="no">
			</cfif>
	
	
	<cfelseif isDefined('URL.blog_id')>
	
		<cfmodule template="customtags/display_blog.cfm">
		
	<cfelseif isDefined('URL.month')>
		
		<cfmodule template="customtags/archive_posts.cfm">
	
	<cfelseif isDefined('URL.category')>
		
		<cfmodule template="customtags/category_posts.cfm">
	
	<cfelseif isDefined('URL.write_blog')>
		
		<cfmodule template="customtags/newuser.cfm">
	
	<cfelseif isDefined('URL.newuser')>
	
		<cfmodule template="customtags/author_profile.cfm">
	
	<cfelse>
	
		<cfmodule template="customtags/blog_home.cfm">
	
	</cfif>
	<div class="clear"></div>
</div><!-- class="blog_col_two" -->
<div class="blog_col_three">
	<div class="blog_col_box">
		<div class="blog_col_heading">
			CATEGORIES
		</div><!-- "blog_col_heading" -->
		<cfmodule template="customtags/category_listing.cfm">
	</div>
	
	<div class="blog_col_box">
		<div class="blog_col_heading">
			ARCHIVES
		</div><!-- "blog_col_heading" -->
		<cfmodule template="customtags/archive_listing.cfm">
	</div>
		
	<div class="blog_col_box">
		<div class="blog_col_heading">
			AUTHORS
		</div><!-- "blog_col_heading" -->
		<cfmodule template="customtags/author_listing.cfm">
	</div>
	<!--- div class="blog_col_heading">[MISC CONTENT]</div><!-- "blog_col_heading" -->
	<cfquery name="qBlog" datasource="#APPLICATION.DSN#">
		SELECT * 
		FROM Blog_Home
		WHERE Blog_id = 1
	</cfquery>
	<cfoutput>
		<div class="blog_right_content">
			#qBlog.blog_misc_block#
		</div>
	</cfoutput>
	--->

	<div class="page_title_login">
	<cfif REQUEST.user_id EQ 0>
		<a href="index.cfm?page=blog&login=1">LOGIN</a>
	<cfelse>
		<a href="index.cfm?page=blog&admin=1" style="margin-right: 10px;">MY PROFILE</a>
		|
		<a href="index.cfm?page=blog&logout=1" style="margin-left: 10px;">LOGOUT</a>
	</cfif>
	</div>
		
</div><!-- class="blog_col_three" -->
<div class="blog_stilt"></div>
<div class="clear"></div>
</div>
<script>
	$('.blog_wrapper').css({'margin-top':'4px'});
</script>