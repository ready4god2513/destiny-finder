<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This Product Review format is called by dsp_reviews_inline.cfm and is used on the Product Detail page. It does not include the Product's name and photo. --->

<cfoutput>
	<table width="100%" class="mainpage" cellpadding="5" cellspacing="0">
		<cfif Helpful_Total>
		<tr>
			<td colspan="2">#Helpful_Yes# of #Helpful_Total# found the following review helpful:</td>
		</tr>
		</cfif>
		<tr>
			<td valign="top" width="70"><img src="#request.appsettings.defaultimages#/icons/#Rating#_med_stars.gif" alt="#Rating# Stars" border="0" /></td>
			<td width="88%"><strong>#Title#</strong><br/>
			by <cfif Anonymous is 1>a member<cfelseif user_ID><a href="#XHTMLFormat('#self#?fuseaction=product.reviews&do=list&uid=#user_ID##request.token2#')#" #doMouseover('Other Reviews by #username#')#><cfif len(anon_name)>#anon_name#<cfelse>#username#</cfif></a><cfelse>#anon_name#</cfif>
			<cfif len(Anon_Loc)>from #Anon_Loc#</cfif> on #dateformat(Posted,"mmm d, yyyy")#
			</td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<td>#comment#</td>
		</tr>		
		<tr>
			<td colspan="2">
			<cfif user_ID IS NOT Session.User_ID>
			<cfset ratelink = "#self#?fuseaction=product.reviews&do=rate&Review_ID=#Review_ID#&product_ID=#product_ID#">
			
			Was this review helpful to you? <a href="#XHTMLFormat('#ratelink#&rate=1#request.token2#')#" #doMouseover('Click to Vote Yes')#>Yes</a> 
			<a href="#XHTMLFormat('#ratelink#&rate=0#request.token2#')#" #doMouseover('Click to Vote No')#>No</a>
			<cfelse>
			<!--- You cannot rate this review, since you wrote it.  --->
			</cfif>
			<!--- An optional link to allow users to flag a review for editorial review.
			<br/><a href="#self#?fuseaction=product.reviews&do=flag&Review_ID=#Review_ID##request.token2#">Flag for Editor Review</a>  --->
			</td>
		</tr>
	</table>
	<cfinclude template="put_admin_menu.cfm">
</cfoutput>	
