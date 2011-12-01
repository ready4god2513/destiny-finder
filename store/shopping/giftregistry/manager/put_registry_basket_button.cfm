
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This Template put a button in the shopping cart to allow user to add the products in the basket to a Gift Registry. Called from shopping/basket/dsp_basket.cfm.

If there is only one gift registry, the ID is passed. --->

<!--- User Must be logged in ---->
<cfif Session.User_ID>

	<!--- Check if user has a Registry ---->
	<cfset variables.uid = Session.User_ID>
	<cfinclude template="../qry_get_giftregistries.cfm">
	
	<!--- If a registry exists, display link --->
	<cfif qry_Get_registries.recordcount>
		
		<cfoutput><tr>
	    	<td colspan="5" align="center"><a href="#XHTMLFormat('#request.self#?fuseaction=shopping.giftregistry&manage=additems#request.token2#')#">Move these Items to My Registry</a></td>
		</tr></cfoutput>
	
	</cfif>
</cfif>
