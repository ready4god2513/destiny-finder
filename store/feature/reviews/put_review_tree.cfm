<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- 	Display user comments for Features in a TREE view. 
		This page is not called directly, but included on inline and review detail pages.
		dsp_inline_feature
		dsp_list_feature
		Attributes.ExpandTree determins if the entire comment tree or only the top level comments are shown.
--->

<cfparam name="attributes.ExpandTree" default="0">
<cfparam name="attributes.CurrentReview" default="0">
		
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="mainpage">
	
<cfif attributes.expandTree is 0>
	
	<cfloop query="qry_get_reviews">
		<cfif maketreesortlevel is 1><cfset finalrow = currentrow></cfif>
	</cfloop>
	
	<cfoutput query="qry_get_reviews">
		<cfif maketreesortlevel is 1>
  		<tr>
			<td height="30">
			<cfif currentrow is finalrow>
				<img src="#request.appsettings.defaultimages#/icons/treeLastItem.gif" alt="" align="left" width="20" height="30" />
			<cfelse>
				<img src="#request.appsettings.defaultimages#/icons/treeitem.gif" alt="" align="left"  width="20" height="30" />
			</cfif>
			<a href="#XHTMLFormat('#self#?fuseaction=feature.reviews&do=display&review_id=#review_id##PCatNoSES##request.token2#')#" #doMouseover('Read Review')#><strong>#Title#</strong></a>
			<cfif datediff('h',Posted,now()) lt 24><span style="color:###Request.GetColors.formreq#; font-weight:bold;">-NEW-</span> </cfif>
			<cfif Anonymous is 1>Anonymous<cfelseif user_ID><a href="#XHTMLFormat('#self#?fuseaction=feature.reviews&do=list&uid=#user_ID##request.token2#')#" #doMouseover('Other Reviews by #username#')#><cfif len(anon_name)>#anon_name#<cfelse>#username#</cfif></a><cfelse>#anon_name#</cfif>, #dateformat(Posted,"mm/dd/yy")#<br/>
			</td>
		</tr>
		</cfif>
	</cfoutput>
		
<cfelse>
	
	
	<cfoutput query="qry_get_reviews">
   <tr>
		<td height="30">
		
			<cfif Review_ID is attributes.CurrentReview>
				<img src="#request.appsettings.defaultimages#/icons/treeSelectedItem.gif" alt="" align="left" width="20" height="30" />
			<cfelse>
				<img src="#request.appsettings.defaultimages#/icons/spacer.gif" alt="" align="left" width="20" height="30" />
			</cfif>
		
		
			<cfloop index="i" from="1" to="#maketreesortlevel#">
	
				<!--- Look at TreeLevels starting with next and continuing until
				level is at or below current level --->
				<cfset testrow = currentrow + 1>
				<cfset thelevel = i + 1>
				
				<cfloop condition="thelevel gt i AND testrow lte qry_get_reviews.recordcount">
					<cfset thelevel = qry_get_reviews.maketreesortlevel[testrow]>
					<cfset testrow = testrow + 1>
				</cfloop>	
						
				<cfif maketreesortlevel is i and thelevel is i>
					<img src="#request.appsettings.defaultimages#/icons/treeitem.gif" align="left" alt="" width="20" height="30" />
				
				<cfelseif thelevel is i>
					<img src="#request.appsettings.defaultimages#/icons/treeSkipItem.gif" align="left" alt="" width="20" height="30" />
				
				<cfelseif maketreesortlevel is i>
					<img src="#request.appsettings.defaultimages#/icons/treeLastItem.gif" align="left" alt="" width="20" height="30" />
					
				<cfelse>
					<img src="#request.appsettings.defaultimages#/icons/spacer.gif" align="left" alt="" width="20" height="30" />
				</cfif>
		
			</cfloop>
		 <cfif Review_ID is attributes.CurrentReview>
		 	<strong>#Title#</strong>
		 <cfelse>
		 	<a href="#XHTMLFormat('#self#?fuseaction=feature.reviews&do=display&review_id=#review_id##PCatNoSES##request.token2#')#" #doMouseover('Read Review')#><strong>#Title#</strong></a>
		 </cfif>
		 <cfif datediff('h',Posted,now()) lt 24><span style="color:###Request.GetColors.formreq#; font-weight:bold;">-NEW-</span> </cfif>
		 <cfif Anonymous is 1>Anonymous<cfelseif user_ID><a href="#XHTMLFormat('#self#?fuseaction=feature.reviews&do=list&uid=#user_ID##request.token2#')#" #doMouseover('More Reviews by #username#')#><cfif len(anon_name)>#anon_name#<cfelse>#username#</cfif></a><cfelse>#anon_name#</cfif>, #dateformat(Posted,"mm/dd/yy")#<br/>
		</td>
	</tr>
	</cfoutput>	
</cfif>

</table>
