<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This outputs the accordion menu for the gift menu. Called from put_admin_menu.cfm --->

<!--- variable to save the menu to output in the tab --->
<cfparam name="giftmenu" default="">
<cfparam name="totaltabs" default="0">
<cfset gift_tab = 0> 

<cfsavecontent variable="giftmenu">
<cfoutput>

	<!--- Shopping Permission 512 = gift registry admin --->
	<cfmodule template="../../access/secure.cfm"
		keyname="shopping"
		requiredPermission="512"
		/>
		<cfif ispermitted AND Request.AppSettings.GiftRegistry>
		<cfset gift_tab = 1>
		<br/>
		<form name="giftregistryjump" action="#self#?fuseaction=shopping.admin&giftregistry=listitems#request.token2#" method="post" target="AdminContent" class="nomargins">
		<input type="text" name="string" value="Registry ID or Name..." size="20" maxlength="100" class="accordionTextBox" onfocus="giftregistryjump.string.value = '';" onchange="submit();" />
		</form>
		<a href="#self#?fuseaction=shopping.admin&giftregistry=add#Request.Token2#" onmouseover="return escape(gift5)" target="AdminContent">New Registry</a><br/>
		<a href="#self#?fuseaction=shopping.admin&giftregistry=list#Request.Token2#" onmouseover="return escape(gift1)" target="AdminContent">Gift Registries</a><br/>
		<a href="#self#?fuseaction=shopping.admin&giftregistry=clear#Request.Token2#" onmouseover="return escape(gift2)" target="AdminContent">Remove Expired Registries</a><br/>
		<cfelseif ispermitted>
			<br/>Gift Registries are disabled<br/>
		</cfif>

<cfmodule template="../../access/secure.cfm"
	keyname="shopping"
	requiredPermission="1"
	> 	
	<!--- Giftwrapping Options ------>
	<cfif ispermitted AND get_order_settings.giftwrap is 1>
	<cfset gift_tab = 1>
	<br/><a href="#self#?fuseaction=shopping.admin&giftwrap=list#Request.Token2#" onmouseover="return escape(gift3)" target="AdminContent">Giftwrapping Options</a>
	<cfelseif ispermitted>
		<br/>Giftwrapping is disabled<br/>
	</cfif>
</cfmodule>

		
	<!--- shopping permissions 4 = gift certificates --->
	<cfmodule template="../../access/secure.cfm"
	keyname="shopping"
	requiredPermission="4"
	>
	<cfset gift_tab = 1>
	<br/><a href="#self#?fuseaction=shopping.admin&certificate=list#Request.Token2#" onmouseover="return escape(gift4)" target="AdminContent">Gift Certificates</a><br/>
	</cfmodule>

</cfoutput>

</cfsavecontent>

<cfif gift_tab>
	<cfset totaltabs = totaltabs + 1>
</cfif>

