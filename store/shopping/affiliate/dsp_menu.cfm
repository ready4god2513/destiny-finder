<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the tabbed menu at the top of the affiliate pages --->

<cfparam name="attributes.do" default="report">

<cfset querystring = "fuseaction=shopping.affiliate">
<cfif isdefined("attributes.UID")>
	<cfset querystring = querystring & "&uid=" & attributes.uid>
</cfif>

<cfoutput>
<table border="0" cellpadding="0" cellspacing="0" style="BACKGROUND-COLOR: ###Request.GetColors.InputHBGCOLOR#; COLOR: ###Request.GetColors.InputHTEXT#;" width="100%">
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
			   <td class="TopTierNav" nowrap="nowrap" width="5" style="BACKGROUND-COLOR: ###Request.GetColors.InputHBGCOLOR#; COLOR: ###Request.GetColors.InputHTEXT#;">&nbsp;</td>
			
			
			<!--- report ----->
			  <cfif attributes.do is "register" or attributes.do is "report">
			  <td class="TopTierNav" nowrap="nowrap" width="5" style="BACKGROUND-COLOR: ###Request.GetColors.InputTBGCOLOR#; COLOR: ###Request.GetColors.InputTTEXT#;">&nbsp;</td>
			    <td class="TopTierNav" style="BACKGROUND-COLOR: ###Request.GetColors.InputTBGCOLOR#; COLOR: ###Request.GetColors.InputTTEXT#;">
				<a class="TopTierNav" href="#XHTMLFormat('#self#?#querystring#&do=report')#"><cfif attributes.do is "register">Welcome<cfelse>Reports</cfif></a></td>
			  <td class="TopTierNav" nowrap="nowrap" width="1" style="BACKGROUND-COLOR: ###Request.GetColors.InputTBGCOLOR#; COLOR: ###Request.GetColors.InputTTEXT#;">&nbsp;</td>
			  
			  <cfelse>
			   <td nowrap="nowrap" width="5" class="TopTierNav" style="BACKGROUND-COLOR: ###Request.GetColors.InputHBGCOLOR#; COLOR: ###Request.GetColors.InputHTEXT#;">&nbsp;</td>
			  <td class="TopTierNav" style="BACKGROUND-COLOR: ###Request.GetColors.InputHBGCOLOR#; COLOR: ###Request.GetColors.InputHTEXT#;">
				<a class="TopTierNav" href="#XHTMLFormat('#self#?#querystring#&do=report')#" style="COLOR: ###Request.GetColors.InputHTEXT#;">Reports </a></td>
			  <td class="TopTierNav" nowrap="nowrap" width="5" style="BACKGROUND-COLOR: ###Request.GetColors.InputHBGCOLOR#; COLOR: ###Request.GetColors.InputHTEXT#;">&nbsp;</td>
			   </cfif>
			
		   <!---- Line -------->		
			 <td nowrap="nowrap" width="1" style="BACKGROUND-COLOR: ###Request.GetColors.InputTBGCOLOR#; COLOR: ###Request.GetColors.InputTTEXT#;">
			<img src="#Request.AppSettings.defaultimages#/spacer.gif" alt="" height="1" width="1" /></td>
		
			<!--- links ----->
			 <cfif attributes.do is "links">
			  <td class="TopTierNav" nowrap="nowrap" width="5" style="BACKGROUND-COLOR: ###Request.GetColors.InputTBGCOLOR#; COLOR: ###Request.GetColors.InputTTEXT#;">&nbsp;</td>
			    <td class="TopTierNav" style="BACKGROUND-COLOR: ###Request.GetColors.InputTBGCOLOR#; COLOR: ###Request.GetColors.InputTTEXT#;">
				<a class="TopTierNav" href="#XHTMLFormat('#self#?#querystring#&do=links#Request.Token2#')#">Creating Links</a></td>
			  <td class="TopTierNav" nowrap="nowrap" width="1" style="BACKGROUND-COLOR: ###Request.GetColors.InputTBGCOLOR#; COLOR: ###Request.GetColors.InputTTEXT#;">&nbsp;</td>
			  <cfelse>
			   <td class="TopTierNav" nowrap="nowrap" width="5" style="BACKGROUND-COLOR: ###Request.GetColors.InputHBGCOLOR#; COLOR: ###Request.GetColors.InputHTEXT#;">&nbsp;</td>
			  <td class="TopTierNav" style="BACKGROUND-COLOR: ###Request.GetColors.InputHBGCOLOR#; COLOR: ###Request.GetColors.InputHTEXT#;">
				<a class="TopTierNav" href="#XHTMLFormat('#self#?#querystring#&do=links#Request.Token2#')#" style="COLOR: ###Request.GetColors.InputHTEXT#;">Creating Links</a></td>
			  <td class="TopTierNav" nowrap="nowrap" width="5" style="BACKGROUND-COLOR: ###Request.GetColors.InputHBGCOLOR#; COLOR: ###Request.GetColors.InputHTEXT#;">&nbsp;</td>
			  </cfif>		
						
				</tr></tbody></table>
				
	  		</td></tr>

			</tbody></table><br/>
</cfoutput>
