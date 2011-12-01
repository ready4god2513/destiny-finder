<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the form to update which USPS methods are to be used. Called by shopping.admin&shipping=usps_methods --->

<cfquery name="GetMethods" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
SELECT * FROM #Request.DB_Prefix#USPSMethods
ORDER BY Type, Priority, Name
</cfquery>

<cfprocessingdirective suppresswhitespace="no">
	<script type="text/javascript">
    function edittype(shipid, action) {
	document.editform.ID.value = shipid;
	document.editform.Action2.value = action;
	document.editform.submit();	
	}
	function CancelForm () {
	location.href =
	"<cfoutput>#self#?fuseaction=shopping.admin&shipping=settings&redirect=yes#request.token2#";</cfoutput>
	}
    </script>
</cfprocessingdirective>

<cfmodule template="../../../../customtags/format_output_admin.cfm"
	box_title="U.S.P.S. Shipping Methods"
	Width="640">
	
<cfoutput>
	<table border="0" cellpadding="0" cellspacing="4" width="100%" class="formtext"	style="color:###Request.GetColors.InputTText#">
	
	
	<form name="editform" action="#self#?fuseaction=shopping.admin&shipping=usps_methods#request.token2#" method="post">
</cfoutput>
	<input type="hidden" name="ID" value=""/>
	<input type="hidden" name="Action" value=""/>
	<input type="hidden" name="Action2" value=""/>
	
	<cfinclude template="../../../../includes/form/put_space.cfm">
	
	
	<tr>
		<th>Type</th>
		<!--- <th>Code</th> --->
		<th>Name</th>
		<th>Used?</th>
		<th>Priority<br/><span class="formtextsmall">(1 is highest, 0 is none)</span></th>
		<th>&nbsp;</th>
	</tr>	
	

<cfoutput query="GetMethods">
	<tr>
		<td align="center">#Type#</td>
		<!--- <td>#Code#</td>  --->
		<td>#Name#</td> 
		<td align="center"><input type="checkbox" name="Used#ID#" value="1" #doChecked(Used)# /></td>
		<td align="center" nowrap="nowrap"><input type="text" name="Priority#ID#" value="#doPriority(Priority,0,99)#" size="4" maxlength="10" class="formfield"/> </td>
		<td align="center" nowrap="nowrap"><input type="button" name="JS" value="Edit" onclick="javascript:edittype(#ID#, 'Edit');" class="formbutton"/></td>
	</tr>
</cfoutput>

	<tr>
		<td colspan="6" align="center"><br/>
		<input type="submit" name="submit_change" value="Update Used" class="formbutton"/> 
		<input type="button" name="JS" value="Add Method"  onclick="javascript:edittype(0, this.value);" class="formbutton"/> 
		<input type="button" value="Back to Settings" onclick="javascript:CancelForm();"
class="formbutton"/><br/><br/>
		</td>
	</tr>
	
	</form>
	</table>
	
</cfmodule>

