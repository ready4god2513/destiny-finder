<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This page displays the tabbed menu at the top of the product edit forms. --->

<cfparam name="attributes.cid" default="">
<cfparam name="attributes.do" default="options">

<cfif isDefined("attributes.Addon")>
	<cfset attributes.do = "Addons">
</cfif>

<cfset querystring = "fuseaction=product.admin&product_ID=#attributes.product_id#">

<cfif attributes.cid is not "">
	<cfset querystring = "#querystring#&cid=#attributes.cid#">
</cfif>


<cfoutput>
<table border="0" cellpadding="0" cellspacing="0" class="TopTierNavBkgrd" width="100%">
        <tbody>
		
<!----- TITLE ROW ------>
        <tr class="TopTierHeader">
          <td class="TopTierHeader">
		  <img src="#Request.AppSettings.defaultimages#/spacer.gif" height="2" width="1" /></td></tr>

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
			
			
			<!--- Display ----->
			  <cfif attributes.do is "edit" or attributes.do is "add">
			  <td class="TopTierNavActive" nowrap="nowrap" width="5">&nbsp;</td>
			    <td class="TopTierNavActive"><a class="TopTierNavActive" href="#self#?#querystring#&do=edit">Display</a></td>
			  <td class="TopTierNavActive" nowrap="nowrap" width="1">&nbsp;</td>
			  
			  <cfelse>
			   <td nowrap="nowrap" width="5" class="TopTierNav">&nbsp;</td>
			  <td class="TopTierNav"><a class="TopTierNav" href="#self#?#querystring#&do=edit">Display</a></td>
			  <td class="TopTierNav" nowrap="nowrap" width="5">&nbsp;</td>
			  </cfif>
			
		   <!---- Line -------->		
			 <td nowrap="nowrap" width="1" class="TopTierNavBkgrd">
			 <img src="#Request.AppSettings.defaultimages#/spacer.gif" height="1" width="1" /></td>
		
			<!--- Pricing ----->
			 <cfif attributes.do is "Price">
			  <td class="TopTierNavActive" nowrap="nowrap" width="5">&nbsp;</td>
			    <td class="TopTierNavActive">
				<a class="TopTierNavActive" href="#self#?#querystring#&do=price#Request.Token2#">Pricing</a></td>
			  <td class="TopTierNavActive" nowrap="nowrap" width="1">&nbsp;</td>
			  <cfelse>
			   <td class="TopTierNav" nowrap="nowrap" width="5">&nbsp;</td>
			  <td class="TopTierNav"><a class="TopTierNav" href="#self#?#querystring#&do=price#Request.Token2#">Pricing</a></td>
			  <td class="TopTierNav" nowrap="nowrap" width="5">&nbsp;</td>
			  </cfif>

			<!---- Line -------->
 			<td nowrap="nowrap" width="1" class="TopTierNavBkgrd">
			<img src="#Request.AppSettings.defaultimages#/spacer.gif" height="1" width="1" /></td>  
			
			<!--- Info ----->
			 <cfif attributes.do is "Info">
			  <td class="TopTierNavActive" nowrap="nowrap" width="5">&nbsp;</td>
			    <td class="TopTierNavActive">
				<a class="TopTierNavActive" href="#self#?#querystring#&do=info#Request.Token2#">Info</a></td>
			  <td class="TopTierNavActive" nowrap="nowrap" width="1">&nbsp;</td>
			  <cfelse>
			   <td class="TopTierNav" nowrap="nowrap" width="5">&nbsp;</td>
			  <td class="TopTierNav"><a class="TopTierNav" href="#self#?#querystring#&do=info#Request.Token2#">Info</a></td>
			  <td class="TopTierNav" nowrap="nowrap" width="5">&nbsp;</td>
			  </cfif>

			<!---- Line -------->
 			<td nowrap="nowrap" width="1" class="TopTierNavBkgrd">
			<img src="#Request.AppSettings.defaultimages#/spacer.gif" height="1" width="1" /></td>  
				  
			<!--- Group Prices ----->
			 <cfif attributes.do is "Grp_Price">
			  <td class="TopTierNavActive" nowrap="nowrap" width="5">&nbsp;</td>
			    <td class="TopTierNavActive">
				<a class="TopTierNavActive" href="#self#?#querystring#&do=Grp_Price#Request.Token2#">Group Prices</a></td>
			  <td class="TopTierNavActive" nowrap="nowrap" width="1">&nbsp;</td>
			  <cfelse>
			   <td class="TopTierNav" nowrap="nowrap" width="5">&nbsp;</td>
			  <td class="TopTierNav">
			  <a class="TopTierNav" href="#self#?#querystring#&do=Grp_Price#Request.Token2#">Group Prices</a></td>
			  <td class="TopTierNav" nowrap="nowrap" width="5">&nbsp;</td>
			  </cfif>

			<!---- Line -------->	
			 <td nowrap="nowrap" width="1" class="TopTierNavBkgrd">
			<img src="#Request.AppSettings.defaultimages#/spacer.gif" height="1" width="1" /></td>  
				  
			<!--- Quantity Discounts ----->
			 <cfif attributes.do is "Qty_Discounts">
			  <td class="TopTierNavActive" nowrap="nowrap" width="5">&nbsp;</td>
			    <td class="TopTierNavActive">
				<a class="TopTierNavActive" href="#self#?#querystring#&do=Qty_Discounts#Request.Token2#">Qty Discounts</a></td>
			  <td class="TopTierNavActive" nowrap="nowrap" width="1">&nbsp;</td>
			  <cfelse>
			   <td class="TopTierNav" nowrap="nowrap" width="5">&nbsp;</td>
			  <td class="TopTierNav">
			  <a class="TopTierNav" href="#self#?#querystring#&do=Qty_Discounts#Request.Token2#">Qty Discounts</a></td>
			  <td class="TopTierNav" nowrap="nowrap" width="5">&nbsp;</td>
			  </cfif>
			  		
			<!---- Line -------->	
			 <td nowrap="nowrap" width="1" class="TopTierNavBkgrd">
			 <img src="#Request.AppSettings.defaultimages#/spacer.gif" height="1" width="1" /></td>  
				  
			<!--- Options ----->
			 <cfif attributes.do is "options">
			  <td class="TopTierNavActive" nowrap="nowrap" width="5">&nbsp;</td>
			    <td class="TopTierNavActive">
				<a class="TopTierNavActive" href="#self#?#querystring#&do=options#Request.Token2#">Options</a></td>
			  <td class="TopTierNavActive" nowrap="nowrap" width="1">&nbsp;</td>
			  <cfelse>
			   <td class="TopTierNav" nowrap="nowrap" width="5">&nbsp;</td>
			  <td class="TopTierNav"><a class="TopTierNav" href="#self#?#querystring#&do=options#Request.Token2#">Options</a></td>
			  <td class="TopTierNav" nowrap="nowrap" width="5">&nbsp;</td>
			  </cfif>
				
			<!---- Line -------->	
			 <td nowrap="nowrap" width="1" class="TopTierNavBkgrd">
			 <img src="#Request.AppSettings.defaultimages#/spacer.gif" height="1" width="1" /></td>  
				  
			<!--- Addons ----->
			 <cfif attributes.do is "Addons">
			  <td class="TopTierNavActive" nowrap="nowrap" width="5">&nbsp;</td>
			    <td class="TopTierNavActive">
				<a class="TopTierNavActive" href="#self#?#querystring#&do=addons#Request.Token2#">Addons</a></td>
			  <td class="TopTierNavActive" nowrap="nowrap" width="1">&nbsp;</td>
			  <cfelse>
			   <td class="TopTierNav" nowrap="nowrap" width="5">&nbsp;</td>
			  <td class="TopTierNav"><a class="TopTierNav" href="#self#?#querystring#&do=addons#Request.Token2#">Addons</a></td>
			  <td class="TopTierNav" nowrap="nowrap" width="5">&nbsp;</td>
			  </cfif>
				
			<!---- Line -------->	
			 <td nowrap="nowrap" width="1" class="TopTierNavBkgrd">
			 <img src="#Request.AppSettings.defaultimages#/spacer.gif" height="1" width="1" /></td>  
				  
			<!--- Images ----->
			 <cfif attributes.do is "images">
			  <td class="TopTierNavActive" nowrap="nowrap" width="5">&nbsp;</td>
			    <td class="TopTierNavActive"> 
				<a class="TopTierNavActive" href="#self#?#querystring#&do=images#Request.Token2#">Images</a></td>
			  <td class="TopTierNavActive" nowrap="nowrap" width="1"">&nbsp;</td>
			  <cfelse>
			   <td class="TopTierNav" nowrap="nowrap" width="5">&nbsp;</td>
			  <td class="TopTierNav"><a class="TopTierNav" href="#self#?#querystring#&do=images#Request.Token2#">Images</a></td>
			  <td class="TopTierNav" nowrap="nowrap" width="5">&nbsp;</td>
			  </cfif>		
			
			<!---- Line -------->	
			 <td nowrap="nowrap" width="1" class="TopTierNavBkgrd">
			 <img src="#Request.AppSettings.defaultimages#/spacer.gif" height="1" width="1" /></td>  
				  
			<!--- Related ----->
			 <cfif attributes.do is "related">
			  <td class="TopTierNavActive" nowrap="nowrap" width="5">&nbsp;</td>
			    <td class="TopTierNavActive">
				<a class="TopTierNavActive" href="#self#?#querystring#&do=related#Request.Token2#">Related Products</a></td>
			  <td class="TopTierNavActive" nowrap="nowrap" width="1">&nbsp;</td>
			  <cfelse>
			   <td class="TopTierNav" nowrap="nowrap" width="5">&nbsp;</td>
			  <td class="TopTierNav">
			  <a class="TopTierNav" href="#self#?#querystring#&do=related#Request.Token2#">Related Products</a></td>
			  <td class="TopTierNav" nowrap="nowrap" width="5">&nbsp;</td>
			  </cfif>		
			
			
			<!---- Line -------->	
			 <td nowrap="nowrap" width="1" class="TopTierNavBkgrd">
			 <img src="#Request.AppSettings.defaultimages#/spacer.gif" height="1" width="1" /></td>  
				  
			<!--- View ----->	  
			<td class="TopTierNav" nowrap="nowrap" width="5">&nbsp;</td>
			  <td class="TopTierNav"><a class="TopTierNav" href="#self#?fuseaction=product.display&product_id=#attributes.product_id##Request.Token2#" target="store">View</a></td>
			  <td class="TopTierNav" nowrap="nowrap" width="5">&nbsp;</td>						
					
				</tr></tbody></table>
				
	  		</td></tr>

			</tbody></table><br/>
</cfoutput>
