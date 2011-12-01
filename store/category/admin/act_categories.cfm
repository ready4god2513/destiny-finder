
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Performs the admin actions for categories: add, update, delete. Called by category.admin&category=act --->

<cfset Message = "">

<!---====== Prepare form variables =====--->
<cfif NOT isNumeric(attributes.Priority) OR attributes.Priority IS 0>
	<cfset attributes.Priority = 9999>
</cfif>

<!--- Replace double carriage returns with HTML paragraph tags. --->
<cfset HTMLBreak = Chr(60) & 'br/' & Chr(62)>
<cfset HTMLParagraph = HTMLBreak & HTMLBreak>
<cfset LineBreak = Chr(13) & Chr(10)>
<cfset Long_Desc = Replace(Trim(attributes.Long_Desc), LineBreak & LineBreak, HTMLParagraph & LineBreak & LineBreak, "ALL")>
<cfset Short_Desc = Replace(Trim(attributes.Short_Desc), LineBreak & LineBreak, HTMLParagraph & LineBreak & LineBreak, "ALL")>
<cfmodule template="../../customtags/intlchar.cfm" string="#Short_Desc#">
<cfset Short_Desc = String>

<!--- Replace any instances of the reserved characters --->
<cfset Name = Trim(attributes.Name)>
<cfset Name = ReplaceList(Name, ":", ";")>
<!----
<cfset Name = HTMLEditFormat(Name)>
--->
<!--- Calculate Parent Strings ---->
<cfset Parent_ID = attributes.PID>
<cfinclude template="act_calc_parents.cfm">


<cfswitch expression="#mode#">
	<cfcase value="i">
	
		<cftransaction isolation="SERIALIZABLE">
				
		<cfquery name="Add_Record" datasource="#Request.ds#" username="#Request.user#"  password="#Request.pass#">
		INSERT INTO #Request.DB_Prefix#Categories
		(Parent_ID, CatCore_ID, Name, Short_Desc, Long_Desc, Metadescription, Keywords, TitleTag, 
		Sm_Image, Lg_Image, Sm_Title, Lg_Title, PassParam, AccessKey, CColumns, PColumns, Color_ID, 
		ProdFirst, Display, Priority, Highlight, Sale, ParentIDs, ParentNames, DateAdded)
		VALUES(
		#Attributes.Pid#,
		#Attributes.Catcore_ID#,
		'#Name#',
		'#Short_Desc#',
		'#long_desc#',
		'#Trim(metadescription)#',
		'#Trim(keywords)#',
		'#Trim(attributes.titletag)#',
		'#Trim(Attributes.Sm_Image)#',
		'#Trim(Attributes.Lg_Image)#',
		'#Trim(Attributes.Sm_Title)#',
		'#Trim(Attributes.Lg_Title)#',
		'#Trim(attributes.Passparam)#',
		<cfif len(trim(Attributes.AccessKey))>#Trim(Attributes.AccessKey)#,<cfelse>0,</cfif>
		<cfif len(trim(Attributes.CColumns)) AND Attributes.CColumns GTE 1>#Attributes.CColumns#,<cfelse>NULL,</cfif>
		<cfif len(trim(Attributes.PColumns)) AND Attributes.PColumns GTE 1>#Attributes.PColumns#,<cfelse>NULL,</cfif>
		<cfif isNumeric(attributes.Color_ID)>#attributes.Color_ID#,<cfelse>NULL,</cfif>
		#Attributes.ProdFirst#,
		#Attributes.Display#,
		#Attributes.Priority#,
		#Attributes.Highlight#,
		#Attributes.sale#,
		'#CatIDs#',
		'#CatNames#',
		#createODBCdate(Now())#)
			</cfquery>	

		<cfquery name="Get_id" datasource="#Request.ds#" username="#Request.user#"  password="#Request.pass#">
			SELECT MAX(Category_ID) AS maxid 
			FROM #Request.DB_Prefix#Categories
			</cfquery>
		
		<cfset attributes.CID = get_id.maxid>
		
		</cftransaction>
		
		<cfinclude template="act_update_discounts.cfm">
		
	</cfcase>
			
	<cfcase value="u">
		<cfif frm_submit is "Delete">
		
			<cfinclude template="act_delete_category.cfm">
							
		<cfelse>
					
			<!--- Make changes to discounts --->
			<cfinclude template="act_update_discounts.cfm">
					
			<cfquery name="Update_Categories" datasource="#Request.ds#" username="#Request.user#" password="#Request.pass#">
			UPDATE #Request.DB_Prefix#Categories
			SET 	
			Parent_ID = #attributes.PID#,
			CatCore_ID = #attributes.Catcore_ID#,
			Name = '#Name#',
			Short_Desc = '#Short_Desc#',
			Long_Desc = '#Long_Desc#',
			Metadescription = '#Trim(metadescription)#',
			Keywords = '#Trim(keywords)#',
			TitleTag = '#Trim(attributes.titletag)#',
			Sm_Image = '#Trim(attributes.Sm_Image)#',
			Lg_Image = '#Trim(attributes.Lg_Image)#',
			Sm_Title = '#Trim(attributes.Sm_Title)#',
			Lg_Title = '#Trim(attributes.Lg_Title)#',
			PassParam = '#Trim(attributes.Passparam)#',
			AccessKey = <cfif len(trim(Attributes.AccessKey))>#Trim(Attributes.AccessKey)#,<cfelse>0,</cfif>
			CColumns = <cfif len(trim(attributes.CColumns)) AND attributes.CColumns GTE 1>#attributes.CColumns#,<cfelse>NULL,</cfif>
			PColumns = <cfif len(trim(attributes.PColumns))  AND attributes.PColumns GTE 1>#attributes.PColumns#,<cfelse>NULL,</cfif>
			Color_ID = <cfif isNumeric(attributes.Color_ID)>#attributes.Color_ID#,<cfelse>NULL,</cfif>
			ProdFirst = #attributes.ProdFirst#,
			Display = #attributes.Display#,
			Priority = #attributes.Priority#,
			Highlight = #attributes.Highlight#,
			Sale = #attributes.sale#,
			ParentIDs = '#CatIDs#',
			ParentNames = '#CatNames#'
			WHERE Category_ID = #attributes.CID#
			</cfquery>
			
			<!--- If changes made to discounts, update any products in the category --->
			<cfif isDefined("attributes.Discounts") and Compare(attributes.Discounts, attributes.CurrDiscounts) IS NOT 0>
				<cfinclude template="act_update_proddiscounts.cfm">			
			</cfif>
				
			<cfinclude template="act_update_children.cfm">

		</cfif>
	
	</cfcase>

</cfswitch>	

<cfscript>
	//Update top category queries
	Application.objMenus.getTopCats(rootcat="0", reset='yes');
	//Update all categories query
	Application.objMenus.getAllCats(reset='yes');
	
	//Update current user's menus
	StructDelete(Session, 'SideMenus');
</cfscript>	

		