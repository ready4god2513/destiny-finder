<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This template is called by product=review&do=display and displays a full Product review. --->

<!----- Set page for rating return ------->
<cfset Session.Page="#Request.currentURL#">

<!--- Required for pop-up mail form --->
<cfhtmlhead text="<script type='text/javascript' src='includes/openwin.js'></script>">

<!--- Provide a Page Title --->
<cfset Webpage_title = "Product Review">
<cfmodule template="../../customtags/puttitle.cfm" TitleText="Product Reviews" class="product">

<!--- Display Product header --->
<cfinclude template="put_product_header.cfm">

<cfmodule template="../../customtags/putline.cfm" linetype="thin"/>

<!--- Product Review --->
<cfoutput query="qry_get_review">
<div class="mainpage">

<strong>#Title#</strong><br/>
by <cfif Anonymous is 1>Anonymous<cfelseif user_ID><a href="#XHTMLFormat('#self#?fuseaction=product.reviews&do=list&uid=#user_ID##Request.Token2#')#" #doMouseover('Other Reviews by #username#')#><cfif len(anon_name)>#anon_name#<cfelse>#username#</cfif></a><cfelse>#anon_name#</cfif>
<cfif len(Anon_Loc)>from #Anon_Loc#</cfif>on #dateformat(Posted,"mmm d, yyyy")#<br/>
<br/>
#Comment#
<br/><br/><strong>Rated:</strong> <img src="#request.appsettings.defaultimages#/icons/#Rating#_med_stars.gif" alt="#Rating# Stars" border="0" />

<!--- <br/><strong>Recommended:</strong> <cfif Recommend is 1>Yes<cfelse>No</cfif> --->

<br/><br/>
<cfif Helpful_Total>
#Helpful_Yes# readers of #Helpful_Total# found this review helpful.<br/>
</cfif>
<cfif user_id IS NOT Session.User_ID>
<cfset ratelink = "#self#?fuseaction=product.reviews&do=rate&Review_ID=#Review_ID#&product_ID=#product_ID##request.token2#">
Was this review helpful to you? 
	<a href="#XHTMLFormat('#ratelink#&rate=1')#" #doMouseover('Click to Vote')#>Yes</a> 
	<a href="#XHTMLFormat('#ratelink#&rate=0')#" #doMouseover('Click to Vote')#>No</a><br/>
</cfif>


<ul>
	<li><a href="javascript:newWindow=openWin('#XHTMLFormat('#self#?fuseaction=home.email&mailto=editor&page=#self#?#cgi.query_string#')#','Email','width=500,height=360,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1'); newWindow.focus()">Alert us of an offensive message</a></li>
		<!--- An alternative link to allow users to flag a review for editorial review directly rather than sending an email.
			<li><a href="#self#?fuseaction=product.reviews&do=flag&Review_ID=#Review_ID##request.token2#">Flag for Editor Review</a></li> --->

	<li><a href="#XHTMLFormat('#self#?fuseaction=product.reviews&do=write&product_ID=#product_ID##PCatNoSES##request.token2#')#">Write A Review of this Product</a></li>
</ul>	
	
</div>

<cfinclude template="put_admin_menu.cfm">

</cfoutput>
	
	
