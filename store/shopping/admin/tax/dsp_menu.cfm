<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the tabbed menu at the top of the tax administration pages --->

<cfparam name="attributes.taxes" default="state">

<cfset querystring = "fuseaction=shopping.admin&code_id=#attributes.code_id##Request.Token2#">

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
	
			
			<!--- state ----->
			  <cfif attributes.taxes is "state">
			  <td class="TopTierNavActive" nowrap="nowrap" width="5">&nbsp;</td>
			    <td class="TopTierNavActive">
				<a class="TopTierNavActive" href="#self#?#querystring#&taxes=state">State</a></td>
			  <td class="TopTierNavActive" nowrap="nowrap" width="1">&nbsp;</td>
			  
			  <cfelse>
			   <td nowrap="nowrap" width="5" class="TopTierNav">&nbsp;</td>
			  <td class="TopTierNav">
			  <a class="TopTierNav" href="#self#?#querystring#&taxes=state">State</a></td>
			  <td class="TopTierNav" nowrap="nowrap" width="5">&nbsp;</td>
			  </cfif>
			  
		   <!---- Line -------->		
			<td nowrap="nowrap" width="1" class="TopTierNavBkgrd">
			 <img src="#Request.AppSettings.defaultimages#/spacer.gif" alt="" height="1" width="1" /></td>
		
			<!--- county ----->
			 <cfif attributes.taxes is "county">
			  <td class="TopTierNavActive" nowrap="nowrap" width="5">&nbsp;</td>
			    <td class="TopTierNavActive">
				<a class="TopTierNavActive" href="#self#?#querystring#&taxes=county#Request.Token2#">County</a></td>
			  <td class="TopTierNavActive" nowrap="nowrap" width="1">&nbsp;</td>
			  <cfelse>
			   <td class="TopTierNav" nowrap="nowrap" width="5">&nbsp;</td>
			  <td class="TopTierNav">
			  <a class="TopTierNav" href="#self#?#querystring#&taxes=county">County</a></td>
			  <td class="TopTierNav" nowrap="nowrap" width="5">&nbsp;</td>
			  </cfif>
			
		   <!---- Line -------->		
			<td nowrap="nowrap" width="1" class="TopTierNavBkgrd">
			 <img src="#Request.AppSettings.defaultimages#/spacer.gif" alt="" height="1" width="1" /></td>
		
			<!--- local ----->
			 <cfif attributes.taxes is "Local">
			  <td class="TopTierNavActive" nowrap="nowrap" width="5">&nbsp;</td>
			    <td class="TopTierNavActive">
				<a class="TopTierNavActive" href="#self#?#querystring#&taxes=Local#Request.Token2#">Local</a></td>
			  <td class="TopTierNavActive" nowrap="nowrap" width="1">&nbsp;</td>
			  <cfelse>
			   <td class="TopTierNav" nowrap="nowrap" width="5">&nbsp;</td>
			  <td class="TopTierNav">
			  <a class="TopTierNav" href="#self#?#querystring#&taxes=Local">Local</a></td>
			  <td class="TopTierNav" nowrap="nowrap" width="5">&nbsp;</td>
			  </cfif>
			
			<!---- Line -------->	
			<td nowrap="nowrap" width="1" class="TopTierNavBkgrd">
			<img src="#Request.AppSettings.defaultimages#/spacer.gif" alt="" height="1" width="1" /></td>
				  
			<!--- Country ----->
			 <cfif attributes.taxes is "Country">
			  <td class="TopTierNavActive" nowrap="nowrap" width="5">&nbsp;</td>
			    <td class="TopTierNavActive">
				<a class="TopTierNavActive" href="#self#?#querystring#&taxes=Country#Request.Token2#">Country</a></td>
			  <td class="TopTierNavActive" nowrap="nowrap" width="1">&nbsp;</td>
			  <cfelse>
			   <td class="TopTierNav" nowrap="nowrap" width="5">&nbsp;</td>
			  <td class="TopTierNav">
			  <a class="TopTierNav" href="#self#?#querystring#&taxes=Country#Request.Token2#">Country</a></td>
			  <td class="TopTierNav" nowrap="nowrap" width="5">&nbsp;</td>
			  </cfif>				
						
				</tr></tbody></table>
				
	  		</td></tr>

			</tbody></table><br/>
</cfoutput>
