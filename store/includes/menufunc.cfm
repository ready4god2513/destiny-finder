<!---
menufunc.cfm
XML based menuing functions.
Do NOT invoke GetItem() directly, the only entry point
should be BuildMenu().

Ben Forta
--->

<!---
GetItem
Parses XML and gets each item, called recursivley
for nested menus.
This function should not be called directly, it should
only be called by the primay menu interface and by
itself.
--->
<CFFUNCTION NAME="GetItem" RETURNTYPE="string" OUTPUT="no">
	<CFARGUMENT NAME="menu" REQUIRED="yes">
	<CFARGUMENT NAME="callback" REQUIRED="yes">

	<!--- Local variables --->
	<CFSET VAR result="">
	<CFSET VAR i1=0>
	<CFSET VAR i2=0>
	<CFSET VAR item_name="">
	<CFSET VAR item_link="">

	<!--- Loop through menu items --->
	<CFLOOP FROM="1" TO="#ArrayLen(menu)#" INDEX="i1">
		<cfset item_link="javascript:;">
		<CFLOOP FROM="1"
				TO="#ArrayLen(menu[i1].XMLChildren)#"
				INDEX="i2">
			<CFIF menu[i1].XMLChildren[i2].XMLName IS "Name">
				<CFSET item_name=menu[i1].Name.XMLText>
			<CFELSEIF menu[i1].XMLChildren[i2].XMLName IS "URL">
				<CFSET item_link=menu[i1].URL.XMLText>
			</CFIF>
		</CFLOOP>
		<!--- Is this an ITEM or a MENU? --->
		<CFIF NOT StructKeyExists(menu[i1], "Item")>			
			<!--- pass this one to the callback function --->
			<CFSET result=result & arguments.callback("item", item_name, item_link)>
		<!--- It's a SUBMENU --->
		<CFELSEIF StructKeyExists(menu[i1], "Item")>
			<!--- Start submenu --->
			<CFSET result=result & arguments.callback("submenu_start",item_name, item_link)>
			<!--- Recurse to get child submenu items --->
			<CFSET result=result & GetItem(menu[i1].Item, arguments.callback)>
			<!--- End submenu --->
			<CFSET result=result & arguments.callback("submenu_end")>
		</CFIF>
	</CFLOOP>

	<!--- And return it --->	
	<CFRETURN result>
</CFFUNCTION>


<!---
BuildMenu
This is the menu entry point, pass it the XML for the menu
and a callback function and it does the rest. It returns
a complete menu as a string (built by the callback function
calls).
--->
<CFFUNCTION NAME="BuildMenu" RETURNTYPE="string" OUTPUT="no">
	<CFARGUMENT NAME="menu_xml" TYPE="string" REQUIRED="yes">
	<CFARGUMENT NAME="callback" REQUIRED="yes">

	<!--- Local variables --->
	<CFSET VAR menu=XMLParse(menu_xml)>
	<CFSET VAR meta_data="">
	<CFSET VAR proceed="yes">
	
	<cfset var menustring = "">
	
	<!--- Make sure "callback" is a valid UDF --->
	<CFIF NOT IsCustomFunction(arguments.callback)>
		<CFTHROW MESSAGE="Callback function must be a UDF">
	</CFIF>

	<!--- Get callback meta data --->
	<CFSET meta_data=GetMetaData(arguments.callback)>

	<!--- Now make sure callback returns right type --->
	<CFIF meta_data.returntype IS NOT "string">
		<CFTHROW MESSAGE="Callback function must return a string">
	</CFIF>
	
	<!--- Make sure it accepts the right params --->
	<CFIF ArrayLen(meta_data.parameters) IS NOT 3
		OR meta_data.parameters[1].type IS NOT "string"
		OR meta_data.parameters[2].type IS NOT "string"
		OR meta_data.parameters[3].type IS NOT "string">
		<CFTHROW MESSAGE="Callback function must accept three string arguments">
	</CFIF>
	
	<cfset menustring = arguments.callback("menu_start")>
	<cfset menustring = menustring & GetItem(menu.menu.XMLChildren, arguments.callback)>
	<cfset menustring = menustring & arguments.callback("menu_end")>
			
	<!--- Build and return menu --->
	<CFRETURN menustring>

</CFFUNCTION>


