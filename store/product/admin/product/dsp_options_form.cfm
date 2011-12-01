<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the list of product options, with links to add or edit the options. Called by product.admin&do=options --->

<cfparam name="attributes.cid" default="">

<cfset act_title="Update Product - #qry_get_product.name#">

<!--- Get Lists of options for Product --->
<cfinclude template="options/qry_get_options.cfm">

<cfprocessingdirective suppresswhitespace="no">
<cfhtmlhead text="
<script language=""JavaScript"">
	function setoption(optnum,stdopt,action) {
	document.go_options.Option_ID.value = optnum;
	document.go_options.StandOpt.value = stdopt;
	document.go_options.Action.value = action;
	document.go_options.submit();
	}
</script>
">
</cfprocessingdirective>


<cfmodule template="../../../customtags/format_output_admin.cfm"
	box_title="#act_title#"
	Width="700"
	menutabs="yes">
	
	<cfinclude template="../product/dsp_menu.cfm">
	
	<cfoutput>
	<!--- Table --->
	<table border="0" cellpadding="0" cellspacing="4" width="100%" class="formtext"
	style="color:###Request.GetColors.InputTText#">

		<tr>
			<td colspan="3" align="center">
			
			<!---- Table to hold Add Option Buttons --->
			
			<table>
				<tr>
					
					<td><form action="#self#?fuseaction=product.admin&option=addstd&product_id=#attributes.product_id#&cid=#attributes.cid##request.token2#" method="post">
						<input type="submit" value="Add a Standard Option" class="formbutton"/>
						</form>
					</td>
					<td>
					<form action="#self#?fuseaction=product.admin&option=addcust&product_id=#attributes.product_id#&cid=#attributes.cid##request.token2#" method="post">
						<input type="submit" value="Add a Custom Option" class="formbutton"/>
						</form>
					</td>
					
				</tr>
			</table>
			
			
			</td>
		</tr>
<!--- Display options and buttons to edit or delete --->
<form action="#self#?fuseaction=product.admin&option=change&product_id=#attributes.product_id#&cid=#attributes.cid##request.token2#" method="post" name="go_options">

<!--- Pass product id and category ids as hidden variables --->
<input type="hidden" name="Option_ID" value="0"/>
<input type="hidden" name="StandOpt" value="0"/>
<input type="hidden" name="Action" value=""/>

<!--- Display current options and buttons to edit or add options--->
<cfinclude template="options/put_option_listing.cfm">

</form>

<tr><td colspan="3" align="center"><br/>
			
			<!---- Table to hold Add Option Buttons --->
			<cfmodule template="../../../customtags/putline.cfm" linetype="thin" linecolor="#Request.GetColors.InputHBgcolor#"  width="98%"/>
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
						<form action="#self#?fuseaction=product.admin&stdoption=list&product_id=#attributes.product_id#&cid=#attributes.cid##request.token2#" method="post">
						<input type="submit" value="Edit Standard Options" class="formbutton"/>
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


