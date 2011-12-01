
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!---
<fusedoc fuse="FBX_Settings.cfm">
	<responsibilities>
		I set up the enviroment settings for this circuit. If this settings file is being inherited, then you can use CFSET to override a value set in a parent circuit or CFPARAM to accept a value set by a parent circuit
	</responsibilities>	
</fusedoc>
--->
 
<cfsilent>

<cfparam name="self" default="#request.self#">
		
<!--- should fusebox silently suppress its own error messages? default is FALSE --->
<cfset fusebox.suppresserrors = FALSE>

<!--- Execute only when this is the application's home circuit --->
<cfif fusebox.IsHomeCircuit>

	<cfif NOT isDefined("SESFile")>				
		<!--- Includes CFWebstore global functions --->
		<cfinclude template="includes/cfw_functions.cfm">
	</cfif>	
	
	<!--- Run remainig code only if this is not a custom tag call to the fuseaction --->
	<cfif not IsDefined("ThisTag.ExecutionMode") AND NOT StructKeyExists(fusebox,'customtagcall')>
	
		<!--- Application Definition --->
		<cfinclude template="setapp.cfm">
		
		<cfinclude template="includes/browserdetect.cfm">
		
		<!--- Get Request.AppSettings --->
		<cfinclude template="queries/qry_getsettings.cfm">
	
		<!--- Request.GetColors default colors --->	
		<cfinclude template="queries/qry_getcolors.cfm">
	
		<!--- Set Line & sale images etc. --->
		<cfinclude template="customtags/setimages.cfm"> 
		
		<cfscript>
			//Set current locale
			Locale = SetLocale("#Request.AppSettings.Locale#");
			
			//Settings used according to DB and server type
			if (Request.servertype IS "Unix")
				Request.slash = "/";
			else
				Request.slash = "\";
				
			if (Request.dbtype IS "MySQL")
				Request.SQL_Bit = "CF_SQL_TINYINT";
			else
				Request.SQL_Bit = "CF_SQL_BIT";
				
		</cfscript>
		
		<!--- Set location of error handler pages 	---> 	 
		<cferror type="EXCEPTION" TEMPLATE="errors/fullhandler.cfm" MAILTO="#request.appsettings.webmaster#">
		<!--- Comment out this error line on Railo, not supported --->
		<cferror type="REQUEST" template="errors/errorhandler.cfm">	
	 
		<!--- Testing for cookies on/off for all site links --->		
		<!--- <cfparam name="cookieson" default="0"> --->
		<!--- Default now is to always require cookies. This is for security, to not append session information on the URL --->
		<!--- If you want your site to work with cookies turned off, you can set this to 0, but this has security issues you should be aware of. --->
		<cfparam name="cookieson" default="1">
		
		<cfif browserName IS "spider">
			<cfset cookieson = 1>
			
		<cfelseif CGI.SERVER_PORT IS 443 AND Request.SharedSSL>
			<cfset cookieson = 0>
		
		<cfelseif isdefined("cookie.isOn")>
			<cfset cookieson = 1>
		</cfif>	
		
		<cfif cookieson>
			<cfset Request.Token1 = "">
			<cfset Request.Token2 = "">	
		<cfelse>
			<cfif not isdefined("session.rollCount")>
				<cfset session.rollcount = 1>
				<cfcookie name="isOn" value="testing" expires="2">
			</cfif>	
			
			<cfset Request.Token1 = "?" & Session.URLToken>
			<cfset Request.Token2 = "&" & Session.URLToken>
			
		</cfif>
		
		<!--- Set the link to be used when switching to SSL according to if the user is on Shared SSL --->
		<cfif Request.SharedSSL>
			<cfset Request.AddToken = "&" & Session.URLToken>
		<cfelse>
			<cfset Request.AddToken = Request.Token2>
		</cfif>
		
		<!--- Check if the site is using SSL at all --->
		<cfif Left(Request.SecureURL, 5) IS "https">
			<cfset Request.secure_cookie = "yes">
		<cfelse>
			<cfset Request.secure_cookie = "no">
		</cfif>
		
		<!--- In case no fuseaction was given, I'll set up one to use by default. --->
		<!--- These will also check for the "short-cut" SES links and convert them --->
		<cfscript>
			try {
				if (NOT isDefined("attributes.fuseaction")) {
					if (isDefined("attributes.category") AND len(attributes.category)) {
						attributes.fuseaction = "category.display";
						attributes.category_ID = ListGetAt(attributes.category, 1, "_");
						checkparams = attributes.category;
					}
					else if (isDefined("attributes.product") AND len(attributes.product)) {
						attributes.fuseaction = "product.display";
						attributes.product_ID = ListGetAt(attributes.product, 1, "_");
						checkparams = attributes.product;
					}
					else if (isDefined("attributes.feature") AND len(attributes.feature)) {
						attributes.fuseaction = "feature.display";
						attributes.feature_ID = ListGetAt(attributes.feature, 1, "_");
						checkparams = attributes.feature;
					}
					else if (isDefined("attributes.page")) {
						attributes.fuseaction = "page.display";
						attributes.pageaction = attributes.page;
						checkparams = '';
					}
					else if (len(request.appsettings.default_fuseaction)) {
						attributes.fuseaction = request.appsettings.default_fuseaction;
						checkparams = '';
						}
					else {
						attributes.fuseaction = 'page.home';
						checkparams = '';
					}
					// Check if Parent Category defined
					if (ListLen(checkparams, "_") GT 1) {
						attributes.ParentCat = ListGetAt(checkparams, 2, "_");
					}
				}
			}
			catch(Any excpt) { invalidFA = true; }
		
		// Check for invalid fuseactions 
			if (ListLen(attributes.fuseaction, ".") LT 2 OR isDefined('invalidFA')) {
				if (len(request.appsettings.default_fuseaction)) 
					attributes.fuseaction = request.appsettings.default_fuseaction;
				else
					attributes.fuseaction = 'page.home';
				}
		
		</cfscript>
		
		<!--- Load CFCs into memory if and not already available    --->
		<!--- The second check for the application variable ensures the CFCs are not loaded by a second thread
					while waiting for a first one to complete   --->
		<cfif NOT structKeyExists(Application,"reload_CFCs")>
			<cflock scope="Application" type="Exclusive" timeout="30">
			<cfif NOT structKeyExists(Application, "reload_CFCs")>    
				<cflog file="startupLog" text="Running Instantiation of CFWebstore components"> 
				<cfset Application.objMenus = CreateObject("component", "#Request.CFCMapping#.layout.menus").init()>
				<cfset Application.objDiscounts = CreateObject("component", "#Request.CFCMapping#.shopping.discounts").init()>
				<cfset Application.objPromotions = CreateObject("component", "#Request.CFCMapping#.shopping.promotions").init()>
				<cfset Application.objCart = CreateObject("component", "#Request.CFCMapping#.shopping.cart").init()>
				<cfset Application.objCheckout = CreateObject("component", "#Request.CFCMapping#.shopping.checkout").init()>
				<cfset Application.objShipping = CreateObject("component", "#Request.CFCMapping#.shipping.shipping").init()>
				<cfset Application.objUsers = CreateObject("component", "#Request.CFCMapping#.users.users").init()>
				<cfset Application.objGlobal = CreateObject("component", "#Request.CFCMapping#.global").init()>
				<cfset Application.reload_CFCs = true>
			 </cfif>
			</cflock>
		</cfif>		<!--- 	--->
		
	<!--- Set cookies for session to be cleared when browser closed --->	
		<cfif not IsDefined("Cookie.CFID") AND IsDefined("Session.CFID")>
         	<!--- <cfcookie name="CFID" value="#Session.CFID#">
          	<cfcookie name="CFTOKEN" value="#Session.CFTOKEN#"> --->
			<cfheader name="Set-Cookie" value="CFID=#Session.CFID#;path=#Request.StorePath#;HTTPOnly">
			<cfheader name="Set-Cookie" value="CFTOKEN=#Session.CFTOKEN#;path=#Request.StorePath#;HTTPOnly">
	    </cfif>	
		
		<!--- Initialize Page for Keep Shopping & other processeses. 
		Updated for Keep Shopping in product display & product category. --->
		<cfparam name="Session.Page" default="#self#">
		
		<!---- USER INITIALIZATION ---------->	
		<cfparam name="Session.User_ID" default=0>	
		<cfparam name="Session.Username" default="">
		<cfparam name="Session.Realname" default="">
		<cfparam name="Session.UserPermissions" default="">		
		<cfparam name="Session.Group_ID" default=0>
		
		<cfif isdefined("form.SUBMIT_LOGOUT")>
			<cfset Session.User_ID = 0>
		</cfif>
		
		<cfparam name="request.reg_form" default="register">	
			
		<!---- SHOPPING INITIALIZATION ---------->			
		<!--- Session Basket -------------->
		<cfparam name="Session.Wholesaler" default=0>	
		<cfparam name="Session.BasketNum" default=0>
		<cfparam name="Session.Coup_code" default="">
		<cfparam name="Session.Gift_Cert" default="">
		<cfparam name="Session.BasketTotals" default="">
		<!---- Affiliates ----->
		<cfparam name="Session.Affiliate" default="0">
		<cfparam name="Session.Referrer" default="Unknown">
		
		<cfif Session.BasketNum is 0>
			<cfinvoke component="#Request.CFCMapping#.shopping.cart" 
				method="doNewBasket" returnvariable="Session.BasketNum">
			<cfcookie name="#request.DS#_Basket" value="#Session.BasketNum#" expires="365">
		</cfif>
	
		<cfif IsDefined("URL.aff")>
			<cfset Session.Affiliate = URL.aff>
			
			<cfif isDefined("CGI.HTTP_REFERER") AND len(CGI.HTTP_REFERER)>
				<cfset Session.Referrer = CGI.HTTP_REFERER>
			</cfif>
		</cfif>
		
		<!--- Set the index string. If using built-in SES support, this would be '#self#/' --->
		<!--- If you wish to rewrite your URLs without the index.cfm in them, you need a server installed rewrite method --->
		<!--- Example using ISAPI_Rewrite filter, this uses 'dyn/' for the SESindex --->
		<!---   
		  RewriteRule (.*?dyn)(\?[^/]*)?/([^/]*)/([^/]*)/(.*?\.cfm)(.*) $1(?2$2&:\?)$3=$4$6 [N,I]   
			RewriteRule (.*?)(dyn)(.*) $1index.cfm$3 [I]
			RewriteRule (.*?)(\?CFID)(.*) $1&CFID$3 [I]
		 --->
		<cfset Request.SESindex = "#self#/">
		
		<!--- Remove any subdirectory path from the path info --->
		<cfset path_info = ReplaceNoCase(cgi.path_info, cgi.script_name, "")>
	
		<!--- If using mod-rewrite or other server method like ISAPI Rewrite, set translate path to 'no' --->
		<cfif Request.AppSettings.UseSES AND len(path_info)>
			<cfset translatepath = "yes">
		<cfelse>
			<cfset translatepath = "no">
		</cfif>
		
		<!--- If using search-engine safe URLs, get the Query_String from the URL structure --->
		<cfif translatepath>
			<cfset Request.Query_String ="">

			<cfloop item="URLVar" collection="#URL#">
				<cfif NOT ListFind('CFTOKEN,CFID,JSESSIONID,CATEGORY,PRODUCT,FEATURE,PAGE',URLVar) AND Len(URL[URLVar])>
					<cfset Request.Query_String = ListAppend(Request.Query_String, LCase(URLVar) & '=' & LCase(URL[URLVar]), "&")>
				</cfif>
			</cfloop>
			
			<!--- Clean any XSS attempts in the URLs --->
			<!--- <cfset Request.Query_String = Application.objGlobal.CodeCleaner(Request.Query_String)> --->
			
			<!--- If not a SES page, add the query string --->
			<cfif len(Request.Query_String)>
				<cfset Request.currentURL = "#self##path_info#?#Request.Query_String##Request.Token2#">
				<cfset Request.LoginURL = "#self##path_info#?#Request.Query_String#">
			<cfelse>
				<cfset Request.currentURL = "#self##path_info##Request.Token1#">
				<cfset Request.LoginURL = "#self##path_info#?dologin=yes">
			</cfif>
			
			
		<cfelse>
				
			<!--- Strip session vars from the URL string --->
			<cfset Request.query_string = Replace(cgi.query_string, "&" & Session.URLToken, '', "ALL")>
			<cfset Request.query_string = Replace(Request.query_string, Session.URLToken, '', "ALL")>
			<!--- Clean any XSS attempts in the URLs --->
			<!--- <cfset Request.Query_String = Application.objGlobal.CodeCleaner(Request.Query_String)> --->
			
			<cfset Request.currentURL = "#self#?#Request.Query_String##Request.Token2#">
			<cfset Request.LoginURL = "#self#?#Request.Query_String#">
		
		</cfif>
		
		<cfset clearsession = "no">
		
		<!--- Clear cookies/session for users coming from external links or spoofing session. Setting when not using shared SSL --->
 		<cfif NOT Request.SharedSSL AND isDefined("URL.CFID") OR isDefined("Form.CFID")>
			<!--- Clear only if this is not a PayPal IPN transaction --->
			<cfif attributes.fuseaction IS NOT "shopping.checkout" OR NOT IsDefined("attributes.custom") OR CompareNoCase(attributes.custom, Session.BasketNum) IS NOT 0>
				<cfset clearsession = "yes">
			</cfif>
		<cfelseif Request.SharedSSL AND (isDefined("URL.CFID") OR isDefined("Form.CFID")) AND NOT isDefined("attributes.redirect")>
			<!--- Clear only if referer is blank OR Referrer is not same as server name and not on SSL ---> 
			<cfif NOT len(CGI.HTTP_REFERER) OR (CGI.SERVER_PORT IS NOT 443 AND NOT FindNoCase(CGI.Server_Name, CGI.HTTP_REFERER))>
				<cfset clearsession = "yes">
			</cfif>
		</cfif>	
		
		<cfif clearsession>			
			<cfcookie name="CFID" value="" expires="NOW">
		    <cfcookie name="CFTOKEN" value="" expires="NOW">
			<cfset Request.Token2 = "">	
		    <cfset attributes.submit_logout = "yes">
		    <cfset attributes.xfa_logout_successful = "#self#?#Request.Query_String#">
		    <cfinclude template="users/login/act_logout.cfm">
		</cfif>
		
		<!--- If this is an admin fuseaction, and a secure URL is set up, make sure it is using SSL --->				
		<cfif Request.secure_cookie AND ListGetAt(attributes.fuseaction,2,".") IS "admin" AND CGI.SERVER_PORT NEQ 443 >
			<cfheader statuscode="301" statustext="Moved permanently">
			<cfheader name="Location" value="#Request.SecureURL##Request.LoginURL##Request.AddToken#">
		</cfif> 
		
		<!--- If this is an user fuseaction, not the loginbox and a secure URL is set up, make sure it is using SSL --->				
		<cfif Request.secure_cookie AND ListGetAt(attributes.fuseaction,1,".") IS "users" AND attributes.fuseaction IS NOT "users.loginbox" AND CGI.SERVER_PORT NEQ 443 >
			<cfheader statuscode="301" statustext="Moved permanently">
			<cfheader name="Location" value="#Request.SecureURL##Request.LoginURL##Request.AddToken#">
		</cfif> 

	<!---------------------------------------------------------
	Code here will run for main fusebox requests as well as custom tag calls 
	-------------------------------------------------------------->
	
	</cfif>		
		
<cfelse>
	<!--- put settings here that you want to execute only when this is not an application's home circuit --->

</cfif>

</cfsilent>
