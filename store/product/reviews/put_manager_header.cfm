<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This template is called by dsp_reviews_list.cfm when displaying reviews written by a single user. The header includes a link to the My Account page and an email verification check. --->

<!--- Link back to My Account --->
<cfoutput>
<a href="#XHTMLFormat('#Request.SecureURL##self#?fuseaction=users.manager#Request.AddToken#')#" #doMouseover('Back to My Account')#>Return to My Account</a><br/>
</cfoutput>

<!--- If verified email address is required, check it. ---->
	<cfif request.appsettings.ProductReview_Add is 2>

	<cfquery name="checkemail"  datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" maxrows="1">
	SELECT EmailLock FROM #Request.DB_Prefix#Users 
	WHERE User_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#Session.User_ID#">
	</cfquery>

		<cfif checkemail.emaillock is not "verified">
		<cfoutput>
			<p>Your account has not yet been confirmed. Your reviews will not appear until your account is confirmed.
			<ul>
				<li><a href="#XHTMLFormat('#Request.SecureURL##self#?fuseaction=users.sendlock#Request.AddToken#')#" #doMouseover('Send Confirmation')#>
				Click here to have a confirmation email sent.</a></li>
				<li><a href="#XHTMLFormat('#Request.SecureURL##self#?fuseaction=users.unlock&xfa_success=fuseaction=product.reviews&do=manager#Request.AddToken#')#"  #doMouseover('Enter Confirmation')#>
				Click here to enter your confirmation code.</a></li>
			</ul>
			</p>
		</cfoutput>
		</cfif>

	</cfif>			
	
