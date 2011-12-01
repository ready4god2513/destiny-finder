<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the form for the order download function.  --->


<cfloop list="fromdate,todate,fromorder,toorder,format" index="counter">
	<cfparam name="attributes.#counter#" default="">
</cfloop>

<cfmodule template="../../../customtags/format_admin_form.cfm"
box_title="Order Download" 
width="450"
required_fields="1">

<cfoutput>
<form action="#request.self#?#cgi.query_string#" method="post" name="editform">
<tr>
	<td align="right">By Order Number:</td>
	<td>&nbsp;</td>
	<td>
		From &nbsp;<input type="text" name="FromOrder" value="#Val(attributes.lastordernumber) + 1#" size="8" maxlength="10" class="formfield"/> &nbsp; 
		To <input type="text" name="ToOrder" value="" size="8" maxlength="10" class="formfield"/>
	</td></tr>

	<cfinclude template="../../../includes/form/put_space.cfm">
		
	<tr>
	<td align="right" valign="top">OR By Date Range:</td>
	<td>&nbsp;</td>
	<td> <input type="text" name="FromDate" value="#dateformat(attributes.FromDate,"yyyy-mm-dd")#" class="formfield" size="15" /> &nbsp;through&nbsp; <input type="text" name="ToDate" value="#dateformat(attributes.ToDate,"yyyy-mm-dd")#" class="formfield" size="15" /><br/>
		<span class="formtextsmall">Enter dates in the format 'YYYY-MM-DD'.<br/>You can enter partial dates such at 'YYYY-MM'.</span>

	</td></tr>
	
	<cfinclude template="../../../includes/form/put_space.cfm">
	
	<tr>
	<td align="right" valign="top">Order Type:</td>
	<td style="background-color: ###Request.GetColors.formreq#;" width="3">&nbsp;</td>
	<td>
		<input type="radio" name="ordertype" value="AllOrders" checked="checked" /> All Orders<br/>
		<input type="radio" name="ordertype" value="FilledOrders"/> Filled Orderes<br/>
	</td></tr>
	
	<cfinclude template="../../../includes/form/put_space.cfm">
	
	<tr>
	<td align="right" valign="top">Output Fomat:</td>
	<td style="background-color: ###Request.GetColors.formreq#;" width="3">&nbsp;</td>
	<td>
		<input type="radio" name="downloadformat" value="orderlineCSV" checked="checked" /> One Order per line, comma delimited<br/>
		<input type="radio" name="downloadformat" value="orderlinetab"/> One Order per line, tab delimited<br/>
		<input type="radio" name="downloadformat" value="productlinetab"/> One Product per line, tab delimited
	</td></tr>
		
<tr>
	<td colspan="2">&nbsp;</td><td><input type="submit" value="Download" class="formbutton"/> 
	<button name="Cancel" value="Cancel" class="formbutton" onclick="javascript:history.go(-1);">Cancel</button>
	
	
	</td></tr></form>
	
<script type="text/javascript">
<!--//
// initialize the qForm object
objForm = new qForm("editform");

objForm.FromOrder.description = "from order number";
objForm.ToOrder.description = "to order number";
objForm.FromDate.description = "from date";
objForm.ToDate.description = "to date";

objForm.FromOrder.validateNumeric();
objForm.ToOrder.validateNumeric();

qFormAPI.errorColor = "###Request.GetColors.formreq#";
//-->
</script>

</cfoutput>

</cfmodule>