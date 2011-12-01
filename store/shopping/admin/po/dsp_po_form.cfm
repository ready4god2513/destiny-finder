<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the form to edit the purchase order information. Called by shopping.admin&po=add|edit --->

<!--- Initialize the values for the form --->
<cfset fieldlist="po_no,printdate,notes,po_status,po_open">

<!--- Set the form fields to values retrieved from the record --->
<cfloop list="#fieldlist#" index="counter">
	<cfset "attributes.#counter#" = evaluate("qry_get_po." & counter)>
</cfloop>
				
<cfinclude template="../../../queries/qry_getpicklists.cfm">
				
<cfmodule template="../../../customtags/format_admin_form.cfm"
	box_title="Purchase Order"
	width="550"
	>
<cfoutput>
	<form name="editform" action="#self#?fuseaction=shopping.admin&po=act#request.token2#" method="post">
		<input type="hidden" name="order_po_id" value="#attributes.order_po_id#"/>
		<input type="hidden" name="xfa_success" value="#attributes.xfa_success#"/>
	
	<!--- Order Number - not editable --->
		<tr valign="top">
			<td align="right">Order No:</td>
			<td></td>
			<td class="formtitle">#Evaluate(qry_get_po.Order_No + Get_Order_Settings.BaseOrderNum)#</td>
		</tr>
			
	<!--- Order Number - not editable--->
		<tr valign="top">
			<td align="right">Account:</td>
			<td></td>
			<td class="formtitle">#qry_get_po.account_name#</td>
		</tr>
			
		
	<!--- PO Number --->
		<tr valign="top">
			<td align="right">Purchase Order No:</td>
			<td style="background-color: ###Request.GetColors.formreq#;" width="3">&nbsp;</td>
			<td><input type="text" name="po_no" value="#attributes.po_no#" size="10" class="formfield" maxlength="30"/></td>
		</tr>
			
	<!--- PO Date --->
		<tr valign="top">
			<td  align="right">PO Date:</td>
			<td style="background-color: ###Request.GetColors.formreq#;">
			<img src="#Request.AppSettings.defaultimages#/spacer.gif" alt="" height="1" width="4" /></td>
			<td><cfmodule template="../../../customtags/calendar_input.cfm" ID="calend" formfield="printdate" formname="editform" value="#dateformat(attributes.printdate,"mm/dd/yyyy")#" size="15" browser="#browsername#" bversion="#browserversion#" /></td>
		</tr>
			
	<!--- Open --->
		<tr>
			<td align="RIGHT">Open:</td>
			<td></td>
			<td><input type="radio" name="po_open" value="1" #doChecked(attributes.po_open)# />Yes &nbsp; 
			<input type="radio" name="po_open" value="0" #doChecked(attributes.po_open,0)# />No
			</td>
		</tr>			
		

	<!--- po_status --->
	 	<tr>
			<td align="RIGHT">Status:</td>
			<td></td>
			<td>
	 		<select name="PO_status" class="formfield">
			<option value="" #doSelected(attributes.PO_status,'')#></option>
			<cfmodule template="../../../customtags/form/dropdown.cfm"
			mode="valuelist"
			valuelist="#qry_getpicklists.po_status#"
			selected="#attributes.po_status#"
			/>
			</select>
			</td>
		</tr>		
		
		
	<!--- notes--->
	 	<tr>
			<td align="RIGHT" valign="top">Notes:</td>
			<td></td>
			<td>
	 			<textarea cols="40" rows="5" name="notes" class="formfield">#attributes.notes#</textarea>
			</td>
		</tr>		
	
	
	<!----SUMBIT ---->
		<cfinclude template="../../../includes/form/put_space.cfm">
	
		<tr>
			<td>&nbsp;</td><td></td>
			<td>			
			
			<input type="submit" name="submit" value="Update" class="formbutton"/> 
			<input type="button" value="Cancel" onclick="javascript:window.history.go(-1);" class="formbutton"/>
			<input type="submit" name="submit" value="Delete" class="formbutton" onclick="return confirm('Are you sure you want to delete this Purchase Order?');" />
			
			</td></tr>
			</form>
			
<cfprocessingdirective suppresswhitespace="no">
<script type="text/javascript">
objForm = new qForm("editform");

objForm.required("po_no,printdate");

objForm.printdate.validateDate();
objForm.printdate.description = "PO Date";
objForm.po_no.description = "PO Number";

qFormAPI.errorColor = "###Request.GetColors.formreq#";
</script>
</cfprocessingdirective>

</cfoutput>			
</cfmodule>
