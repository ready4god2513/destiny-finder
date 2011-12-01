<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the form for selecting (or displaying) the shipping charge and entering additional order information (notes, coupon, gift cert, etc.) Called by shopping.checkout (step=shipping) --->

<!--- initialize form field attributes ---->
<cfset attributes.fieldlist="giftcard,delivery,comments">

<!--- add custom checkout fields --->
<cfloop index="x" from="1" to="3">
	<cfset attributes.fieldlist = ListAppend(attributes.fieldlist, 'CustomText' & x)>
</cfloop>
<cfloop index="x" from="1" to="2">
	<cfset attributes.fieldlist = ListAppend(attributes.fieldlist, 'CustomSelect' & x)>
</cfloop>

<cfloop list="#attributes.fieldlist#" index="counter">
	<cfparam name="attributes.#counter#" default= "#evaluate('gettemporder.' & counter)#">
</cfloop>

<cfparam name="ShowForm" default="yes">
	
<!--- see if "Gift Cards" are a valid payment method, for Shift4 --->
<cfquery name="qGetCards" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	SELECT CardName FROM #Request.DB_Prefix#CreditCards
	WHERE Used = 1 AND CardName LIKE 'Gift%'
</cfquery>
<cfset GCEnabled=qGetCards.RecordCount GT 0>

<!--- Load character counter --->
<cfinclude template="../../includes/charCount.js">

<!--- Border Table ---->
<cfmodule template="../../customtags/format_input_form.cfm"
box_title="Order Options"
width="#iif(TotalShip or TotalFreight, DE('100%'), DE('400'))#"
required_fields = "0"
>

<cfoutput>		
		<tr><td align="center">
	<cfif len(Message)>
	<p class="formerror"><br/>#Message#</p>
	</cfif>		
	
	<form action="#XHTMLFormat('#self#?fuseaction=shopping.checkout&step=shipping#request.token2#')#" method="post" name="shipform">
			
	<!--- Content Table provides 2 columns ---->
	<table cellspacing="0" border="0" cellpadding="10" class="formtext" style="color:###Request.GetColors.InputTText#">
		<tr align="left">
		
		<!--- If order has shipping, display cost or choices ---->
		<cfif TotalShip or TotalFreight>
		
		<td valign="top">
		<!--- If shipping calculated by weight or UPS, display total weight --->
		<cfif NOT ListFind('Price,Price2,Item', ShipSettings.ShipType) AND Session.CheckoutVars.TotalWeight GT 0>
			<b>Total Weight:</b> #Session.CheckoutVars.TotalWeight# #Request.AppSettings.WeightUnit#<br/>
			<br/>
		</cfif>
		
		<cfif ShipSettings.ShowFreight AND TotalFreight>
			<b>Freight Charges:</b> #LSCurrencyFormat(TotalFreight)#<br/><br/>
		</cfif>

		<b>Shipping Charges:</b>		
			
			<cfif isDefined("attributes.NoShip") AND attributes.NoShip IS "Yes">
			<p class="formerror">Please select a shipping rate!</p>
			</cfif>
		
			<cfinclude template="shipping/put_shiprates.cfm">
		
		<cfif ShowForm AND NOT ListFind('UPS,FedEx,USPS,Intershipper',ShipSettings.ShipType)>	
			<cfif get_Order_Settings.Delivery>
			<br/><br/><strong>Ship to arrive on/by:</strong> &nbsp;<span class="formtextsmall">(optional)</span><br/>
			<input type="text" name="Delivery" value="#attributes.Delivery#" size="40" maxlength="50" class="formfield"/>
			</cfif>
		</cfif>
		
		<cfif CompareNoCase(ShipSettings.ShipType, 'UPS') IS 0>
		<br/><br/><img src="#Request.AppSettings.defaultimages#/icons/ups_smlogo.jpg" alt="" width="32" height="32" 
		border="0"	align="left" /><i>UPS, UPS brandmark, and the Color Brown are trademarks of United
		Parcel Service of America, Inc. All Rights Reserved.</i>
		<cfelseif CompareNoCase(ShipSettings.ShipType, 'USPS') IS 0>
		<br/><br/><img src="#Request.AppSettings.defaultimages#/icons/hdr_uspsLogo.gif" width="160" height="60" 
		alt="Rates by U.S. Postal Service" border="0" align="middle" /><br/><i>Rates courtesy of U.S. Postal Service</i>
		<cfelseif CompareNoCase(ShipSettings.ShipType, 'FedEx') IS 0>
		<br/><br/><img src="#Request.AppSettings.defaultimages#/icons/fedex_sm.gif" width="130" height="50" 
		alt="Rates by FedEx" border="0" align="middle" /><br/><i>&nbsp;&nbsp;&nbsp;Rates courtesy of FedEx&reg;</i>
		<cfelseif CompareNoCase(ShipSettings.ShipType, 'Intershipper') IS 0>
		<br/><br/><img src="#Request.AppSettings.defaultimages#/isbutton.gif" width="258" height="68" alt="Rates by Intershipper"
		border="0" />
		</cfif>
	
		</td>
		</cfif><!--- if totalship --->	
	
		<!--- Order options ---->
		<td valign="top">
	<cfif ShowForm>	
	<table border="0" cellpadding="0" cellspacing="0" class="formtext" style="color:###Request.GetColors.InputTText#">

	
	<cfif get_Order_Settings.Giftcard>
	 <tr align="left">
    	<td><strong>Gift card text:</strong><br/>
		<textarea name="GiftCard" id="GiftCard" class="formfield" cols="30" rows="3" onkeyup="CheckFieldLength(GiftCard, 'charcount', 'remaining', 255);" onkeydown="CheckFieldLength(GiftCard, 'charcount', 'remaining', 255);" onmouseout="CheckFieldLength(GiftCard, 'charcount', 'remaining', 255);">#attributes.GiftCard#</textarea><br/>
		<small><span id="charcount">#len(attributes.GiftCard)#</span> chrs entered.   |   
		<span id="remaining">#255-len(attributes.GiftCard)#</span> chrs remaining.</small><br/><br/>
		</td>
	 </tr>
	</cfif>	
	
	<cfif get_Order_Settings.Delivery AND ListFind('UPS,FedEx,USPS,Intershipper',ShipSettings.ShipType)>
	 <tr>
    	<td><strong>Ship to arrive on/by:</strong> &nbsp;<span class="formtextsmall">(optional)</span><br/>
		<input type="text" name="Delivery" value="#attributes.Delivery#" size="40" maxlength="50" class="formfield"/>
		<br/><br/>
		</td>
	 </tr>
	</cfif>
	
<!--- Not currently supported, visible on the shopping cart page instead --->
<!--- 	<cfif get_Order_Settings.Coupons>
	<tr>
    	<td><strong><cfif GCEnabled>Coupon Code<cfelse>Coupon or Gift Certificate:</cfif></strong> 
		&nbsp;<span class="formtextsmall">(if available)</span><br/>
		<input type="text" name="Coupon" value="" size="40" maxlength="50" class="formfield"/>
		<cfif len(Session.Coup_Code)><br/>Current Coupon Code: #Session.Coup_Code#</cfif>
		<cfif len(Session.Gift_Cert)><br/>Current Gift Certificate: #Session.Gift_Cert#</cfif>
		<br/><br/>		
		</td>
		</tr>
	</cfif> --->
	
<!--- Output custom text box  fields --->
<cfloop index="x" from="1" to="3">
	<cfif len(get_Order_Settings["CustomText" & x][1])>
	<tr><td><strong>#get_Order_Settings["CustomText" & x][1]#</strong><br/>
	<input type="text" name="CustomText#x#" value="#attributes['CustomText' & x]#" size="40" maxlength="50" class="formfield"/><br/><br/>	
	</td></tr>
	</cfif>
</cfloop>
<!--- Output custom selectbox fields --->
<cfloop index="x" from="1" to="2">
	<cfif len(get_Order_Settings["CustomSelect" & x][1]) AND len(get_Order_Settings["CustomChoices" & x][1])>
	<cfset ChoiceList = get_Order_Settings["CustomChoices" & x][1]>
	<tr><td><strong>#get_Order_Settings["CustomSelect" & x][1]#</strong><br/>
	<select name="CustomSelect#x#" size="1" class="formfield">
	<option value="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>
	<cfloop index="i" from="1" to="#ListLen(ChoiceList)#">
		<cfset choice = Trim(ListGetAt(ChoiceList, i))>
		<option value="#choice#" #doSelected(attributes['customselect' & x],choice)#>#choice#</option>
	</cfloop>
	</select><br/><br/>	
	</td></tr>
	</cfif>
</cfloop>

	<tr style="display:none"><td>
	<!--- required custom checkout fields --->
	<input type="hidden" name="CustomText_Req" value="#get_Order_Settings.CustomText_Req#"/>
	<input type="hidden" name="CustomSelect_Req" value="#get_Order_Settings.CustomSelect_Req#"/>
	</td></tr>	
	
	<tr>
    	<td>			
		<strong>Additional comments:</strong><br/>
		<input type="text" name="Comments" value="#attributes.Comments#" size="40" maxlength="255" class="formfield"/><br/><br/>
		</td>
		</tr>
		
	</table>
	</cfif>

	
	</td></tr>
	
	</table>
	
	<input type="hidden" name="formaction" value="Continue"/>
	
	<cfif ShowForm>	
		<input type="submit" name="SubmitShipping" value="Continue" class="formbutton"/>
		<input type="submit" name="CancelForm" value="Cancel" class="formbutton" onclick="noValidation();" />
	<cfelse>
		<input type="submit" name="CancelForm" value="Back to Shopping Cart" class="formbutton" />
		
	</cfif>	
	</form>
	</td></tr>
	</cfoutput>
</cfmodule>

<cfif ShowForm>
<cfprocessingdirective suppresswhitespace="No">
<script type="text/javascript">
objForm = new qForm("shipform");

<cfoutput>
<!--- output JS checks for required text fields --->
<cfif len(get_Order_Settings.CustomText_Req)>
	objForm.required("#get_Order_Settings.CustomText_Req#");
	
	<cfloop index="customfield" list="#get_Order_Settings.CustomText_Req#">
		objForm.#customfield#.description = "#get_Order_Settings[customfield][1]#";
	</cfloop>
</cfif>
<!--- output JS checks for required selectbox fields --->
<cfif len(get_Order_Settings.CustomSelect_Req)>
	objForm.required("#get_Order_Settings.CustomSelect_Req#");
	
	<cfloop index="customfield" list="#get_Order_Settings.CustomSelect_Req#">
		objForm.#customfield#.description = "#get_Order_Settings[customfield][1]#";
	</cfloop>
</cfif>

function noValidation() {
	objForm._skipValidation = true;
}

qFormAPI.errorColor = "###Request.GetColors.formreq#";
</cfoutput>

</script>
</cfprocessingdirective>
</cfif>
