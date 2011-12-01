
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
		
		<cftransaction>
			
		<cfquery name="Add_GiftRegistry" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
		<cfif Request.dbtype IS "MSSQL">
			SET NOCOUNT ON
		</cfif>
		INSERT INTO #Request.DB_Prefix#GiftRegistry
		(ID_Tag, User_ID, Registrant, OtherName, GiftRegistry_Type, Event_Date, Event_Name, Event_Descr, City, State,
		Private, Order_Notification, Live, Created, Expire)
		VALUES
			(<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#NewIDTag#">, 
			<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#Session.User_ID#">,
			<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Trim(Attributes.Registrant)#">,
			<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Trim(Attributes.OtherName)#">,
			<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Trim(Attributes.GiftRegistry_Type)#">,
			<cfqueryparam cfsqltype="CF_SQL_TIMESTAMP" value="#Attributes.Event_Date#" null="#YesNoFormat(NOT isDate(Attributes.Event_Date))#">,
			<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Trim(Attributes.Event_Name)#">,
			<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Trim(Attributes.Event_Descr)#">,
			<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Trim(Attributes.City)#">,
			<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Trim(Attributes.State)#">,
			<cfqueryparam cfsqltype="#Request.SQL_Bit#" value="#Attributes.Private#">,
			<cfqueryparam cfsqltype="#Request.SQL_Bit#" value="#Attributes.Order_Notification#">,
			<cfqueryparam cfsqltype="#Request.SQL_Bit#" value="#Attributes.Live#">,
			<cfqueryparam cfsqltype="CF_SQL_TIMESTAMP" value="#Now()#">,
			<cfqueryparam cfsqltype="CF_SQL_TIMESTAMP" value="#Attributes.Expire#">
			)
			<cfif Request.dbtype IS "MSSQL">
				SELECT @@Identity AS New_ID
				SET NOCOUNT OFF
			</cfif>
			</cfquery>	
			
			<cfif Request.dbtype IS NOT "MSSQL">
				<cfquery name="Add_GiftRegistry" datasource="#Request.ds#" username="#Request.user#"  password="#Request.pass#">
				   SELECT GiftRegistry_ID AS New_ID
				   FROM #Request.DB_Prefix#GiftRegistry
				   WHERE ID_Tag = '#NewIDTag#'
				 </cfquery>
			  </cfif>
		</cftransaction>		
			
		<cfset attributes.GiftRegistry_id = Add_GiftRegistry.New_ID>
			
	</cfcase>
			
	<cfcase value="u">
		<cfif submit is "Delete">
			<!--- Delete registry items first --->
			<cfquery name="RemoveItems" datasource="#Request.ds#" username="#Request.user#"  password="#Request.pass#">
			   DELETE FROM #Request.DB_Prefix#GiftItems
			   WHERE GiftRegistry_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#attributes.GiftRegistry_ID#">
			</cfquery>

			<cfquery name="delete_GiftRegistry"  datasource="#Request.ds#" username="#Request.user#" password="#Request.pass#">
				DELETE FROM #Request.DB_Prefix#GiftRegistry 
			    WHERE GiftRegistry_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#attributes.GiftRegistry_ID#">
			</cfquery>		
			
		<cfelse>

			<!--- Update --->
		
			<cfquery name="update_giftregistry" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" >
				UPDATE #Request.DB_Prefix#GiftRegistry
				SET
				Registrant = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Trim(Attributes.Registrant)#">,
				OtherName = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Trim(Attributes.OtherName)#">,
				GiftRegistry_Type = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Trim(Attributes.GiftRegistry_Type)#">,
				Event_Date = <cfqueryparam cfsqltype="CF_SQL_TIMESTAMP" value="#Attributes.Event_Date#" null="#YesNoFormat(NOT isDate(Attributes.Event_Date))#">,
				Event_Name = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Trim(Attributes.Event_Name)#">,
				Event_Descr = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Trim(Attributes.Event_Descr)#">,
				City = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Trim(Attributes.City)#">,
				State = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Trim(Attributes.State)#">,
				Private = <cfqueryparam cfsqltype="#Request.SQL_Bit#" value="#Attributes.Private#">,
				Order_Notification = <cfqueryparam cfsqltype="#Request.SQL_Bit#" value="#Attributes.Order_Notification#">,
				Live = <cfqueryparam cfsqltype="#Request.SQL_Bit#" value="#Attributes.Live#">,
				Expire = <cfqueryparam cfsqltype="CF_SQL_TIMESTAMP" value="#Attributes.Expire#">
				WHERE GiftRegistry_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#attributes.GiftRegistry_ID#">
			</cfquery>
			
		</cfif>

	</cfcase>	
</cfswitch>
			
