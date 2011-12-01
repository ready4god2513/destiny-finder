
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Creates a copy of a feature. Called by feature.admin&feature=copy --->

<!--- Get the feature to copy --->
<cfquery name="GetFeature" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" maxrows=1>
	SELECT * FROM #Request.DB_Prefix#Features F
	WHERE F.Feature_ID = #attributes.dup#
</cfquery>

<cftransaction isolation="SERIALIZABLE">
	<cfquery name="Add_Record" datasource="#Request.ds#" username="#Request.user#"  password="#Request.pass#">
		INSERT INTO Features
			(User_ID, Feature_Type, Name, Author, Copyright, Display, Approved, Start, Expire, 
			Priority, AccessKey, Highlight, Reviewable, Display_Title, Sm_Title, Sm_Image, Short_Desc, 
			Lg_Title, Lg_Image, Long_Desc, TitleTag, Metadescription, Keywords, PassParam, Color_ID, Created)
		VALUES(
			 #GetFeature.user_ID#,
			'#GetFeature.feature_type#',
			'COPY OF #GetFeature.Name#',
			'#Trim(GetFeature.Author)#',
			'#Trim(GetFeature.copyright)#',
			 #GetFeature.display#,
			 #GetFeature.approved#,
			<cfif len(GetFeature.start)>#createODBCdate(GetFeature.start)#,<cfelse>NULL,</cfif>
			<cfif len(GetFeature.expire)>#createODBCdate(GetFeature.expire)#,<cfelse>NULL,</cfif>
			 #GetFeature.priority#,
			<cfif len(trim(GetFeature.AccessKey))>#Trim(GetFeature.AccessKey)#,<cfelse>0,</cfif>
			 #GetFeature.highlight#,
			 #GetFeature.Reviewable#,
			 #GetFeature.display_title#,
			'#Trim(GetFeature.Sm_Title)#',
			'#Trim(GetFeature.Sm_image)#',
			'#GetFeature.short_desc#',
			'#Trim(GetFeature.lg_title)#',
			'#Trim(GetFeature.lg_image)#',
			'#GetFeature.long_desc#',
			'#GetFeature.TitleTag#',
			'#GetFeature.metadescription#',
			'#GetFeature.keywords#',
			'#GetFeature.passparam#',
			<cfif isNumeric(GetFeature.Color_ID)>#GetFeature.Color_ID#,<cfelse>NULL,</cfif>
			#createODBCDate(now())#
			)
	</cfquery>	
			
	<cfquery name="Get_id" datasource="#Request.ds#" username="#Request.user#"  password="#Request.pass#">
		   SELECT MAX(Feature_ID) AS maxid
		   FROM #Request.DB_Prefix#Features
	</cfquery>
			
	<cfset attributes.Feature_id = get_id.maxid>
</cftransaction>
		
	
<!--- Copy feature categories --->
<cfquery name="GetFeatureCats" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" maxrows=1>
	SELECT Category_ID 
	FROM #Request.DB_Prefix#Feature_Category
	WHERE Feature_Category.Feature_ID = #attributes.dup#
</cfquery>

<cfloop query="GetFeatureCats">

	<cfquery name="AddFeatureCat" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	INSERT INTO #Request.DB_Prefix#Feature_Category
	(Feature_ID, Category_ID)
	VALUES (#attributes.Feature_ID#, #category_ID#)
	</cfquery>
	
</cfloop>


