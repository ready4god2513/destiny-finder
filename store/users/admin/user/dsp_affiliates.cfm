<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the Affiliate information for a User for editing. Called by users.admin&user=affiliate --->

<!--- Get affiliate info --->
<cfquery name="GetAff" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" maxrows=1>
SELECT A.*
FROM #Request.DB_Prefix#Affiliates A, #Request.DB_Prefix#Users U
WHERE U.User_ID = #attributes.UID#
AND A.Affiliate_ID = U.Affiliate_ID
</cfquery>

<!--- Display form --->
<cfmodule template="../../../customtags/format_admin_form.cfm"
	box_title="Affiliate Information"
	width="500"
	>
	
	<cfoutput>

	<form action="#self#?#cgi.query_string#" method="post" name="editform">
	
	<!--- Affiliate Code --->
	<cfif GetAff.RecordCount>
	
		<tr>
			<td align="right">Affiliate Code:</td>
			<td></td>
			<td>#GetAff.AffCode#</td>
			</tr>
			<input type="hidden" name="Affiliate_ID" value="#GetAff.Affiliate_ID#"/>
			<input type="hidden" name="AffCode" value="#GetAff.AffCode#"/>
			
	<cfelse>
		<tr>
			<td align="right">Affiliate Code:</td>
			<td></td>
			<td>New</td>
			</tr>
			<input type="hidden" name="Affiliate_ID" value="0"/>
			<input type="hidden" name="UID" value="#attributes.UID#"/>
	</cfif>

	<!--- Percentage --->
		<tr>
			<td align="right">Percentage:</td>
			<td style="background-color: ###Request.GetColors.formreq#;" width="3">&nbsp;</td>
			<td ><input type="text" name="Percentage" size="5" maxlength="10" <cfif GetAff.RecordCount>value="#(GetAff.AffPercent * 100)#"</cfif> class="formfield"/>%</td>
			</tr>
			
		<tr>
			<td align="right">Affiliate Site:</td>
			<td>&nbsp;</td>
			<td ><input type="text" name="Aff_Site" size="40" maxlength="255" value="#GetAff.Aff_Site#"  class="formfield"/></td>
			</tr>
	
	</cfoutput>
	
	<cfinclude template="../../../includes/form/put_space.cfm">
	
	<tr>
			<td colspan="2">&nbsp;</td>
			<td>
			<input type="submit" name="submit_aff" value="Save" class="formbutton"/>
			<input type="submit" name="submit_aff" value="Remove" onclick="return confirm('Are you sure you want to remove this affiliate record?\nThis will also change any orders placed for this affiliate.');" class="formbutton"/>
			<input type="button" value="Cancel" onclick="javascript:window.history.go(-1);" class="formbutton"/> 
			</td></tr>
     
</cfmodule>

<cfprocessingdirective suppresswhitespace="no">
<script type="text/javascript">
objForm = new qForm("editform");

objForm.required("Percentage");

objForm.Percentage.validateNumeric();

qFormAPI.errorColor = "###Request.GetColors.formreq#";
</script>
</cfprocessingdirective>
