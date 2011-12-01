
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Performs the user actions for GiftRegistry: add, update, delete.
Called by shopping.giftregistry&manage=act --->

<cfset attributes.error_message="">

<cfif len(attributes.expire_days)>
	<cfset attributes.Expire = dateadd('d',attributes.expire_days,attributes.Event_Date)>
<cfelse>
	<cfset attributes.Expire = dateadd('d','365',attributes.Event_Date)>
</cfif>

<!--- UUID to tag new inserts --->
<cfset NewIDTag = CreateUUID()>
<!--- Remove dashes --->
<cfset NewIDTag = Replace(NewIDTag, "-", "", "All")>

<cfswitch expression="#mode#">
	<cfcase value="i">
	
		<!--- check to make sure the user is valid --->
		<cfquery name="finduser" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
			SELECT User_ID FROM #Request.DB_Prefix#Users
			WHERE Username = '#attributes.UName#'
		</cfquery>

		<cfif finduser.recordcount is 1>
		
			<cftransaction>
				
			<cfquery name="Add_GiftRegistry" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
			<cfif Request.dbtype IS "MSSQL">
				SET NOCOUNT ON
			</cfif>
			INSERT INTO #Request.DB_Prefix#GiftRegistry
			(ID_Tag, User_ID, Registrant, OtherName, GiftRegistry_Type, Event_Date, Event_Name, Event_Descr, City, State,
			Private, Order_Notification, Live, Created, Expire)
			VALUES
			('#NewIDTag#', 
			#finduser.User_ID#,
			'#Trim(Attributes.Registrant)#',
			'#Trim(Attributes.OtherName)#',
			'#Trim(Attributes.GiftRegistry_Type)#',
			#createODBCDate(Attributes.Event_Date)#,
			'#Trim(Attributes.Event_Name)#',
			'#Trim(Attributes.Event_Descr)#',
			'#Trim(Attributes.City)#',
			'#Trim(Attributes.State)#',
			#Attributes.Private#,
			#Attributes.Order_Notification#,
			#Attributes.live#,
			 #createODBCdate(Now())#,
			 #createODBCdate(attributes.Expire)#
			)
			<cfif Request.dbtype IS "MSSQL">
				SELECT @@Identity AS New_ID
				SET NOCOUNT OFF
			</cfif>
			</cfquery>	
			
			<cfif Request.dbtype IS NOT "MSSQL">
				<cfquery name="Add_GiftRegistry" datasource="#Request.ds#" 
					username="#Request.user#"  password="#Request.pass#">
				   SELECT GiftRegistry_ID AS New_ID
				   FROM #Request.DB_Prefix#GiftRegistry
				   WHERE ID_Tag = '#NewIDTag#'
				 </cfquery>
			  </cfif>
	
			</cftransaction>
			
			<cfset attributes.GiftRegistry_id = Add_GiftRegistry.New_ID>
			
		<cfelse>
		
			<cfset attributes.error_message = "Can not add this Account. Not a valid User">
			
		</cfif>			
			
	</cfcase>
			
	<cfcase value="u">
		<cfif submit is "Delete">
			<!--- Delete registry items first --->
			<cfquery name="CheckItems" datasource="#Request.ds#" username="#Request.user#"  password="#Request.pass#">
			   DELETE FROM #Request.DB_Prefix#GiftItems
			   WHERE GiftRegistry_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#attributes.GiftRegistry_ID#">
			</cfquery>
		
			<cfquery name="delete_GiftRegistry"  datasource="#Request.ds#" username="#Request.user#" password="#Request.pass#">
				DELETE FROM #Request.DB_Prefix#GiftRegistry 
			    WHERE GiftRegistry_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#attributes.GiftRegistry_ID#">
			</cfquery>			
			
		<cfelse>

			<!--- Update --->
			<!--- check to make sure the user is valid --->
			<cfquery name="finduser" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
				SELECT User_ID FROM #Request.DB_Prefix#Users
				WHERE Username = '#attributes.UName#'
			</cfquery>
		
			<cfif finduser.recordcount is 1>	

				<cfquery name="update_registry" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" >
				UPDATE #Request.DB_Prefix#GiftRegistry
				SET
				User_ID = #finduser.User_ID#, 
				Registrant = '#Trim(Attributes.Registrant)#',
				OtherName = '#Trim(Attributes.OtherName)#',
				GiftRegistry_Type = '#Trim(Attributes.GiftRegistry_Type)#',
				Event_Date = <cfif len(attributes.Event_Date)>#createODBCdate(attributes.Event_Date)#,<cfelse>NULL,</cfif>
				Event_Name = '#Trim(Attributes.Event_Name)#',
				Event_Descr = '#Trim(Attributes.Event_Descr)#',
				City = '#Trim(Attributes.City)#',
				State = '#Trim(Attributes.State)#',
				Private =  #Attributes.Private#,
				Order_Notification =  #Attributes.Order_Notification#,
				Live = #Attributes.live#
				Expire = #createODBCdate(attributes.Expire)#
				WHERE GiftRegistry_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#attributes.GiftRegistry_ID#">
				</cfquery>
			
			<cfelse>
			
				<cfset attributes.error_message = "Could not update Account. Not a valid User">
		
			</cfif>			
			
		</cfif>

	</cfcase>	
</cfswitch>
			
