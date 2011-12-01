<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the Order Shipping Screen. Allows merchant to sending shipping and tracking information to the customer. Called by shopping.admin&order=shipping --->
		
	<cfmodule template="../../../customtags/format_output_admin.cfm"
		box_title="Order Manager - Edit Order #Evaluate(GetOrder.Order_No + Get_Order_Settings.BaseOrderNum)#"
		Width="650">
	
		<!----
		<cfinclude template="dsp_menu.cfm">
		------>
		<cfoutput>
		<table border="0" cellpadding="0" cellspacing="4" width="94%" class="formtext" align="center"
		style="color:###Request.GetColors.InputTtext#"></cfoutput>
	
		<cfif not getorder.recordcount>
		
			<tr>
				<td align="CENTER">		
				<p>
				Order not found!</p><p>
				</td></tr>
	
		<cfelse>
		
			<cfoutput query="getorder">
			<form name="editform" action="#self#?fuseaction=shopping.admin&order=shipping#request.token2#" method="post">
			<input type="hidden" name="Order_No" value="#Order_No#"/>
			<input type="hidden" name="xfa_success" value="#attributes.xfa_success#"/>
	
			<tr><td colspan="3"><img src="#request.appsettings.defaultimages#/spacer.gif" alt="" height="12" width="1" /></td></tr>

			<tr>
				<td align="RIGHT"><strong>Order No.</strong></td>
				<td></td>
				<td>
				<strong>#Evaluate(Order_No + Get_Order_Settings.BaseOrderNum)#</strong>
				</td>
			</tr>

			<tr>
				<td align="RIGHT">Order Date:</td>
				<td></td>
				<td>#LSDateFormat(GetOrder.DateOrdered, "mmmm d, yyyy")#</td>
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
			
			<tr>
				<td colspan="2"></td>
				<td><input type="submit" name="submit_shipping" value="Complete Order" class="formbutton"/>
				<input type="button" value="Cancel" onclick="javascript:window.history.go(-1);" class="formbutton"/>
				</td>	
			</tr>	
		
			</form>
			
			<cfinclude template="../../../includes/form/put_requiredfields.cfm">
			
		</cfif>	
		</table>
	</cfmodule>