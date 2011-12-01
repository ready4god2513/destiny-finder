
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Performs the admin actions for pages: add, update, delete. Called by page.admin&do=act --->

<!---====== Prepare form variables =====--->
<cfif NOT isNumeric(attributes.Priority) OR attributes.Priority IS 0>
	<cfset attributes.Priority = 9999>
</cfif>

<!--- Replace double carriage returns with HTML paragraph tags. --->
<cfset HTMLBreak = Chr(60) & 'br/' & Chr(62)>
<cfset HTMLParagraph = HTMLBreak & HTMLBreak>
<cfset LineBreak = Chr(13) & Chr(10)>
<cfset attributes.PageText = Replace(Trim(attributes.PageText), LineBreak & LineBreak, HTMLParagraph & LineBreak & LineBreak, "ALL")>

		
<cfswitch expression="#mode#">
	<cfcase value="i">

		<cftransaction isolation="SERIALIZABLE">

		<cfquery name="Get_id" datasource="#Request.ds#" username="#Request.user#"  password="#Request.pass#">
			SELECT MAX(Page_ID) AS maxid 
			FROM #Request.DB_Prefix#Pages
			</cfquery>
		
		<cfif get_id.maxid gt 0>
			<cfset attributes.Page_ID = get_id.maxid + 1>
		<cfelse>
			<cfset attributes.Page_ID = 1>
		</cfif>
		
		<cfif trim(attributes.page_url) is "">
			<cfif len(trim(attributes.PageAction))>
				<cfset attributes.page_url = "#self#?fuseaction=page.#trim(attributes.pageaction)#">
			<cfelse>
				<cfset attributes.page_url = "#self#?fuseaction=page.display&page_id=#attributes.page_ID#">
			</cfif>
		</cfif>
		
		<cfif attributes.parent_id is "HEADER">
			<cfset attributes.Parent_id = attributes.Page_id>
			<cfset title_priority = attributes.priority>
			<cfset attributes.priority = 0>
		<cfelse>
			<cfset title_priority = 0>
		</cfif>

		<cfquery name="Add_Record" datasource="#Request.ds#" username="#Request.user#"  password="#Request.pass#">
		INSERT INTO #Request.DB_Prefix#Pages
			(Page_ID, Page_URL, Display, Page_Name, PageAction, Page_Title, Sm_Title, Lg_Image, Lg_Title, 
			CatCore_ID, PassParam, Color_ID, PageText, Priority, Href_Attributes, AccessKey, 
			Parent_ID, Title_Priority, TitleTag, Metadescription, Keywords)
		VALUES(
			#attributes.Page_ID#,
			'#Attributes.page_url#',
			#Attributes.Display#,
			'#trim(Attributes.Page_name)#',
			'#Attributes.PageAction#',
			'#trim(Attributes.Page_title)#',
			'#Attributes.sm_title#',
			'#Attributes.Lg_image#',
			'#Attributes.Lg_title#',
			<cfif len(trim(Attributes.Catcore_ID))>#Trim(Attributes.Catcore_ID)#,<cfelse>0,</cfif>
			'#Attributes.Passparam#',
			<cfif isNumeric(attributes.Color_ID)>#attributes.Color_ID#,<cfelse>NULL,</cfif>
			'#Attributes.PageText#',
			#Attributes.Priority#,
			'#Attributes.href_attributes#',
			<cfif len(trim(Attributes.AccessKey))>#Trim(Attributes.AccessKey)#,<cfelse>0,</cfif>
			 #Attributes.parent_id#,
			 #title_priority#,
			 '#Trim(Attributes.titletag)#',
			 '#Trim(Attributes.metadescription)#',
			 '#Trim(Attributes.keywords)#'
			)
			</cfquery>	
		</cftransaction>
		
		<!--- ADDITIONAL PROCESSING HERE ----->
		
		</cfcase>
			
		<cfcase value="u">
			<cfif frm_submit is "Delete">
				
				<cfquery name="delete_images"  datasource="#Request.ds#" 
				username="#Request.user#" password="#Request.pass#">
				SELECT Lg_Image, Lg_Title
				FROM #Request.DB_Prefix#Pages WHERE
				Page_ID = #attributes.Page_ID#
				</cfquery>		
				
				<cfset attributes.image_list="">		
				<cfif len(delete_images.lg_image)>
					<cfset attributes.image_list = listappend(attributes.image_list,delete_images.lg_image)>
				</cfif>
				<cfif len(delete_images.lg_title)>
					<cfset attributes.image_list = listappend(attributes.image_list,delete_images.lg_title)>
				</cfif>		
								
				<cfquery name="delete_Page"  datasource="#Request.ds#" 
				username="#Request.user#" password="#Request.pass#">
				DELETE FROM #Request.DB_Prefix#Pages 
				WHERE Page_ID = #attributes.Page_ID#
				</cfquery>
												
			<cfelse>
			
				<cfif trim(attributes.page_url) is "">
					<cfif len(trim(attributes.PageAction))>
						<cfset attributes.page_url = "#self#?fuseaction=page.#trim(attributes.pageaction)#">
					<cfelse>
						<cfset attributes.page_url = "#self#?fuseaction=page.display&page_id=#attributes.page_ID#">
					</cfif>
				</cfif>
		
				<cfif trim(attributes.parent_id) is "HEADER">
					<cfset attributes.Parent_id = attributes.Page_id>
					<cfset title_priority = attributes.priority>
					<cfset attributes.priority = 0>
				<cfelse>
					<cfset title_priority = 0>
				</cfif>
				
				<cfquery name="EditPage" datasource="#Request.DS#" username="#Request.user#" 
					password="#Request.pass#">
				UPDATE #Request.DB_Prefix#Pages
				SET 
				Page_URL = '#Trim(attributes.page_url)#',
				Display = #attributes.Display#,
				Page_Name = '#page_name#',
				Page_Title = '#page_title#',
				PageAction = '#Attributes.PageAction#',
				Sm_Title = <cfif len(attributes.Sm_Title)>'#Trim(attributes.Sm_Title)#',<cfelse>NULL,</cfif>
				Lg_Title = <cfif len(attributes.lg_title)>'#Trim(attributes.lg_title)#',<cfelse>NULL,</cfif>
				Lg_Image = <cfif len(attributes.lg_image)>'#Trim(attributes.lg_image)#',<cfelse>NULL,</cfif>
				PassParam = <cfif len(attributes.passparam)>'#Trim(attributes.passparam)#',<cfelse>NULL,</cfif>
				CatCore_ID = <cfif len(trim(Attributes.Catcore_ID))>#Trim(Attributes.Catcore_ID)#,<cfelse>0,</cfif>
				Color_ID = <cfif isNumeric(attributes.Color_ID)>#attributes.Color_ID#,<cfelse>NULL,</cfif>
				Href_Attributes = <cfif len(attributes.href_attributes)>'#Trim(attributes.href_attributes)#',<cfelse>NULL,</cfif>
				AccessKey = <cfif len(trim(Attributes.AccessKey))>#Trim(Attributes.AccessKey)#,<cfelse>0,</cfif>
				Parent_ID = #attributes.parent_id#,
				PageText = '#PageText#',
				Priority = #attributes.Priority#,
				Title_Priority = #title_priority#,
				TitleTag = '#Trim(attributes.titletag)#',
				Metadescription = '#Trim(attributes.metadescription)#',
				Keywords = '#Trim(attributes.keywords)#'
				WHERE Page_ID = #attributes.Page_ID#
				</cfquery>
							
			</cfif>
		
		</cfcase>

	</cfswitch>	
	

<cfscript>
	//Update main page queries
	Application.objMenus.getMenuPages(reset='yes');
	Application.objMenus.getAllPages(reset='yes');
	
	//Update current user's menus
	if (isDefined("Session.SideMenus"))
		StructDelete(Session, 'SideMenus');
</cfscript>	


	



				
			
