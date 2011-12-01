<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the form to update which shipping methods are to be used for custom methods. Called by shopping.admin&shipping=methods --->

<cfquery name="GetMethods" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
SELECT * FROM #Request.DB_Prefix#CustomMethods
ORDER BY Priority, Name
</cfquery>

<cfprocessingdirective suppresswhitespace="no">
<cfhtmlhead text="
<script language=""JavaScript"">
		function CancelForm () {
		location.href = ""#self#?fuseaction=shopping.admin&shipping=settings&redirect=yes#request.token2#"";
		}
	</script>
">
</cfprocessingdirective>

<cfprocessingdirective suppresswhitespace="no">
<script type="text/javascript">
    function edittype(shipid, action) {
	document.editform.ID.value = shipid;
	document.editform.Action2.value = action;
	document.editform.submit();	
	}
</script>
</cfprocessingdirective>

<cfmodule template="../../../customtags/format_output_admin.cfm"
	box_title="Shipping Methods"
	Width="640">
	
	<cfoutput>
	<table border="0" cellpadding="0" cellspacing="4" width="100%" class="formtext"	style="color:###Request.GetColors.InputTText#">
	
	<form name="editform" action="#self#?fuseaction=shopping.admin&shipping=method#request.token2#" method="post">
	</cfoutput>
	<input type="hidden" name="ID" value=""/>
	<input type="hidden" name="Action" value=""/>
	<input type="hidden" name="Action2" value=""/>
	
	<cfinclude template="../../../includes/form/put_space.cfm">
	
	<tr>
		<th align="left">Description</th>
		<th align="center">Cost</th>
		<th align="center">Used?</th>
		<th align="center">Domestic</th>
		<th align="center">Int'l</th>
		<th align="center">Priority<br/><span class="formtextsmall">(1 is highest,<br/> 0 is none)</span></th>
		<th>&nbsp;</th>
	</tr>	
	
<cfoutput query="GetMethods">
	<tr>
		<td align="left">#Name#</td> 
		<td align="center">#LSCurrencyFormat(Amount)#</td>
		<td align="center"><input type="checkbox" name="Used#ID#" value="1" #doChecked(Used)# /></td>
		<td align="center">#YesNoFormat(Domestic)#</td>
		<td align="center">#YesNoFormat(International)#</td>
		<td align="center" nowrap="nowrap"><input type="text" name="Priority#ID#" value="#doPriority(Priority,0,99)#" size="4" maxlength="10" class="formfield"/> </td>
		<td align="center" nowrap="nowrap"><input type="button" name="JS" value="Edit" onclick="javascript:edittype(#ID#, 'Edit');" class="formbutton"/></td>
	</tr>
</cfoutput>

	<tr>
		<td colspan="7" align="center"><br/>
		<input type="submit" name="submit_change" value="Update Used" class="formbutton"/> 
		<input type="button" name="JS" value="Add Method"  onclick="javascript:edittype(0, this.value);" class="formbutton"/> 
		<input type="button" name="Cancel" value="Back to Settings" onclick="CancelForm();" class="formbutton"/><br/><br/>
		</td>
	</tr>
	
	<tr>
		<td colspan="7" align="left"><br/>
		<strong>Notes on using custom shipping methods</strong><br/>Be sure to set up a base rate, such as for basic ground shipping. If you wish to ship both domestic and international, be sure to set up at least one method for each. Any countries you wish to ship to must be included under Country Rates.<br/><br/>
		</td>
	</tr>
	
	</form>
	</table>
	
</cfmodule>