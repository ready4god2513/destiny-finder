
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Get the list of promotions for the selected group, called from dsp_group_form.cfm --->

<cfparam name="attributes.GID" default="0">

<cfquery name="qry_Get_Group_Promotions" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
SELECT Promotion_ID FROM #Request.DB_Prefix#Promotion_Groups
WHERE Group_ID = #attributes.GID#
ORDER BY Promotion_ID
</cfquery>

<cfset PromotionList = ValueList(qry_Get_Group_Promotions.Promotion_ID)>

