<a href="gift_type_listing.cfm"><strong>&laquo; Gift Types</strong></a> 
<cfmodule template="customtags/item_listing.cfm"
	table_name="Gifts"
	select_columns="gift_id,gift_type_id,gift_name"
	primary_key="gift_id"
    secondary_key="gift_type_id"
    secondary_value="#url.gift_type_id#"
	title_column="gift_name"
	order_by="gift_id"
	sortable="no"
	item_prefix="gift"
	listing_title="Gifts"
	column_headings="Name"
	add_new_link="gift.cfm?gift_id=new"
	item_page="gift.cfm"
	column_details="<a href=""gift.cfm?gift_id=##qItems.gift_id##&gift_type_id=##qItems.gift_type_id##"" style=""cursor:hand;""><img src=""images/edit.gif"" />&nbsp;##qItems.gift_name##</a>"
	column_widths="470"
>

