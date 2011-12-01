<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This page displays the tabbed menu at the top of the paymnent management forms. --->

<cfparam name="attributes.payment" default="cards">

<cfset querystring = "fuseaction=shopping.admin">

<cfoutput>
<table border="0" cellpadding="0" cellspacing="0" width="100%" class="TopTierNavBkgrd">
        <tbody>
		
<!----- TITLE ROW ------>
        <tr class="TopTierHeader">
          <td class="TopTierHeader">
		  <img src="#Request.AppSettings.defaultimages#/spacer.gif" width="1" height="2" alt="" /></td></tr>

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
			  <cfif attributes.payment is "cards">
			  <td class="TopTierNavActive" nowrap="nowrap" width="5">&nbsp;</td>
			    <td class="TopTierNavActive">
				<a class="TopTierNavActive" href="#self#?#querystring#&payment=Cards#Request.Token2#">Payment Options</a></td>
			  <td class="TopTierNavActive" nowrap="nowrap" width="1">&nbsp;</td>
			  
			  <cfelse>
			   <td nowrap="nowrap" width="5" class="TopTierNav">&nbsp;</td>
			  <td class="TopTierNav">
			  <a class="TopTierNav" href="#self#?#querystring#&payment=Cards#Request.Token2#">Payment Options</a></td>
			  <td class="TopTierNav" nowrap="nowrap" width="5">&nbsp;</td>
			  </cfif>
			
		   <!---- Line -------->		
			<td nowrap="nowrap" width="1" class="TopTierNavBkgrd">
			 <img src="#Request.AppSettings.defaultimages#/spacer.gif" width="1" height="1" alt="" /></td>
		
			<!--- process ----->
			 <cfif attributes.payment is "process">
			  <td class="TopTierNavActive" nowrap="nowrap" width="5">&nbsp;</td>
			    <td class="TopTierNavActive">
				<a class="TopTierNavActive" href="#self#?#querystring#&payment=process#Request.Token2#">Card Processing</a></td>
			  <td class="TopTierNavActive" nowrap="nowrap" width="1">&nbsp;</td>
			  <cfelse>
			   <td class="TopTierNav" nowrap="nowrap" width="5">&nbsp;</td>
			  <td class="TopTierNav">
			  <a class="TopTierNav" href="#self#?#querystring#&payment=process#Request.Token2#">Card Processing</a></td>
			  <td class="TopTierNav" nowrap="nowrap" width="5">&nbsp;</td>
			  </cfif>		
						
				</tr></tbody></table>
				
	  		</td></tr>

			</tbody></table><br/>
</cfoutput>
