
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This page is used to output breadcrumb links at the top of the page. For categories, will provide links back to the parent categories. For other pages, will display a link to the Home and the current page name. For any pages not listed, displays a welcome or login message. Called from the layout pages.  --->

<cfparam name="attributes.separator" default="&raquo;">

<!--- Used to check for invalid query strings --->
<cfparam name="invalid" default="0">
<cfparam name="attributes.ParentCat" default="">

<!--- Check if this is a category page, and use the category details query --->
<cfif isDefined("request.qry_get_cat.recordcount") and not invalid>
	<cfset CatQuery = request.qry_get_cat>
<!--- Check if this is a product page, and if a ParentCat was defined --->
<cfelseif isDefined("Request.GetRelatedCats.recordcount") and isNumeric(attributes.ParentCat) and not invalid>
	<!--- Retrieve the specific information for the selected category --->
	<cfquery name="CatQuery" dbtype="query">
	SELECT * FROM Request.GetRelatedCats
	WHERE Category_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#attributes.ParentCat#"> 
	</cfquery>
</cfif>

<cfif isDefined("CatQuery.Recordcount")>

<!--- IF THIS IS A CATEGORY PAGE, CREATE CATEGORY PARENT STRING ------>
<cfset ParentString = "">

<!--- Change the 0 below to adjust when the parent categories show up --->
<cfif Listlen(Trim(CatQuery.ParentIDs)) GT 0>
<cfloop index="num" from="1" to="#Listlen(Trim(CatQuery.ParentIDs))#">

<cfset ParentID = ListGetAt(Trim(CatQuery.ParentIDs), num)>
<cfset ParentName = ListGetAt(CatQuery.ParentNames, num, ":")>

<cfset ParentString = ListAppend(Parentstring, "<a class=""menu_trail"" href=""", ":")>

<cfif Request.AppSettings.UseSES>
	<cfset ParentString = Parentstring & "#Request.SESindex#category/#ParentID#/#SESFile(ParentName)##Request.Token1#" & """ ">
<cfelse>
	<cfset ParentString = Parentstring & "#self#?fuseaction=category.display&Category_id=#ParentID##Request.Token2#" & """ ">
</cfif>

<cfset ParentString = Parentstring & doMouseover(ParentName) & ">" & ParentName & "</a>">
</cfloop>

<cfset ParentString = "#attributes.separator# " & Replace(ParentString, ":", " #attributes.separator# ", "ALL")>

</cfif>

<cfif Request.AppSettings.UseSES>
	<cfset currentPage = "#Request.SESindex#category/#CatQuery.Category_ID#/#SESFile(CatQuery.name)##Request.Token1#">
<cfelse>
	<cfset currentPage = "#self#?fuseaction=category.display&Category_id=#CatQuery.Category_ID##Request.Token2#">
</cfif>

<cfoutput><span class="menu_trail"><a href="#self##Request.Token1#" class="menu_trail" #doMouseover('#request.appsettings.sitename# Homepage')#>Home</a> #REReplace(ParentString,"&(?!([##A-Za-z0-9]{2,6};))","&amp;","all")# #attributes.separator# <a href="#XHTMLFormat(currentPage)#" #doMouseover(CatQuery.name)# class="menu_trail">#CatQuery.name#</a></span></cfoutput>
	
<!--- IF THIS IS A STORE PAGE, DISPLAY PAGE TITLE ------>
<cfelseif isDefined("qry_get_page.recordcount") and not invalid>

	<cfoutput><div id="menu_trail"><a href="#self##request.token1#" #doMouseover(qry_get_page.page_Title)#>Home</a> #attributes.separator#  #qry_get_page.page_Title#</div></cfoutput>
	
<cfelseif not invalid>

<cfoutput>
<cfswitch expression = "#attributes.fuseaction#">
	
<!--- USER --->
	<cfcase value="users.forgot">
	<span class="menu_trail"><a class="menu_trail" href="#self##request.token1#" #doMouseover('Email Password')#>Home</a> #attributes.separator#  Email My Password</span>
	</cfcase>
	
	<cfcase value="users.register">
	<span class="menu_trail"><a class="menu_trail" href="#self##request.token1#" #doMouseover('New Member')#>Home</a> #attributes.separator#  New Member</span>
	</cfcase>
	
	<cfcase value="users.manager">
	<span class="menu_trail"><a class="menu_trail" href="#self##request.token1#" #doMouseover('My Account')#>Home</a> #attributes.separator#  My Account</span>
	</cfcase>

<!--- Shopping Cart --->

	
	<cfdefaultcase>
		<cfif Session.User_ID IS 0>			
			<cfset attributes.xfa_success = Request.LoginURL>
			<div id="menu_trail">Welcome! <a href="#XHTMLFormat('#Request.SecureURL##request.self#?fuseaction=users.manager#Request.AddToken#&xfa_login_successful=#urlEncodedFormat(attributes.xfa_success)#')#" #doMouseover('Sign In')#>Please sign in or register here</a></div>
		<cfelseif fusebox.fuseaction IS "admin">
       		<div id="menu_trail"><a href="#XHTMLFormat('#request.self#?fuseaction=home.admin#request.token2#')#" #doMouseover('Admin Menu')#>Admin Menu</a></div> 
		<cfelse>
			<div id="menu_trail">Welcome #Session.realname#!</div>
		</cfif>
	</cfdefaultcase>

</cfswitch>
</cfoutput>		

</cfif>



