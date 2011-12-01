<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This is the default file used for the home page template.  --->

<!--- 
Parameters that can be set for this page:
	topcats: display the top-level categories
	sale: display items marked as on sale
	new: display items marked as new
	notsold: display products marked as not for sale (information only items)
	hot: display products marked as 'hot'
	listing: format to use for the hot/new products
	columns: number of columns to use for highlighted items
	ProdofDay: Display the Product of the Day 
	searchform: Displays a product search form 
 --->
 
<cfset QuerytoUse = qry_get_page>
<cfinclude template="../includes/parseparams.cfm">
	
<cfparam name="attributes.topcats" default="0">
<cfparam name="attributes.hot" default="0">
<cfparam name="attributes.new" default="0">
<cfparam name="attributes.onsale" default="0">
<cfparam name="attributes.notsold" default="0">
<cfparam name="attributes.prodofday" default="0">
<cfparam name="attributes.searchform" default="0">
<cfparam name="attributes.listing" default="vertical">	

<!--- Uncomment to put store-wide discounts here 
	 <cfset DiscountMess = Application.objDiscounts.dspDiscountMess(DiscType:'Store', class:'cat_text_list')>
	<cfoutput>#DiscountMess#</cfoutput> 	
--->

<!--- Output top-level categories if requested --->
<cfif attributes.topcats>
	<cfinclude template="../category/qry_get_subcats.cfm">
	<cfinclude template="../category/dsp_subcats.cfm">	
</cfif>

	
<!--- Output the HOT products --->
<cfif attributes.hot>	
	
	<cfmodule template="../customtags/putline.cfm" linetype="Thick">
	
	<!--- can also accept the productCols attribute ---->
	 <cfmodule template="../#self#"
	 fuseaction="product.list"
	 hot="1"
	 searchform = "#attributes.searchform#"
	 searchheader = "0"
	 displaycount="6"
	 productCols="2"
	 listing="#attributes.listing#"
	 maxrows="6"
	 thickline="0"
	 >  
		
	<br/>
</cfif>
		
	
<!--- Output New and Sale products & categories --->
<cfif attributes.new or attributes.onsale or attributes.notsold>
	<div class="header">&nbsp;What's New</div>
	<!--- Hide the hot products --->
	<cfset attributes.hot = 0>
	<cfset attributes.columns = 2>
	<cfinclude template="catcore_highlight.cfm">
	<br/>
</cfif>

<!--- Output Product of the Day if requested --->
<cfif attributes.prodofday>
	
	<!--- listings can be short, vertical, or blank for standard --->
	<cfset attributes.listing = "short">
	<cfset attributes.UnderCategory_id = 0>
	<cfset fusebox.nextaction="product.productofday">
	<cfinclude template="../lbb_runaction.cfm">
	
</cfif>
