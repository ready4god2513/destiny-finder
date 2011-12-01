
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This template allows user to edit items on their gift registry. The entire registry prints on a single page. --->

<cfset Webpage_title = "Manage Registry">

<cfparam name="attributes.message" default="">
<cfset action = "#request.self#?fuseaction=shopping.giftregistry#request.token2#">

<!--- Title --->
<cfmodule template="../../../customtags/puttitle.cfm"
	TitleText="Manage #qry_get_giftregistry.Event_Name# Registry"
	class="cat_title_large">

<br/>
	
<!--- Event Information --->
<table cellspacing="2" cellpadding="2" border="0" width="100%" class="formtext">
	<tr>
		<td>
<cfoutput query="qry_get_giftregistry">
<span class="listingTitle">#Event_Name#</span><br/>
#Registrant# <cfif len(OtherName)>& #OtherName#</cfif><br/>
Event Date: #DateFormat(Event_Date,'MM/DD/YY')#<br/>
<!--- Event Type: #GiftRegistry_Type#<br/> --->
</cfoutput>
		</td>
		<td valign="top" align="right">
		<cfoutput><a href="#XHTMLFormat('#action#&manage=list')#">Back to Registry List</a></cfoutput>
		</td>
	</tr>
</table>

<br/>

<!--- output listing of Items --->
<cfif NOT qry_get_items.recordcount>
	<cfoutput>
	<div class="formtitle">You have not added any items to this registry.</div>
	</cfoutput>

<cfelse>	

	<cfif len(attributes.message)>
		<cfoutput><div class="formerror"><b>#attributes.message#</b><br/><br/></div></cfoutput>
	</cfif>
	
<cfoutput>
<form name="editform" action="#XHTMLFormat('#action#&manage=actitems&giftregistry_ID=#attributes.giftregistry_ID#')#" method="post">
</cfoutput>
<table cellspacing="2" cellpadding="2" border="0" width="100%" class="formtext">
	<tr>
		<th align="left">Item</th>
		<th align="center">Requested</th>
		<th align="center">Need</th>
		<th align="center">Add</th>
		<th align="center">Remove*</th>
	</tr>
	<tr><td colspan="5"><cfmodule template="../../../customtags/putline.cfm" linetype="thick"></td></tr>
	<cfset ItemList = "">
	<!----
		<cfif len(Sm_Image)>
			<cfmodule template="../../../customtags/putimage.cfm" filename="#Sm_Image#" 
			filealt="#Name#" imglink="#XHTMLFormat(ImgLink)#"  hspace="4" vspace="0">
		</cfif>
	---->
	
	<!--- List Items in Registry --->
	<cfoutput query="qry_get_items">
	<!--- Check if item is still available --->
		<cfinclude template="../qry_check_item.cfm">
		<cfset disable = "no">
		
		<cfset ItemList = ListAppend(ItemList, GiftItem_ID)>
		<cfset ProdLink = "#request.self#?fuseaction=product.display&Product_ID=#product_id##Request.Token2#">
	<tr>
		<td valign="top"><a href="#XHTMLFormat(ProdLink)#" class="cat_title_list">#Name#</a>
		<cfif len(Options)><br/>#Options#</cfif>
		<cfif len(Addons)><br/>#Left(Addons, Len(Addons)-4)#</cfif>
		<cfif len(SKU)><br/>SKU: #SKU#</cfif>
		<cfif NOT CheckProd.Recordcount>
			<cfset disable = "yes">
			<br/><span class="proderror">This product is not currently available</span>
		<cfelseif CheckProd.OptQuant IS NOT 0 AND (CheckProd.OptQuant IS NOT qry_get_items.OptQuant OR NOT CheckOptions.RecordCount)>
			<cfset disable = "yes">
			<br/><span class="proderror">The options selected for this item are no longer valid</span>
		</cfif>
		</td>
		<td align="center" valign="top">#Quantity_Requested#
		<input type="hidden" name="Quantity_Purchased#GiftItem_ID#" value="#Quantity_Purchased#"/>
		</td>
		<td align="center" valign="top">#Evaluate(Quantity_Requested - Quantity_Purchased)#
		<input type="hidden" name="Quantity_Requested#GiftItem_ID#" value="#Quantity_Requested#"/>
		</td>
		
		<td align="center" valign="top">
		<cfif disable>
			<input type="hidden" name="Quantity_Add#GiftItem_ID#" value="0"/> N/A
		<cfelse>
			<input type="text" name="Quantity_Add#GiftItem_ID#" size="3" class="formfield"/>
		</cfif>
		</td>
		<td align="center" valign="top"><input type="checkbox" name="remove#GiftItem_ID#" value="1"/></td>
	</tr>	

	<tr><td colspan="5"><cfmodule template="../../../customtags/putline.cfm" linetype="thin"></td></tr>
	</cfoutput>
	
	<cfoutput>
	<tr>
		<td colspan="5" align="right">&nbsp;<input type="hidden" name="ItemList" value="#ItemList#"/>
		<input type="submit" name="KeepShopping" value="Continue Shopping" class="formbutton"/> 
		<input type="submit" name="UpdateRegistry" value="Update Registry" class="formbutton"/></td>
	</tr>
	</table>
	</form>
	<br/>
	<p style="margin:5px;">(*) You can not remove an item which has already been purchased. If purchases have been made, 'Remove' will zero out the quantity Needed for the item to prevent any more purchases.</p>
	
	
<cfprocessingdirective suppresswhitespace="no">
<script type="text/javascript">
objForm = new qForm("editform");

<cfloop index="item_ID" list="#ItemList#">
	objForm.Quantity_Add#item_ID#.description = "Quantity to Add #item_ID#";
	objForm.Quantity_Add#item_ID#.validateNumeric();
	objForm.Quantity_Add#item_ID#.validateRange('0','999');
</cfloop>

qFormAPI.errorColor = "###Request.GetColors.formreq#";

</script>
</cfprocessingdirective>
	</cfoutput>
	
</cfif>


