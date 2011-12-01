
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This page displays the tabbed menu at the top of the gift registry admin forms. --->

<cfparam name="attributes.giftregistry" default="list">

<cfset querystring = "fuseaction=shopping.admin&giftregistry_ID=#attributes.giftregistry_ID#">

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
			
			
			<!--- cards ----->
			  <cfif attributes.giftregistry is not "listitems">
			  <td class="TopTierNavActive" nowrap="nowrap" width="5">&nbsp;</td>
			    <td class="TopTierNavActive">
				<a class="TopTierNavActive" href="#request.self#?#querystring#&giftregistry=edit">Registry Options</a></td>
			  <td class="TopTierNavActive" nowrap="nowrap" width="1">&nbsp;</td>
			  
			  <cfelse>
			   <td nowrap="nowrap" width="5" class="TopTierNav">&nbsp;</td>
			  <td class="TopTierNav">
			  <a class="TopTierNav" href="#request.self#?#querystring#&giftregistry=edit">Registry Options</a></td>
			  <td class="TopTierNav" nowrap="nowrap" width="5">&nbsp;</td>
			  </cfif>
			
		   <!---- Line -------->		
			<td nowrap="nowrap" width="1" class="TopTierNavBkgrd">
		  <img src="#Request.AppSettings.defaultimages#/spacer.gif" alt="" height="1" width="1" /></td>
		
			<!--- process ----->
			 <cfif attributes.giftregistry is "listitems">
			  <td class="TopTierNavActive" nowrap="nowrap" width="5">&nbsp;</td>
			    <td class="TopTierNavActive">
				<a class="TopTierNavActive" href="#request.self#?#querystring#&giftregistry=listitems#Request.Token2#">Registry Products</a></td>
			  <td class="TopTierNavActive" nowrap="nowrap" width="1">&nbsp;</td>
			  
			  <cfelseif attributes.giftregistry is not "add">
			   <td class="TopTierNav" nowrap="nowrap" width="5">&nbsp;</td>
			  <td class="TopTierNav">
			  <a class="TopTierNav" href="#request.self#?#querystring#&giftregistry=listitems#Request.Token2#">Registry Products</a></td>
			  <td class="TopTierNav" nowrap="nowrap" width="5">&nbsp;</td>
			  </cfif>		
						
				</tr></tbody></table>
				
	  		</td></tr>

			</tbody></table><br/>
</cfoutput>
