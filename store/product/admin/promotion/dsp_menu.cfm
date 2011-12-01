<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This page displays the tabbed menu at the top of the promotion management forms. --->

<cfparam name="attributes.promotion" default="qual_products">

<cfparam name="qry_get_promotion.Type1" default="">
<cfparam name="qry_get_promotion.Type4" default="">

<cfset querystring = "fuseaction=product.admin&promotion_ID=#attributes.promotion_id#">

<cfoutput>
<table border="0" cellpadding="0" cellspacing="0" width="100%" class="TopTierNavBkgrd">
        <tbody>
		
<!----- TITLE ROW ------>
        <tr class="TopTierHeader">
          <td class="TopTierHeader">
		  <img src="#Request.AppSettings.defaultimages#/spacer.gif" width="1" height="2" alt="" />
		  </td></tr>

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
			   <td class="TopTierNavBkgrd" nowrap="nowrap" width="5" >&nbsp;</td>
			
			
			<!--- main promotion page ----->
			  <cfif attributes.promotion is "edit" or attributes.promotion is "add">
			  <td class="TopTierNavActiv"e nowrap="nowrap" width="5" >&nbsp;</td>
			    <td class="TopTierNavActive">
				<a class="TopTierNavActive" href="#self#?#querystring#&promotion=edit">Settings</a></td>
			  <td class="TopTierNavActive" nowrap="nowrap" width="1" >&nbsp;</td>
			  
			  <cfelse>
			   <td nowrap="nowrap" width="5" class="TopTierNav">&nbsp;</td>
			  <td class="TopTierNav"><a class="TopTierNav" href="#self#?#querystring#&promotion=edit">Settings</a></td>
			  <td class="TopTierNav" nowrap="nowrap" width="5">&nbsp;</td>
			  </cfif>

			<!--- products ----->
			 <cfif attributes.promotion is "qual_products">			
		   <!---- Line -------->		
			 <td nowrap="nowrap" width="1" class="TopTierNavBkgrd">
			<img src="#Request.AppSettings.defaultimages#/spacer.gif" width="1" height="1" alt="" /></td>
		
			  <td class="TopTierNavActive" nowrap="nowrap" width="5" >&nbsp;</td>
			    <td class="TopTierNavActive">
				<a class="TopTierNavActive" href="#self#?#querystring#&promotion=qual_products#Request.Token2#">Qualfiying Products</a> 
				</td>
			  <td class="TopTierNavActive" nowrap="nowrap" width="1">&nbsp;</td>
			  <cfelseif qry_get_promotion.Type1 IS NOT 4>
		   <!---- Line -------->		
			 <td nowrap="nowrap" width="1" class="TopTierNavBkgrd">
			<img src="#Request.AppSettings.defaultimages#/spacer.gif" width="1" height="1" alt="" /></td>
		
			   <td class="TopTierNav" nowrap="nowrap" width="5">&nbsp;</td>
			  <td class="TopTierNav">
			  <a class="TopTierNav" href="#self#?#querystring#&promotion=qual_products&cid=0#Request.Token2#">Qualifying Products</a> 		
			</td>
			  <td class="TopTierNav" nowrap="nowrap" width="5">&nbsp;</td>
			  </cfif>		
			  
			<!--- categories ----->
			 <cfif attributes.promotion is "disc_product">			
		   <!---- Line -------->		
			 <td nowrap="nowrap" width="1" class="TopTierNavBkgrd">
			 <img src="#Request.AppSettings.defaultimages#/spacer.gif" width="1" height="1" alt="" /></td>
		
			  <td class="TopTierNavActive" nowrap="nowrap" width="5">&nbsp;</td>
			    <td class="TopTierNavActive">
				<a class="TopTierNavActive" href="#self#?#querystring#&promotion=disc_product#Request.Token2#">Discounted Product</a> 
				 </td>
			  <td class="TopTierNavActive" nowrap="nowrap" width="1">&nbsp;</td>
			  
			  <cfelseif qry_get_promotion.Type1 IS NOT 1>	
			   <td nowrap="nowrap" width="1" class="TopTierNavBkgrd">
			 <img src="#Request.AppSettings.defaultimages#/spacer.gif" width="1" height="1" alt="" /></td>		
			   <td class="TopTierNav" nowrap="nowrap" width="5">&nbsp;</td>
			  <td class="TopTierNav">
			  <a class="TopTierNav" href="#self#?#querystring#&promotion=disc_product&pid=0#Request.Token2#">Discounted Product</a></td>
			  <td class="TopTierNav" nowrap="nowrap" width="5">&nbsp;</td>
			  </cfif>	
			  
			<!--- users ----->
			 <cfif attributes.promotion is "groups">			
		   <!---- Line -------->		
			 <td nowrap="nowrap" width="1" class="TopTierNavBkgrd">
			 <img src="#Request.AppSettings.defaultimages#/spacer.gif" width="1" height="1" alt="" /></td>
		
			  <td class="TopTierNavActive" nowrap="nowrap" width="5">&nbsp;</td>
			    <td class="TopTierNavActive">
				<a class="TopTierNavActive" href="#self#?#querystring#&promotion=groups#Request.Token2#">User Groups</a></td>
			  <td class="TopTierNavActive" nowrap="nowrap" width="1">&nbsp;</td>
			  <cfelseif qry_get_promotion.Type4 IS 1>			
		   <!---- Line -------->		
			 <td nowrap="nowrap" width="1" class="TopTierNavBkgrd">
			 <img src="#Request.AppSettings.defaultimages#/spacer.gif" width="1" height="1" alt="" /></td>
		
			   <td class="TopTierNav" nowrap="nowrap" width="5">&nbsp;</td>
			  <td class="TopTierNav">
			  <a class="TopTierNav" href="#self#?#querystring#&promotion=groups#Request.Token2#">User Groups</a></td>
			  <td class="TopTierNav" nowrap="nowrap" width="5">&nbsp;</td>
			  </cfif>	
						
				</tr></tbody></table>
				
	  		</td></tr>

			</tbody></table><br/>
</cfoutput>
