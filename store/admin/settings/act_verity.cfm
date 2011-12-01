

<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Used to reindex and optimize the verity collections. Called by home.admin&settings=save and home.verity --->

<cfparam name="attributes.act_verity" default="Reindex Verity Collection">

<cftry>
<cfif attributes.act_verity IS "Reindex Verity Collection">
		
		<!--- Purge Collection --->
		<cflock name="verity" type="EXCLUSIVE" timeout="60">
			<cfindex action="PURGE" collection="#Request.AppSettings.CollectionName#">
		</cflock>

		<!--- INDEX CATEGORIES --->
		<cfinclude template="../../category/qry_get_allcats.cfm">
		
		<cfset NewIDArray = ArrayNew(1)>

		<cfloop query="qry_Get_allCats">
			<cfset NewIDArray[qry_Get_allCats.CurrentRow] = "C#qry_Get_allCats.Category_ID#">
		</cfloop>
		
		<cfset QueryAddColumn(qry_Get_allCats, "New_ID", NewIDArray)>

		<cflock name="verity" type="EXCLUSIVE" timeout="300">
			<cfindex action="UPDATE"
         		collection="#Request.AppSettings.CollectionName#"
    		    key="New_ID"
        		type="CUSTOM"
         		title="Name"
         		query="qry_Get_allCats"
         		body="Name,Short_Desc,Long_Desc,Metadescription,Keywords"
         		custom1=""
         		custom2="">
		</cflock>

				<!--- INDEX PRODUCTS --->
		<cfinclude template="../../product/queries/qry_get_products_tease.cfm">
		
		<cfset NewIDArray = ArrayNew(1)>

		<cfloop query="qry_Get_products_tease">
			<cfset NewIDArray[qry_Get_products_tease.CurrentRow] = "P#qry_Get_products_tease.Product_ID#">
		</cfloop>
		
		<cfset QueryAddColumn(qry_Get_products_tease, "New_ID", NewIDArray)>

		<cflock name="verity" type="EXCLUSIVE" timeout="300">
			<cfindex action="UPDATE"
         		collection="#Request.AppSettings.CollectionName#"
    		    key="New_ID"
        		type="CUSTOM"
         		title="Name"
         		query="qry_Get_products_tease"
         		body="Name,Short_Desc,Long_Desc,SKU,Metadescription,Keywords"
         		custom1="SKU"
         		custom2="">
		</cflock>
		
		<!--- INDEX FEATURES --->
		<cfquery name="GetFeatures" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
		SELECT Feature_ID, Name, Short_Desc, Long_Desc, Author, Metadescription, Keywords
		FROM #Request.DB_Prefix#Features
		WHERE Display = 1
		AND Approved = 1
		</cfquery>

		<cflock name="verity" type="EXCLUSIVE" timeout="300">
			<cfindex action="UPDATE"
         	collection="#Request.AppSettings.CollectionName#"
         	key="Feature_ID"
         	type="CUSTOM"
         	title="Name"
         	query="GetFeatures"
         	body="Name,Short_Desc,Long_Desc,Author,Metadescription,Keywords"
         	custom1=""
         	custom2="">
			</cflock>

		<!--- INDEX PAGES --->
		<cfquery name="GetPages" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
		SELECT Page_ID, Page_Name, PageText, Page_URL
		FROM #Request.DB_Prefix#Pages
		WHERE Display = 1
		</cfquery>
		
		<cfset NewIDArray = ArrayNew(1)>

		<cfloop query="GetPages">
			<cfset NewIDArray[GetPages.CurrentRow] = "G#GetPages.Page_ID#">
		</cfloop>
		
		<cfset QueryAddColumn(GetPages, "New_ID", NewIDArray)>

		<cflock name="verity" type="EXCLUSIVE" timeout="300">
			<cfindex action="UPDATE"
         	collection="#Request.AppSettings.CollectionName#"
         	key="New_ID"
         	type="CUSTOM"
         	title="Page_Name"
         	query="GetPages"
         	body="Page_Name,PageText"
         	custom1="Page_URL"
         	custom2="">
			</cflock>
		
			<cfset Complete = "Indexing Complete!">

	<!--- Optimize will only work in CF4 --->
	<cfelseif attributes.act_verity IS "Optimize Verity Collection">

		<cflock name="verity" type="EXCLUSIVE" timeout="60">
			<cfcollection action="optimize" collection="#Request.AppSettings.CollectionName#">
		</cflock>

		<cfset Complete = "Optimize Complete!">
	
	<cfelse>
	
		<cfset Complete = "An Error has Occurred">
		
	</cfif>


<cfcatch>
	<cfset Complete = "An Error has Occurred">
</cfcatch>
</cftry>	 


<cfmodule template="../../customtags/format_admin_form.cfm"
	box_title="Update Verity Search Collection"
	width="450"
	required_fields="0"
	>
	<tr><td align="center" class="formtitle">
		<br/>
	
	<cfoutput>#complete#
	<form action="#self#?fuseaction=home.admin&settings=edit#request.token2#" method="post">
	</cfoutput>
		<input class="formbutton" type="submit" value="Back to Main Settings"/>
	</form>	
	
	</td></tr>
</cfmodule> 
