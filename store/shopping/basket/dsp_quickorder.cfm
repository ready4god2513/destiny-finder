<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the quick order form. Allows the user to order up to 10 items at a time with the SKU number. Called by shopping.quickorder --->

<cfset Webpage_title = "Quick Order Form">

<cfoutput>
<form method="post" action="#XHTMLFormat('#self#?fuseaction=shopping.quickact#Request.Token2#')#" name="orderform">

<cfmodule template="../../customtags/format_input_form.cfm"
	box_title="Quick Order Form"
	width="440"
	required_fields="0"
	>
		
       <tr align="left"> 
            <td colspan="3"> 
              If you have the order code or the SKU of the item that 
           you wish to purchase, you can place your order with this Quick Order form. 
				The items will be placed in your shopping cart until you are ready to check out. <br/><br/>
			</td>
		</tr>
	

		
		<cfloop index="num" from="1" to="10">
		<tr align="left"> 
            <td><b>Item #NumberFormat(num, "00")#</b></td>
			<td>Order Code or SKU: <input name="item#num#" type="text" class="formfield" size="17"/></td>
            <td>Quantity: <input name="quant#num#" type="text" class="formfield" size="5"/></td>
        </tr>
		
		</cfloop>           
		<tr align="left">    
			<td colspan="3" align="center"> 
             <br/><input type="submit" value="Add to Order" class="formbutton"/>
			 <br/><br/>
			</td>
		</tr> 
</cfmodule>
</form>
</cfoutput>

<cfprocessingdirective suppresswhitespace="no">
<cfoutput>
<script type="text/javascript">
	<!--
	objForm = new qForm("orderform");
	
	/* if any product form fields filled out, make the quantity field required */
	<cfloop index="num" from="1" to="10">
		objForm.quant#num#.createDependencyTo("item#num#"); 
		objForm.quant#num#.description = "quantity #num#";
		objForm.quant#num#.enforceDependency();
	</cfloop>
		
	qFormAPI.errorColor = "###Request.GetColors.formreq#";
	//-->
</script>
</cfoutput>
</cfprocessingdirective>

