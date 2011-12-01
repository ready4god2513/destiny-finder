
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!---
<fusedoc fuse="FBX_Switch.cfm">
	<responsibilities>
		I am the cfswitch statement that handles the fuseaction, delegating work to various fuses.
	</responsibilities>
	<io>
		<string name="fusebox.fuseaction" />
		<string name="fusebox.circuit" />
	</io>	
</fusedoc>
--->

<!--- The shopping circuit --->
<cfif CompareNoCase(fusebox.fuseaction, "order") IS 0>
<!--- Order an item --->
	<cfinclude template="basket/act_cookiecheck.cfm">
	<!--- mjs Check if the user is adding the product to their registry --->
	<cfif isDefined("attributes.AddtoRegistry") OR isDefined("attributes.AddtoRegistry.x")>
		<cfinclude template="giftregistry/manager/act_add_item.cfm">
	<cfelse>
		<cfinclude template="basket/act_add_item.cfm">
		<!--- Recalculate basket --->
		<cfinclude template="basket/act_recalc.cfm">
		<!--- If hiding shopping cart --->
		<cfif get_Order_Settings.ShowBasket AND isDefined("attributes.Product_ID")>
			<cflocation url="#self#?fuseaction=shopping.basket&Product_ID=#Val(attributes.Product_ID)##Request.Token2#" addtoken="No">
		<cfelse>
			<cflocation url="#URLDecode(Session.Page)#" addtoken="No">
		</cfif>
	</cfif>
	
<!--- Displays shopping cart and performs the actions on it --->		
<cfelseif CompareNoCase(fusebox.fuseaction, "basket") IS 0>
	<cfinclude template="basket/act_cookiecheck.cfm">
	<cfif isdefined("attributes.recalculate") OR isdefined("attributes.recalculate.x")>
		<cfinclude template="basket/act_recalc.cfm">
		<cfinclude template="basket/do_basket.cfm">
	<cfelseif isdefined("attributes.ClearCart") OR isdefined("attributes.ClearCart.x")>
		<cfinclude template="basket/dsp_confirm_clear.cfm">
	<cfelseif isdefined("attributes.KeepShopping") OR isdefined("attributes.KeepShopping.x")>
		<cflocation url="#session.page#" addtoken="no">
	<cfelseif isdefined("attributes.Checkout") OR isdefined("attributes.Checkout.x")>
		<cfinclude template="basket/act_recalc.cfm">
		<cflocation url="#Request.SecureURL##self#?fuseaction=shopping.checkout#Request.AddToken#" addtoken="No">
	<cfelse>
		<cfinclude template="basket/act_basket_totals.cfm">
		<cfinclude template="basket/do_basket.cfm">
	</cfif>
	
<!--- Runs the checkout section --->
<cfelseif CompareNoCase(fusebox.fuseaction, "checkout") IS 0>
	<cfinclude template="checkout/do_checkout.cfm">
	
<!--- The shipping admin circuit --->
<cfelseif CompareNoCase(fusebox.fuseaction, "admin") IS 0>
	<cfinclude template="admin/index.cfm">

<!--- Displays and edits the wishlist --->
<cfelseif CompareNoCase(fusebox.fuseaction, "wishlist") IS 0>
	<!---- check that a user is logged in --->
	<cfmodule template="../access/secure.cfm"
	keyname="login"
	requiredPermission="1"
	dsp_login_Required="dsp_please_login_wishlist.cfm" 
	>	
	<cfif ispermitted>
		<!--- call the page display fuseaction --->
		<cfset attributes.page_id = 10>
		<cfset fusebox.nextaction="page.display">
		<cfinclude template="../lbb_runaction.cfm">
		<!--- end fuseaction call --->
		<cfif isDefined("attributes.ProdList")>
			<cfinclude template="wishlist/act_update.cfm">
		<cfelse>
			<cfinclude template="wishlist/act_add_item.cfm">
		</cfif>
		<cfinclude template="wishlist/qry_get_list.cfm">
		<cfinclude template="wishlist/dsp_list.cfm">
	
	</cfif>

	
<!--- Giftwrap: Adds Giftwrapping to selected product in basket. --->
<cfelseif CompareNoCase(fusebox.fuseaction, "giftwrap") IS 0>
	
	<!--- Required: Basket_ID passed as "ID" --->
	<cfparam name="attributes.item" default="0">
	<cfparam name="attributes.giftwrap_ID" default="">

	<!--- If Giftwrap_ID is defined, then process, otherwise display --->
	<cfif isnumeric(attributes.giftwrap_ID)>
		<cfinclude template="giftwrap/act_giftwrap.cfm">
		
		<!--- Confirmation ---->	
		<cfset attributes.XFA_success="fuseaction=shopping.basket">
		<cfset attributes.message="Your Selection Has Been Saved.">
		<cfset attributes.box_title="Gift Wrapping">
		<cfinclude template="../includes/form_confirmation.cfm">				
	<cfelse>
		<cfinclude template="giftwrap/qry_get_giftwraps.cfm">
		<cfinclude template="giftwrap/dsp_giftwraps.cfm">
	</cfif>
	
<!--- Shopping cart summary --->
<cfelseif CompareNoCase(fusebox.fuseaction, "basketstats") IS 0>
	<cfinclude template="basket/dsp_basketstats.cfm">
	
<!--- Clears the shopping cart --->	
<cfelseif CompareNoCase(fusebox.fuseaction, "clear") IS 0>
	<cfif isdefined("attributes.clear") and trim(attributes.clear) is "Yes">
		<cfinclude template="basket/act_clear_basket.cfm">     
	<cfelse>
		<cfinclude template="basket/act_basket_totals.cfm">
		<cfinclude template="basket/do_basket.cfm">
	</cfif>         
	
<!--- Displays the quick order form --->
<cfelseif CompareNoCase(fusebox.fuseaction, "quickorder") IS 0>
	<cfinclude template="basket/dsp_quickorder.cfm">                                      

	
<!--- Displays the tracking form --->
<cfelseif CompareNoCase(fusebox.fuseaction, "tracking") IS 0>
	<cfif ShipSettings.ShipType IS "UPS">
		<cfinclude template="tracking/ups/act_tracking.cfm">
		<cfinclude template="tracking/ups/dsp_tracking.cfm">
	<cfelseif shipsettings.shiptype is "fedex">
		<cfinclude template="tracking/fedex/act_tracking.cfm">
		<cfinclude template="tracking/fedex/dsp_tracking.cfm">
	<cfelseif shipsettings.shiptype is "usps">
		<cfinclude template="tracking/uspostal/act_tracking.cfm">
		<cfinclude template="tracking/uspostal/dsp_tracking.cfm">
	<cfelse>
		<br/><br/>Sorry, tracking information is not available for this store.
	</cfif>
	
<!--- Processes the quick order form --->
<cfelseif CompareNoCase(fusebox.fuseaction, "quickact") IS 0>
	<cfif isDefined("attributes.item1")>
		<cfinclude template="basket/act_quickorder.cfm">
	</cfif>
	<cfinclude template="basket/act_basket_totals.cfm">
	<cfinclude template="basket/do_basket.cfm">   


<!--- Displays the order history --->
<cfelseif CompareNoCase(fusebox.fuseaction, "history") IS 0>
	<!---- check that a user is logged in --->
	<cfmodule template="../access/secure.cfm"
	  keyname="login"
	  requiredPermission="1"
	  > 
	  <cfif ispermitted>   
		  <cfif isdefined("order")>
			   <cfinclude template="order/dsp_order.cfm">
		  <cfelse>
		 	  <cfinclude template="order/dsp_history.cfm">
		  </cfif>
	</cfif>
	
<!--- Runs the affiliate functions --->
<cfelseif CompareNoCase(fusebox.fuseaction, "affiliate") IS 0>
	<cfinclude template="affiliate/index.cfm">
	

<!--- Gift Registry --->
<cfelseif CompareNoCase(fusebox.fuseaction, "giftregistry") IS 0>
	<cfif Request.AppSettings.GiftRegistry>
		<cfinclude template="giftregistry/index.cfm">
	<cfelse>	
		<cfoutput><br/>Gift registry function is not available. <br/><br/></cfoutput>
	</cfif>

<!--- No valid fuseaction found --->
<cfelse>
	<cfmodule template="../#self#" fuseaction="page.pageNotFound">
	
</cfif>



	