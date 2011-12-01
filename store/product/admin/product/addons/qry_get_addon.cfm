
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Retrieves the information on a product addon. Called by product.admin&addon=change --->

<cfquery name="qry_get_Addon"   datasource="#Request.ds#"	 username="#Request.user#"  password="#Request.pass#" >
SELECT PA.*, SA.Std_Prompt, SA.Std_Type, SA.Std_Display, SA.Std_Required 
FROM #Request.DB_Prefix#ProdAddons PA 
LEFT JOIN #Request.DB_Prefix#StdAddons SA ON PA.Standard_ID = SA.Std_ID
WHERE PA.Addon_ID =  #attributes.Addon_ID#
</cfquery>
		

