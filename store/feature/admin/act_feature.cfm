
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Performs the admin actions for features: add, update, delete. Called by feature.admin&feature=act --->

<cfparam name="attributes.cid" default="">
<cfparam name="attributes.CID_list" default="">

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
			
<cfswitch expression="#mode#">
	<cfcase value="i">
		
		<cftransaction isolation="SERIALIZABLE">
			<cfquery name="Add_Record" datasource="#Request.ds#" username="#Request.user#"  password="#Request.pass#">
			INSERT INTO #Request.DB_Prefix#Features
			(User_ID, Feature_Type, Name, Author, Copyright, Display, Approved, Start, Expire, 
			Priority, AccessKey, Highlight, Reviewable, Display_Title, Sm_Title, Sm_Image, Short_Desc, 
			Lg_Title, Lg_Image, Long_Desc, TitleTag, Metadescription, Keywords, PassParam, Color_ID, Created)
			VALUES(
			 #Attributes.UID#,
			'#Attributes.feature_type#',
			'#Name#',
			'#Trim(Attributes.Author)#',
			'#Trim(Attributes.copyright)#',
			 #Attributes.display#,
			 #Attributes.approved#,
			<cfif len(attributes.start)>#createODBCdate(attributes.start)#,<cfelse>NULL,</cfif>
			<cfif len(attributes.expire)>#createODBCdate(attributes.expire)#,<cfelse>NULL,</cfif>
			 #Attributes.priority#,
			<cfif len(trim(Attributes.AccessKey))>#Trim(Attributes.AccessKey)#,<cfelse>0,</cfif>
			 #Attributes.highlight#,
			 #Attributes.Reviewable#,
			 #Attributes.display_title#,
			'#Trim(Attributes.Sm_Title)#',
			'#Trim(Attributes.Sm_image)#',
			'#short_desc#',
			'#Trim(Attributes.lg_title)#',
			'#Trim(Attributes.lg_image)#',
			'#long_desc#',
			'#Trim(Attributes.titletag)#',
			'#Trim(Attributes.metadescription)#',
			'#Trim(Attributes.keywords)#',
			'#Trim(Attributes.passparam)#',
			<cfif isNumeric(attributes.Color_ID)>#attributes.Color_ID#,<cfelse>NULL,</cfif>
			<cfif len(attributes.created)>#createODBCdate(attributes.created)#<cfelse>NULL</cfif>
			)
			</cfquery>	
			
			 <cfquery name="Get_id" datasource="#Request.ds#" username="#Request.user#"  password="#Request.pass#">
			   SELECT MAX(Feature_ID) AS maxid
			   FROM #Request.DB_Prefix#Features
			  </cfquery>
			
			  <cfset attributes.Feature_id = get_id.maxid>
		</cftransaction>
		</cfcase>
			
		<cfcase value="u">
			
			<cfquery name="delete_categories"  datasource="#Request.ds#" username="#Request.user#" password="#Request.pass#">
			DELETE FROM #Request.DB_Prefix#Feature_Category
			WHERE Feature_ID = #attributes.Feature_id#
			</cfquery>
		
			<cfif frm_submit is "Delete">
					
				<cfquery name="delete_reviews" datasource="#Request.ds#" username="#Request.user#" password="#Request.pass#">
				DELETE FROM #Request.DB_Prefix#FeatureReviews
				WHERE Feature_ID = #attributes.feature_ID#
				</cfquery>	

				<cfquery name="delete_related_prod" datasource="#Request.ds#" username="#Request.user#" password="#Request.pass#">
				DELETE FROM #Request.DB_Prefix#Feature_Product
				WHERE Feature_ID = #attributes.feature_ID#
				</cfquery>	
						
				<cfquery name="delete_related_feat" datasource="#Request.ds#" username="#Request.user#" password="#Request.pass#">
				DELETE FROM #Request.DB_Prefix#Feature_Item
				WHERE Feature_ID = #attributes.feature_ID#
				</cfquery>	
										
				<cfquery name="delete_images" datasource="#Request.ds#" username="#Request.user#" password="#Request.pass#">
				SELECT Sm_Image, Lg_Image, Sm_Title, Lg_Title
				FROM #Request.DB_Prefix#Features 
				WHERE Feature_ID = #attributes.Feature_id#
				</cfquery>		
				
				<cfset attributes.image_list="">		
				<cfif len(delete_images.sm_image)>
					<cfset attributes.image_list = listappend(attributes.image_list,delete_images.sm_image)>
				</cfif>
				<cfif len(delete_images.sm_title)>
					<cfset attributes.image_list = listappend(attributes.image_list,delete_images.sm_title)>
				</cfif>
				<cfif len(delete_images.lg_image)>
					<cfset attributes.image_list = listappend(attributes.image_list,delete_images.lg_image)>
				</cfif>
				<cfif len(delete_images.lg_title)>
					<cfset attributes.image_list = listappend(attributes.image_list,delete_images.lg_title)>
				</cfif>		
									
				<cfquery name="delete_Features"  datasource="#Request.ds#" username="#Request.user#" password="#Request.pass#">
				DELETE FROM #Request.DB_Prefix#Features 
				WHERE Feature_ID = #attributes.Feature_id#
				</cfquery>
								
			<cfelse>
				
		
				<cfquery name="Update_Features" datasource="#Request.ds#" username="#Request.user#" password="#Request.pass#">
				UPDATE #Request.DB_Prefix#Features
				SET User_ID = #attributes.UID#,
				Feature_Type = '#attributes.feature_type#',
				Name = '#Name#',
				Author = '#Trim(attributes.Author)#',
				Copyright = '#Trim(attributes.copyright)#',
				Display = #Trim(attributes.Display)#,
				Approved = #Trim(attributes.approved)#,
				Start = <cfif len(attributes.start)>#createODBCdate(attributes.start)#,<cfelse>NULL,</cfif>
				Expire = <cfif len(attributes.expire)>#createODBCdate(attributes.expire)#,<cfelse>NULL,</cfif>
				Priority = #attributes.Priority#,
				AccessKey = <cfif len(trim(Attributes.AccessKey))>#Trim(Attributes.AccessKey)#,<cfelse>0,</cfif>
				Highlight = #attributes.Highlight#,
				Reviewable = #attributes.Reviewable#,
				Display_Title = #Trim(attributes.display_title)#,
				Sm_Title = '#Trim(attributes.Sm_Title)#',
				Sm_Image = '#Trim(attributes.Sm_image)#',
				Short_Desc = '#short_desc#',
				Lg_Title = '#Trim(attributes.lg_title)#',
				Lg_Image = '#Trim(attributes.lg_image)#',
				Long_Desc = '#Trim(long_desc)#',
				TitleTag = '#Trim(attributes.titletag)#',
				Metadescription = '#Trim(attributes.metadescription)#',
				Keywords = '#Trim(attributes.keywords)#',
				PassParam = '#Trim(attributes.passparam)#',
				Color_ID = <cfif isNumeric(attributes.Color_ID)>#attributes.Color_ID#,<cfelse>NULL,</cfif>
				Created = <cfif len(attributes.Created)>#createODBCdate(attributes.Created)#<cfelse>NULL</cfif>
				WHERE Feature_ID = #attributes.Feature_id#
				</cfquery>
							
			</cfif>
		
		</cfcase>

	</cfswitch>	
	
	
	<!--- Add Category ----->
	<cfif len(attributes.CID_list) and frm_submit is not "Delete">
		<cfloop index="thisID" list="#attributes.CID_list#">
			<cfquery name="Add_Feature_Category" datasource="#Request.ds#" username="#Request.user#"  password="#Request.pass#">
			INSERT INTO #Request.DB_Prefix#Feature_Category
			(Feature_ID, Category_ID)
			VALUES(#attributes.feature_ID#, #thisID#)
			</cfquery>
		</cfloop>
	</cfif>
		
		
			


