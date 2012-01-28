<cfif isDefined('URL.author')>
	<cfmodule template="customtags/author_detail.cfm">
		
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

<footer>
	<div class="row">
		<div class="span4">
			<cfinclude template="customtags/popular_blog_posts.cfm" />
		</div>
		<div class="span5">
			<cfinclude template="customtags/archive_posts.cfm" />
		</div>
	</div>
</footer>