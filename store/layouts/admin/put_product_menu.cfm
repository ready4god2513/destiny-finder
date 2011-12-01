<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the admin menu for products. Called by product.admin --->

<cfparam name="totaltabs" default="0">
<cfparam name="productmenu" default="">

<!--- product permissions 3 = product admin --->
<cfmodule template="../../access/secure.cfm"
	keyname="product"
	requiredPermission="15"
	> 

<!--- If page being called is a product admin page, set tabs open on Product menu --->
<cfif (FindNoCase("product.admin", attributes.xfa_admin_link))>
	<cfset tabstart = totaltabs>
</cfif>

<cfset totaltabs = totaltabs + 1>

<cfsavecontent variable="productmenu">

<cfoutput>

		<!--- Product Permission 3 = product edit --->
		<cfmodule template="../../access/secure.cfm"
		keyname="product"
		requiredPermission="3"
		/>
		<cfif ispermitted>
		<form name="productjump" action="#self#?fuseaction=product.admin&do=list#request.token2#" method="post" target="AdminContent" class="nomargins">
		<input type="text" name="string" value="enter Product ID..." size="20" maxlength="100" class="accordionTextBox" onfocus="productjump.string.value = '';" onchange="submit();" />
		</form>
		</cfif>
<cfif ispermitted>
	<a href="#self#?fuseaction=product.admin&do=add&CID=0#Request.Token2#" onmouseover="return escape(product12)" target="AdminContent">New Product</a><br/>
	<a href="#self#?fuseaction=product.admin&do=list&CID=0#Request.Token2#" onmouseover="return escape(product1)" target="AdminContent">Manage Products</a><br/>
	<a href="#self#?fuseaction=product.admin&stdoption=list#Request.Token2#" onmouseover="return escape(product2)" target="AdminContent">Standard Product Options</a><br/>
	<a href="#self#?fuseaction=product.admin&stdaddon=list#Request.Token2#" onmouseover="return escape(product3)" target="AdminContent">Standard Product Addons</a><br/>
</cfif>

<cfmodule template="../../access/secure.cfm"
	keyname="product"
	requiredPermission="1"
	> 
	<a href="#self#?fuseaction=product.admin&fields=edit#Request.Token2#" onmouseover="return escape(product6)" target="AdminContent">Custom Product Fields</a><br/><br/>
</cfmodule>

<cfmodule template="../../access/secure.cfm"
	keyname="product"
	requiredPermission="64"
	> 

	<cfif request.appsettings.productreviews>
		<cfif request.appsettings.ProductReview_Approve OR request.appsettings.ProductReview_Flag>		
		<cfset innertext = Application.objMenus.getPendingReviews()>
		<div id="Reviews_Div" spry:region="txtPending"><a href="#self#?fuseaction=product.admin&review=listform&display_status=editor&order=DESC#Request.Token2#" target="AdminContent">Reviews Pending</a>:<br/> <span style="color: red"><span id="reviewcount" spry:content="{Reviews}">#innertext#</span> approval.</span><br/><br/>
		</div>
		</cfif>
		<a href="#self#?fuseaction=product.admin&review=list#Request.Token2#" onmouseover="return escape(product11)" target="AdminContent">Product Reviews</a><br/>
	</cfif>

	<!--- Product Reviews --->
	<a href="#self#?fuseaction=product.admin&review=settings#Request.Token2#" onmouseover="return escape(product10)" target="AdminContent">Product Reviews Settings</a><br/>
	<!--- end custom code --->
</cfmodule>


</cfoutput>

</cfsavecontent>
</cfmodule>