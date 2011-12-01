<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the current group prices for the product, with links to edit or remove the price. Provides the form to add new group prices. Called by product.admin&do=Grp_Price --->

<cfparam name="attributes.message" default="">

<cfif isdefined("attributes.edit")>
	<cfquery name="GetPrice" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	SELECT Group_ID AS GID, Price, GrpPrice_ID 
	FROM #Request.DB_Prefix#ProdGrpPrice
	WHERE GrpPrice_ID = #attributes.edit#
	</cfquery>

	<cfloop list="gid,price,grpprice_id" index="counter">
		<cfset "attributes.#counter#" = evaluate("GetPrice." & counter)>
	</cfloop>
	
	<cfset formbutton = "Update">
	
<cfelse><!--- add --->
	<cfset attributes.gid = 0>
	<cfset attributes.price = 0>
	<cfset attributes.grpprice_id = 0>
	<cfset formbutton = "Add Group Price">
	
</cfif>

<cfinclude template="../../../users/admin/group/qry_get_all_groups.cfm">

<cfhtmlhead text="
	<script language=""JavaScript"">
	<!--
		function CancelForm () {
		location.href = ""#self#?fuseaction=product.admin&do=list&redirect=1#request.token2#"";
		}
	// -->
	</script>
">

<cfmodule template="../../../customtags/format_output_admin.cfm"
	box_title="Update Product - #qry_get_product.name#"
	Width="700"
	menutabs="yes">
	
	<cfinclude template="dsp_menu.cfm">
	
	<cfif len(trim(attributes.Message))>
		<cfoutput>
		<p align="center"><span class="formerror"><b>#attributes.Message#</b></span></p>
		</cfoutput>
	</cfif>
	
<cfoutput>	
<table border="0" cellpadding="0" cellspacing="4" width="100%" class="formtext"
	style="color:###Request.GetColors.InputTText#">
<!--- Add form ---->
	<form name="editform" action="#self#?fuseaction=product.admin&do=Grp_Price#request.token2#" 
	method="post" enctype="multipart/form-data">
	<input type="hidden" name="GrpPrice_ID" value="#attributes.GrpPrice_ID#"/>
	<input type="hidden" name="product_ID" value="#attributes.product_ID#"/>
	
			<tr>
				<td align="RIGHT">User Group:</td>
				<td></td>
				<td width="70%">
				<select name="GID"  class="formfield">
				<option value="" #doSelected(attributes.gid,0)#>&raquo;</option>
				<cfloop query="qry_get_all_groups">
				<!--- Make sure the group is not already being used for a price --->
				<cfif Not ListFind(GroupList, Group_ID) OR Group_ID IS attributes.gid>
				    <option value="#Group_ID#"  class="formfield" #doSelected(attributes.gid,qry_get_all_groups.Group_ID)#>#Name#</option>
				 </cfif>
				</cfloop>
	 			</select>
				</td>
			</tr>	

		<tr>
			<td align="RIGHT" width="30%">Price:</td>
			<td style="background-color: ###Request.GetColors.formreq#;" width="3">&nbsp;</td>
			<td>
			
				<input type="text" name="Price"  class="formfield" value="#iif(attributes.Price IS NOT 0, NumberFormat(attributes.Price, '0.00'), DE(""))#" size="5" maxlength="15"/> #Request.AppSettings.MoneyUnit#</td>	
		</tr>
		
		<cfinclude template="../../../includes/form/put_space.cfm">
		
		<tr>
			<td colspan="2"></td>
			<td><input type="submit" name="Submit_price" value="#formbutton#" class="formbutton"/> 
			</td>	
		</tr>	
		
		</form>
		<cfinclude template="../../../includes/form/put_requiredfields.cfm">
		
<cfprocessingdirective suppresswhitespace="no">
<script type="text/javascript">
<!--//
// initialize the qForm object
objForm = new qForm("editform");

// make these fields required
objForm.required("GID,Price");

objForm.GID.validateNumeric();
objForm.Price.validateNumeric();

objForm.GID.description = "user group";
objForm.Price.description = "price";

qFormAPI.errorColor = "###Request.GetColors.formreq#";
//-->
</script>
</cfprocessingdirective>
</cfoutput>
	
<cfif qry_get_grp_prices.RecordCount>	
	<hr size="1" noshade="noshade" width="98%" />
	<br/>
<cfoutput>

		<tr><td colspan="3">
		<table border="0" align="center" cellspacing="10" class="formtext">
		<tr><td colspan="3" align="center">User Group Pricing</td></tr>
		<tr><td colspan="3" style="background-color: ###Request.GetColors.boxhbgcolor#;">
		<img src="images/spacer.gif" alt="" width="1" height="1" /></td></tr>
		<tr>
			<th>User Group</th>
			<th align="right">Price</th>
			<th>&nbsp;</th>
		</tr>
	
		<cfloop query="qry_get_grp_prices">
		<tr>
			<td align="center">#Name#</td>
			<td align="right">#LSCurrencyFormat(Price)#</td>
			<td align="right">[<a href="#self#?fuseaction=product.admin&do=Grp_Price&product_id=#product_id#&edit=#GrpPrice_ID##Request.Token2#">edit</a>] [<a href="#self#?fuseaction=product.admin&do=Grp_Price&product_id=#product_id#&delete=#GrpPrice_ID##Request.Token2#">delete</a>]</td>
		</tr>
		</cfloop>		
		<tr><td colspan="3" align="center">&nbsp;</td></tr></table>
		
		</td></tr>
		</cfoutput>
<cfelse>
	<!---
	<p align="center" class="formtitle">No Quantity Discounts Entered<p>
	--->
</cfif>	

	<tr>
		<td align="center" colspan="3">

		
		<cfoutput><form action="#self#?fuseaction=product.admin&do=list#request.token2#" method="post" enctype="multipart/form-data">
<hr size="1" noshade="noshade" />	<br/>	
		<input type="hidden" name="act" value="choose"/>
		<input type="hidden" name="cid" value="#iif(len(attributes.cid),attributes.cid,0)#"/>
		<input type="submit" name="DONE" value="Back to Product List" class="formbutton"/>
		</form>	
		</cfoutput>
		</td>
    </tr>

	</table>


<!---- CLOSE MODULE ----->
</cfmodule>

