
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the form to verify the product import. Called by product.admin&do=doimport --->

<cfif isDefined("attributes.submit_import") AND NOT len(attributes.error_message)>

	<cfhtmlhead text="
		<script language=""JavaScript"">
			function CancelForm () {
			location.href = ""#self#?fuseaction=home.admin&redirect=yes#request.token2#"";
			}
		</script>
	">

	<cfmodule template="../../../customtags/format_output_admin.cfm"
		box_title="Product Import"
		width="500">
		
	<cfoutput>
		<!--- Table --->
		<table border="0" cellpadding="0" cellspacing="4" width="100%" class="formtext"
		style="color:###Request.GetColors.InputTText#">
		<form action="#self#?#cgi.query_string#" method="post" enctype="multipart/form-data" name="importform" id="importform">
		<tr>
			<td><br/>
			Verify the Data you want to import:</td>
		</tr>	
		<tr>
			<td><br/><cfdump var="#qryImport#" label="Product Import"></td>
		</tr>	
		
		<tr>
			<td align="center" ><br/>
			<input type="hidden" name="passinfo" value="#HTMLEditFormat(passinfo)#"/>
			<input type="hidden" name="fieldlist" value="#fieldlist#"/>
			<input type="hidden" name="fieldtypes" value="#fieldtypes#"/>
			<input type="hidden" name="cid_list" value="#attributes.cid_list#"/>
			<input type="submit" name="do_import" value="Add Products" class="formbutton"/> 
			<input type="button" value="Cancel" onclick="CancelForm();" class="formbutton"/>
			</td>
		</tr>
		
		</form>	
		</table>
	</cfoutput>
	
	</cfmodule>

<cfelseif isDefined("qryFailed") and qryFailed.Recordcount>

	<cfmodule template="../../../customtags/format_output_admin.cfm"
		box_title="Product Import"
		width="500">
		
	<cfoutput>
		<!--- Table --->
		<table border="0" cellpadding="0" cellspacing="4" width="100%" class="formtext"
		style="color:###Request.GetColors.InputTText#">
		<form action="#self#?#attributes.XFA_success##Request.Token2#" method="post" enctype="multipart/form-data" name="importform" id="importform">
		<tr>
			<td align="center"><br/>
			<p class="formerror"><strong>The following records could not be imported due to data imcompatibilities. <br/>Be sure you selected the correct columns for the data being added and have included all required fields.</strong></p></td>
		</tr>	
		<tr>
			<td><br/><cfdump var="#qryFailed#" label="Product Import"></td>
		</tr>	
		
		<tr>
			<td align="center" ><br/>
			<input type="submit" value="Return to Import" class="formbutton"/> 
			</td>
		</tr>
		
		</form>	
		</table>
	</cfoutput>
	
	</cfmodule>
	
<cfelse>
	<cfinclude template="../../../includes/admin_confirmation.cfm">
</cfif>


