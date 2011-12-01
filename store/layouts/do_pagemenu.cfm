<cfsilent>
	
<!--- This is coded for the styles in the 5 horizontal style files --->

<!--- Called by the do_dhtml_menus.cfm page which includes the additonal menu functions and 
outputs the scripts and styles sheets needed for the menu
 --->

<!---
MenuAsList
This is the callback function, this one creates a nested
unordered list, it can be replaced with any other function
(the name of which must be passed as a parameter to
BuildMenu().
When called three parameters will be passed to it:
 TYPE: One of the following:
		MENU_START = start of menu
		MENU_END = end of menu
		SUBMENU_START = start of submenu
		SUBMENU_END = end of submenu
		ITEM = menu item
 TEXT:  Item text (only for SUBMENU_START and ITEM)
 LINK:  Link URL (only for ITEM)
--->
<CFFUNCTION NAME="doPageMenu" RETURNTYPE="string" OUTPUT="no">
	<CFARGUMENT NAME="type" TYPE="string" DEFAULT="">
	<CFARGUMENT NAME="text" TYPE="string" DEFAULT="">
	<CFARGUMENT NAME="link" TYPE="string" DEFAULT="">

	<!--- Local variable for result --->	
	<CFSET var result="">
	
	<!--- Build result based on type --->
	<CFSWITCH EXPRESSION="#type#">
		<CFCASE VALUE="menu_start">
			<CFSET result="<div class=""tmtHierbar""><ul>">
		</CFCASE>
		<CFCASE VALUE="menu_end">
			<CFSET result="</ul></div>">
		</CFCASE>
		<CFCASE VALUE="submenu_start">
			<CFSET result="<li class=""tmtHiermenu""><a href=""#link#"" onmouseover=""tmt_showHiermenu(this)"" onmouseout=""tmt_hideHiermenu(this)"">#text#</a><ul>">
		</CFCASE>
		<CFCASE VALUE="submenu_end">
			<CFSET result="</ul>">
		</CFCASE>
		<CFCASE VALUE="item">
			<CFSET result="<li><a href=""#link#"">#text#</a></li>">
		</CFCASE>
	</CFSWITCH>

	<!--- And return it --->
	<CFRETURN result>
</CFFUNCTION>

<!---
Here's the test menu code.
First get the path to the menu.xml file, then read it,
then pass it to BuildMenu() to do just that, and then
finally display it.
--->

<cfset xmlstring = Application.objMenus.xmlPageTreeCreator()>
<!--- Do it --->
<cfset PageMenu = BuildMenu(xmlString, doPageMenu)>

</cfsilent>

