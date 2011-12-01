<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This page displays the form used for creating and editing Customer records. This Customer record can be for a 'Customer' (billing address), 'Shipto' or 'Contact' (generic). Slightly different fields are displayed for each type of record. --->

<cfparam name="attributes.message" default="">
<cfparam name="attributes.mode" default="customer"><!--- shipto | contact | customer --->
<cfparam name="attributes.Customer_ID" default="0">
<cfparam name="attributes.shipto" default="1">
<cfparam name="attributes.show" default="">


<!---if this form is not submitting to itself, then populate the default form field values. --->
<cfif not isdefined("submit_customer")>
	
	<cfset attributes.fieldlist="Customer_ID,FirstName,LastName,Company,Address1,Address2,City,County,State,State2,Zip,Country,Phone,Phone2,Fax,Email,Residence">
	
	<!--- If a customer_ID is not passed, see if there is a default value
	in the user's record. --->
	<cfif not attributes.customer_ID>
		
		<cfinclude template="qry_get_user.cfm">
		
		<cfif qry_get_user.recordcount>
			<cfif attributes.mode is "customer">
				<cfset attributes.customer_ID = qry_get_User.Customer_ID>
			</cfif>
			<cfif attributes.mode is "shipto">
				<cfset attributes.customer_ID = qry_get_User.shipto>
			</cfif>	
		</cfif>
	
	</cfif>
		
	<!--- populate form from database if we are updating a record --->	
	<cfif attributes.customer_id>
			
		<cfinclude template="qry_get_customer.cfm"> 
		
		<cfif qry_get_customer.recordcount is 1>
			<cfset action="Update">
		<cfelse>
			<cfset attributes.Message = "OOPS! That Address Not Found. Please Add Your Address.">
			   <cfset action="Add">
			   <cfif attributes.mode is "customer">
				   <cfset attributes.email="#qry_get_User.Email#">	
			</cfif>
		</cfif>
		
		<cfloop list="#attributes.fieldlist#" index="counter">
			<cfset "attributes.#counter#" = evaluate("qry_get_customer." & counter)>
		</cfloop>
	
				 
	<!--- if we're adding a new customer record, populate the form with blanks --->
	<cfelse>
	
		<cfloop list="#attributes.fieldlist#" index="counter">
			<cfset setvariable("attributes.#counter#", "")>
		</cfloop>
	
	   <cfset action="Add">
	   <cfif attributes.mode is "customer">
		   <cfset attributes.email="#qry_get_User.Email#">	
		</cfif>
	</cfif>
	
<cfelse>
	
	<cfset action= attributes.submit_customer> 

</cfif>


<cfinclude template="../queries/qry_getstates.cfm">
<cfinclude template="../queries/qry_getcounties.cfm">
<cfinclude template="../queries/qry_getcountries.cfm">

<cfif attributes.mode is "customer">
	<cfset FormTitle = "Customer Billing Information">
<cfelseif attributes.mode is "shipto">
	<cfset FormTitle = "Shipping Information">
<cfelse>
	<cfset FormTitle = "Contact Information">
</cfif>

<cfoutput>
<form name="editform" action="#XHTMLFormat('#request.self#?#attributes.xfa_submit_customer##request.token2#')#" method="post">

<input type="hidden" name="fieldlist" value="#HTMLEditFormat(attributes.fieldlist)#"/>
<input type="hidden" name="mode" value="#HTMLEditFormat(attributes.mode)#"/>		
<input type="hidden" name="show" value="#HTMLEditFormat(attributes.show)#"/>		
<input type="hidden" name="xfa_submit_customer" value="#HTMLEditFormat(attributes.xfa_submit_customer)#"/>
<cfif isdefined("attributes.xfa_customer_success")>
<input type="hidden" name="xfa_customer_success" value="#HTMLEditFormat(attributes.xfa_customer_success)#"/>
</cfif>
<input type="hidden" name="lastused" value="#createODBCDate(now())#"/>
<input type="hidden" name="customer_id" value="#HTMLEditFormat(attributes.customer_id)#"/>

<cfmodule template="../customtags/format_input_form.cfm"
box_title="#formtitle#"
width="380">
				
	<cfif len(attributes.Message)>
	<tr>
		<td colspan="3" align="center" class="formerror"><br/>#attributes.Message#<br/><br/></td></tr>
	</cfif>				
	
	<!--- Put address fields --->
	<cfinclude template="formfields/put_contact.cfm">		
		
	<cfif get_User_Settings.UseShipTo and attributes.mode is "customer">
	<tr align="left"> 
		<td align="right">Is this also your shipping address?: </td>
    	<td></td>
		<td><input type="radio" name="ShipTo" value="1" #doChecked(attributes.shipto)# /> Yes  
		&nbsp;&nbsp;<input type="radio" name="ShipTo" value="0" #doChecked(attributes.shipto,0)# /> No 
		</td>
		</tr>
	<cfelse>
		<input type="hidden" name="shipto" value="1"/>
	</cfif>
	
	<tr><td colspan="3"><img src="#Request.AppSettings.defaultimages#/spacer.gif" alt="" height="3" width="1" /></td></tr>

	<tr align="left">
	<td align="right">&nbsp;</td>
	<td></td>
	<td><input type="submit" name="submit_customer" class="formbutton" value="#action#"/>
		<input type="button" value="Cancel" onclick="javascript:window.history.go(-1);" class="formbutton"/>
			
		<cfif action is not "add">
		<input type="submit" name="submit_customer" class="formbutton" value="Delete"  onclick="return confirm('Are you sure you want to delete this customer?\nThis will delete all associated records and orders.');" />
		</cfif>
		</td></tr>
</cfmodule>

</form>

<cfprocessingdirective suppresswhitespace="no">
<script type="text/javascript">
<!--//
objForm = new qForm("editform");

	objForm.required("FirstName,LastName,Address1,City,Zip,residence");
	<cfif attributes.mode is not "shipto">
		objForm.email.validateEmail();	
	</cfif>
	
<cfif ShowCounties>
	<cfif get_User_Settings.RequireCounty>
		requireCounties();
	</cfif>

	<cfif len(attributes.State)>
		<cfoutput>
		setDefault("State", "#attributes.State#");
		setDefault("County", "#attributes.County#");
		</cfoutput>
	</cfif>
</cfif>

<!--- Alternate Mask for US Zipcodes 
objForm.Zip.validateZipCode(); ---->	
objForm.Zip.validateLengthGT("3");

<!--- Require a state if the country is US or Canada --->
objForm.State.createDependencyTo("Country", "US^United States");
objForm.State.createDependencyTo("Country", "CA^Canada");
objForm.Country.enforceDependency();

<!--- comment out to allow "toll free" or other text in phone2 field
objForm.Phone.validatePhoneNumber();
objForm.Phone.validateFormat("Phone2");
 ---->

objForm.Address1.description = "address";
objForm.FirstName.focus();

qFormAPI.errorColor = "###Request.GetColors.formreq#";
//-->
</script>
</cfprocessingdirective>

</cfoutput>

<!---- DEBUG
 <cfoutput>#get_User_Settings.UseShipTo# and #attributes.mode#</cfoutput>
---->