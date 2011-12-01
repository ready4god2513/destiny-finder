
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Makes a user an affiliate by assigning an Affiliate Code. Called by users.admin&user=affiliate --->

<cfset message="">

<cfif attributes.percentage is "">
	<cfset attributes.percentage = 0>
</cfif>

<cfset Percent = attributes.Percentage/100>

<!--- Affiliate Update --->
<cfif attributes.Affiliate_ID IS NOT 0 AND attributes.submit_aff IS "Save">

	<cfquery name="EditAff" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
		UPDATE #Request.DB_Prefix#Affiliates
		SET AffPercent = #Percent#,
		Aff_Site = '#attributes.Aff_Site#'
		WHERE Affiliate_ID = #attributes.Affiliate_ID#
	</cfquery>
	
<!--- Affiliate Removal --->
<cfelseif attributes.Affiliate_ID IS NOT 0 AND attributes.submit_aff IS "Remove">

	<!--- Update any orders for this affiliate first --->
	<cfquery name="UpdOrders" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
		UPDATE #Request.DB_Prefix#Order_No
		SET Affiliate = 0
		WHERE Affiliate = #attributes.AffCode#	
	</cfquery>
	
	<!--- Update the user account --->
	<cfquery name="UpdUser" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
		UPDATE #Request.DB_Prefix#Users
		SET Affiliate_ID = 0
		WHERE User_ID = #attributes.UID#
	</cfquery>
	
	<!--- Remove the affiliate record --->
	<cfquery name="EditAff" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
		DELETE FROM #Request.DB_Prefix#Affiliates
		WHERE Affiliate_ID = #attributes.Affiliate_ID#
	</cfquery>
	
<!--- Add new affiliate --->
<cfelse>
	
	<!--- UUID to tag new inserts --->
	<cfset NewIDTag = CreateUUID()>
	<!--- Remove dashes --->
	<cfset NewIDTag = Replace(NewIDTag, "-", "", "All")>

	<cfset Code = "">

	<cfloop condition="NOT len(Code)">
		<!--- Generate an affiliate code --->
		<cfset r = Randomize(Minute(now())&Second(now()))>
		<cfset Code = RandRange(10000,99999)>
	
		<!--- Make sure code is not already in use --->
		<cfquery name="GetCode" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
			SELECT AffCode FROM #Request.DB_Prefix#Affiliates
			WHERE AffCode = #Code#
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
			VALUES ('#NewIDTag#', #Percent#, #Code#, '#attributes.Aff_Site#')
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

	<cfset attributes.affiliate_ID = AddAffiliate.newID>

	<cfquery name="EditUser" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
		UPDATE #Request.DB_Prefix#Users
		SET Affiliate_ID = #attributes.affiliate_ID#
		WHERE User_ID = #attributes.UID#
	</cfquery>
	
	<cfset message="a">

</cfif>

<cfmodule template="../../../customtags/format_admin_form.cfm"
	box_title="Affiliate Information"
	Width="350"
	required_fields="0"
	>
		
	<tr><td align="center" class="formtitle">
		<br/>
		<cfif message is "a">
			Affiliate Added<br/><br/>
			The Affiliate Code for this user is <cfoutput>#Code#</cfoutput>.
			
		<cfelseif attributes.submit_aff IS "Save">
			Affiliate Updated
			
		<cfelseif attributes.submit_aff IS "Remove">
			Affiliate Removed
		</cfif>
		
		<br/><br/>
		
		<cfoutput>
		<form action="#self#?fuseaction=users.admin&user=list#request.token2#" method="post">
		</cfoutput>
		<input class="formbutton" type="submit" value="Back to Users List"/>
		</form>
		<br/>
	</td></tr>
				
</cfmodule> 
      

