<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the form for filling a purchase order and emailing shipping information to the customer. Called by shooping.admin&po=ship--->

	<cfinclude template="../../../queries/qry_getpicklists.cfm">

	<cfmodule template="../../../customtags/format_output_admin.cfm"
		box_title="Order Manager - PO Filled"
		Width="540">
	
		<!----
		<cfinclude template="dsp_menu.cfm">
		------>
		
		<cfoutput>
		<table border="0" cellpadding="0" cellspacing="4" width="94%" class="formtext" align="center"
		style="color:###Request.GetColors.InputTText#"></cfoutput>
	
		<cfif not qry_ship.recordcount>
		
			<tr>
				<td align="CENTER">		
				<p>
				Order not found!</p><p>
				</td></tr>
	
		<cfelse>
		
			<cfoutput query="qry_ship">
			
			<cfif qry_ship.shipdate is "">
				<cfset attributes.shipdate = now()>
			<cfelse>
				<cfset attributes.shipdate = qry_ship.shipdate>
			</cfif>
			
			<form action="#self#?fuseaction=shopping.admin&po=ship#request.token2#" method="post" name="editform">
			<input type="hidden" name="Order_PO_ID" value="#Order_PO_ID#"/>
			<input type="hidden" name="Order_no" value="#Order_no#"/>
			<input type="hidden" name="xfa_success" value="#attributes.xfa_success#"/>
	
			<tr><td colspan="3">
			<img src="#request.appsettings.defaultimages#/spacer.gif" alt="" height="12" width="1" /></td></tr>

		
			<!--- Order Number - not editable --->
			<tr valign="top">
				<td align="right">Purchase Order:</td>
				<td></td>
				<td class="formtitle">#PO_no#</td>
				</tr>
			
			<!--- Order Number - not editable--->
			<tr valign="top">
				<td align="right">Account:</td>
				<td></td>
				<td class="formtitle">#account_name#</td>
			</tr>			
			
			<tr>
				<td align="RIGHT">PO Date:</td>
				<td></td>
				<td class="formtitle">#LSDateFormat(qry_ship.printdate, "mmmm d, yyyy")#</td>
			</tr>
		
			<tr>
				<td align="RIGHT">Order:</td>
				<td></td>
				<td>#Evaluate(Order_No + Get_Order_Settings.BaseOrderNum)#
				</td>
			</tr>		
			
			<tr>
				<td align="RIGHT">Customer:</td>
				<td></td>
				<td><a href="mailto:#email#">#FirstName# #LastName#</a></td>
			</tr>
			
			</cfoutput>
		
			<cfinclude template="../../../includes/form/put_space.cfm">
			
			<tr><td colspan="3" class="formtextsmall">
You can send an automated email to this customer to notify them that this order has been shipped. If you select a shipper and enter a tracking number, the email will include a tracking link to the shippers web site. If no tracking number is entered, the shipper selection will be ignored and not included in the email.
			</td></tr>
	
			<tr>
				<td align="RIGHT">Send Email:</td>
				<td style="background-color: <cfoutput>###Request.GetColors.formreq#</cfoutput>;" width="3">&nbsp;</td>
				<td>
				<input type="radio" name="EmailCustomer" value="1" checked="checked" />Yes &nbsp;
				<input type="radio" name="EmailCustomer" value="0"/>No 
				</td>
			</tr>
			

		<!--- PO Date --->
			<tr valign="top">
				<td  align="right">Date Shipped:</td>
			<cfoutput>
				<td><img src="#Request.AppSettings.defaultimages#/spacer.gif" alt="" height="1" width="4" /></td>
				<td><cfmodule template="../../../customtags/calendar_input.cfm" ID="calship" formfield="shipdate" formname="editform" value="#dateformat(attributes.shipdate,"mm/dd/yyyy")#" size="15" browser="#browsername#" bversion="#browserversion#" /></td>
			</tr></cfoutput>
				
			<tr>
				<td align="RIGHT">Shipper:</td>
				<td></td>
				<td>
				 <select name="Shipper" size="1" class="formfield">
					<option value="UPS">UPS</option>
					<option value="USPS">US Postal Service</option>
					<option value="FedEx">FedEx</option>
					<option value="Airborne">Airborne Express</option>
					<option value="Other">Other</option>
				 </select>
				</td>
			</tr>
			
			<tr>
				<td align="RIGHT" valign="top"><nobr>Tracking Numbers:</nobr></td>
				<td></td>
				<td>
				<input type="text" name="Tracking" size="40" maxlength="255" class="formfield"/><br/>
				<span class="formtextsmall">Enter all numbers, separated by commas.</span>
				</td>
			</tr>
			
			<tr>
				<td align="RIGHT" valign="top">Additional Notes<br/>to Customer:</td>
				<td></td>
				<td>
				<textarea name="CustNotes" wrap="soft" cols="50" rows="5" class="formfield"></textarea>
				</td>
			</tr>
			
			<cfinclude template="../../../includes/form/put_space.cfm">
			
			
	<!--- Open --->
	<cfoutput>
		<tr>
			<td align="RIGHT">Keep PO Open:</td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
			<td><input type="radio" name="po_open" value="1" #doChecked(qry_ship.po_open)# />Yes &nbsp; 
			<input type="radio" name="po_open" value="0" #doChecked(qry_ship.po_open,0)# />No
			</td>
		</tr>	
	</cfoutput>		
		

	<!--- po_status --->
	 	<tr>
			<td align="RIGHT">Status:</td>
			<td></td>
			<td>
	 		<select name="PO_status" class="formfield">
			<option value="" #doSelected(qry_ship.PO_status,'')#></option>
			<cfmodule template="../../../customtags/form/dropdown.cfm"
			mode="valuelist"
			valuelist="#qry_getpicklists.po_status#"
			selected="#qry_ship.po_status#"
			/>
			</select>
			</td>
		</tr>		
		
		
	<!--- notes--->
	 	<tr>
			<td align="RIGHT" valign="top">Notes:</td>
			<td></td>
			<td>
	 			<textarea cols="40" rows="5" name="notes"><cfoutput>#qry_ship.notes#</cfoutput></textarea>
			</td>
		</tr>		
	
			
			<cfinclude template="../../../includes/form/put_space.cfm">
			
			<tr>
				<td colspan="2"></td>
				<td><input type="submit" name="submit_ship" value="Update PO" class="formbutton"/>
				<input type="button" value="Cancel" onclick="javascript:window.history.go(-1);" class="formbutton"/>
				</td>	
			</tr>	
		
			</form>
			
			<cfinclude template="../../../includes/form/put_requiredfields.cfm">
			
		</cfif>	
		</table>
	</cfmodule>