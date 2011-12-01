
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Runs the function to download the customer data to an excel spreadsheet. Called by the users.download fuseaction --->

<cfquery name="Download_customers"   datasource="#Request.ds#"	 username="#Request.user#"  password="#Request.pass#" >
	SELECT U.Username AS a_User_Name, C.FirstName AS b_First_Name, C.LastName AS c_Last_Name, 
	C.Company AS d_Company, C.Address1 AS e_Address, C.Address2 AS f_Address_Cont, C.City AS g_City, 
	C.County AS h_County, C.State AS i_State, C.State2 AS j_State_Alternative, C.Zip AS k_Zip_Code, 
	C.country AS l_Country, C.Phone AS m_Phone, C.Phone2 AS n_Phone_Alt, C.Fax AS o_Fax, C.Email AS p_Email, 
	U.Subscribe AS q_Subscribed, U.Created AS r_Date_Created, G.Name AS s_Group_Name, C.LastUsed AS t_Last_LogOn	
	FROM (#Request.DB_Prefix#Users U 
			LEFT JOIN #Request.DB_Prefix#Groups G ON U.Group_ID = G.Group_ID) 
	INNER JOIN #Request.DB_Prefix#Customers C ON U.Customer_ID = C.Customer_ID 
	</cfquery>
	
<cfif Download_Customers.Recordcount>
	<cfmodule template="../../../customtags/query2excel.cfm" query="download_customers">
<cfelse>
	<cfoutput><br/><b>No customers found!</b></cfoutput>
</cfif>	
		

