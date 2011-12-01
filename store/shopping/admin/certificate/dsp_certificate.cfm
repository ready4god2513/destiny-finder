
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the form to add or edit a gift certificates. Called by shopping.admin&certificate=add|edit --->

<!--- Initialize the values for the form --->
<cfset fieldlist="Cert_Code,Cust_Name,CertAmount,InitialAmount,Order_No,StartDate,EndDate,valid">	
		
<cfswitch expression="#certificate#">
			
	<cfcase value="add">
		<cfloop list="#fieldlist#" index="counter">
			<cfset setvariable("attributes.#counter#", "")>
		</cfloop>
		<cfset attributes.cert_ID = 0>
		<cfset action="#self#?fuseaction=shopping.admin&certificate=act&mode=i">
	    <cfset act_title="Add Gift Certificate">
		<cfset act_button="Generate">
	</cfcase>
					
	<cfcase value="edit">
		<cfinclude template="qry_get_certificate.cfm"> 
		<!--- Set the form fields to values retrieved from the record --->
		<cfloop list="cert_id,#fieldlist#" index="counter">
			<cfset "attributes.#counter#" = evaluate("qry_get_certificate." & counter)>
		</cfloop>
				
		<cfset action="#self#?fuseaction=shopping.admin&certificate=act&mode=u">
		<cfset act_title="Update Gift Certificate">
		<cfset act_button="Update">	
	</cfcase>
</cfswitch>
		
<cfhtmlhead text="<script type='text/javascript' src='includes/openwin.js'></script>">
		
		
<cfmodule template="../../../customtags/format_admin_form.cfm"
	box_title="#act_title#"
	width="500"
	>
	
	<!--- Table --->
	<cfoutput>
	<form name="editform" action="#action#" method="post">
	<input type="hidden" name="cert_ID" value="#attributes.cert_ID#"/>


	<!--- Check for orders with this certificate --->
	<cfif certificate eq "edit">

		<cfquery name="GetOrders" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
		SELECT * FROM #Request.DB_Prefix#Order_No
		WHERE Cert_Code = '#qry_get_certificate.Cert_Code#'
		</cfquery>

		<cfif GetOrders.RecordCount>
	
		<tr><td colspan="3" align="center">
		This gift certificate was redeemed on Order<cfif GetOrders.RecordCount GT 1>s</cfif> 
		<cfloop query="GetOrders">#(GetOrders.Order_No + get_order_settings.BaseOrderNum)#<cfif GetOrders.CurrentRow IS NOT GetOrders.RecordCount>, </cfif>
		</cfloop><br/>&nbsp;</td></tr>

		</cfif>
	</cfif>
	
	
	<!--- certificate ID --->
		<tr>
			<td align="RIGHT">Code:</td>
			<td></td>
		 	<td><cfif certificate is "add">NEW<cfelse>#attributes.cert_code#</cfif>
						
 	<!--- name --->
		<tr>
			<td align="RIGHT">Customer:</td>
			<td></td>
		 	<td>
			<input type="text" name="cust_name" value="#attributes.cust_name#" size="35" maxlength="255" class="formfield"/>
			</td></tr>
			
		<tr>
			<td align="RIGHT">Order No:</td>
			<td></td>
		 	<td>
			<input type="text" name="order_no" value="#iif(isNumeric(attributes.Order_No), Evaluate(De('attributes.Order_No+Get_Order_Settings.BaseOrderNum')), DE(''))#" size="10" class="formfield"/>
			</td></tr>
			<tr><td colspan="2">&nbsp;</td>
			<td><span class="formtextsmall">The order number used to purchase the gift certificate, if any.</span></td></tr>	
		
	<!--- start --->
			<tr>
				<td align="RIGHT">Start Date</td>
				<td></td>
				<td><cfmodule template="../../../customtags/calendar_input.cfm" ID="calstart" formfield="StartDate" formname="editform" value="#dateformat(attributes.StartDate,"mm/dd/yyyy")#" size="15" browser="#browsername#" bversion="#browserversion#" /></td>
			</tr>
									
 	<!--- expire --->
			<tr>
				<td align="RIGHT">End Date</td>
				<td></td>
				<td><cfmodule template="../../../customtags/calendar_input.cfm" ID="calend" formfield="EndDate" formname="editform" value="#dateformat(attributes.EndDate,"mm/dd/yyyy")#" size="15" browser="#browsername#" bversion="#browserversion#" /></td>
			</tr>
			
	 <!--- Amount --->
		<tr>
			<td align="RIGHT"><cfif attributes.Cert_ID IS NOT 0>Current</cfif> Certificate Amount</td>
			<td style="background-color: ###Request.GetColors.formreq#;" width="3">&nbsp;</td>
		 	<td>
			<input type="text" name="CertAmount" value="#NumberFormat(attributes.CertAmount, '0.00')#" size="7" maxlength="10" class="formfield"/>
#Request.AppSettings.MoneyUnit# 
			</td></tr>
		
	<cfif attributes.Cert_ID IS NOT 0>

		<tr>
			<td align="RIGHT">Initial Certificate Amount</td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
		 	<td>
			<input type="text" name="InitialAmount" value="#NumberFormat(attributes.InitialAmount, '0.00')#" size="7" maxlength="10" class="formfield"/>
#Request.AppSettings.MoneyUnit# 
			</td></tr>

	</cfif>				
			
	<!--- valid --->
		<tr>
			<td align="RIGHT" valign="top">Valid</td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
		 	<td>
			<input type="radio" name="Valid" value="1" #doChecked(attributes.Valid)# />
			 Yes &nbsp; <input type="radio" name="Valid" value="0" #doChecked(attributes.Valid,0)# /> No
			</td></tr>			

			
		<cfinclude template="../../../includes/form/put_space.cfm">
		
		<tr>
			<td colspan="2">&nbsp;</td>
			<td>
			<input type="submit" name="submit" value="#act_button#" class="formbutton"/> 
			<input type="button" value="Cancel" onclick="javascript:window.history.go(-1);" class="formbutton"/>
		<cfif certificate is "edit">
			<input type="submit" name="submit" value="Delete" class="formbutton" onclick="return confirm('Are you sure you want to delete this gift certificate?');" />
		</cfif>
			</td></tr>
			
	</form>	
<cfprocessingdirective suppresswhitespace="no">
<script type="text/javascript">
objForm = new qForm("editform");

objForm.required("CertAmount");

objForm.CertAmount.validateNumeric();
objForm.order_no.validateNumeric();

objForm.StartDate.validateDate();
objForm.EndDate.validateDate();

objForm.order_no.description = "order number";
objForm.StartDate.description = "start date";
objForm.EndDate.description = "end date";
objForm.CertAmount.description = "<cfif attributes.Cert_ID IS NOT 0>current </cfif>certificate amount";

<cfif attributes.Cert_ID IS NOT 0>
	objForm.required("InitialAmount");
	objForm.InitialAmount.validateNumeric();
	objForm.InitialAmount.description = "Initial Certificate Amount";
</cfif>

qFormAPI.errorColor = "###Request.GetColors.formreq#";
</script>
</cfprocessingdirective>

</cfoutput>
</cfmodule>
	
