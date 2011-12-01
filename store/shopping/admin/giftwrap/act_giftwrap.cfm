
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Performs actions on giftwrap options: add, edit and delete. Asks for confirmation for deletions. Called by shopping.admin&giftwrap=act --->

<!---====== Prepare form variables =====--->
<cfif NOT isNumeric(attributes.Priority) OR attributes.Priority IS 0>
	<cfset attributes.Priority = 9999>
</cfif>

<!--- Replace double carriage returns with HTML paragraph tags. --->
<cfset HTMLBreak = Chr(60) & 'br/' & Chr(62)>
<cfset HTMLParagraph = HTMLBreak & HTMLBreak>
<cfset LineBreak = Chr(13) & Chr(10)>
<cfset Short_Desc = Replace(Trim(attributes.Short_Desc), LineBreak & LineBreak, HTMLParagraph & LineBreak & LineBreak, "ALL")>
			
<cfswitch expression="#mode#">
	<cfcase value="i">
		
		<cfif NOT len(attributes.name)>
		
			<cfset attributes.error_message = "You must enter a name.">
			
		<cfelse>
		
		  <cftransaction isolation="SERIALIZABLE">
			<cfquery name="Add_Giftwrap" datasource="#Request.ds#" username="#Request.user#"  password="#Request.pass#">
			INSERT INTO #Request.DB_Prefix#Giftwrap 
			(Name, Short_Desc, Sm_Image, Price, Weight, Priority, Display)
			VALUES (
			'#attributes.Name#',
			'#Short_Desc#',
			'#Trim(Attributes.Sm_Image)#',		
			 <cfif len(Attributes.Price)>#Attributes.Price#,<cfelse>0,</cfif>
			 <cfif len(Attributes.Weight)>#Attributes.Weight#,<cfelse>0,</cfif>
			 #Attributes.Priority#,
			 #Attributes.Display#
			)
			</cfquery>	
			
			 <cfquery name="Get_id" datasource="#Request.ds#" username="#Request.user#"  password="#Request.pass#">
			   SELECT MAX(Giftwrap_ID) AS maxid
			   FROM #Request.DB_Prefix#Giftwrap
			  </cfquery>
			
			  <cfset attributes.giftwrap_id = get_id.maxid>
		  </cftransaction>
		</cfif>
		
		</cfcase>
			
		<cfcase value="u">
		
			<cfif submit is "Delete">
			
				<cfquery name="delete_giftwrap"  datasource="#Request.ds#" username="#Request.user#" password="#Request.pass#">
				DELETE FROM #Request.DB_Prefix#Giftwrap 
				WHERE Giftwrap_ID = #attributes.Giftwrap_id#
				</cfquery>
								
			<cfelse>
		
				<cfif NOT len(attributes.name)>
		
					<cfset attributes.error_message = "You must enter a name.">
			
				<cfelse>
		
		
				<cfquery name="Update_Giftwrap" datasource="#Request.ds#" username="#Request.user#" password="#Request.pass#">
				UPDATE #Request.DB_Prefix#Giftwrap
				SET 
				Name = '#attributes.Name#',
				Short_Desc = '#Short_Desc#',
				Sm_Image = '#Trim(attributes.Sm_image)#',
				Price = <cfif len(Attributes.Price)>#Attributes.Price#,<cfelse>0,</cfif>
				Weight = <cfif len(Attributes.Weight)>#Attributes.Weight#,<cfelse>0,</cfif>	
				Display = #Trim(attributes.Display)#,
				Priority = #attributes.Priority#
				WHERE Giftwrap_ID = #attributes.Giftwrap_ID#		
				</cfquery>
							
				</cfif>			
					
			</cfif>
		
		</cfcase>

	</cfswitch>	
	

