
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This page displays backordered items, and will end the checkout process or allow the user to continue depending on the settings. Called by shopping.checkout (step=payment) --->

<cfset no_checkout = 1>
		
<!--- Border Table ---->
<cfmodule template="../../customtags/format_input_form.cfm"
box_title="Out of Stock!"
width="520"
required_fields = "0">	

<tr><td align="center">
<br/>We do not have the following items in stock<br/>
 in the quantity you are trying to order:<br/>
<table cellpadding="3" cellspacing="3" class="formtext" width="80%">
<tr align="left">
<th>Item Name</th>
<th>Quant. in Stock</th>
<th>Quant. Ordered</th></tr>

<cfoutput query="Backorder">
<tr align="left">
	<td align="left"><span class="formtext">#ItemName#<cfif len(OptName)>, #OptName#</cfif></span></td>
	<td align="center"><span class="formtext">#QuantinStock#</span></td>
	<td align="center"><span class="formtext">#QuantOrdered#</span></td>
</tr>
</cfoutput>
</table>
<br/>


<!--- Allow ordering of out of stock items? --->
<cfif get_Order_Settings.BackOrders>
	<cfoutput>
	<form action="#XHTMLFormat('#self#?fuseaction=shopping.checkout&step=shipping#Request.Token2#')#" method="post">
	<cfif isDefined("attributes.Offline")>
		<input type="hidden" name="Offline" value="#attributes.Offline#"/>
	</cfif></cfoutput>
<!--- If so, allow user to continue or cancel order. --->
<cfoutput>
<div align="center" class="formtext">
These items will have to be back-ordered, do you wish to continue?
</div><br/>

<input type="submit" name="SubmitShipping" value="Continue" class="formbutton"/>
<input type="submit" name="CancelForm" value="Cancel" class="formbutton" />

<input type="hidden" name="Backorder" value="Yes"/>

<!--- Pass any other form variables --->
<cfset FieldNameList = attributes.FieldNames>

<cfloop index="field" list="#FieldNameList#">
	<cfif field IS NOT "formaction">
		<input type="hidden" name="#field#" value="#attributes[field]#"/>
	</cfif>
</cfloop>

</cfoutput>

<cfelse>

<cfoutput><div align="center" class="formtext">
Please return to your cart to change your order:<br/>

<form action="#XHTMLFormat('#Request.StoreURL##self#?fuseaction=shopping.basket&Recalc=Yes#Request.Token2#')#" method="post">

<input type="submit" value="Shopping Cart" class="formbutton"/></div>
</cfoutput>
</cfif>

</form>
</td></tr>
</cfmodule>


