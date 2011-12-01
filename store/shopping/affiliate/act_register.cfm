
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This page is used to create the affiliate code and set up the user as an affiliate. Called by shopping.affiliate&do=register --->

<cfquery name="GetAffiliate" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	SELECT Affiliate_ID, Username
	FROM #Request.DB_Prefix#Users
	WHERE User_ID = <cfqueryparam value="#Session.User_ID#" cfsqltype="CF_SQL_INTEGER">
</cfquery>

<cfif getaffiliate.affiliate_id is 0>
	
	<cfinclude template="../../users/qry_get_user_settings.cfm">
	
	<cfset Code = "">
	
	<!--- UUID to tag new inserts --->
	<cfset NewIDTag = CreateUUID()>
	<!--- Remove dashes --->
	<cfset NewIDTag = Replace(NewIDTag, "-", "", "All")>
	
	<cfloop condition="NOT len(Code)">
		<!--- Generate an affiliate code --->
		<cfset r = Randomize(Minute(now())&Second(now()))>  
		<cfset Code = RandRange(10000,99999)>
		
		<!--- Make sure code is not already in use --->
		<cfquery name="GetCode" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
		SELECT AffCode FROM #Request.DB_Prefix#Affiliates
		WHERE AffCode = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#Code#">
		</cfquery>
		
		<cfif GetCode.RecordCount>
			<cfset Code = "">
		</cfif>
	
	</cfloop>
	
	<cftransaction>
	
		<cfquery name="AddAffiliate" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
		<cfif Request.dbtype IS "MSSQL">
			SET NOCOUNT ON
		</cfif>
		INSERT INTO #Request.DB_Prefix#Affiliates
			(ID_Tag, AffPercent, AffCode, Aff_Site)
		VALUES 
			(<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#NewIDTag#">, 
			<cfqueryparam cfsqltype="CF_SQL_DOUBLE" value="#get_User_Settings.AffPercent#">, 
			<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#Code#">,
			<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#attributes.Aff_Site#">)
			<cfif Request.dbtype IS "MSSQL">
				SELECT @@Identity AS newID
				SET NOCOUNT OFF
			</cfif>
		</cfquery>
		
		<!--- Get New Affiliate Number --->
		<cfif Request.dbtype IS NOT "MSSQL">
			<cfquery name="AddAffiliate" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
			SELECT Affiliate_ID AS newID 
			FROM #Request.DB_Prefix#Affiliates
			WHERE ID_Tag = '#NewIDTag#'
			</cfquery>
		</cfif>
	
	</cftransaction>	
	
	<cfset attributes.affiliate_id = AddAffiliate.newID>
	
	<cfquery name="EditUser" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
		UPDATE #Request.DB_Prefix#Users
		SET Affiliate_ID = <cfqueryparam value="#attributes.affiliate_id#" cfsqltype="CF_SQL_INTEGER">
		WHERE User_ID = <cfqueryparam value="#Session.User_ID#" cfsqltype="CF_SQL_INTEGER">
	</cfquery>
	
	<!--- Send Admin email notice --->
	<cfset LineBreak = Chr(13) & Chr(10)>
	<cfset MergeContent = "User Name:  #GetAffiliate.Username#" & LineBreak & LineBreak>
	<cfset MergeContent = MergeContent & "Affiliate Code:  #Code#" & LineBreak & LineBreak>
	<cfset MergeContent = MergeContent & "Site URL:  #attributes.Aff_Site#" & LineBreak & LineBreak>
	
	<cfinvoke component="#Request.CFCMapping#.global" 
		method="sendAutoEmail" Email="#Request.AppSettings.Webmaster#" 
		MailAction="NewAffiliateNotice" MergeContent="#MergeContent#">
		

<cfelse>

	<!--- Make sure code is not already in use --->
	<cfquery name="GetCode" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	SELECT AffCode FROM #Request.DB_Prefix#Affiliates
	WHERE Affiliate_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#getaffiliate.affiliate_id#">
	</cfquery>

	<cfset code = getcode.affcode>

</cfif>



