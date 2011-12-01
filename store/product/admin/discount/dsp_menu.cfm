<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This page displays the tabbed menu at the top of the discount management forms. --->

<cfparam name="attributes.discount" default="products">

<cfparam name="qry_get_Discount.Type3" default="">
<cfparam name="qry_get_Discount.Type5" default="">

<cfset querystring = "fuseaction=product.admin&discount_ID=#attributes.discount_id#">

<cfoutput>
<table border="0" cellPadding="0" cellSpacing="0" class="TopTierNavBkgrd" width="100%">
        <tbody>
		
<!----- TITLE ROW ------>
        <tr class="TopTierHeader">
          <td class="TopTierHeader"><img src="#Request.AppSettings.defaultimages#/spacer.gif" alt="" height="2" width="1" /></td></tr>

<!----- SPACING ROW  ------>  
        <tr class="TopTierNav">
          <td>
</td></tr>


<!----- TAB ROW  ------>  
		<tr>
          <td valign="bottom">
		  
		  	<!----- Start Sub Tier Nav Table  ------>  
            <table border="0" cellPadding="0" cellSpacing="0">
              <tbody>
              <tr>		  
			   <td class="TopTierNavBkgrd" nowrap="nowrap" width="5">&nbsp;</td>
			
			
			<!--- main discount page ----->
			  <cfif attributes.discount is "edit" or attributes.discount is "add">
			  <td class="TopTierNavActive" nowrap="nowrap" width="5">&nbsp;</td>
			    <td class="TopTierNavActive"><a class="TopTierNavActive" href="#self#?#querystring#&discount=edit">Settings</a></td>
			  <td class="TopTierNavActive" nowrap="nowrap" width="1">&nbsp;</td>
			  
			  <cfelse>
			   <td nowrap="nowrap" width="5" class="TopTierNav">&nbsp;</td>
			  <td class="TopTierNav"><a class="TopTierNav" href="#self#?#querystring#&discount=edit">Settings</a></td>
			  <td class="TopTierNav" nowrap="nowrap" width="5">&nbsp;</td>
			  </cfif>

			<!--- products ----->
			 <cfif attributes.discount is "products">			
		   <!---- Line -------->		
			 <td nowrap="nowrap" width="1" class="TopTierNavBkgrd">
			 <img src="#Request.AppSettings.defaultimages#/spacer.gif" alt="" height="1" width="1" /></td>
		
			  <td class="TopTierNavActive" nowrap="nowrap" width="5">&nbsp;</td>
			    <td class="TopTierNavActive">
				<a class="TopTierNavActive" href="#self#?#querystring#&discount=products#Request.Token2#">Products</a></td>
			  <td class="TopTierNavActive" nowrap="nowrap" width="1">&nbsp;</td>
			  
			  <cfelseif qry_get_Discount.Type3 IS 0>			
		   <!---- Line -------->		
			 <td nowrap="nowrap" width="1" class="TopTierNavBkgrd">
			 <img src="#Request.AppSettings.defaultimages#/spacer.gif" alt="" height="1" width="1" /></td>
		
			   <td class="TopTierNav" nowrap="nowrap" width="5">&nbsp;</td>
			  <td class="TopTierNav"><a class="TopTierNav" href="#self#?#querystring#&discount=products&cid=0#Request.Token2#">Products</a></td>
			  <td class="TopTierNav" nowrap="nowrap" width="5">&nbsp;</td>
			  </cfif>		
			  
			<!--- categories ----->
			 <cfif attributes.discount is "categories">			
		   <!---- Line -------->		
			 <td nowrap="nowrap" width="1" class="TopTierNavBkgrd">
			 <img src="#Request.AppSettings.defaultimages#/spacer.gif" alt="" height="1" width="1" /></td>
		
			  <td class="TopTierNavActive" nowrap="nowrap" width="5">&nbsp;</td>
			    <td class="TopTierNavActive">
				<a class="TopTierNavActive" href="#self#?#querystring#&discount=categories#Request.Token2#">Categories</a></td>
			  <td class="TopTierNavActive" nowrap="nowrap" width="1">&nbsp;</td>
			  
			  <cfelseif qry_get_Discount.Type3 IS 1>			
		   <!---- Line -------->		
			  <td nowrap="nowrap" width="1" class="TopTierNavBkgrd">
			 <img src="#Request.AppSettings.defaultimages#/spacer.gif" alt="" height="1" width="1" /></td>
		
			   <td class="TopTierNav" nowrap="nowrap" width="5">&nbsp;</td>
			  <td class="TopTierNav"><a class="TopTierNav" href="#self#?#querystring#&discount=categories&pid=0#Request.Token2#">Categories</a></td>
			  <td class="TopTierNav" nowrap="nowrap" width="5">&nbsp;</td>
			  </cfif>	
			  
			<!--- users ----->
			 <cfif attributes.discount is "groups">			
		   <!---- Line -------->		
			 <td nowrap="nowrap" width="1" class="TopTierNavBkgrd">
			 <img src="#Request.AppSettings.defaultimages#/spacer.gif" alt="" height="1" width="1" /></td>
		
			  <td class="TopTierNavActive" nowrap="nowrap" width="5">&nbsp;</td>
			    <td class="TopTierNavActive">
				<a class="TopTierNavActive" href="#self#?#querystring#&discount=groups#Request.Token2#">User Groups</a></td>
			  <td class="TopTierNavActive" nowrap="nowrap" width="1">&nbsp;</td>
			  
			  <cfelseif qry_get_Discount.Type5 IS 1>			
		   <!---- Line -------->		
			 <td nowrap="nowrap" width="1" class="TopTierNavBkgrd">
			 <img src="#Request.AppSettings.defaultimages#/spacer.gif" alt="" height="1" width="1" /></td>
		
			   <td class="TopTierNav" nowrap="nowrap" width="5">&nbsp;</td>
			  <td class="TopTierNav"><a class="TopTierNav" href="#self#?#querystring#&discount=groups#Request.Token2#">User Groups</a></td>
			  <td class="TopTierNav" nowrap="nowrap" width="5">&nbsp;</td>
			  </cfif>	
						
				</tr></tbody></table>
				
	  		</td></tr>

			</tbody></table><br/>
</cfoutput>
