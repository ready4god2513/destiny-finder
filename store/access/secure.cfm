
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This security model is based on Hal Helms' secure.cfm (halhelms.com) --->

<!--- This page handles all the security throughout the site. With it you can:

- require that a user be logged in to gain access to a particular page
- validate their user record by testing for things such as a current email, 
that the email address provided has been confirmed, that they have a customer record, 
that they have an account record, that their birthdate is over 18, that they have a 
current valid credit card on file, etc.
- require that the user has a particular access key required to access the site content
- require that the user has the correct administrative permissions to perform a certain task.

This tag can be implemented in 2 different ways:

- A custom tag with beginning and end tags will make the enclosed content "not visible" unless they pass the required test:

	<cfmodule template="access/secure.cfm" keyname="login" requiredPermission="1">
		Content that will only be visibe if the user is currently logged in	
	</cfmodule>	

- Without an end tag. The variable "ispermitted" will be set and avialable to use in your code:
	
	<cfmodule template="access/secure.cfm"	keyname="user" requiredPermission="1" >	
	<cfif ispermitted>	
		*Then run this code*
	</cfif>

Here are the tag's perameters:
	<cfmodule 
		template="access/secure.cfm"      | pointed correctly at this page
		keyname="login|circuit|accesskey" | keyname can be one of the following 3 things:
									  	  |'login' for login required and validation
							 			  |'contentkey_list' for site content
							 			  | a circuit name for admin permissions
		requiredPermission="1" 	   		  | value of keyname we're testing for
		dsp_login_Required="template"     | optional template when login text fails
		dsp_not_permitted="template"	  | optional template for when permitted fails
	>	


	If the Keyname is 'login', the following are permissions you can test for:
	(these are set when users create or edit thier user record by the 
	users/act_set_registration_permissions.cfm template)

			0:  		   - login only
			1:	email_ok   - email not known to be bad	
			2:	email_conf - email address confirmed
			4:	customer   - customer record exits
			8:	account    - account record exists			
			16:	adult      - birthdate is over 18	
			32:	cc_ok      - cc validated

	If the Keyname is 'contentkey_list', then the required permission will be the 
	accesskey_id from the accesskey table

	If the Keyname is the name of a circuit, then the require permission you can 
	test for will be listed in that circuit's FBX_permissions page.
			
--->

<!--- Template to display IF Membership Required and logged in. ---->
<cfparam name="attributes.dsp_not_Permitted" default="dsp_not_permitted.cfm">

<!--- Template to display IF Membership Required and NOT logged in. ---->
<cfparam name="attributes.dsp_not_Permitted_login" default="dsp_membership_login.cfm">
		
<!--- If permitted fails, include the following files ------->
<cfparam name="attributes.dsp_login_Required" default="dsp_login_required.cfm">


<cfset user_id = Session.User_ID>
<cfset permitted = FALSE>


<!--- FIRST, check for login --->
<cfif not user_id>

<!--- if user is not logged in and there is no end tag, display login required page. --->
  <cfif not ThisTag.HasEndTag>
   <cfif attributes.keyname is "contentkey_list" and attributes.requiredPermission is not "1">
   <cfinclude template="#attributes.dsp_not_Permitted_login#">
 <cfelse>
  <cfinclude template="#attributes.dsp_login_Required#">
  <cfset Request.NotAllowed = True>
 </cfif> 
  </cfif>
	
<cfelse><!---- user is logged in ---->

	<cfif attributes.keyname is "login">
	
		<!--- 0   - logged in only --->
		<cfif attributes.requiredPermission is 0>
			<cfset permitted = TRUE>
		<cfelse>
		
			<!------------------------------------------
			1:	email_ok   - email not known to be bad	
			2:	email_conf - email address confirmed
			4:	customer   - cutomer record exits
			8:	account    - account record exists			
			16:	adult      - birthdate is over 18	
			32:	cc_ok      - cc validated
			-------------------------------------------->
			
			<cfset permitted = TRUE>
			
			<cfset reg_loc = ListContainsNoCase(session.userPermissions,'registration',';')>
			
			<cfif reg_loc>
				<cfset reg_val = ListLast(ListGetAt(session.userPermissions,reg_loc,';'),'^')>
			<cfelse>
				<cfset reg_val = 0>
			</cfif>
						
			<cfloop index="this_permission" list="#attributes.requiredPermission#">
				
				<cfif NOT BitAnd(reg_val, this_permission)>
				
					<cfswitch expression = "#this_permission#">
					
						<!--- email address is BAD ---> 
						<cfcase value="1">
							
							<cfoutput><h3>The email address we have for you is either not valid or not accepting emails from our site.<br/><br/>
							Please update your email address below OR <a href="mailto:#request.appsettings.MerchantEmail#">email the editor</a> to have your current email address reinstated.</h3>	</cfoutput>		
							<cfmodule template="../#caller.self#"
								fuseaction="users.email"
								message = "Please update your email address."
								xfa_success = "#cgi.query_string#"
								>
							<cfset permitted = FALSE>
							<cfbreak>
						</cfcase>
						
						<!--- email address must be confirmed --->
						<cfcase value="2">
							
							<cfmodule template="../#caller.self#"
								fuseaction="users.unlock"
								xfa_success = "#cgi.query_string#"
								>	
							<cfset permitted = FALSE>
							<cfbreak>
						</cfcase>
						
						<!--- No Customer Record --->
						<cfcase value="4">
							<cfoutput><h3>Your registration information is incomplete. Please fill out	the form below.</h3></cfoutput>
							<cfmodule template="../#caller.self#"
								fuseaction="users.address"
								xfa_submit_customer = "#cgi.query_string#"
								xfa_customer_success = "#cgi.query_string#"
								mode = "customer"
								>	
							<cfset permitted = FALSE>
							<cfbreak>
						</cfcase>
						
						<!--- No Account Record --->
						<cfcase value="8">
							<cfoutput><h3>Your account registration information is incomplete. Please fill out	the form below.</h3></cfoutput>
							<cfset permitted = FALSE>
							<cfbreak>
						</cfcase>
												
						<!--- UNDER 18 --->
						<cfcase value="16">
							<cfoutput><p></p><p></p>
							<h3>You must be at least 18 years of age to access this area.</h3></cfoutput>
							<cfset permitted = FALSE>
							<cfbreak>	
						</cfcase>
		
						<!--- CC Not Valid  --->
						<cfcase value="32">
							<cfoutput><h3>You must have a valid credit card number on file to continue. Please update your credit card information below.</h3></cfoutput>
							<cfmodule template="../#caller.self#"
								fuseaction="users.ccard"
								message = "Please update your credit card information."
								xfa_success = "#cgi.query_string#"
								>
							<cfset permitted = FALSE>
							<cfbreak>
						</cfcase>
									
					</cfswitch>	
						
				</cfif>		
	
			</cfloop>
				
		</cfif>	
		
	<cfelse><!--- keyname is 'contentkey_list" OR the name of a circuit --->

		<cfset key_loc = ListContainsNoCase(session.userPermissions,attributes.keyname,';')>
		<cfif key_loc>
			<cfset key_val = ListLast(ListGetAt(session.userPermissions,key_loc,';'),'^')>
		<cfelse>
			<cfset key_val = 0>
		</cfif>
		
	
		<!--- LIST COMPARE --->
		<cfif Right(attributes.keyname,4) is "list">
			<cfif attributes.requiredPermission is "1">
				<cfset permitted = TRUE>
			<cfelse>
				<cfif key_val is not "0" and
				ListFind( key_val, attributes.requiredPermission )>
					<cfset permitted = TRUE>
				</cfif>
			</cfif>
			
		<!--- BIT COMPARE --->
		<cfelse>
			<!--- to make it possible to pass a list multiple valid permissions (ie "1,2,4" meaning "1 OR 2 OR 4"), use this loop and change 227 from attributes.requiredpermission to requiredpermission---->
			<cftry>
			<cfloop index="requiredPermission" list="#attributes.requiredPermission#" delimiters=",">
				<cfif key_val and BitAnd( key_val, requiredPermission )>
					<cfset permitted = TRUE>
				</cfif>
			</cfloop> 	
				<cfcatch>
					<cfif not ThisTag.HasEndTag>
					<!--- key may be undefined 
					A problem occurred when trying to process a BIT-based authentication.--->
					</cfif>
				</cfcatch>
			</cftry>
			
		</cfif>
			
		<cfif not ThisTag.HasEndTag AND NOT permitted AND IsDefined( 'attributes.dsp_not_permitted' )>
			<cfif attributes.keyname is "contentkey_list">
				<cfinclude template="#attributes.dsp_not_permitted#">
			</cfif>
		</cfif>
		
	</cfif><!--- login only --->

</cfif><!--- login check --->


<cfif ThisTag.HasEndTag>
	<cfif NOT permitted>
		<cfset caller.isPermitted = "FALSE">
		<cfexit method="EXITtag">
	<cfelse>
		<cfset caller.isPermitted = "TRUE">
	</cfif>						
<cfelse>
	<cfif NOT permitted>
		<cfset caller.isPermitted=FALSE>
	<cfelse>
		<cfset caller.isPermitted=TRUE>
	</cfif>
</cfif>

<!----DEBUG 
<cfoutput><h1>DEBUG</h1>
permitted: #permitted#<br/>
user: #user_id#<br/>
keyname: #attributes.keyname#<br/>
userpermissions: <cfdump var="#session.userPermissions#"><br/>
<!--- keyvalue: #evaluate("session.userPermissions." & attributes.keyname)#<br/> --->
required: #attributes.requiredPermission#<br/>
caller.ispermitted: #caller.isPermitted#<br/>
Permission: #BitAND(2,31)#<br/>
</cfoutput>--->




