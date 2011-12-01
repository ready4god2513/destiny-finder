
<!--- Set up the functions for updating permissions --->
<cfscript>
function UpdateFeaturePerm (PermissionList) {
	var CurrFeaturePerm = '';
	var NewFeaturePerm = '';
	var thePerm = 0;
	//see if the permission list includes the feature permission
	var FeaturePerm = ListContains(PermissionList, 'feature', ';');
	//The Feature permission was found
	if (FeaturePerm IS NOT 0) {
		//Get the current feature permission, then remove it from the list
		CurrFeaturePerm = ListGetAt(PermissionList, FeaturePerm, ";");
		PermissionList = ListDeleteAt(PermissionList, FeaturePerm, ";");
		
		//Check what permission the user has
		if (ListLen(CurrFeaturePerm, "^") GT 1) {
			thePerm = ListGetAt(CurrFeaturePerm, 2, "^");
			// if the user has feature admin permission, add the feature review permission
			if (BitAnd(thePerm, 1)) {
				thePerm = thePerm + 8; }
			//create the permission string and return
			NewFeaturePerm = "feature^#thePerm#";
			PermissionList = ListAppend(PermissionList, NewFeaturePerm, ";");
		}
	}
	
	return PermissionList;
}

function UpdateShoppingPerm (PermissionList) {
	var CurrShopPerm = '';
	var NewShopPerm = '';
	var NewProductPerm = '';
	var thePerm = 0;
	var productPerm = 0;
	//see if the permission list includes the shopping permission
	var ShoppingPerm = ListContains(PermissionList, 'shopping', ';');
	//The Shopping permission was found
	if (ShoppingPerm IS NOT 0) {
		//Get the current shopping permission, then remove it from the list
		CurrShopPerm = ListGetAt(PermissionList, ShoppingPerm, ";");
		PermissionList = ListDeleteAt(PermissionList, ShoppingPerm, ";");
		
		//Check what permission the user has
		if (ListLen(CurrShopPerm, "^") GT 1) {
			thePerm = ListGetAt(CurrShopPerm, 2, "^");
			// first check for product admin permission
			if (BitAnd(thePerm, 2)) {
				productPerm = 241;
				thePerm = thePerm - 2; 	}
			// next check for discount permissions
			if (BitAnd(thePerm, 4)) {
				productPerm = productPerm + 12; }
			//check for order access permission
			if (BitAnd(thePerm, 256)) {
				thePerm = thePerm + 2 - 256; }
			//finally, add the new order search permission if has order approve access
			if (BitAnd(thePerm, 8)) {
				thePerm = thePerm + 256; }
			//create the permission string and return
			NewShopPerm = "shopping^#thePerm#";
			PermissionList = ListAppend(PermissionList, NewShopPerm, ";");
			if (productPerm) {
				NewProductPerm = "product^#productPerm#";
				PermissionList = ListAppend(PermissionList, NewProductPerm, ";");
			}
			
		}
		
	}
	
	return PermissionList;	
}

</cfscript>

<!--- Get Groups with permissions to update --->
<cfquery name="GetGroups" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
SELECT Group_ID, Permissions FROM Groups
WHERE Permissions LIKE '%SHOPPING%'
OR Permissions LIKE '%shopping%'
OR Permissions LIKE '%FEATURE%'
OR Permissions LIKE '%feature%'
</cfquery>

<!--- Process the permission strings and update the records --->
<cfloop query="GetGroups">
	<cfset OldPermList = LCase(GetGroups.Permissions)>
	<!--- First, let's do the feature permissions --->
	<cfset NewPermList = UpdateFeaturePerm(OldPermList)>
	<!--- Now, let's do the shopping permissions --->
	<cfset FinalPermList = UpdateShoppingPerm(NewPermList)>
	
	<cfquery name="UpdGroups" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	UPDATE Groups
	SET Permissions = '#FinalPermList#'
	WHERE Group_ID = #GetGroups.Group_ID#	
	</cfquery>
</cfloop>


<!--- Get Users with permissions to update --->
<cfquery name="GetUsers" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
SELECT User_ID, Permissions FROM Users
WHERE Permissions LIKE '%SHOPPING%'
OR Permissions LIKE '%shopping%'
OR Permissions LIKE '%FEATURE%'
OR Permissions LIKE '%feature%'
</cfquery>

<!--- Process the permission strings and update the records --->
<cfloop query="GetUsers">
	<cfset OldPermList = LCase(GetUsers.Permissions)>
	<!--- First, let's do the feature permissions --->
	<cfset NewPermList = UpdateFeaturePerm(OldPermList)>
	<!--- Now, let's do the shopping permissions --->
	<cfset FinalPermList = UpdateShoppingPerm(NewPermList)>
	
	<cfquery name="UpdUsers" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	UPDATE Users
	SET Permissions = '#FinalPermList#'
	WHERE User_ID = #GetUsers.User_ID#	
	</cfquery>
</cfloop>

<!--- Clear cached data --->
<cfobjectcache action = "clear">

<!--- Clear Application data --->
<cfset StructClear(Application)>

