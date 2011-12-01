<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This page displays the tabbed menu at the top of the feature edit forms. Used when editing features and the related products/features for a feature --->
    <cfparam name="attributes.cid" default="0">
    <cfparam name="attributes.feature" default="edit">
    <cfset querystring = "fuseaction=feature.admin&feature_ID=#attributes.feature_id#&cid=#attributes.cid#"><!---		
	<cfif attributes.cid is not "">	    
	    <cfset querystring = "#querystring#&cid=#attributes.cid#">
	</cfif>
	--->
	<cfoutput>
	  <table border="0" cellpadding="0" cellspacing="0" class="TopTierNavBkgrd" width="100%">
	    <tbody>  <!----- TITLE ROW ------>
	      <tr class="TopTierHeader">
	        <td class="TopTierHeader"><img src="#Request.AppSettings.defaultimages#/spacer.gif" alt="" width="1" height="2"/>
	        </td>
	      </tr>  <!----- SPACING ROW  ------>
	      <tr class="TopTierNav">
	        <td>
	        </td>
	      </tr>  <!----- TAB ROW  ------>
	      <tr>
	        <td valign="bottom">  <!----- Start Sub Tier Nav Table  ------>
	          <table border="0" cellpadding="0" cellspacing="0">
	            <tbody>
	              <tr>
	                <td class="TopTierNavBkgrd" nowrap="nowrap" width="5">  &nbsp;
	                </td>  
					
					<!--- Display ----->	              		
	              	<cfif attributes.feature is "edit" or attributes.feature is "add">
	              	  <td class="TopTierNavActive" nowrap="nowrap" width="5">  &nbsp;
	              	  </td>
	              	  <td class="TopTierNavActive">
					  <a class="TopTierNavActive" href="#self#?#querystring#&feature=edit">Edit Page</a>
	              	  </td>
	              	  <td class="TopTierNavActive" nowrap="nowrap" width="1">  &nbsp;
	              	  </td>
	              	<cfelse>
	              	  <td  nowrap="nowrap" width="5" class="TopTierNav">  &nbsp;
	              	  </td>
	              	  <td class="TopTierNav">
					  <a class="TopTierNav" href="#self#?#querystring#&feature=edit">Edit Page</a>
	              	  </td>
	              	  <td class="TopTierNav" nowrap="nowrap" width="5">  &nbsp;
	              	  </td>
	              	</cfif>
	              	<!---- Line -------->
	                <td  nowrap="nowrap" width="1" class="TopTierNavBkgrd">
					<img src="#Request.AppSettings.defaultimages#/spacer.gif" alt="" height="1" width="1" />
	                </td>  
					
					<!--- Related ----->	              		
	              	<cfif attributes.feature is "related">
	              	  <td class="TopTierNavActive" nowrap="nowrap" width="5">  &nbsp;
	              	  </td>
	              	  <td class="TopTierNavActive">
					  <a class="TopTierNavActive" href="#self#?#querystring#&feature=related#Request.Token2#">
					  Related Features</a>
	              	  </td>
	              	  <td class="TopTierNavActive" nowrap="nowrap" width="1">  &nbsp;
	              	  </td>
	              	<cfelse>
	              	  <td class="TopTierNav" nowrap="nowrap" width="5">  &nbsp;
	              	  </td>
	              	  <td class="TopTierNav">
					  <a class="TopTierNav" href="#self#?#querystring#&feature=related#Request.Token2#">
					  Related Features</a>
	              	  </td>
	              	  <td class="TopTierNav" nowrap="nowrap" width="5">  &nbsp;
	              	  </td>
	              	</cfif>
					
	              	<!---- Line -------->
	                <td nowrap="nowrap" width="1" class="TopTierNavBkgrd">
					<img src="#Request.AppSettings.defaultimages#/spacer.gif" alt="" height="1" width="1" />
					</td>  
					
					<!--- Related Products ----->	              		
	              	<cfif attributes.feature is "related_prod">
	              	  <td class="TopTierNavActive" nowrap="nowrap" width="5">  &nbsp;
	              	  </td>
	              	  <td class="TopTierNavActive">
					  <a class="TopTierNavActive" href="#self#?#querystring#&feature=related_prod#Request.Token2#">
					  Related Products</a>
	              	  </td>
	              	  <td class="TopTierNavActive" nowrap="nowrap" width="1">  &nbsp;
	              	  </td>
	              	<cfelse>
	              	  <td class="TopTierNav" nowrap="nowrap" width="5">  &nbsp;
	              	  </td>
	              	  <td class="TopTierNav">
					  <a class="TopTierNav" href="#self#?#querystring#&feature=related_prod#Request.Token2#">
					  Related Products</a>
	              	  </td>
	              	  <td class="TopTierNav" nowrap="nowrap" width="5">  &nbsp;
	              	  </td>
	              	</cfif>
					
	              	<!---- Line -------->
	                <td nowrap="nowrap" width="1" class="TopTierNavBkgrd">
					<img src="#Request.AppSettings.defaultimages#/spacer.gif" alt="" height="1" width="1" />
	                </td>  
					
					<!--- View ----->
	                <td class="TopTierNav" nowrap="nowrap" width="5">  &nbsp;
	                </td>
	                <td class="TopTierNav">
					<a class="TopTierNav" href="#self#?fuseaction=feature.display&feature_id=#attributes.feature_id##Request.Token2#" target="store">View</a>
	                </td>
	                <td class="TopTierNav" nowrap="nowrap" width="5">  &nbsp;
	                </td>
	              </tr>
	            </tbody>
	          </table>
	        </td>
	      </tr>
	    </tbody>
	  </table>
	    <br/>
	</cfoutput>
