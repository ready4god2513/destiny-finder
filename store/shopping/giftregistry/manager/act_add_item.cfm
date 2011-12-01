
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This template adds items to the Gift Registry from a product page. --->

<!--- Select Gift Registry if needed.  --->
<cfset variables.uid = Session.User_ID>
<cfinclude template="../qry_get_giftregistries.cfm">

<!--- If gift registry not found, reselect ---->
<cfif NOT qry_Get_registries.recordcount>

	<cflocation url="#request.self#?fuseaction=shopping.giftregistry&manager=additems#request.token2#" addtoken="No">
	
<!--- If more than one registry found, present selection page --->
<cfelseif qry_Get_registries.recordcount GT 1 AND NOT len(attributes.GiftRegistry_ID)>

	<cfoutput>
		<form action="#XHTMLFormat('#request.self#?fuseaction=shopping.giftregistry&manage=additem#request.token2#')#" method="post">
		<!--- pass product information fields --->
		<cfif isDefined("form.fieldnames")>
	 		<cfloop index="form_vars" list="#form.fieldnames#">
	   			<input type="hidden" name="#form_vars#" value="#evaluate(form_vars)#"/>
	  		</cfloop>
	  	<cfelseif isDefined("attributes.Product_ID")>
	  		<input type="hidden" name="Product_ID" value="#Val(attributes.Product_ID)#"/>
		</cfif>

	<cfmodule template="../../../customtags/format_input_form.cfm"
		box_title="Add Product to Registry"
		width="370"
		required_fields = "0"
		>

		<tr align="left">
			<td align="right"><br/><b>Select Gift Registry:</b></td>
			<td>&nbsp;</td>
			<td><br/><select name="GiftRegistry_ID" class="formfield">
				<cfloop query="qry_Get_registries">
					<option value="#GiftRegistry_ID#">#Event_Name#</option>
				</cfloop>
				</select>
			</td>
		</tr>	
		<tr>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td><input type="submit" name="selectRegistry" value="continue" class="formbutton"/></td>
		</tr>
	</cfmodule>
	</form>
	</cfoutput>

<!--- One registry found, so add product to it --->
<cfelse>

	<cfparam name="attributes.product_id" default="0">
	
	<!--- If passing in registry ID, make sure it is valid for this user --->
	<cfif len(attributes.GiftRegistry_ID)>
	
		<cfquery name="checkRegistry" dbtype="query">
		SELECT * FROM qry_Get_registries
		WHERE GiftRegistry_ID = #attributes.GiftRegistry_ID#
		</cfquery>
	
		<cfif NOT checkRegistry.RecordCount>
			<cflocation url="#request.self#?fuseaction=shopping.giftregistry&manager=additems#request.token2#" addtoken="No">
		</cfif>
	
	<!--- otherwise set the id to the user's only registry --->
	<cfelse>
		<cfset attributes.GiftRegistry_ID = qry_Get_registries.GiftRegistry_ID>
	</cfif>

	<cfset Application.objCart.addProducttoRegistry(argumentcollection=attributes)>
	
	<!--- Success! Now display Gift Registry Item Form --->
	<cflocation url="#request.self#?fuseaction=shopping.giftregistry&manage=items&giftregistry_id=#attributes.GiftRegistry_ID##request.token2#" addtoken="No">

</cfif>
	
