
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Retrieves the list of gift certificates. Called by shopping.admin&certificate=list --->

<cfloop index="namedex" list="Cert_Code,Cust_Name,CertAmount,Order_No,current,valid">
	<cfparam name="attributes.#namedex#" default="">
</cfloop>

<cfparam name="attributes.Show" default="recent">
				
<cfquery name="qry_get_certificates" datasource="#Request.ds#" username="#Request.user#" password="#Request.pass#" >
	SELECT *
	FROM #Request.DB_Prefix#Certificates
	WHERE 1 = 1

<cfif attributes.show is "recent">
	AND StartDate >= #DateAdd("ww", -2, Now())#
</cfif>
<cfif trim(attributes.Cert_Code) is not "">
		AND Cert_Code like '%#attributes.Cert_Code#%'	</cfif>
<cfif trim(attributes.Cust_Name) is not "">
		AND Cust_Name like '%#attributes.Cust_Name#%'	</cfif>
<cfif trim(attributes.CertAmount) is not "">
		AND CertAmount = #attributes.CertAmount#	</cfif>
<cfif isNumeric(attributes.Order_No)>
		AND Order_No = #(attributes.Order_No-Get_Order_Settings.BaseOrderNum)# </cfif>
<cfif trim(attributes.current) is "current">
		AND (EndDate >= #CreateODBCDateTime(Now())# or EndDate is null)	</cfif>
<cfif trim(attributes.current) is "expired">
		AND EndDate < #CreateODBCDateTime(Now())#          				</cfif>
<cfif trim(attributes.current) is "scheduled">
		AND StartDate > #CreateODBCDateTime(Now())#						</cfif>		
<cfif trim(attributes.valid) is not "">
		AND Valid = #attributes.valid#	</cfif>	
	ORDER BY Cert_Code
</cfquery>
		
		


		