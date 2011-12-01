
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Get the list of promotions for user groups, called from dsp_group_form.cfm --->

<cfquery name="qry_Get_Promotions" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
SELECT Promotion_ID, Name 
FROM #Request.DB_Prefix#Promotions
WHERE Type4 = 1
ORDER BY Name, StartDate
</cfquery>


