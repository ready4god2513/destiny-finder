
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This template inserts a confirmation box to confirm admin actions
	An alert box is used unless an error occurs. Then a text box.
INPUT:
	attributes.box_title	 - optional, used for box style (as opposed to "alert")
	attributes.XFA_success	 - where to return to... if blank, a "back" is used
	attributes.message		 - message displayed at successful completion
	attributes.error_message - if the update was not successful.
--->	
<cfparam name = "attributes.message" default="Changes Saved!">
<cfparam name = "attributes.error_message" default="">
<cfparam name = "attributes.box_title" default="Error">
<cfparam name = "attributes.XFA_success" default="">
<cfparam name = "attributes.admin_reload" default="">
<cfparam name = "attributes.secureURL" default="no">


<!--- If an error_message exists, use confirmation BOX ---->
<cfif len(attributes.error_message)>
	
	<cfoutput>
	<cfmodule template="../customtags/format_input_form.cfm"
		box_title="#attributes.box_title#"
		width="350"
		required_fields= "0"
		>
		<tr><td align="center">
		<br/>
		<p class="formerror"><strong>#attributes.error_message#</strong></p>

		<input type="button" value="Return" onclick="javascript:window.history.go(-1);" class="formbutton"/>
		<br/><br/>	
		
		</td></tr>
	</cfmodule> 
	</cfoutput>

<!--- if no error, then use an alert style confirmation ---->
<cfelse>

	<cfif NOT FindNoCase(request.self, attributes.XFA_success)>
		<cfset redirectURL = "#request.self#?#attributes.XFA_success#&redirect=yes">
	<cfelse>
		<cfset redirectURL = "#attributes.XFA_success#&amp;redirect=yes">
	</cfif>
	
	<!--- Check if redirecting to an admin page, if so add SecureURL --->
	<cfif ReFind("fuseaction=[a-zA-z0-9]+\.admin",redirectURL)>
	<cfset redirectURL = Request.SecureURL & redirectURL & Request.AddToken>
	<!--- Check if redirecting to any user functions, if so add SecureURL --->
	<cfelseif ReFind("fuseaction=users/.",redirectURL)>
		<cfset redirectURL = Request.SecureURL & redirectURL & Request.AddToken>
	<!--- Regular store links --->
	<cfelse>
		<cfset redirectURL = Request.StoreURL & redirectURL & Request.Token2>
	</cfif>
	
	<cfif len(attributes.admin_reload)>
		<cfswitch expression="#attributes.admin_reload#">
			<cfcase value="membershipcount">
				<cfset innertext = Application.objMenus.getValidMemberships()>
			</cfcase>
			<cfcase value="usercount">
				<cfset innertext = Application.objMenus.getValidUserCCs()>
			</cfcase>
			<cfcase value="commentcount">
				<cfset innertext = Application.objMenus.getPendingComments()>
			</cfcase>
			<cfcase value="reviewcount">
				<cfset innertext = Application.objMenus.getPendingReviews()>
			</cfcase>
		</cfswitch>		
	</cfif>
		
	<!--- if admin confirmation, add inframes attribute to link --->	
	<cfif fusebox.fuseaction is "admin">
		<cfset redirectURL = redirectURL & "&inframes=yes">
	</cfif>
	
	<cfoutput>
	<cfprocessingdirective suppresswhitespace="no">
	<script type="text/javascript">
	<!--- if reloading an admin menu, output JS code --->
	<cfif len(attributes.admin_reload) AND CGI.SERVER_PORT IS NOT 443>
		if (parent.AdminMenu.document.getElementById('#attributes.admin_reload#') != null) {
		  parent.AdminMenu.document.getElementById('#attributes.admin_reload#').innerHTML = '#innertext#';
		}
	</cfif>
  	alert('#HTMLEditFormat(attributes.message)#');	
	location.href = '#redirectURL#';
    </script>
	</cfprocessingdirective>
	
	<!--- Output link if JS disabled --->
	#HTMLEditFormat(attributes.message)#<br/><br/>
	
	<a href="#XHTMLFormat(redirectURL)#">Click</a> to continue. 
	</cfoutput>

</cfif>

	
