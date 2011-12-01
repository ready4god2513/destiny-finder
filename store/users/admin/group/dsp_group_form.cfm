
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the form to add and edit Groups. Called by the fuseaction users.admin&group=add|edit --->

<!--- Initialize the values for the form --->
<cfset fieldlist="Name,Description,group_code,Wholesale,TaxExempt,ShipExempt">

<cfswitch expression="#group#">
	<cfcase value="add">
		<cfloop list="#fieldlist#" index="counter">
			<cfset setvariable("attributes.#counter#", "")>
		</cfloop>

		<cfset action="#self#?fuseaction=users.admin&group=act&mode=i">
	    <cfset attributes.Gid = 0>
	    <cfset act_title="Add Group">	
		
		<!--- Radio button defaults --->
		<cfset attributes.Wholesale = 0>
		<cfset attributes.TaxExempt = 0>
		<cfset attributes.ShipExempt = 0>
		
	</cfcase>
			
	<cfcase value="edit">
		<!--- Set the form fields to values retrieved from the record --->
		<cfloop list="#fieldlist#" index="counter">
			<cfset "attributes.#counter#" = evaluate("qry_get_group." & counter)>
		</cfloop>
	
		<cfset action="#self#?fuseaction=users.admin&group=act&mode=u">
		<cfset act_title="Update Group">			
	</cfcase>
</cfswitch>

<cfinclude template="qry_get_discounts.cfm">
<cfinclude template="qry_get_group_discounts.cfm">	
<cfinclude template="qry_get_promotions.cfm">
<cfinclude template="qry_get_group_promotions.cfm">

<cfmodule template="../../../customtags/format_admin_form.cfm"
	box_title="#act_title#"
	width="550"
	>

	<cfoutput>
	<form name="editform" action="#action##request.token2#" method="post">
	<input type="hidden" name="gid" value="#attributes.gid#"/>

 <!--- Name --->
	<tr>
		<td align="right">Name:</td>
		<td style="background-color: ###Request.GetColors.formreq#;" width="3">&nbsp;</td>
		<td><input type="text" name="Name" class="formfield" value="#attributes.Name#" size="40" maxlength="100"/></td></tr>
			
 <!--- Description --->
	<tr>
		<td align="right">Description:</td>
		<td></td>
	 	<td><input type="text" size="40" name="Description" value="#attributes.Description#" class="formfield"/></td></tr>

			
 <!--- Description --->
	<tr>
		<td align="right" valign="baseline">Group Code:</td>
		<td></td>
	 	<td><input type="text" size="20" name="group_code" value="#attributes.group_code#" class="formfield" maxlength="20"/>
		<br/><span class="formtextsmall">Code entered on user registration to place them into this group</span>
</td></tr>
			
 <!--- Wholesale --->
	<tr>
		<td align="right">Wholesale:</td>
		<td></td>
		<td><input type="radio" name="wholesale" value="0" #doChecked(attributes.wholesale,0)# />No 
		<input type="radio" name="wholesale" value="1" #doChecked(attributes.wholesale)# />Yes
		</td></tr>
		
 <!--- TaxExempt --->
	<tr>
		<td align="right">Tax Exempt:</td>
		<td></td>
		<td><input type="radio" name="TaxExempt" value="0" #doChecked(attributes.TaxExempt,0)# />No 
		<input type="radio" name="TaxExempt" value="1" #doChecked(attributes.TaxExempt)# />Yes
		</td></tr>
		
 <!--- ShipExempt --->
	<tr>
		<td align="right">Shipping Exempt:</td>
		<td></td>
		<td><input type="radio" name="ShipExempt" value="0" #doChecked(attributes.ShipExempt,0)# />No 
		<input type="radio" name="ShipExempt" value="1" #doChecked(attributes.ShipExempt)# />Yes
		</td></tr>
		
<!--- discounts --->
<cfif qry_get_discounts.RecordCount> 
		<tr>
		<td align="right" valign="top">Discounts:<br/><br/></td>
		<td></td>
		<td>
		<select name="Discounts" class="formfield" 
			size="#iif(qry_get_discounts.RecordCount LT 5,qry_get_discounts.RecordCount + 1,5)#" multiple="multiple">
		<option value="None" #doSelected(qry_Get_Group_Discounts.Recordcount,0)#>None</option>
		<cfloop query="qry_get_discounts">
		<option value="#Discount_ID#" #doSelected(ListFind(DiscountList, qry_get_discounts.Discount_ID))#>#Name#</option>
		</cfloop>
		</select>	
		</td>
		</tr>
</cfif>	
<input type="hidden" name="DiscountList" value="#ValueList(qry_get_discounts.Discount_ID)#"/>

<!--- promotions --->
<cfif qry_get_promotions.RecordCount> 
		<tr>
		<td align="right" valign="top">Promotions:<br/><br/></td>
		<td></td>
		<td>
		<select name="Promotions" class="formfield" 
			size="#iif(qry_get_promotions.RecordCount LT 5,qry_get_promotions.RecordCount + 1,5)#" multiple="multiple">
		<option value="None" #doSelected(qry_Get_Group_Promotions.Recordcount,0)#>None</option>
		<cfloop query="qry_get_Promotions">
		<option value="#Promotion_ID#" #doSelected(ListFind(PromotionList, qry_get_Promotions.Promotion_ID))#>#Name#</option>
		</cfloop>
		</select>	
		</td>
		</tr>
</cfif>	
<input type="hidden" name="PromotionList" value="#ValueList(qry_get_Promotions.Promotion_ID)#"/>
	

		<cfinclude template="../../../includes/form/put_space.cfm">
		<tr>
			<td colspan="2">&nbsp;</td>
			<td>
			<input type="submit" name="submit" value="#act_title#" class="formbutton"/>	
			<input type="button" value="Cancel" onclick="javascript:window.history.go(-1);" class="formbutton"/> 		
			<cfif group is "edit" AND attributes.gid is not "1">
			<input type="submit" name="submit" value="Delete" class="formbutton"  onclick="return confirm('Are you sure you want to delete this group?');" />
			</cfif></td></tr>
			
	</form>	
<cfprocessingdirective suppresswhitespace="no">
<script type="text/javascript">
	objForm = new qForm("editform");
	
	objForm.required("Name,wholesale,TaxExempt");
	
	qFormAPI.errorColor = "###Request.GetColors.formreq#";
	</script>
</cfprocessingdirective>

</cfoutput>
</cfmodule>
	