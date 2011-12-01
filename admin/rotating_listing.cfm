
<cfmodule template="customtags/item_listing.cfm"
	item_prefix="Rotating"
	table="Rotating"
	listing_title="Rotating Banners"
	dsn="#APPLICATION.DSN#"
	sortable="yes"
	addl_url_vars=""
	top_section=""
	listing_page="#CGI.SCRIPT_NAME#"
	xml_update="write_banner_xml">