<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the list of product addons, with links to add or edit the addons. Called by product.admin&do=addons --->

<cfparam name="attributes.cid" default="">

<cfset act_title="Update Product - #qry_get_product.name#">

<!--- Get Lists of Addons for Product --->
<cfinclude template="addons/qry_get_addons.cfm">

<cfprocessingdirective suppresswhitespace="no">
<cfhtmlhead text="
<script language=""JavaScript"">
	function setAddon(Addonnum,stdAddon,action) {
	document.go_Addons.Addon_ID.value = Addonnum;
	document.go_Addons.StandAddon.value = stdAddon;
	document.go_Addons.Action.value = action;
	document.go_Addons.submit();
	}
</script>
">
</cfprocessingdirective>


<cfmodule template="../../../customtags/format_output_admin.cfm"
	box_title="#act_title#"
	Width="650"
	menutabs="yes">
	
	<cfinclude template="../product/dsp_menu.cfm">
	
<cfoutput>
	<!--- Table --->
	<table border="0" cellpadding="0" cellspacing="4" width="100%" class="formtext"
	style="color:###Request.GetColors.InputTText#">

		<tr>
			<td colspan="3" align="center">
			
			<!---- Table to hold Add Addon Buttons --->
			
			<table>
				<tr>
					<td>
					<form action="#self#?fuseaction=product.admin&Addon=addstd&product_id=#attributes.product_id#&cid=#attributes.cid##request.token2#" method="post">
						<input type="submit" value="Add a Standard Addon" class="formbutton"/></form>
					</td>
					<td>
					<form action="#self#?fuseaction=product.admin&Addon=addcust&product_id=#attributes.product_id#&cid=#attributes.cid##request.token2#" method="post">
						<input type="submit" value="Add a Custom Addon" class="formbutton"/></form>
					</td>
					
				</tr>
			</table>
			
			
			</td>
		</tr>

<!--- Set variable to display edit buttons in Addons.cfm --->
<cfset Edit = "Yes">

<!--- Display Addons and buttons to edit or delete --->
<form action="#self#?fuseaction=product.admin&Addon=change&product_id=#attributes.product_id#&cid=#attributes.cid##request.token2#" method="post" name="go_Addons">

<!--- Pass product id and category ids as hidden variables --->
<input type="hidden" name="Addon_ID" value="0"/>
<input type="hidden" name="StandAddon" value="0"/>
<input type="hidden" name="Action" value=""/>

<!--- Display current options and buttons to edit or add addons --->
<cfinclude template="addons/put_addon_listing.cfm">

</form>

<tr><td colspan="3" align="center"><br/>
			
			<!---- Table to hold Add Addon Buttons --->
<cfmodule template="../../../customtags/putline.cfm" linetype="thin" linecolor="#Request.GetColors.InputHBgcolor#" width="98%"/>

			<table>
				<tr>
				<td><br/>
					<form action="#self#?fuseaction=product.admin&do=list#request.token2#" method="post">
						<input type="hidden" name="act" value="choose"/>
						<input type="hidden" name="cid" value="#iif(len(attributes.cid),attributes.cid,0)#"/>
						<input type="submit" name="DONE" value="Back to Product List" class="formbutton"/>
						</form>
					</td>						
					<td><br/>
					<form action="#self#?fuseaction=product.admin&stdAddon=list&product_id=#attributes.product_id#&cid=#attributes.cid##request.token2#" method="post">
						<input type="submit" value="Edit Standard Addons" class="formbutton"/>
					</form>
					</td>
				</tr>
			</table>
			<br/>
			
			</td>
		</tr>

</td></tr>
</table>
</cfoutput>
</cfmodule>


