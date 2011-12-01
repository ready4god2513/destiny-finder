
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Performs actions on gift certificates: add, edit and delete. Called by shopping.admin&certificate=act --->
			
<cfswitch expression="#mode#">
	<cfcase value="i">

		<!--- Generate Cert_Code --->	
		<cfinclude template="act_generate_code.cfm">
						
		<cfquery name="AddCert" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
		INSERT INTO #Request.DB_Prefix#Certificates
		(Cert_Code, Cust_Name, CertAmount, InitialAmount, Order_No, StartDate, EndDate, Valid)
		VALUES (
		'#Cert_Code#',
		<cfif len(attributes.Cust_Name)>'#Trim(attributes.Cust_Name)#',<cfelse>NULL,</cfif>
		#attributes.CertAmount#, #attributes.CertAmount#,
		<cfif isNumeric(attributes.Order_No)>#(attributes.Order_No-Get_Order_Settings.BaseOrderNum)#,<cfelse>NULL,</cfif>
		<cfif isDate(attributes.StartDate)>#CreateODBCDate(attributes.StartDate)#,<cfelse>NULL,</cfif>
		<cfif isDate(attributes.EndDate)>#CreateODBCDate(attributes.EndDate)#,<cfelse>NULL,</cfif>
		#attributes.Valid#)
		</cfquery>	
				
	</cfcase>
					
	<cfcase value="u">
			
		<cfif submit is "Delete">
				
			<cfquery name="DeleteCert" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
			DELETE FROM #Request.DB_Prefix#Certificates
			WHERE Cert_ID = #attributes.Cert_ID#
			</cfquery>		
								
		<cfelse><!---- EDIT ---->
			
			<cfquery name="UpdCert" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
			UPDATE #Request.DB_Prefix#Certificates
			SET 
			Cust_Name = <cfif len(attributes.Cust_Name)>'#Trim(attributes.Cust_Name)#',<cfelse>NULL,</cfif>
			CertAmount = #attributes.CertAmount#,
			InitialAmount = #attributes.InitialAmount#,
			Order_No = <cfif isNumeric(attributes.Order_No)>#(attributes.Order_No-Get_Order_Settings.BaseOrderNum)#,<cfelse>NULL,</cfif>
			StartDate = <cfif isDate(attributes.StartDate)>#CreateODBCDate(attributes.StartDate)#,<cfelse>NULL,</cfif>
			EndDate = <cfif isDate(attributes.EndDate)>#CreateODBCDate(attributes.EndDate)#,<cfelse>NULL,</cfif>
			Valid = #attributes.Valid#
			WHERE Cert_ID = #attributes.Cert_ID#
			</cfquery>
				
			</cfif><!---- update ---->
		
		</cfcase>

	</cfswitch>	
	
				
			


