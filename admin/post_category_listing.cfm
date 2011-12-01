
<cfmodule template="customtags/item_listing.cfm"
	table_name="categories"
	select_columns="category_id,category_title"
	primary_key="category_id"
	title_column="category_title"
	order_by="category_title"
	listing_title="Topic Categories"
	column_headings="Title"
	add_new_link="post_category.cfm?category_id=new"
	item_page="post_category.cfm"
	column_details="<a href=""post_category.cfm?category_id=##qItems.category_id##"" style=""cursor:hand;""><img src=""images/edit.gif"" />&nbsp;##qItems.category_title##</a>"
	column_widths="490"
>

<!--- <a href=""blog_category.cfm?category_id=##VARIABLES['qItems'][category_id][qItems.currentrow]##"" style=""cursor:hand;""><img src=""images/edit.gif"" />&nbsp;##VARIABLES['qItems'][category_title][qItems.currentrow]##</a>" --->