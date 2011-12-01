
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This template allows user to edit items on their gift registry. The entire registry prints on a single page. --->

<cfset Webpage_title = "Manage #qry_get_giftregistry.Event_Name# Registry">

<cfparam name="attributes.message" default="">

<cfinclude template="../../../includes/imagepreview.js">

<cfmodule template="../../../customtags/format_output_admin.cfm"
	box_title="Update Gift Registry"
	Width="650"
	menutabs="yes">

	
	<cfinclude template="dsp_menu_tab.cfm">
	
	
<cfoutput>
	<table border="0" cellpadding="0" cellspacing="4" width="100%" class="formtext" style="color:###Request.GetColors.InputTText#">
</cfoutput>

<!--- Event Information --->
<table cellspacing="2" cellpadding="2" border="0" width="100%" class="formtext">
	<tr>
		<td>
<cfoutput query="qry_get_giftregistry">
<span class="listingTitle"><a href="#request.self#?fuseaction=shopping.giftregistry&do=display&giftregistry_ID=#attributes.giftregistry_ID##request.token2#">#Event_Name#</a></span><br/>
#GiftRegistry_Type# - #DateFormat(Event_Date,'MM/DD/YY')#<br/>
#registrant# <cfif len(OtherName)> &amp; #OtherName#</cfif>  <br/>
</cfoutput>
		</td>
		<td valign="top" align="right">
		<cfoutput>
<button class="formbutton" onclick="JavaScript: newWindow = openWin( '#request.self#?fuseaction=shopping.admin&giftregistry=AddProduct&giftregistry_ID=#attributes.giftregistry_ID##request.token2#', 'Products', 'width=525,height=250,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()">Add Product</button> &nbsp;&nbsp;</cfoutput>
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

<table cellspacing="2" cellpadding="2" border="0" width="100%" class="formtext">
	<tr>
		<th align="left">Item</th>
		<th align="center">Requested</th>
		<th align="center">Purchased</th>
		<th align="center">Remove*</th>
	</tr>
	<tr><td colspan="4"><cfmodule template="../../../customtags/putline.cfm" linetype="thick"/></td></tr>
	<cfset ItemList = "">
	<cfoutput>
	<form name="editform" action="#request.self#?fuseaction=shopping.admin&giftregistry=actitems&giftregistry_ID=#attributes.giftregistry_ID##Request.Token2#" method="post"></cfoutput>

	<!----
		<cfif len(Sm_Image)>
			<cfmodule template="../../../customtags/putimage.cfm" filename="#Sm_Image#" 
			filealt="#Name#" imglink="#ImgLink#"  hspace="4" vspace="0">
		</cfif>
	---->
	
	<!--- List Items in Registry --->
	<cfoutput query="qry_get_items">
		<cfset ItemList = ListAppend(ItemList, GiftItem_ID)>
		<cfset ImgLink = "#request.self#?fuseaction=product.display&Product_ID=#product_id##Request.Token2#">
	<tr>
		<td valign="top"><a href="#ImgLink#" class="cat_title_list">#Name#</a><br/>
		<cfif len(Options)>#Options#<br/></cfif>
		<cfif len(SKU)>SKU: #SKU#</cfif>
		</td>
		<td align="center" valign="top">
		<input type="text" size="4" name="Quantity_Requested#GiftItem_ID#" value="#Quantity_Requested#" class="formfield"/>
		</td>
		<td align="center" valign="top">
		<input type="text" size="4" name="Quantity_Purchased#GiftItem_ID#" value="#Quantity_Purchased#" class="formfield"/>
		</td>

		<td align="center" valign="top"><input type="checkbox" name="remove#GiftItem_ID#" value="1"/></td>
	</tr>	
	<!--- Add Message if Product is no longer available. --->
	<cfif NOT len(Name) OR NOT Display> 
	<tr>
		<td colspan="2">This product is no longer available</td>
		<td colspan="2"></td>
	</tr>	
	</cfif>

	<tr><td colspan="4"><cfmodule template="../../../customtags/putline.cfm" linetype="thin" /></td></tr>
	</cfoutput>
	
	<cfoutput>
	<tr>
		<td colspan="2">&nbsp;<input type="hidden" name="ItemList" value="#ItemList#"/></td>
		<td colspan="2" align="Center"><input type="submit" name="Action" value="Update Registry" class="formbutton"/></td>
	</tr>
	</form>
	</table>
	<br/><br/>
	<div align="center" class="formtext">(*) You can not remove an item which has already been purchased.</div>
	

		
		
	<table cellspacing="2" cellpadding="2" border="0" width="100%" class="formtext">
<form action="#request.self#?fuseaction=shopping.admin&giftregistry=list#request.token2#" method="post">
	<tr>
		<td align="center">
<cfmodule template="../../../customtags/putline.cfm" linetype="thin" linecolor="#Request.GetColors.InputHBgcolor#" width="98%" /><br/>
		<input type="submit" name="DONE" value="Back to Registry List" class="formbutton"/><br/><br/>
		</td>
    </tr>
    </form>
	</table>	
	
<cfprocessingdirective suppresswhitespace="no">
<script type="text/javascript">
objForm = new qForm("editform");

<cfloop index="item_ID" list="#ItemList#">
	objForm.Quantity_Requested#item_ID#.description = "Quantity Requested #item_ID#";
	objForm.Quantity_Requested#item_ID#.validateNumeric();
	objForm.Quantity_Requested#item_ID#.validateRange('0','999');
</cfloop>

<cfloop index="item_ID" list="#ItemList#">
	objForm.Quantity_Purchased#item_ID#.description = "Quantity Purchased #item_ID#";
	objForm.Quantity_Purchased#item_ID#.validateNumeric();
	objForm.Quantity_Purchased#item_ID#.validateRange('0','999');
</cfloop>

qFormAPI.errorColor = "###Request.GetColors.formreq#";

</script>
</cfprocessingdirective>
	</cfoutput>
	
</cfif>

</cfmodule>
