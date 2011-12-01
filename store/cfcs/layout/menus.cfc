<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<cfcomponent displayname="Page Menu Functions" hint="This component is used for displaying the category and page menus.">
<!--- This component developed by Mary Jo Sminkey maryjo@cfwebstore.com --->
<!--- Developed for use with CFWebstore e-commerce (www.cfwebstore.com) --->

<!--- Requires CFMX 6 or higher --->

<!--- This code is owned by Dogpatch Software and may not be distributes or reused without permission --->

<cfinclude template="../../includes/cfw_functions.cfm">
<cfset variables.LineBreak = Chr(13) & Chr(10)>

<!------------------------- COMPONENT INITIALIZATION ----------------------------------->
<cffunction name="init" access="public" output="no" returntype="menus">
    <cfreturn this>
  </cffunction>

<cffunction name="dspCatMenu" displayname="Display Category Menu" hint="Generates the text string to display the category menu." access="public" output="No" returntype="string">

	<cfargument name="rootcat" type="numeric" required="No" default="0" hint="The parent ID for the categories to display">
	<cfargument name="menu_class" type="string" required="No" default="menu_page" hint="CSS style to use for the menu">
	<cfargument name="menu_text" type="boolean" required="No" default="1" hint="Determines whether to use text or images for menu">
	<cfargument name="menu_orientation" type="string" required="No" default="vertical" 
		hint="Determines whether to display a vertical or horizontal menu">
	<cfargument name="menu_type" type="string" required="No" default="normal" hint="Type of menu to create, normal or selectbox">
	<cfargument name="separator" type="string" required="No" default="&##183;" hint="Separator to use for horizontal menus">
	<cfargument name="bullet" type="string" required="No" default="" hint="Bullet image to use on vertical menus">
	
	<cfset var qryTopCats = getTopCats(arguments.rootcat)>
	<cfset var Count = qryTopCats.RecordCount>
	<cfset var strMenu = ''>
	<cfset var catlink = ''>

 <cfif arguments.menu_type IS "selectbox">
 	<cfsavecontent variable="strMenu">
		<form id="categorySelect" name="categorySelect" method="post">
		<select name="categoryJump" onchange="location=document.categorySelect.categoryJump.options[document.categorySelect.categoryJump.selectedIndex].value;">
		<option value="">Go to...</option>
		<cfoutput query="qryTopCats">
		<cfif Request.AppSettings.UseSES>
			<cfset catlink = "#Request.StoreURL##Request.SESindex#category/#qryTopCats.Category_ID#/#SESFile(qryTopCats.Name)##Request.Token1#">
		<cfelse>
			<cfset catlink = "#Request.StoreURL##self#?category=#qryTopCats.Category_ID##Request.Token2#">
		</cfif>
			<option value="#catlink#">#qryTopCats.Name#</option>												
		</cfoutput>
		</select>
	</form>
	</cfsavecontent>
	
<cfelse>

	<cfsavecontent variable="strMenu"> 
	<cfoutput><div class="#arguments.menu_class#"></cfoutput>
	
	<cfloop query="qryTopCats">
		<cfset Count = Count - 1>
		
		<cfif Request.AppSettings.UseSES>
			<cfset catlink = "#Request.StoreURL##Request.SESindex#category/#qryTopCats.Category_ID#/#SESFile(qryTopCats.Name)##Request.Token1#">
		<cfelse>
			<cfset catlink = "#Request.StoreURL##request.self#?category=#qryTopCats.Category_ID##Request.Token2#">
		</cfif>
		
		<cfif len(arguments.bullet)>
			<cfoutput><img src="#request.appsettings.defaultimages#/#arguments.bullet#" align="absmiddle"></cfoutput>
		</cfif>
		
		<cfif len(Sm_Title) and not arguments.menu_text>
			<cfmodule template="../customtags/putimage.cfm" filename="#Sm_Title#" filealt="#Name#" imglink="#XHTMLFormat(catlink)#" /><cfif arguments.menu_orientation is "vertical"><br/><cfelseif Count> #arguments.separator# </cfif>
		<cfelse>
			<cfoutput>
			<a href="#catlink#" class="#arguments.menu_class#" #doMouseover(qryTopCats.Name)#>#qryTopCats.Name#</a><cfif arguments.menu_orientation is "vertical"><br/><cfelseif Count> #arguments.separator# </cfif>
			</cfoutput>
		</cfif>
		
<!--- Sample code for doing sub-menus 
	<cfscript>
		if (arguments.rootcat IS 0) {
			addtext = dspCatMenu(menu_class:'menu_page2', rootcat:qryTopCats.Category_ID );
			WriteOutput(addtext);
		}
	</cfscript>
--->
		
	</cfloop>
	    </div>
	</cfsavecontent>

</cfif>

	<cfreturn strMenu>


</cffunction>

<cffunction name="dspPageMenu" displayname="Display for Page Menu" hint="Generates the text string to display the page menu." access="public" output="No" returntype="string">

	<cfargument name="parent_id" type="numeric" required="No" default="0">
	<cfargument name="menu_class" type="string" required="No" default="menu_page" hint="CSS style to use for the menu">
	<cfargument name="menu_text" type="boolean" required="No" default="1" hint="Determines whether to use text or images for menu">
	<cfargument name="menu_orientation" type="string" required="No" default="vertical" 
		hint="Determines whether to display a vertical or horizontal menu">
	<cfargument name="separator" type="string" required="No" default="&##183;" hint="Separator to use for horizontal menus.">
	
	<cfset var qryPages = getMenuPages(arguments.parent_id)>
	<cfset var Count = qryPages.RecordCount>
	<cfset var strMenu = ''>
	<cfset var pageURL = ''>
	<cfset var linkclass = ''>

	<cfsavecontent variable="strMenu">
	<cfoutput><div class="#arguments.menu_class#"></cfoutput>
	
	<cfoutput query="qryPages" group="titlepriority">

		<cfoutput>
		<cfset Count = Count - 1>
	
		<cfif qryPages.istitle>
			<cfset linkclass = arguments.menu_class & "_title">
		<cfelse>
			<cfset linkclass = arguments.menu_class>
		</cfif>
		
		<cfif len(qryPages.page_url) and qryPages.page_url is not "none">
		
			<cfif Request.AppSettings.UseSES AND FindNoCase("fuseaction=page.", qryPages.page_url) AND len(qryPages.PageAction)>
				<cfset pageURL = "#Request.StoreURL##Request.SESindex#page/#qryPages.PageAction#/#SESFile(qryPages.Page_Name)#">
			<cfelseif FindNoCase("http",qryPages.page_url)>
				<cfset pageURL = qryPages.page_url>
			<cfelse>
				<cfset pageURL = Request.StoreURL & qryPages.page_url>
			</cfif>
			
			<cfif Right(pageURL, 4) IS ".cfm">
				<cfset pageURL = PageURL & Request.Token1>
			<cfelseif NOT FindNoCase("http",qryPages.page_url)>
				<cfset pageURL = PageURL & Request.Token2>
			</cfif>
			
			<a href="#pageURL#" class="#linkclass#" #doMouseover(qryPages.Page_Name)# <cfif len(qryPages.href_attributes)>#qryPages.href_attributes#</cfif>>
		</cfif>
		
		<cfif len(qryPages.sm_title) and not arguments.menu_text>
			<cfmodule template="../customtags/putimage.cfm" filename="#qryPages.sm_title#" filealt="#qryPages.Page_Name#" />
		<cfelse>
			<span class="#linkclass#">#qryPages.Page_Name#</span>
		</cfif>
		
		<cfif len(qryPages.page_url) and qryPages.page_url is not "none"></a></cfif>
		
		<cfif arguments.menu_orientation is "vertical"><br/><cfelse><cfif Count> #arguments.separator# </cfif></cfif>
	</cfoutput>
			<br/>
	</cfoutput>	
	
	<cfoutput>
	    </div>
	</cfoutput>
	
	<!--- Include Admin Links
			Page Permission 2 = menu admin ---->
		<cfmodule template="../../access/secure.cfm" keyname="page" requiredPermission="1">	
		<span class="menu_admin">[ <a href="<cfoutput>#Request.SecureURL##request.self#?fuseaction=page.admin&amp;page=list#Request.AddToken#" </cfoutput> class="menu_admin" <cfif Request.AppSettings.admin_new_window>target="_blank"</cfif>>EDIT MENU</a>]</span>
		<br/>
		</cfmodule>
		<br/>

	</cfsavecontent>
	
	<cfreturn strMenu>


</cffunction>

<cffunction name="getTopCats" displayname="Get Top Level Categories" hint="Gets the list of top level categories. Can send in a root category ID to retrieve a different sublevel of categories." access="public" returntype="query" output="No">

	<cfargument name="rootcat" type="numeric" required="Yes">
	<cfargument name="reset" required="No" default="no" hint="Set whether to refresh the cached query.">
	
	<cfset var qry_get_topcats = ''>
	
	<cfif arguments.reset>
		<cfset Request.Cache = CreateTimeSpan(0, 0, 0, 0)>
	</cfif>			
	
	<cfquery name="qry_get_topcats" datasource="#Request.DS#" username="#Request.user#" 
		password="#Request.pass#" cachedwithin="#Request.Cache#">
	SELECT Sm_Image, Sm_Title, Short_Desc, Category_ID, Name, Highlight, Sale 
	FROM #Request.DB_Prefix#Categories
	WHERE Parent_ID = #Val(arguments.rootcat)#
	AND Display = 1
	ORDER BY Priority, Name
	</cfquery>
	
	<cfreturn qry_get_topcats>

</cffunction>

<cffunction name="getBestSellers" displayname="Get Best Sellers" hint="Gets the list of best-selling products. Can send in max number of products to retrieve." access="public" returntype="query" output="No">

	<cfargument name="maxnum" type="numeric" required="No" default="10">
	<cfargument name="reset" required="No" default="no" hint="Set whether to refresh the cached query.">
	
	<cfset var qry_get_bestsellers = ''>
	
	<cfif arguments.reset>
		<cfset Request.Cache = CreateTimeSpan(0, 0, 0, 0)>
	</cfif>			
	
	<cfquery name="qry_get_bestsellers" datasource="#Request.DS#" username="#Request.user#" 
		password="#Request.pass#" maxrows="#arguments.maxnum#" cachedwithin="#Request.Cache#">
		SELECT Max(P.Name) AS Name, P.Product_ID, 
		SUM(O.Quantity) AS ProductsSold_Sum
		FROM #Request.DB_Prefix#Order_Items O, #Request.DB_Prefix#Order_No N, #Request.DB_Prefix#Products P
		WHERE N.Order_No = O.Order_No
		AND P.Product_ID = O.Product_ID
		AND N.Void = 0
		AND P.Display = 1
		GROUP BY P.Product_ID
		ORDER BY 3 DESC
	</cfquery>
	
	<cfreturn qry_get_bestsellers>

</cffunction>

<cffunction name="dspBestSellers" displayname="Display Best Seller List" hint="Generates the text list of best sellers." access="public" output="No" returntype="string">

	<cfargument name="maxnum" type="numeric" required="No" default="10" hint="The number of best sellers to display">
	<cfargument name="menu_class" type="string" required="No" default="menu_page" hint="CSS style to use for the list">
	<cfargument name="bullet" type="string" required="No" default="" hint="Bullet image to use, if any">
	
	<cfset var qryBestSellers = getBestSellers(arguments.maxnum)>
	<cfset var strList = ''>
	<cfset var prodlink = ''>

	<cfsavecontent variable="strList"> 
	
	<cfloop query="qryBestSellers">
		
		<cfif Request.AppSettings.UseSES>
			<cfset prodlink = "#Request.StoreURL##Request.SESindex#product/#qryBestSellers.Product_ID#/#SESFile(qryBestSellers.Name)##Request.Token1#">
		<cfelse>
			<cfset prodlink = "#Request.StoreURL##request.self#?product=#qryBestSellers.Product_ID##Request.Token2#">
		</cfif>
				
		<cfoutput>
			<cfif len(arguments.bullet)><img src="#request.appsettings.defaultimages#/#arguments.bullet#" align="absmiddle"></cfif>
			<a href="#prodlink#" class="#arguments.menu_class#" #doMouseover(qryBestSellers.Name)#>#qryBestSellers.Name#</a><br/>
		</cfoutput>
		
	</cfloop>
	</cfsavecontent>

	<cfreturn strList>

</cffunction>

<!--- Get All Categories --->
<cffunction name="getAllCats" output="No" returntype="query" hint="Get query with all store categories">
	<cfargument name="reset" required="No" default="no" hint="Set whether to refresh the cached query.">
	<cfset var qAllCats = "">
	
	<cfif arguments.reset>
		<cfset Request.Cache = CreateTimeSpan(0, 0, 0, 0)>
	</cfif>
	
	<cfquery name="qAllCats" datasource="#Request.DS#" username="#Request.user#" 
			password="#Request.pass#" cachedwithin="#Request.Cache#">
		SELECT Name, Parent_ID, Category_ID, Priority,
			(SELECT COUNT(*)
			FROM #Request.DB_Prefix#Categories AS Cat2
			WHERE Cat2.Parent_ID = C.Category_ID) AS subcats        
		FROM #Request.DB_Prefix#Categories C 
		WHERE Display = 1
		ORDER BY Parent_ID, Priority
	</cfquery>  
	                      
	<cfreturn qAllCats>   
</cffunction>

<cffunction name="getCats" output="No" returntype="query" hint="Get a subgroup of categories from the entire category list">
	<cfargument name="qryAllCats" type="query">
	<cfargument name="Parent_ID" type="numeric" default="0">
	<cfset var qGetCats = "">
	
	<cfquery name="qGetCats" dbtype="query">
		SELECT * FROM arguments.qryAllCats
		WHERE Parent_ID = #arguments.Parent_ID#
		ORDER BY Priority
	</cfquery> 
	                       
	<cfreturn qGetCats> 
</cffunction>
    
<!--- recursive function to populate categories into tree structure --->
<cffunction name="categoryTreeCreator" output="No" returntype="string" hint="Populate categories into tree structure using recursive calls">
	<cfargument name="CatData" type="query">
	<cfargument name="Parent_ID" type="numeric" default="0">	
	<cfset var result="">
	<cfset var qryGetCats = getCats(arguments.CatData,arguments.Parent_ID)>
	
	<cfloop query="qryGetCats">
		<cfif Request.AppSettings.UseSES>
			<cfset catlink = "#Request.StoreURL##Request.SESindex#category/#qryGetCats.Category_ID#/#SESFile(qryGetCats.Name)##Request.Token1#">
		<cfelse>
			<cfset catlink = "#Request.StoreURL##request.self#?category=#qryGetCats.Category_ID##Request.Token2#">
		</cfif>       
		<cfset result=result & "<Item><URL>#catlink#</URL><Name>#qryGetCats.name#</Name>">
		<cfif qryGetCats.subCats GT 0>  
			<cfset result=result & variables.LineBreak>
			<cfset result = result & categoryTreeCreator(arguments.CatData,qryGetCats.Category_ID)> 
		</cfif>                     
		<cfset result = result & "</Item>" & variables.LineBreak>          
	</cfloop>   
	      
	<cfreturn result>
</cffunction>
   
<!--- populate categories into xml string --->
<cffunction name="xmlCatTreeCreator" output="No" returntype="string" hint="Populate categories into an XML string for use with store menus">
	<cfscript>
		var xmlstring = '<?xml version="1.0" encoding="iso-8859-1"?>' & variables.LineBreak;
		var qAllCats = getAllCats();
		var catxmlString = categoryTreeCreator(qAllCats);
	</cfscript>
	
	<cfset xmlstring = xmlstring & '<menu>' & variables.LineBreak>
	<cfset xmlstring = xmlstring & catxmlstring & "</menu>" & variables.LineBreak>
	
	<cfreturn XHTMLFormat(xmlString)>
</cffunction>


<!--- Get All Pages --->
<cffunction name="getAllPages" output="No" returntype="query" hint="Get query with all store pages">
	<cfargument name="reset" required="No" default="no" hint="Set whether to refresh the cached query.">
	
	<cfset var qAllPages = "">
	
	<cfif arguments.reset>
		<cfset Request.Cache = CreateTimeSpan(0, 0, 0, 0)>
	</cfif>
	
	<cfquery name="qAllPages" datasource="#Request.DS#" username="#Request.user#" 
			password="#Request.pass#" cachedwithin="#Request.Cache#">
		<cfif Request.dbtype IS "Access">
			SELECT IIF(A.Title_Priority=0,B.Title_Priority,A.Title_Priority) AS titlepriority,
		<cfelse>
			SELECT CASE WHEN A.Title_Priority=0 THEN B.Title_Priority ELSE A.Title_Priority END AS titlepriority,
		</cfif>
		A.Title_Priority AS istitle, A.Parent_ID, A.Page_ID, A.Priority, A.Page_URL, A.Page_Name, A.Href_Attributes, A.PageAction,
			(SELECT COUNT(*)
			FROM #Request.DB_Prefix#Pages AS Page2
			WHERE Page2.Parent_ID = A.Page_ID
			AND Page2.Title_Priority = 0) AS subpages        
		FROM #Request.DB_Prefix#Pages A, #Request.DB_Prefix#Pages B
		WHERE A.Parent_ID = B.Page_ID
		AND A.Display = 1
		AND A.Page_ID <> 0
		ORDER BY 1, 2
	</cfquery>  
	                      
	<cfreturn qAllPages>   
</cffunction>

<cffunction name="getPages" output="No" returntype="query" hint="Get a subgroup of pages from the entire page list">
	<cfargument name="qryAllPages" type="query">
	<cfargument name="Parent_ID" type="numeric" default="0">
	<cfset var qGetPages = "">
	
	<cfquery name="qGetPages" dbtype="query">
		SELECT * FROM arguments.qryAllPages
		WHERE Parent_ID = #arguments.Parent_ID#
		<!--- Get header menu items --->
		<cfif arguments.Parent_ID IS 0>
		OR Page_ID = Parent_ID
		<cfelse>
		AND Page_ID <> Parent_ID
		</cfif>
		ORDER BY titlepriority, Priority
	</cfquery> 
	                       
	<cfreturn qGetPages> 
</cffunction>

<!--- recursive function to populate pages into tree structure --->
<cffunction name="pageTreeCreator" output="No" returntype="string" hint="Populate pages into tree structure using recursive calls">
	<cfargument name="PageData" type="query">
	<cfargument name="Parent_ID" type="numeric" default="0">	
	<cfset var result="">
	<cfset var qryPages = getPages(arguments.PageData,arguments.Parent_ID)>
	
	<cfloop query="qryPages">
		<cfif len(qryPages.page_url) and qryPages.page_url is not "none">
			<cfif Request.AppSettings.UseSES AND FindNoCase("fuseaction=page.", qryPages.page_url) AND len(qryPages.PageAction)>
				<cfset pageURL = "#Request.StoreURL##Request.SESindex#page/#qryPages.PageAction#/#SESFile(qryPages.Page_Name)#">
			<cfelseif FindNoCase("http",qryPages.page_url)>
				<cfset pageURL = qryPages.page_url>
			<cfelse>
				<cfset pageURL = Request.StoreURL & qryPages.page_url>
			</cfif>
			
			<cfif Right(pageURL, 4) IS ".cfm">
				<cfset pageURL = PageURL & Request.Token1>
			<cfelse>
				<cfset pageURL = PageURL & Request.Token2>
			</cfif>
			<cfset result=result & "<Item><URL>#pageURL#</URL><Name>#qryPages.Page_Name#</Name>">
		<cfelse>
			<cfset result=result & "<Item><Name>#qryPages.Page_Name#</Name>">
		</cfif>      
		
		<cfif qryPages.subPages GT 0>  
			<cfset result=result & variables.LineBreak>
			<cfset result = result & pageTreeCreator(arguments.PageData,qryPages.Page_ID)> 
		</cfif>                     
		<cfset result = result & "</Item>" & variables.LineBreak>          
	</cfloop>   
	      
	<cfreturn result>
</cffunction>

<!--- populate page into xml string --->
<cffunction name="xmlPageTreeCreator" output="No" returntype="string" hint="Populate pages into an XML string for use with menus">
	<cfscript>
		var xmlstring = '<?xml version="1.0" encoding="iso-8859-1"?>' & variables.LineBreak;
		var qAllPages = getAllPages();
		var pagexmlString = pageTreeCreator(qAllPages);
	</cfscript>
	
	<cfset xmlstring = xmlstring & '<menu>' & variables.LineBreak>
	<cfset xmlstring = xmlstring & pagexmlString & "</menu>" & variables.LineBreak>
	
	<cfreturn XHTMLFormat(xmlString)>
</cffunction>

<cffunction name="getMenuPages" displayname="Get the Pages for store menus" hint="Gets the list of pages for the store menus." access="public" returntype="query" output="No">

	<cfargument name="parent_id" type="numeric" required="No" default="0">
	<cfargument name="reset" required="No" default="no" hint="Set whether to refresh the cached query.">
	
	<cfset var qry_Get_menupages = ''>
	
	<cfif arguments.reset>
		<cfset Request.Cache = CreateTimeSpan(0, 0, 0, 0)>
	</cfif>	

	<cfquery name="qry_Get_menupages" datasource="#Request.DS#" username="#Request.user#" 
		password="#Request.pass#" cachedwithin="#Request.Cache#">
		<cfif Request.dbtype IS "Access">
			SELECT IIF(A.Title_Priority=0,B.Title_Priority,A.Title_Priority) AS titlepriority,
		<cfelse>
			SELECT CASE WHEN A.Title_Priority=0 THEN B.Title_Priority ELSE A.Title_Priority END AS titlepriority,
		</cfif>
		A.Title_Priority AS istitle, A.Parent_ID, A.Priority, B.Title_Priority, A.Page_ID, 
		A.Sm_Image, A.Sm_Title, A.Page_URL, A.Page_Name, A.Href_Attributes, A.PageAction
		FROM #Request.DB_Prefix#Pages A, #Request.DB_Prefix#Pages B
		WHERE A.Parent_ID = B.Page_ID AND
		<cfif arguments.parent_id IS NOT 0>
		A.Parent_ID = #Val(arguments.parent_ID)# AND
		</cfif>
		A.Display = 1
		AND A.Page_ID <> 0
		ORDER BY 1, 2 DESC, A.Priority
	</cfquery>

	<cfreturn qry_Get_menupages>

</cffunction>

<cffunction name="doSpryData" output="No" returntype="string" access="remote" displayname="do Spry Data" hint="This function returns all the various pending item strings to use for updating the admin menu. Returns XML string with the various pending items for use with Spry.">
	
	<cfscript>
		var XMLString = '<PendingItems>';
		XMLString = XMLString & '<Memberships>' & getValidMemberships() & '</Memberships>';
		XMLString = XMLString & '<UserCCs>' & getValidUserCCs() & '</UserCCs>';
		XMLString = XMLString & '<Errors>' & getErrorDumps() & '</Errors>';
		XMLString = XMLString & '<Orders>' & getPendingOrders() & '</Orders>';
		XMLString = XMLString & '<Reviews>' & getPendingReviews() & '</Reviews>';
		XMLString = XMLString & '<Comments>' & getPendingComments() & '</Comments>';
		XMLString = XMLString & '</PendingItems>';
	</cfscript>

	<cfreturn XMLString>

</cffunction>

<cffunction name="getValidMemberships" output="No" returntype="string" access="public" displayname="Get Memberships needing Validation." hint="This function retrieves the number of memberships needing validation and returns a string. Used to update the admin menu.">

	<cfscript>
		var txtString = '';
		var qry_get_Memberships = '';
	</cfscript>
	
	<cfquery name="qry_get_Memberships"  datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
		SELECT Membership_ID FROM #Request.DB_Prefix#Memberships
		WHERE Valid = 0	
		AND (Expire >= #createODBCdate(now())# OR Expire is null)
			AND (Suspend_Begin_Date IS NULL
				OR	Suspend_Begin_Date >= #createODBCdate(now())#)
	</cfquery>
	
	<cfscript>
		txtString = qry_get_Memberships.Recordcount & " Membership" & iif(qry_get_Memberships.Recordcount neq 1, DE('s'), DE(''));
	</cfscript>
	
	<cfreturn txtString>
	
</cffunction>

<cffunction name="getValidUserCCs" output="No" returntype="string" access="public" displayname="Get Users needing CC validation" hint="This function retrieves the number of users needing validation of their credit card and returns a string. Used to update the admin menu.">

	<cfscript>
		var txtString = '';
		var qry_get_Users = '';
	</cfscript>
	
	<cfquery name="qry_get_Users"  datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
		SELECT User_ID FROM #Request.DB_Prefix#Users
		WHERE CardisValid = 0
		AND CardNumber <> ''
	</cfquery>
	
	<cfscript>
		txtString = qry_get_Users.Recordcount & " card" & iif(qry_get_Users.Recordcount neq 1, DE('s'), DE(''));	
		txtString = txtString & " require" & iif(qry_get_Users.Recordcount is 1, DE('s'), DE(''));
	</cfscript>
	
	<cfreturn txtString>
	
</cffunction>

<cffunction name="getErrorDumps" output="No" returntype="string" access="public" displayname="Get Error Dumps" hint="This function retrieves the number of current error messages and returns a string. Used to update the admin menu.">

	<cfscript>
	var txtString = '';
	var TopDirectory = GetDirectoryFromPath(ExpandPath("*.*"));
	var error_list = '';
	var FileCount = 0;
	var errorFolder = TopDirectory & 'errors' & Request.slash & 'dumps' & Request.slash;
	</cfscript>
	
	<!--- 
	pull the files 
	--->
	<cfdirectory directory="#errorFolder#" action="list" name="error_list" sort="dateLastModified DESC">
	
	<cfset FileCount=error_list.RecordCount>
		
	<!--- Remove any directories or the main file from the count --->
	<cfloop query="error_list">
		<cfif Len(Name) LT 32 OR NOT IsCFUUID(Left(Name, 32))>
			<cfset FileCount = FileCount - 1>
		</cfif>
	</cfloop>
	
	<cfscript>
		txtString = FileCount & " error report" & iif(FileCount neq 1, DE('s'), DE(''));	
	</cfscript>

	<cfreturn txtString>

</cffunction>

<cffunction name="getPendingOrders" output="No" returntype="string" access="public" displayname="Get Pending Orders" hint="This function retrieves the number of pending orders and returns a string. Used to update the admin menu.">

	<cfscript>
		var txtString = '';
		var qry_pending_orders = '';
	</cfscript>
	
	<cfquery name="qry_pending_orders"  datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
		SELECT Order_No FROM #Request.DB_Prefix#Order_No 
		WHERE NOT Filled = 1 AND NOT Process = 1
	</cfquery>
	
	<cfscript>
		txtString = qry_pending_orders.Recordcount & " Order" & iif(qry_pending_orders.Recordcount neq 1, DE('s'), DE(''));	
	</cfscript>
	
	<cfreturn txtString>
	
</cffunction>

<cffunction name="getPendingReviews" output="No" returntype="string" access="public" displayname="Get Pending Reviews" hint="This function retrieves the number of pending product reviews and returns a string. Used to update the admin menu.">

	<cfscript>
		var txtString = '';
		var qry_pending_reviews = '';
	</cfscript>
	
	<cfquery name="qry_pending_reviews"  datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
		SELECT Review_ID FROM #Request.DB_Prefix#ProductReviews 
		WHERE Approved = 0 OR NeedsCheck = 1
	</cfquery>
	
	<cfscript>
		txtString = qry_pending_reviews.Recordcount & iif(qry_pending_reviews.Recordcount eq 1, DE(' Review needs'), DE(' Reviews need'));	
	</cfscript>
	
	<cfreturn txtString>
	
</cffunction>

<cffunction name="getPendingComments" output="No" returntype="string" access="public" displayname="Get Pending Comments" hint="This function retrieves the number of pending feature comments and returns a string. Used to update the admin menu.">

	<cfscript>
		var txtString = '';
		var qry_pending_comments = '';
	</cfscript>
	
	<cfquery name="qry_pending_comments"  datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
		SELECT Review_ID FROM #Request.DB_Prefix#FeatureReviews 
		WHERE Approved = 0 OR NeedsCheck = 1
	</cfquery>
	
	<cfscript>
		txtString = qry_pending_comments.Recordcount & iif(qry_pending_comments.Recordcount eq 1, DE(' Comment needs'), DE(' Comments need'));
	</cfscript>
	
	<cfreturn txtString>
	
</cffunction>

<cffunction name="AdminProdMenu" output="No" returntype="string" access="public" displayname="Admin Product Menu" hint="This function uses the product ID to create a menu of the product editing functions for the admin.">

	<cfargument name="Product_ID" required="Yes" type="numeric">
	<cfargument name="CID" required="No" type="string" default="" hint="Category ID if passed.">

	<cfscript>
		var menuString = '';
		//starting productlink
		var prodLink = '#Request.self#?fuseaction=Product.admin&product_ID=#arguments.product_id##Request.Token2#';
		
		if (len(arguments.cid))
			prodLink = prodLink & '&cid=#arguments.cid#';
			
		menuString = "<strong>Product #arguments.product_id#<\/strong><br\/>";
		menuString = menustring & "<a href=\'#prodLink#&do=edit\'>Edit Display</a><\/a><br\/>";
		menuString = menustring & "<a href=\'#prodLink#&do=price\'>Edit Pricing</a><\/a><br\/>";
		menuString = menustring & "<a href=\'#prodLink#&do=info\'>Edit Info</a><\/a><br\/>";
		menuString = menustring & "<a href=\'#prodLink#&do=grp_price\'>Edit Group Pricing</a><\/a><br\/>";
		menuString = menustring & "<a href=\'#prodLink#&do=qty_discounts\'>Edit Quantity Discounts</a><\/a><br\/>";
		menuString = menustring & "<a href=\'#prodLink#&do=options\'>Edit Options</a><\/a><br\/>";
		menuString = menustring & "<a href=\'#prodLink#&do=addons\'>Edit Addons</a><\/a><br\/>";
		menuString = menustring & "<a href=\'#prodLink#&do=images\'>Edit Images</a><\/a><br\/>";
		menuString = menustring & "<a href=\'#prodLink#&do=related\'>Edit Related Products</a><\/a><br\/>";
		
	</cfscript>

	
	<cfreturn menuString>
	
</cffunction>

<cffunction access="private" output="false" name="isCFUUID" returntype="Numeric">
<!--- 
* Returns TRUE if the string is a valid CF UUID.
* 
* @param str 	 String to be checked. (Required)
* @return Returns a boolean. 
* @author Jason Ellison (jgedev@hotmail.com) 
* @version 1, November 24, 2003 
 --->
<cfargument name="str" type="string" required="yes">

<cfreturn REFindNoCase("^[0-9A-F]{8}[0-9A-F]{4}[0-9A-F]{4}[0-9A-F]{16}$", arguments.str)>

</cffunction>


</cfcomponent>


