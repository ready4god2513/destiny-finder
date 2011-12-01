<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the code generated when creating a gift certificate. Called by shopping.admin&certificate=act --->
		
<cfmodule template="../../../customtags/format_admin_form.cfm"
	box_title="New Gift Certificate"
	width="450"
	required_fields="0"
	>
	
	<!--- certificate ID --->
		<tr>
			<td colspan="3" align="center">
			
		<cfoutput>
			<br/><br/>
			Certificate Code&nbsp; <strong>#Cert_Code#</strong><br/><br/>
			
			has been created for  <strong>#attributes.Cust_Name#</strong><br/><br/>
			
			in the amount of <strong> #LSCurrencyFormat(attributes.CertAmount)#</strong> #Request.AppSettings.MoneyUnit#<br/><br/>
			
			<cfif len(attributes.startdate) or len(attributes.startdate)>
			good 
				<cfif len(attributes.startdate)>from <strong>#attributes.StartDate#</strong> </cfif>
				<cfif len(attributes.startdate)>to <strong>#attributes.EndDate#</strong></cfif>
			<br/><br/></cfif>
			
			<form action="#self#?fuseaction=shopping.admin&certificate=list#request.token2#" method="post">
			<input class="formbutton" type="submit" value="Return"/>
			</form>	
		</cfoutput>
	
			</td>
		</tr>

</cfmodule>
	
