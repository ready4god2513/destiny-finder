
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays Gift Registry Order form --->

<!--- This template allows user to edit items on their gift registry. The entire registry prints on a single page. --->

<cfset Webpage_title = "#qry_get_giftregistry.Event_Name# Gift Registry">

<!----- Set this page for Keep Shopping button ------->
<cfset Session.Page="#Request.currentURL#">

<cfparam name="attributes.message" default="">

<!--- Title --->
<cfmodule template="../../customtags/puttitle.cfm" 
	TitleText="#qry_get_giftregistry.Event_Name# Gift Registry"
	class="cat_title_large">

<!--- <div align="right"><a href="javascript:window.history.go(-1);">Back to List</a>&nbsp;&nbsp;</div><br/> --->

<table cellspacing="0" cellpadding="0" border="0" width="100%" class="formtext">
	<cfoutput query="qry_get_giftregistry">
	<tr>
		<td>#Registrant# <cfif len(OtherName)>and #OtherName#</cfif><br/>
		<cfif len(GiftRegistry_Type)>Event: &nbsp;#GiftRegistry_Type# <br/></cfif>
		Date: &nbsp;#DateFormat(Event_Date,'MM/DD/YY')#
		</td>
		<td valign="top">
		<cfif len(Event_Name)><span class="listingTitle">#Event_Name#</span><br/></cfif>
		<span class="listingsubtitle">#Event_Descr#</span>
		</td>
	</tr></cfoutput>
</table>
<br/><br/>


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
	<form name="editform"  method="post"
	action="#XHTMLFormat('#request.self#?fuseaction=shopping.giftregistry&do=cart&giftregistry_ID=#attributes.giftregistry_ID##Request.Token2#')#">
	</cfoutput>
<table cellspacing="4" cellpadding="0" border="0" width="100%" class="formtext">
	<tr>
		<th align="left">Item</th>
		<th align="left">Price</th>
		<th align="center">Requested</th>
		<th align="center">Has</th>
		<th align="center">Quantity</th>
	</tr>
	<tr><td colspan="5"><cfmodule template="../../customtags/putline.cfm" linetype="thick"></td></tr>
	<cfset ItemList = "">
	<!----
		<cfif len(Sm_Image)>
			<cfmodule template="../../customtags/putimage.cfm" filename="#Sm_Image#" 
			filealt="#Name#" imglink="#XHTMLFormat(ImgLink)#"  hspace="4" vspace="0">
		</cfif>
	---->
	
	<!--- List Items in Registry --->
	<cfoutput query="qry_get_items">
		<!--- Check if item is still available --->
		<cfinclude template="qry_check_item.cfm">
		<cfif NOT CheckProd.Recordcount>
			<cfset disable = "yes">
		<cfelseif CheckProd.OptQuant IS NOT 0 AND (CheckProd.OptQuant IS NOT qry_get_items.OptQuant OR NOT CheckOptions.RecordCount)>
			<cfset disable = "yes">
		<cfelse>
			<cfset disable = "no">
		</cfif>
		
		
		<cfset ItemList = ListAppend(ItemList, GiftItem_ID)>
		<cfset ProdLink = "#request.self#?fuseaction=product.display&Product_ID=#product_id##Request.Token2#">
		
	<cfif NOT disable>
	<tr>
		<td valign="top"><a href="#XHTMLFormat(ProdLink)#" class="cat_title_list">#Name#</a>
		<cfif len(trim(Options))><br/>#Options#</cfif>
		<cfif len(Addons)><br/>#Left(Addons, Len(Addons)-4)#</cfif>
		<cfif len(SKU)><br/>SKU: #SKU#</cfif>
		<!--- <cfif NOT CheckProd.Recordcount>
			<cfset disable = "yes">
			<br/><span class="proderror">This product is not currently available</span>
		<cfelseif CheckProd.OptQuant IS NOT 0 AND (CheckProd.OptQuant IS NOT qry_get_items.OptQuant OR NOT CheckOptions.RecordCount)>
			<cfset disable = "yes">
			<br/><span class="proderror">The options selected for this item are no longer valid</span>
		</cfif> --->
		</td>
		<td valign="top">#LSCurrencyFormat(Price+OptPrice+AddOnMultP)#</td>
		<td align="center" valign="top">#Quantity_Requested#</td>
		<td align="center" valign="top">#Quantity_Purchased#</td>
		<td align="center" valign="top" class="formtextsmall">
		<cfif Quantity_Requested gt Quantity_Purchased>
			<cfif disable>
				<input type="hidden" name="Quantity_Add#GiftItem_ID#" value="0"/> N/A
			<cfelse>
				<input type="text" name="Quantity_Add#GiftItem_ID#" size="3" class="formfield"/>
			</cfif>
		<cfelseif NOT len(Name) OR NOT Display> 
			Not Available
		<cfelse>
			Purchased
		</cfif>
			
		</td>
	</tr>	
	<tr><td colspan="5"><cfmodule template="../../customtags/putline.cfm" linetype="thin"></td></tr>
	<cfelse>
		<tr style="display:none"><td colspan="5">
		<input type="hidden" name="Quantity_Add#GiftItem_ID#" value="0"/>
		</td></tr>
	</cfif>
	
	</cfoutput>
	
	<cfoutput>
	<tr>
		<td colspan="3">&nbsp;<input type="hidden" name="ItemList" value="#ItemList#"/></td>
		<td colspan="2" align="center"><input type="submit" name="Action" value="Add to Cart" class="formbutton"/></td>
	</tr>
	</table>
	</form>
	
	
<cfprocessingdirective suppresswhitespace="no">
<script type="text/javascript">
<!--
objForm = new qForm("editform");

<cfloop index="item_ID" list="#ItemList#">
	objForm.Quantity_Add#item_ID#.description = "Quantity to Add #item_ID#";
	objForm.Quantity_Add#item_ID#.validateNumeric();
	objForm.Quantity_Add#item_ID#.validateRange('0','999');
</cfloop>

qFormAPI.errorColor = "###Request.GetColors.formreq#";
//-->
</script>
</cfprocessingdirective>
	</cfoutput>
	
</cfif>

<!--- ADMIN EDIT LINK --->
<!--- Shopping Permission 1 = product admin --->
<cfmodule  template="../../access/secure.cfm"
	keyname="shopping"
	requiredPermission="1"
	>		
	<cfoutput><p class="menu_admin">[<a href="#XHTMLFormat('#Request.SecureURL##request.self#?fuseaction=shopping.admin&giftregistry=listitems&giftregistry_ID=#attributes.giftregistry_ID##Request.AddToken#')#" #doAdmin()#>Edit Gift Registry #giftregistry_ID#</a>]</p>
	</cfoutput>
</cfmodule>


