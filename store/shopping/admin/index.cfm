
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This is the shopping.admin circuit. It runs all the admin functions for the shopping circuit --->

<!--- Shipping Administration --->
<cfif isdefined("attributes.shipping")>		

	<cfset Webpage_title = "Shipping #attributes.shipping#">
	
	<!--- Shopping Permission 1 = cart admin --->
	<cfmodule template="../../access/secure.cfm"
	keyname="shopping"
	requiredPermission="1"
	>
	<cfif ispermitted>
				
		<cfswitch expression="#attributes.shipping#">

			<cfcase value="settings">
				<cfif isdefined("attributes.Submit_shipping")>
					<cfinclude template="shipping/act_settings.cfm">
				</cfif>				
				<cfinclude template="shipping/dsp_settings.cfm">
			</cfcase>	

			<cfcase value="country">
				<cfinclude template="shipping/act_country_rates.cfm">
				<cfinclude template="shipping/dsp_country_rates.cfm">
			</cfcase>			
	
			<cfcase value="custom">
				<cfinclude template="shipping/act_custom_rates.cfm">
				<cfinclude template="shipping/dsp_custom_rates.cfm">
			</cfcase>	
			
			<cfcase value="customsettings">
				<cfif isdefined("attributes.submit_custom")>
					<cfinclude template="shipping/act_custom_settings.cfm">
					<!--- save confirmation --->
					<cfset attributes.XFA_success="fuseaction=shopping.admin&shipping=settings">
					<cfset attributes.box_title="Custom Settings">
					<cfinclude template="../../includes/admin_confirmation.cfm">	
				<cfelse>
					<cfinclude template="shipping/dsp_custom_settings.cfm">
				</cfif>
			</cfcase>	
			
			<cfcase value="methods">
				<cfif isdefined("attributes.Submit_method")>
					<cfinclude template="shipping/act_method.cfm">
					<cfset attributes.XFA_success="fuseaction=shopping.admin&shipping=methods">
					<cfset attributes.box_title="Shipping Methods">
					<cfinclude template="../../includes/admin_confirmation.cfm">		
				<cfelse>
					<cfinclude template="shipping/dsp_methods.cfm">
				</cfif>
			</cfcase>	
			
			<cfcase value="method">
				<cfif isdefined("attributes.submit_change")>
					<cfinclude template="shipping/act_save_used.cfm">
				<cfelse>
					<cfinclude template="shipping/dsp_method.cfm">
				</cfif>
			</cfcase>	
			
			<cfcase value="usps">
				<cfif isdefined("attributes.submit_usps")>
					<cfinclude template="shipping/uspostal/act_uspostal.cfm">
					<!--- save confirmation --->
					<cfset attributes.XFA_success="fuseaction=shopping.admin&shipping=settings">
					<cfset attributes.box_title="USPS Settings">
					<cfinclude template="../../includes/admin_confirmation.cfm">	
				<cfelse>
					<cfinclude template="shipping/uspostal/dsp_uspostal.cfm">
				</cfif>
			</cfcase>		
			
				<cfcase value="usps_methods">
				<cfif isdefined("attributes.submit_change")>
					<cfinclude template="shipping/uspostal/act_save_uspostal_used.cfm">
				<cfelseif isdefined("attributes.ID")>
					<cfinclude template="shipping/uspostal/dsp_uspostal_method.cfm">
				<cfelse>
					<cfinclude template="shipping/uspostal/dsp_uspostal_methods.cfm">
				</cfif>
			</cfcase>	
			
			<cfcase value="usps_method">
				<cfif isdefined("attributes.Submit_method")>
					<cfinclude template="shipping/uspostal/act_uspostal_method.cfm">
				<cfelse>
					<cfinclude template="shipping/uspostal/dsp_uspostal_method.cfm">
				</cfif>
			</cfcase>			
			
			<cfcase value="intship_methods">
				<cfif isdefined("attributes.submit_change")>
					<cfinclude template="shipping/intershipper/act_save_intship_used.cfm">
				<cfelseif isdefined("attributes.ID")>
					<cfinclude template="shipping/intershipper/dsp_intship_method.cfm">
				<cfelse>
					<cfinclude template="shipping/intershipper/dsp_intship_methods.cfm">
				</cfif>
			</cfcase>	
			
			<cfcase value="intship_method">
				<cfif isdefined("attributes.Submit_method")>
					<cfinclude template="shipping/intershipper/act_intship_method.cfm">
				<cfelse>
					<cfinclude template="shipping/intershipper/dsp_intship_method.cfm">
				</cfif>
			</cfcase>	
			
			<cfcase value="intershipper">
				<cfif isdefined("attributes.submit_intershipper")>
					<cfinclude template="shipping/intershipper/act_intershipper.cfm">
					<!--- save confirmation --->
					<cfset attributes.XFA_success="fuseaction=shopping.admin&shipping=settings">
					<cfset attributes.box_title="Intershipper Settings">
					<cfinclude template="../../includes/admin_confirmation.cfm">	
				<cfelse>
					<cfinclude template="shipping/intershipper/dsp_intershipper.cfm">
				</cfif>
			</cfcase>		
			
			<cfcase value="ups">
				<cfif isdefined("attributes.submit_ups")>
					<cfinclude template="shipping/ups/act_ups.cfm">
					<!--- save confirmation --->
					<cfset attributes.XFA_success="fuseaction=shopping.admin&shipping=settings">
					<cfset attributes.box_title="UPS Shipping Settings">
					<cfinclude template="../../includes/admin_confirmation.cfm">	
				<cfelse>
					<cfinclude template="shipping/ups/dsp_ups.cfm">
				</cfif>
			</cfcase>	
			
			<cfcase value="upswizard">
				<!--- Make sure store is not in test mode --->
				<cfif Request.DemoMode>
					<cflocation url="#self#?fuseaction=shopping.admin&shipping=settings#Request.Token2#" addtoken="No">
				<cfelse>
					<cfinclude template="shipping/ups/dsp_upswizard.cfm">
				</cfif>
			</cfcase>
			
			<cfcase value="upsinfo">
				<!--- Make sure store is not in test mode --->
				<cfif Request.DemoMode>
					<cflocation url="#self#?fuseaction=shopping.admin&shipping=settings#Request.Token2#" addtoken="No">
				<cfelseif isdefined("attributes.submit_ups")>
					<cfinclude template="shipping/ups/act_upsinfo.cfm">
					<cfinclude template="shipping/ups/dsp_upscomplete.cfm">
				<cfelse>
					<cfinclude template="shipping/ups/dsp_upsinfo.cfm">
				</cfif>
			</cfcase>	
			
			<cfcase value="upslicense">
				<!--- Make sure store is not in test mode --->
				<cfif Request.DemoMode>
					<cflocation url="#self#?fuseaction=shopping.admin&shipping=settings#Request.Token2#" addtoken="No">
				<cfelseif isdefined("attributes.submit_ups") AND isdefined("attributes.agree")>
					<cfif attributes.agree IS "yes">
						<cfinclude template="shipping/ups/dsp_upsregister.cfm">
					<cfelse>
						<cfset attributes.message = "Registration cancelled!">
						<cfset attributes.XFA_success="fuseaction=shopping.admin&shipping=settings">
						<cfset attributes.box_title="UPS Shipping Settings">
						<cfinclude template="../../includes/admin_confirmation.cfm">	
					</cfif>
				<cfelse>
					<cfinclude template="shipping/ups/dsp_upslicense.cfm">
				</cfif>
			</cfcase>
			
			<cfcase value="upsregister">
				<!--- Make sure store is not in test mode --->
				<cfif Request.DemoMode>
					<cflocation url="#self#?fuseaction=shopping.admin&shipping=settings#Request.Token2#" addtoken="No">
				<cfelseif isdefined("attributes.submit_ups")>
					<cfif NOT len(attributes.AccountNo) AND NOT isDefined("attributes.NoAccount")>
						<cfinclude template="shipping/ups/dsp_upsaccount.cfm">
					<cfelse>
						<cfinclude template="shipping/ups/act_upsregister.cfm">
						<cfif len(ErrorMessage)>
							<cfinclude template="shipping/ups/dsp_upsregister.cfm">
						<cfelse>
							<cfinclude template="shipping/ups/dsp_upscomplete.cfm">
						</cfif>
					</cfif>
				<cfelse>
					<cfinclude template="shipping/ups/dsp_upsregister.cfm">
				</cfif>
			</cfcase>	
			
			<cfcase value="upsmethods">
				<cfif isdefined("attributes.submit_change")>
					<cfinclude template="shipping/ups/act_save_ups_used.cfm">
				<cfelse>
					<cfinclude template="shipping/ups/dsp_upsmethods.cfm">
				</cfif>
			</cfcase>	
			
			
			<cfcase value="fedex_methods">
				<cfif isdefined("attributes.submit_change")>
					<cfinclude template="shipping/fedex/act_save_fedex_used.cfm">
				<cfelseif isdefined("attributes.ID")>
					<cfinclude template="shipping/fedex/dsp_fedex_method.cfm">
				<cfelse>
					<cfinclude template="shipping/fedex/dsp_fedex_methods.cfm">
				</cfif>
			</cfcase>	
			
			<cfcase value="fedex_method">
				<cfif isdefined("attributes.Submit_method")>
					<cfinclude template="shipping/fedex/act_fedex_method.cfm">
				<cfelse>
					<cfinclude template="shipping/fedex/dsp_fedex_method.cfm">
				</cfif>
			</cfcase>	
			
			<cfcase value="fedexregister">
				<!--- Make sure store is not in test mode --->
				<cfif Request.DemoMode>
					<cflocation url="#self#?fuseaction=shopping.admin&shipping=settings#Request.Token2#" addtoken="No">
				<cfelseif isdefined("attributes.submit_fedex")>
					<cfinclude template="shipping/fedex/act_fedexregister.cfm">
					<cfset attributes.XFA_success="fuseaction=shopping.admin&shipping=settings">
					<cfset attributes.box_title="FedEx Subscription">
					<cfset attributes.message = "FedEx Subscription Complete!">
					<cfinclude template="../../includes/admin_confirmation.cfm">	
				<cfelse>
					<cfinclude template="shipping/fedex/dsp_fedexregister.cfm">
				</cfif>
			</cfcase>	
			
			<cfcase value="fedex">
				<cfif isdefined("attributes.submit_fedex")>
					<cfinclude template="shipping/fedex/act_fedex.cfm">
					<!--- save confirmation --->
					<cfset attributes.XFA_success="fuseaction=shopping.admin&shipping=settings">
					<cfset attributes.box_title="FedEx Shipping Settings">
					<cfinclude template="../../includes/admin_confirmation.cfm">	
				<cfelse>
					<cfinclude template="shipping/fedex/dsp_fedex.cfm">
				</cfif>
			</cfcase>	

			<cfcase value="free">
				<cfif isdefined("attributes.submit_free")>
					<cfinclude template="shipping/act_free.cfm">
					<!--- save confirmation --->
					<cfset attributes.XFA_success="fuseaction=shopping.admin&shipping=settings">
					<cfset attributes.box_title="Free Shipping Settings">
					<cfinclude template="../../includes/admin_confirmation.cfm">	
				<cfelse>
					<cfinclude template="shipping/dsp_free.cfm">
				</cfif>
			</cfcase>	
			
			<cfdefaultcase>
				<cfoutput>This is the cfdefaultcase tag. I received a fuseaction called 
				"#attributes.fuseaction#" and I don't know what to do with it.</cfoutput>
			</cfdefaultcase>
			
		</cfswitch>
	</cfif>
		
<!--- Tax Administration --->
<cfelseif isdefined("attributes.taxes")>		

	<cfset Webpage_title = "Taxes #attributes.taxes#">
	
	<!--- Shopping Permission 1 = cart admin --->
	<cfmodule template="../../access/secure.cfm"
	keyname="shopping"
	requiredPermission="1"
	>
	<cfif ispermitted>				
	
		<cfswitch expression="#attributes.taxes#">
		
			<cfcase value="codes">
				<cfinclude template="tax/dsp_codes.cfm">
			</cfcase>	
			
			<cfcase value="editcode">
				<!--- single code edit --->
				<cfif isdefined("attributes.submit_code")>
					<cfinclude template="tax/act_code.cfm">
					<cfset attributes.XFA_success="fuseaction=shopping.admin&taxes=codes">
					<cfset attributes.box_title="Tax Codes">
					<cfinclude template="../../includes/admin_confirmation.cfm">		
				<!--- all codes update --->
				<cfelseif isdefined("attributes.submit_all")>
					<cfinclude template="tax/act_all_codes.cfm">
					<cfset attributes.XFA_success="fuseaction=shopping.admin&taxes=codes">
					<cfset attributes.box_title="Tax Codes">
					<cfinclude template="../../includes/admin_confirmation.cfm">				
				<cfelse>
					<cfinclude template="tax/dsp_code.cfm">
				</cfif>
			</cfcase>	

			<cfcase value="local">
				<cfinclude template="tax/act_local.cfm">
				<cfinclude template="tax/dsp_local.cfm">
			</cfcase>	
			
			<cfcase value="state">
				<cfinclude template="tax/act_state.cfm">
				<cfinclude template="tax/dsp_state.cfm">
			</cfcase>	
			
			<cfcase value="county">
				<cfinclude template="tax/act_county.cfm">
				<cfinclude template="tax/dsp_county.cfm">
			</cfcase>	
			
			<cfcase value="country">
				<cfinclude template="tax/act_country.cfm">
				<cfinclude template="tax/dsp_country.cfm">
			</cfcase>	
		
			<cfdefaultcase>
				<cfinclude template="tax/act_state.cfm">
				<cfinclude template="tax/dsp_state.cfm">
			</cfdefaultcase>
			
		</cfswitch>
		
	</cfif>
		
<!--- Payment Settings --->
<cfelseif isdefined("attributes.payment")>		

	<cfset Webpage_title = "Payment #attributes.payment#">

	<!--- Shopping Permission 1 = cart admin --->
	<cfmodule template="../../access/secure.cfm"
	keyname="shopping"
	requiredPermission="1"
	>
	<cfif ispermitted>
					
		<cfswitch expression="#attributes.payment#">

			<cfcase value="cards">
				<cfif isdefined("attributes.Submit_cards")>
					<cfinclude template="payment/act_cards.cfm">
					<cfset attributes.XFA_success="fuseaction=shopping.admin&payment=cards">
					<cfset attributes.box_title="Payment Manager">
					<cfinclude template="../../includes/admin_confirmation.cfm">	
				<cfelse>
					<cfinclude template="payment/dsp_cards.cfm">
				</cfif>
			</cfcase>	
			
			<cfcase value="process">
				<cfif isdefined("attributes.submit_process")>
					<cfinclude template="payment/act_process.cfm">
					<cfset attributes.XFA_success="fuseaction=shopping.admin&payment=cards">
					<cfset attributes.box_title="Card Processing">
					<cfinclude template="../../includes/admin_confirmation.cfm">	
				<cfelse>
					<cfinclude template="payment/dsp_process.cfm">
				</cfif>
			</cfcase>	
			
			<cfdefaultcase>
				<cfinclude template="payment/act_cards.cfm">
				<cfinclude template="payment/dsp_cards.cfm">
			</cfdefaultcase>
			
		</cfswitch>
		
	</cfif>
	
<!--- Gift Certificates --->	
<cfelseif isdefined("attributes.certificate")>		

	<cfset Webpage_title = "Certificate #attributes.Certificate#">

	<!--- Shopping Permission 2 = discount/cert admin --->
	<cfmodule template="../../access/secure.cfm"
	keyname="shopping"
	requiredPermission="4"
	>
	<cfif ispermitted>
			
		<cfswitch expression="#attributes.certificate#">

			<cfcase value="list">
				<cfinclude template="certificate/qry_get_certificates.cfm">
				<cfinclude template="certificate/dsp_certificates.cfm">
			</cfcase>

			<cfcase value="add">
				<cfinclude template="certificate/dsp_certificate.cfm">
			</cfcase>
			
			<cfcase value="edit">
				<cfinclude template="certificate/dsp_certificate.cfm">
			</cfcase>
			
			<cfcase value="act">
				<cfinclude template="certificate/act_certificate.cfm">
				
				<cfif attributes.mode is "i">
					<cfinclude template="certificate/dsp_certificate_add.cfm">
				<cfelse>
					<cfset attributes.XFA_success="fuseaction=shopping.admin&certificate=list">
					<cfset attributes.box_title="Certificates">
					<cfinclude template="../../includes/admin_confirmation.cfm">							
				</cfif>
		
			</cfcase>			
		
			<cfdefaultcase>
				<cfinclude template="certificate/qry_get_certificates.cfm">
				<cfinclude template="certificate/dsp_certificates.cfm">
			</cfdefaultcase>
			
		</cfswitch>

	</cfif>
	
<!--- Shopping Cart Settings --->
<cfelseif isdefined("attributes.cart")>		

	<cfset Webpage_title = "Cart #attributes.cart#">
	
	<!--- Shopping Permission 1 = cart admin --->
	<cfmodule template="../../access/secure.cfm"
	keyname="shopping"
	requiredPermission="1"
	>
	<cfif ispermitted>
				
		<cfswitch expression="#attributes.cart#">

			<cfcase value="edit">
				<cfinclude template="cart/dsp_cart_settings.cfm">
			</cfcase>	
			
			<cfcase value="save">
				<cfinclude template="cart/act_cart_settings.cfm">
				<cfset attributes.XFA_success="fuseaction=shopping.admin&cart=edit&newWindow=Yes">
				<cfset attributes.box_title="Cart Settings">
				<cfset attributes.menu_reload="yes">
				<cfinclude template="../../includes/admin_confirmation.cfm">		
				
			</cfcase>	
			
			<cfdefaultcase>
				<cfinclude template="cart/dsp_cart_settings.cfm">
			</cfdefaultcase>
			
		</cfswitch>
		
	</cfif>
	
<!--- Order Management --->
<cfelseif isdefined("attributes.order")>		
	
		<cfset Webpage_title = "Order #attributes.order#">
	
		<cfswitch expression="#attributes.order#">
		
			<!--- Product add form that pops into own window ---> 
			<cfcase value="AddProduct">

				<!--- Shopping Permission 64 = order editing --->
				<cfmodule template="../../access/secure.cfm"
				keyname="shopping"
				requiredPermission="64"
				>
					<cfif isdefined("attributes.AddtoOrder")>
						<cfinclude template="order/act_basket_addproduct.cfm">
					<cfelse>
						<cfinclude template="order/dsp_basket_addproduct.cfm">
					</cfif>					
					

				</cfmodule>
				
			</cfcase>
			
			<!--- order detail ---------------->
			<cfcase value="display">

				<!--- Shopping Permission 2 = order access --->
				<cfmodule template="../../access/secure.cfm"
				keyname="shopping"
				requiredPermission="2"
				>
				<cfif ispermitted>
						
					<!--- Shopping Permission 64 = order editing functions --->
					<cfmodule template="../../access/secure.cfm"
					keyname="shopping"
					requiredPermission="64"
					>
					
						<cfif isdefined("attributes.payform_submit")>
							<cfset attributes.act = "update">
							<cfinclude template="order/act_order.cfm">
							<cfinclude template="order/put_adminrefresh.cfm">
						
						<cfelseif isdefined("attributes.productform_submit")>
							<cfinclude template="order/act_basket_productform.cfm">
							<cfparam name="attributes.xfa_success" default="fuseaction=shopping.admin&order=display&order_no=#attributes.order_no#&edit=product">
							<cfset message="Changes Saved!">	
							<cfset attributes.box_title="Edit Basket">
							<cfinclude template="../../includes/admin_confirmation.cfm">
	
						<cfelseif isdefined("attributes.shipform_submit")>
							<cfinclude template="order/act_basket_shipform.cfm">
						
						<cfelseif isdefined("attributes.taxes_submit")>
							<cfinclude template="order/act_basket_taxform.cfm">
					
						<cfelseif isdefined("attributes.basket_submit")>
							<cfinclude template="order/qry_order.cfm">
							<cfinclude template="order/act_basket_update.cfm">
						</cfif>
					
					</cfmodule>
					
					<cfif isdefined("attributes.act")>
						<cfinclude template="order/act_billing.cfm">
					</cfif>
			
					<!--- if order number submitted from admin order search --->
					<cfif isdefined("attributes.string")>
						<cfif isNumeric(attributes.string)>
							<cfset attributes.Order_No = attributes.string - get_Order_Settings.BaseOrderNum>
						<cfelse>
							<cfset attributes.Order_No = 0>
						</cfif>
					</cfif>
					
					<cfinclude template="order/qry_order.cfm">
					
					<!--- Check if emailing gift cert codes --->
					<cfif isDefined("attributes.sendcodes")>
						<cfinclude template="order/act_sendcodes.cfm">
					</cfif>
					
					<!--- if no order found, go back to referring page --->					
					<cfif NOT GetOrder.recordcount AND isdefined("attributes.string")>
						<br/>No order found!
					<cfelseif NOT GetOrder.recordcount>
						<cflocation URL="#cgi.http_referer#" addtoken="No">	
					<cfelse>
						<cfinclude template="order/dsp_order.cfm">
					</cfif>					
				
				</cfif>
			
			</cfcase>		
			
<!--- order detail ---------------->
			<cfcase value="print">
				<!--- Shopping Permission 2 = order display/admin --->
				<cfmodule template="../../access/secure.cfm"
				keyname="shopping"
				requiredPermission="2"
				>
				<cfif ispermitted>
					<cfinclude template="order/act_printing.cfm">
				</cfif>		
			</cfcase>		
		
			
			<!--- Shopping Permission 8 = order approve --->
			<cfcase value="pending">
			
				<cfmodule template="../../access/secure.cfm"
				keyname="shopping"
				requiredPermission="8"
				>
				<cfif ispermitted>
				
					<cfif isdefined("attributes.batchprocess")>
						<cfinclude template="order/act_orders.cfm">
						<cfset attributes.order_no = "">
					</cfif>
					
					<cfinclude template="order/qry_get_orders.cfm">
					<cfinclude template="order/dsp_orders.cfm">
				
				</cfif>		
			</cfcase>	

				
			<!--- Shopping Permission 16 = order processing --->				
			<cfcase value="process">
			
				<cfmodule template="../../access/secure.cfm"
				keyname="shopping"
				requiredPermission="16"
				>
				<cfif ispermitted>
				
					<cfif isdefined("attributes.batchprocess")>
						<cfinclude template="order/act_orders.cfm">
					</cfif>
					
					<cfparam name="attributes.sort" default="shiptype">
					<cfinclude template="order/qry_get_orders.cfm">
					<cfinclude template="order/dsp_orders.cfm">
					
				</cfif>
			</cfcase>	
			
			
			
			<!--- Shopping Permission 16 = order processing --->				
			<cfcase value="billing">
				<cfmodule template="../../access/secure.cfm"
				keyname="shopping"
				requiredPermission="64"
				>
				<cfif ispermitted>
				
					<cfif isdefined("attributes.act")>
						<cfinclude template="order/act_billing.cfm">
					</cfif>
					
					<cfparam name="attributes.sort" default="payment">
					<cfinclude template="order/qry_get_orders.cfm">
					<cfinclude template="order/dsp_orders_billing.cfm">
					
				</cfif>
			</cfcase>	
			
			<!--- Shopping Permission 16 = order processing --->				
			<cfcase value="search">
				<cfmodule template="../../access/secure.cfm"
				keyname="shopping"
				requiredPermission="256"
				>
				<cfif ispermitted>
				
					<cfinclude template="order/qry_get_orders.cfm">
					<cfinclude template="order/dsp_orders_search.cfm">
					
				</cfif>
			</cfcase>				
			
			<!--- Shopping Permission 128 = orders reports --->
			<cfcase value="filled">
				<cfmodule template="../../access/secure.cfm"
				keyname="shopping"
				requiredPermission="128"
				>
				<cfif ispermitted>
					<cfif isdefined("attributes.purge")>
						<cfinclude template="order/act_orders_filled.cfm">
					</cfif>
					
					<cfinclude template="order/qry_get_orders.cfm">
					<cfinclude template="order/dsp_orders_filled.cfm">	
				</cfif>
			</cfcase>	
			
				
			<!--- Shopping Permission 16 = order shipping 
			This fills order recording shipping info. --->
			<cfcase value="shipping">
				<cfmodule template="../../access/secure.cfm"
				keyname="shopping"
				requiredPermission="16"
				>
				<cfif ispermitted>
					<!--- after filling, return to order detail or listing --->
					<cfparam name="attributes.xfa_success" default="fuseaction=shopping.admin&order=process">
					
					<!---- Process form --->
					<cfif isdefined("attributes.submit_shipping")>
						<cfinclude template="order/act_order_shipping.cfm">		
						<cfset message="Changes Saved!">	
						<cfset attributes.box_title="Order Manager">
						<cfinclude template="../../includes/admin_confirmation.cfm">	
					<!---- Display shipping form --->
					<cfelse>
						<cfinclude template="order/qry_order_shipping.cfm">
						<cfinclude template="order/dsp_order_shipping.cfm">			
					</cfif>					
				</cfif>
			</cfcase>	
			
				
			<!--- Shopping Permission 128 = order Reports --->
			<cfcase value="reports">
				<cfmodule template="../../access/secure.cfm"
				keyname="shopping"
				requiredPermission="128"
				>
				<cfif ispermitted>
					<cfinclude template="report/dsp_reports.cfm">
				</cfif>
			</cfcase>	

			<!--- Order Download --->
			<cfcase VALUE="download">
				<CFINCLUDE TEMPLATE="download/index.cfm">
			</cfcase>

			
			<cfcase value="printreport">
				<cfmodule template="../../access/secure.cfm"
				keyname="shopping"
				requiredPermission="128"
				>
				<cfif ispermitted>
					<cfinclude template="report/dsp_printreport.cfm">
				</cfif>
			</cfcase>	
	
		
			<cfcase value="cleartemp">
				<cfinclude template="order/act_cleartemp.cfm">
			</cfcase>		
			
			
			<cfdefaultcase>
				<cfoutput>This is the cfdefaultcase tag. I received a fuseaction called 
				"#attributes.fuseaction#" and I don't know what to do with it.</cfoutput>
			</cfdefaultcase>
			
		</cfswitch>
		
		
<!--- Purchase Order Management --->
<cfelseif isdefined("attributes.po")>		
	
	<!--- Shopping Permission 32 = dropshipping --->
	<cfmodule template="../../access/secure.cfm"
	keyname="shopping"
	requiredPermission="32"
	>
	<cfif ispermitted>
		
		<cfset Webpage_title = "Purchase Orders">
	
		<cfswitch expression="#attributes.po#">
		
			<cfcase value="list">
				<cfinclude template="po/qry_get_pos.cfm">
				<cfinclude template="po/dsp_po_list.cfm">
			</cfcase>
			
			<cfcase value="print">
				<cfparam name="attributes.Order_PO_ID" default="0">
				<cfinclude template="po/dsp_po_print.cfm">
				<cfoutput><button name="back" class="formbutton"
				 onclick="javascript:window.history.go(-1);">&nbsp;Back&nbsp;</button></cfoutput>
			</cfcase>				
			
			<cfcase value="add">
				<cfparam name="attributes.order_no" default="">
				<cfparam name="attributes.account_ID" default="">
				<cfparam name="attributes.xfa_success"
				 default="fuseaction=shopping.admin&order=display&order_no=#attributes.order_no#">
	
				<cfinclude template="po/act_po.cfm">
				<cfinclude template="po/qry_get_po.cfm">
				<cfinclude template="po/dsp_po_form.cfm">

			</cfcase>
			
			<cfcase value="edit">
				<cfif isdefined("attributes.order_no")>
					<cfparam name="attributes.xfa_success"
				 default="fuseaction=shopping.admin&order=display&order_no=#attributes.order_no#">
				<cfelse>
					<cfparam name="attributes.xfa_success"
				 	default="fuseaction=shopping.admin&po=list&open=1">
				</cfif>
				
				<cfinclude template="po/qry_get_po.cfm">
				<cfinclude template="po/dsp_po_form.cfm">
			</cfcase>
			
			<cfcase value="act">
				<cfinclude template="po/act_po.cfm">
				
				<cfset message="Changes Saved!">	
				<cfset attributes.box_title="Purchase Order">
				<cfinclude template="../../includes/admin_confirmation.cfm">	
			</cfcase>
		
			<cfcase value="ship">

					<!--- after marking purchase order is shipped return to order detail or PO list--->
					<cfif isdefined("attributes.order_no")>
						<cfparam name="attributes.xfa_success"
					 default="fuseaction=shopping.admin&order=display&order_no=#attributes.order_no#">
					<cfelse>
						<cfparam name="attributes.xfa_success"
					 	default="fuseaction=shopping.admin&po=list&open=1">
					</cfif>
					
					<!---- Process form --->
					<cfif isdefined("attributes.submit_ship")>
						<cfinclude template="po/act_po.cfm">		
						<cfset message="Changes Saved!">	
						<cfset attributes.box_title="Order Manager">
						<cfinclude template="../../includes/admin_confirmation.cfm">	
					<!---- Display shipping form --->
					<cfelse>
						<cfinclude template="po/qry_ship.cfm">
						<cfinclude template="po/dsp_ship.cfm">			
					</cfif>					

			</cfcase>			
		
			<cfdefaultcase>
				<cfoutput>This is the cfdefaultcase tag. I received a fuseaction called 
				"#attributes.fuseaction#" and I don't know what to do with it.</cfoutput>
			</cfdefaultcase>
			
		</cfswitch>
		
	</cfif><!--- dropshipping permission --->
		
	
<!--- CUSTOM CODE - Giftwrapping Options ------>
<cfelseif isdefined("attributes.giftwrap")>		
		<!--- Giftwrapping Options Administration --->			
		<cfset Webpage_title = "Giftwrapping #attributes.giftwrap#">
		
		<cfswitch expression="#attributes.giftwrap#">
		
			<cfcase value="list">
				<cfinclude template="giftwrap/qry_get_giftwraps.cfm">
				<cfinclude template="giftwrap/dsp_giftwrap_list.cfm">
			</cfcase>
		
			<cfcase value="listform">
				<cfinclude template="giftwrap/qry_get_giftwraps.cfm">
				<cfinclude template="giftwrap/dsp_giftwrap_list_form.cfm">
			</cfcase>	
		
			<cfcase value="actform">
				<cfinclude template="giftwrap/act_giftwrap_list_form.cfm">	
				
				<cfset attributes.XFA_success="fuseaction=shopping.admin&giftwrap=list">
				<cfset attributes.box_title="Giftwrap">
				<cfinclude template="../../includes/admin_confirmation.cfm">		
			</cfcase>		
		
			<cfcase value="add">
				<cfinclude template="giftwrap/dsp_giftwrap_form.cfm">
			</cfcase>
			
			<cfcase value="edit">
				<cfinclude template="giftwrap/dsp_giftwrap_form.cfm">
			</cfcase>
		
			<cfcase value="act">
				<cfinclude template="giftwrap/act_giftwrap.cfm">
				
				<cfset attributes.XFA_success="fuseaction=shopping.admin&giftwrap=list">
				<cfset attributes.box_title="Giftwrap">
				<cfinclude template="../../includes/admin_confirmation.cfm">		
				
			</cfcase>
		
		
		
			<cfdefaultcase>
				<cfinclude template="giftwrap/qry_get_giftwraps.cfm">
				<cfinclude template="giftwrap/dsp_giftwrap_list.cfm">
			</cfdefaultcase>
			
		</cfswitch>	
<!--- END CUSTOM CODE ------>


<!--- CUSTOM CODE - Gift Registry  ------>
<cfelseif isdefined("attributes.giftregistry")>		

	<cfinclude template="giftregistry/index.cfm">

<!--- END CUSTOM CODE ------>


<cfelse><!--- MENU --->	
	
	<cfinclude template="dsp_menu.cfm">

</cfif>



