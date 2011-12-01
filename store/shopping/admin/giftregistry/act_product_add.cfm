<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This template adds a product to a selected gift registry. This form appears inside a pop-up window.--->

<!--- A variable to determine what is displayed --->
<cfset message = "">

<cfif not isdefined("attributes.GiftRegistry_ID")>
	<cfset message = "Error: No Gift Registry Number Given">

<cfelseif isNumeric(attributes.product_ID)>

	<cfset Application.objCart.addProducttoRegistry(argumentcollection=attributes)>
		
	<cfset message = "done">

</cfif>


<cfmodule template="../../../customtags/format_admin_form.cfm"
	box_title="Add Product to Gift Registry" 
	required_fields="0" 
	width="450">

	<!--- Display Completed --->
	<cfif message is "done">

		<script type="text/javascript">

		 function finish() {
		 	window.opener.location.reload();
			window.close();	 
		 }
		 
		 </script>	 
		 
	<tr><td align="center" class="formtitle">
	<br/><b>Registry Updated</b>	
	<br/><br/>
	<span class="formtext">The item has been added with the quantity requested.</span>
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

