<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This template adds a product to the basket of an order. This form appears inside a pop-up window.--->

<!--- A variable to determine what is displayed --->
<cfset message = "">

<cfif not isdefined("attributes.Order_No")>
	<cfset message = "Error: No Order Number Given">

<cfelseif isNumeric(attributes.product_ID)>

	<cfset OptChoice = Application.objCart.doAddOrderItem(argumentcollection=attributes)>
		
	<cfset message = "done">
		
	<!--- Update product inventory amounts --->
	<cfset quantity =  attributes.quantity>
	<cfinclude template="act_basket_inventory.cfm">

</cfif>


<cfmodule template="../../../customtags/format_admin_form.cfm"
	box_title="Add Product to Order" 
	required_fields="0" 
	width="500">

	<!--- Display Completed --->
	<cfif message is "done">

		<script type="text/javascript">

		 function finish() {
		 	window.opener.location.reload();
			window.close();	 
		 }
		 
		 </script>	 
		 
	<tr><td align="center" class="formtitle">
	<br/><b>Order Updated</b>	
	<br/><br/>
	<span class="formtext">Be sure to check the product price<br/> and adjust as necessary for this customer.</span>
	<br/><br/>
	<input type="button" name="Done" value="Done" class="formbutton" onclick="javascript:finish();"/>
	<p>
	</td></tr>

	<!--- Display Form --->
	<cfelse>

		<cfif len(message)>
			<cfoutput><br/><div class="formerror" align="center">#message#</div></cfoutput>
		</cfif>	
		
		<input type="button" name="Back" value="Back" onclick="javascript:history.back(-1);" class="formbutton"/>

	</cfif>

</cfmodule>

