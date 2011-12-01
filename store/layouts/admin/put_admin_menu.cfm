
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This page outputs the main admin menu. It calls in the various submenus as needed and as per the user's permissions. Called from fuseaction=home.admin?adminmenu=display --->

<cfinclude template="../../shopping/qry_get_order_settings.cfm">
<cfinclude template="../../users/qry_get_user_settings.cfm">

<!--- Initialize tab counter --->
<cfset totaltabs = 0>

<!--- Creates the body tag with background image and colors set by store. --->
<table border="0" cellspacing="0" cellpadding="5" width="100%">
<tr>

	<td valign="top" width="175" nowrap="nowrap">
	<div id="adminMenu" class="Accordion">
		<cfinclude template="put_shopping_menu.cfm">
		<cfif len(shoppingmenu)>
			<div class="AccordionPanel">
				<div class="AccordionPanelTab">
					Shopping
				</div>
				<div class="AccordionPanelContent">
				<cfoutput>#shoppingmenu#</cfoutput>
				</div>
			</div>
		</cfif>
		
		<cfinclude template="put_gift_menu.cfm">
		<cfif len(giftmenu)>
			<div class="AccordionPanel">
				<div class="AccordionPanelTab">
					Gifts
				</div>
				<div class="AccordionPanelContent">
					<cfoutput>#giftmenu#</cfoutput>
				</div>
			</div>
		</cfif>
		
		<cfinclude template="put_product_menu.cfm">
		<cfif len(productmenu)>
			<div class="AccordionPanel">
				<div class="AccordionPanelTab">
					Products
				</div>
				<div class="AccordionPanelContent">
					<cfoutput>#productmenu#</cfoutput>
				</div>
			</div>
		</cfif>
		
		<cfinclude template="put_feature_menu.cfm">	
		<cfif len(featuremenu)>
			<div class="AccordionPanel">
				<div class="AccordionPanelTab">
					Feature Articles
				</div>
				<div class="AccordionPanelContent">
					<cfoutput>#featuremenu#</cfoutput>
				</div>
			</div>
		</cfif>
		
		<cfinclude template="put_access_menu.cfm">
		<cfif len(accessmenu)>
			<div class="AccordionPanel">
				<div class="AccordionPanelTab">
					Content Access
				</div>
				<div class="AccordionPanelContent">
						<cfoutput>#accessmenu#</cfoutput>				
				</div>
			</div>
		</cfif>
			
		<cfinclude template="put_user_menu.cfm">
		<cfif len(usermenu)>
			<div class="AccordionPanel">
				<div class="AccordionPanelTab">
					Users
				</div>
				<div class="AccordionPanelContent">
					<cfoutput>#usermenu#</cfoutput>								
				</div>
			</div>
		</cfif>

		<cfinclude template="put_importexport_menu.cfm">
		<cfif len(importexport)>
			<div class="AccordionPanel">
				<div class="AccordionPanelTab">
					Import/Export
				</div>
				<div class="AccordionPanelContent">
					<cfoutput>#importexport#</cfoutput>			
				</div>
			</div>			
		</cfif>		
			
		<cfinclude template="put_site_menu.cfm">
		<cfif len(sitemenu)>
			<div class="AccordionPanel">
				<div class="AccordionPanelTab">
					Site Design
				</div>
				<div class="AccordionPanelContent">
					<cfoutput>#sitemenu#</cfoutput>			
				</div>
			</div>			
		</cfif>		
			
		</div>
	</td><td></td>
</tr>
</table>


<!--- Determine tab setting if not set in one of the admin menus --->
<cfparam name="tabstart" default="0">

<!--- Include the tab init into the layout page header --->
<!--- <cfhtmlhead text="
	<script language='javascript'>	
		function init() {
			new Rico.Accordion( $('adminMenu'), {panelHeight:210,onLoadShowTab:#tabstart#} );
		}
	</script>
"> --->
<cfhtmlhead text='
<script type="text/javascript">
function init() {
	var Accordion1 = new Spry.Widget.Accordion("adminMenu", { duration: 200, defaultPanel: #tabstart# });
	}
</script>'>