<cfmodule template="customtags/item_listing.cfm"
	table_name="Event_Categories"
	select_columns="event_cat_id,event_cat_name,event_cat_active"
	primary_key="event_cat_id"
	title_column="event_cat_name"
	order_by="event_cat_id"
	sortable="no"
	item_prefix="event_cat"
	listing_title="Event Categories"
	column_headings="Name,Active"
	add_new_link="event_cat.cfm?event_cat_id=new"
	item_page="event_cat.cfm"
	column_details="<a href=""event_cat.cfm?event_cat_id==##qItems.event_cat_id##"" style=""cursor:hand;""><img src=""images/edit.gif"" />&nbsp;##qItems.event_cat_name##</a>,<img src=""images/##qItems.event_cat_active##.gif""/>"
	column_widths="450,20"
>
