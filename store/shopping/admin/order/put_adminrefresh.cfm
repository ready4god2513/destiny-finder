<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the javascript to update the number of pending orders counter. Called after any possible actions to the order status --->

<!--- Refresh the admin menu counter if the page is not on SSL --->
<cfif CGI.SERVER_PORT IS NOT 443>
	<cfset innertext = Application.objMenus.getPendingOrders()>
	<script type="text/javascript">
	 	if (parent.AdminMenu.document.getElementById('ordercount') != null) {
			<cfoutput>parent.AdminMenu.document.getElementById('ordercount').innerHTML = '#innertext#';</cfoutput>
		}	
	</script>
</cfif>



