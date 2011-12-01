<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This page displays the tabbed menu at the top of the order management edit forms. The tabs displayed will vary according to the user permissions. --->

<cfparam name="attributes.order" default="po">


<cfset querystring = "fuseaction=shopping.admin">

<cfoutput>
<table border="0" cellpadding="0" cellspacing="0" width="100%" class="TopTierNavBkgrd">
        <tbody>
		
<!----- TITLE ROW ------>
        <tr class="TopTierHeader">
          <td class="TopTierHeader">		  
		  <img src="#Request.AppSettings.defaultimages#/spacer.gif" alt="" height="2" width="1" /></td></tr>

<!----- SPACING ROW  ------>  
        <tr class="TopTierNav">
          <td>
</td></tr>


<!----- TAB ROW  ------>  
		<tr>
          <td valign="bottom">
		  
		  	<!----- Start Sub Tier Nav Table  ------>  
            <table border="0" cellpadding="0" cellspacing="0">
              <tbody>
              <tr>		  
			   <td class="TopTierNavBkgrd" nowrap="nowrap" width="5">&nbsp;</td>
			
	<!--- Shopping Permission 8 = approve orders --->		
	<cfmodule template="../../../access/secure.cfm"
	keyname="shopping"
	requiredPermission="8"
	>
			
			<!--- cards ----->
			  <cfif attributes.order is "pending">
			  <td class="TopTierNavActive" nowrap="nowrap" width="5">&nbsp;</td>
			    <td class="TopTierNavActive">
				<a class="TopTierNavActive" href="#self#?#querystring#&order=pending#Request.Token2#">Pending</a></td>
			  <td class="TopTierNavActive" nowrap="nowrap" width="1">&nbsp;</td>
			  
			  <cfelse>
			   <td nowrap="nowrap" width="5" class="TopTierNav">&nbsp;</td>
			  <td class="TopTierNav"><a class="TopTierNav" href="#self#?#querystring#&order=pending#Request.Token2#">Pending</a></td>
			  <td class="TopTierNav" nowrap="nowrap" width="5">&nbsp;</td>
			  </cfif>
			

	</cfmodule>
	
	
	<!--- Shopping Permission 16 = process orders --->		
	<cfmodule template="../../../access/secure.cfm"
	keyname="shopping"
	requiredPermission="16"
	>

		   <!---- Line -------->		
			<td nowrap="nowrap" width="1" class="TopTierNavBkgrd">
			 <img src="#Request.AppSettings.defaultimages#/spacer.gif" alt="" height="2" width="1" /></td>
			
			<!--- process ----->
			 <cfif attributes.order is "process">
			  <td class="TopTierNavActive" nowrap="nowrap" width="5">&nbsp;</td>
			    <td class="TopTierNavActive">
				<a class="TopTierNavActive" href="#self#?#querystring#&order=process#Request.Token2#">In Process</a></td>
			  <td class="TopTierNavActive" nowrap="nowrap" width="1">&nbsp;</td>
			  <cfelse>
			   <td class="TopTierNav" nowrap="nowrap" width="5">&nbsp;</td>
			  <td class="TopTierNav">
			  <a class="TopTierNav" href="#self#?#querystring#&order=process#Request.Token2#">In Process</a></td>
			  <td class="TopTierNav" nowrap="nowrap" width="5">&nbsp;</td>
			  </cfif>		
				
	</cfmodule>
			
		
			
<cfif get_Order_Settings.UseBilling>
	<!--- Shopping Permission 64 = order edit --->		
	<cfmodule template="../../../access/secure.cfm"
	keyname="shopping"
	requiredPermission="64"
	>				
		   <!---- Line -------->		
			<td nowrap="nowrap" width="1" class="TopTierNavBkgrd">
			 <img src="#Request.AppSettings.defaultimages#/spacer.gif" alt="" height="2" width="1" /></td>
		
			<!--- process ----->
			 <cfif attributes.order is "billing">
			  <td class="TopTierNavActive" nowrap="nowrap" width="5">&nbsp;</td>
			    <td class="TopTierNavActive">
				<a class="TopTierNavActive" href="#self#?#querystring#&order=billing#Request.Token2#">Billing</a></td>
			  <td class="TopTierNavActive" nowrap="nowrap" width="1">&nbsp;</td>
			  <cfelse>
			   <td class="TopTierNav" nowrap="nowrap" width="5">&nbsp;</td>
			  <td class="TopTierNav"><a class="TopTierNav" href="#self#?#querystring#&order=billing#Request.Token2#">Billing</a></td>
			  <td class="TopTierNav" nowrap="nowrap" width="5">&nbsp;</td>
			  </cfif>					
						

	</cfmodule>				
			
</cfif>	


			
	<!--- Shopping Permission 128 = order reports --->			
	<cfmodule template="../../../access/secure.cfm"
	keyname="shopping"
	requiredPermission="128"
	>				
		   <!---- Line -------->		
			<td nowrap="nowrap" width="1" class="TopTierNavBkgrd">
			 <img src="#Request.AppSettings.defaultimages#/spacer.gif" alt="" height="2" width="1" /></td>
		
			<!--- process ----->
			 <cfif attributes.order is "filled">
			  <td class="TopTierNavActive" nowrap="nowrap" width="5">&nbsp;</td>
			    <td class="TopTierNavActive">
				<a class="TopTierNavActive" href="#self#?#querystring#&order=filled#Request.Token2#">Filled</a></td>
			  <td class="TopTierNavActive" nowrap="nowrap" width="1">&nbsp;</td>
			  <cfelse>
			   <td class="TopTierNav" nowrap="nowrap" width="5">&nbsp;</td>
			  <td class="TopTierNav">
			  <a class="TopTierNav" href="#self#?#querystring#&order=filled#Request.Token2#">Filled</a></td>
			  <td class="TopTierNav" nowrap="nowrap" width="5">&nbsp;</td>
			  </cfif>									

	</cfmodule>	
	
	<!--- Shopping Permission 256 = order search --->		
	<cfmodule template="../../../access/secure.cfm"
	keyname="shopping"
	requiredPermission="256"
	>

		   <!---- Line -------->		
			<td nowrap="nowrap" width="1" class="TopTierNavBkgrd">
			<img src="#Request.AppSettings.defaultimages#/spacer.gif" alt="" height="2" width="1" /></td>
			
			<!--- process ----->
			 <cfif attributes.order is "search">
			  <td class="TopTierNavActive" nowrap="nowrap" width="5">&nbsp;</td>
			    <td class="TopTierNavActive">
				<a class="TopTierNavActive" href="#self#?#querystring#&order=search#Request.Token2#">Search All</a></td>
			  <td class="TopTierNavActive" nowrap="nowrap" width="1">&nbsp;</td>
			  <cfelse>
			   <td class="TopTierNav" nowrap="nowrap" width="5">&nbsp;</td>
			  <td class="TopTierNav">
			  <a class="TopTierNav" href="#self#?#querystring#&order=search#Request.Token2#">Search All</a></td>
			  <td class="TopTierNav" nowrap="nowrap" width="5">&nbsp;</td>
			  </cfif>		
				
	</cfmodule>
				
				
	<!--- Shopping Permission 32 = order dropshipping --->		
	<cfmodule template="../../../access/secure.cfm"
	keyname="shopping"
	requiredPermission="32"
	>				
		   <!---- Line -------->		
			<td nowrap="nowrap" width="1" class="TopTierNavBkgrd">
			<img src="#Request.AppSettings.defaultimages#/spacer.gif" alt="" height="2" width="1" /></td>
		
			<!--- process ----->
			 <cfif attributes.order is "po">
			  <td class="TopTierNavActive" nowrap="nowrap" width="5">&nbsp;</td>
			    <td class="TopTierNavActive">
				<a class="TopTierNavActive" href="#self#?#querystring#&po=list&open=1#Request.Token2#">PO/Dropship</a></td>
			  <td class="TopTierNavActive" nowrap="nowrap" width="1">&nbsp;</td>
			  <cfelse>
			   <td class="TopTierNav" nowrap="nowrap" width="5">&nbsp;</td>
			  <td class="TopTierNav">
			  <a class="TopTierNav" href="#self#?#querystring#&po=list&open=1#Request.Token2#">PO/Dropship</a></td>
			  <td class="TopTierNav" nowrap="nowrap" width="5">&nbsp;</td>
			  </cfif>					
						

	</cfmodule>	
							
		
	<!--- Shopping Permission 128 = order reports --->			
	<cfmodule template="../../../access/secure.cfm"
	keyname="shopping"
	requiredPermission="128"
	>
					
		   <!---- Line -------->		
			<td nowrap="nowrap" width="1" class="TopTierNavBkgrd">
			 <img src="#Request.AppSettings.defaultimages#/spacer.gif" alt="" height="2" width="1" /></td>
	
			<!--- reports ----->
			 <cfif attributes.order is "reports">
			  <td class="TopTierNavActive" nowrap="nowrap" width="5">&nbsp;</td>
			    <td class="TopTierNavActive">
				<a class="TopTierNavActive" href="#self#?#querystring#&order=reports#Request.Token2#">Reports</a></td>
			  <td class="TopTierNavActive" nowrap="nowrap" width="1">&nbsp;</td>
			  <cfelse>
			   <td class="TopTierNav" nowrap="nowrap" width="5">&nbsp;</td>
			  <td class="TopTierNav">
			  <a class="TopTierNav" href="#self#?#querystring#&order=reports#Request.Token2#">Reports</a></td>
			  <td class="TopTierNav" nowrap="nowrap" width="5">&nbsp;</td>
			  </cfif>					

	</cfmodule>						
<!--- 		
	<!--- Shopping Permission 2 = order access --->		
	<cfmodule template="../../../access/secure.cfm"
	keyname="shopping"
	requiredPermission="2"
	>
		<form name="orderjump" action="#self#?fuseaction=shopping.admin&order=display#request.token2#" method="post">
		<td>&nbsp;</td>
		<td align="right"><input type="text" name="string" value="Order No..." size="10" maxlength="100" class="formfield" onfocus="orderjump.string.value = '';" onchange="submit();" />
		</td></form>
	
	</cfmodule>			 --->		
						
						
				</tr></tbody></table>
				
	  		</td></tr>

			</tbody></table>
</cfoutput>
