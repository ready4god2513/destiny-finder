
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!---- NextItems is used to set and display the "next item" and "previous item" link on an item's detail page. The tag is first placed on or after the items query page (qry_get_products or get_orders, etc.). Then the tag can be place on the item detail page (dsp_product or dsp_order). The tag looks at the list of items and determines what the next and previous items are.

	mode = set | display
	type = product, orders, etc.
	ID	 = used when mode is "display"; the current order_no, product_ID, etc.
	
 --->
<cfif isDefined("ThisTag.ExecutionMode") AND ThisTag.ExecutionMode eq "END">
	<cfexit method="EXITTAG">
</cfif>		

<cfif NOT isDefined("XHTMLFormat")>
	<cfinclude template="../includes/cfw_functions.cfm">
</cfif>

<cfparam name="attributes.mode" default="set">
<cfparam name="attributes.type" default="">
<cfparam name="attributes.ID" default="0">
<cfparam name="attributes.ParentCat" default="0">
<cfparam name="attributes.class" default="">

<cfif attributes.mode is "set">

	<cfif isdefined("qry_get_#attributes.type#s.recordcount") 
	AND evaluate("qry_get_" & attributes.type & "s.recordcount") is not 0>
	
		<cfif attributes.type is "product">
			<cfset item_list = valuelist(qry_get_products.product_id) >
		</cfif>	
		
		<cfif attributes.type is "order">
			<cfset item_list = valuelist(qry_get_orders.order_no) >
		</cfif>	
		
		<cfset Session.NextItems="#attributes.type#^#item_list#">
	
	</cfif>
	
<cfelse><!--- mode is display ----->

<!--- 	<cfoutput>
	<!--- Output back button --->
	<img src="#Request.AppSettings.defaultimages#/icons/left.gif" border="0" valign="middle" alt="" hspace="2" vspace="0" /> 
	
<cfprocessingdirective suppresswhitespace="no">
<script language = "JavaScript">
		if(window.history.length == 0){
			document.write("<a href=\"javascript:onClick = window.close()\" <cfif len(attributes.class)>class=\"#attributes.class#\"</cfif>>close window</a>")
		}
		else {
			document.write("<a href=\"javascript: onClick = window.history.back()\" <cfif len(attributes.class)>class=\"#attributes.class#\"</cfif>>back</a> ")
		}
	</script>
</cfprocessingdirective> 
	</cfoutput> --->
	
	<cfif isdefined("session.nextitems")>
		<cfset NextItems= session.nextitems>
	<cfelse>
		<cfset NextItems= "">
	</cfif>
	
	<cfscript>
	// Set Parent ID text strings
	if (isNumeric(attributes.ParentCat) AND attributes.ParentCat IS NOT 0) {
		PCatSES = "_#attributes.ParentCat#";
		PCatNoSES = "&ParentCat=#attributes.ParentCat#";
	}
	else {
		PCatSES = "";
		PCatNoSES = "";
	}
	</cfscript>

	<!--- check to see if the list type is a match ---->
	<cfif len(nextitems) AND ListFirst(nextitems,"^") is "#attributes.type#">
	
		<cfset itemList = ListLast(nextitems,"^")>
		
		<!--- find the current item in the list ---->
		<cfset itemindex = ListFind(itemlist,"#attributes.ID#")>
		
		<cfif itemindex AND ListLen(itemlist) gt 1>
			<cfif itemindex is ListLen(itemlist)>
				<cfset nextitem = ListGetAt(itemlist, 1)>
			<cfelse>
				<cfset nextitem = ListGetAt(itemlist, itemindex + 1)>
			</cfif>
			
			<cfif itemindex is 1>
				<cfset previtem = ListGetAt(itemlist, listlen(itemlist))>
			<cfelse>
				<cfset previtem = ListGetAt(itemlist, itemindex - 1)>
			</cfif>
			
		<cfif Request.AppSettings.UseSES AND attributes.type is not 'order'>
			<cfset prevlink = "#Request.SESindex##attributes.type#/#previtem##PCatSES#/index.cfm#Request.Token1#">
			<cfset nextlink = "#Request.SESindex##attributes.type#/#nextitem##PCatSES#/index.cfm#Request.Token1#">
		<cfelseif attributes.type is not 'order'>
			<cfset prevlink = "#request.self#?fuseaction=#attributes.type#.display&#attributes.type#_ID=#previtem##PCatNoSES##Request.Token2#">
			<cfset nextlink = "#request.self#?fuseaction=#attributes.type#.display&#attributes.type#_ID=#nextitem##PCatNoSES##Request.Token2#">
		<cfelse>
			<cfset prevlink = "#request.self#?fuseaction=shopping.admin&order=display&#attributes.type#_no=#previtem##Request.Token2#">
			<cfset nextlink = "#request.self#?fuseaction=shopping.admin&order=display&#attributes.type#_no=#nextitem##Request.Token2#">
		</cfif>
			
			<cfoutput>
			<img src="#Request.AppSettings.defaultimages#/icons/left.gif" border="0" style="vertical-align: middle" alt="" hspace="2" vspace="0" /> <a href="#XHTMLFormat(prevlink)#" <cfif len(attributes.class)>class="#attributes.class#"</cfif> onmouseover="dmim('back'); return document.returnValue;" onmouseout="dmim(''); return document.returnValue;">back</a>

			| 
			<a href="#XHTMLFormat(nextlink)#" <cfif len(attributes.class)>class="#attributes.class#"</cfif> onmouseover="dmim('next'); return document.returnValue;" onmouseout="dmim(''); return document.returnValue;">next</a>	
			<img src="#Request.AppSettings.defaultimages#/icons/right.gif" border="0" style="vertical-align: middle" alt="" hspace="2" vspace="0" />
			</cfoutput>
		
		</cfif><!---- item found --->
		
	</cfif><!--- list type --->

</cfif>



