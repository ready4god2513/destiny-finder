<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays form to create an email. Called from users.admin&email=write. --->

<!--- initialize parameters --->
<cfparam name="attributes.un" default="">
<cfparam name="attributes.Mailtext_ID" default="">
<cfparam name="attributes.message" default="">
<cfparam name="attributes.Subject" default="">
<cfparam name="attributes.body" default="">
<cfparam name="attributes.member" default="0">

<cfinclude template="../group/qry_get_all_groups.cfm">
<cfinclude template="qry_get_mailtexts.cfm">

<!--- If a messagetext_id was passed, auto-fill the message text --->	
<cfif len(attributes.mailtext_id)>
	<cfinclude template="qry_get_mailtext.cfm">

	<cfif qry_get_mailtext.recordcount>
		<cfset attributes.subject = qry_get_mailtext.mailtext_subject>
		<cfset attributes.body = qry_get_mailtext.mailtext_message>
	</cfif>
</cfif>


<cfmodule template="../../../customtags/format_output_admin.cfm"
	box_title="Send Email"
	Width="600"
	menutabs="yes">
				
	<cfinclude template="dsp_menu.cfm">
	<cfoutput>
	<table border="0" cellpadding="0" cellspacing="4" width="100%" class="formtext"	style="color:###Request.GetColors.InputTText#">
	</cfoutput>

	<!--- display list of standard messages if any exits ---->
	<cfif qry_get_mailtexts.recordcount>
	<cfoutput>
	<form name="users" action="#self#?fuseaction=users.admin&email=write#Request.Token2#" method="post">
	<input type="hidden" name="xfa_success" value="#attributes.xfa_success#"/>
		
	<cfloop list="customer_id,un,uid,verified,subscribe,GID,wholesale,affiliate,acct,lastLogin,lastLogin_is,created,created_is,product_ID,SKU,dateOrdered,dateFilled,dateOrdered_is,dateFilled_is,member" index="counter">
		<input type="hidden" name="#counter#" value="#attributes[counter]#"/>
	</cfloop>

		<tr>
			<td align="right">Standard Text:</td>
			<td width="4">&nbsp;</td>
		 	<td>
				<select name="mailtext_id" class="formfield" onChange="submit();">
				<option value="" #doSelected(attributes.mailtext_id,'')#></option>
			<cfloop query="qry_get_mailtexts">
				<option value="#qry_get_mailtexts.mailtext_ID#" #doSelected(attributes.mailtext_id,qry_get_mailtexts.mailtext_ID)#>#qry_get_mailtexts.mailtext_name#</option>
			</cfloop>
				</select>
			</td>
		</tr>	
	</form>
	</cfoutput>
	</cfif>
	
	
	<cfoutput>
	<form name="users" action="#self#?fuseaction=users.admin&email=send#Request.Token2#" method="post">
		
	<input type="hidden" name="xfa_success" value="#attributes.xfa_success#"/>
	<!--- insert hidden fields passed from dsp_select_form.cfm --->
	<cfloop list="customer_id,verified,un,uid,mailtext_id,subscribe,GID,wholesale,affiliate,acct,lastLogin,lastLogin_is,created,created_is,product_ID,SKU,dateOrdered,dateFilled,dateOrdered_is,dateFilled_is,member" index="counter">
		<input type="hidden" name="#counter#" value="#attributes[counter]#"/>
	</cfloop>
	
	<cfinclude template="../../../includes/form/put_message.cfm">
	
	 <!--- Send to Group_ID --->
			<tr>
				<td align="right">To:</td>
				<td style="background-color: ###Request.GetColors.formreq#;"></td>
			 		<td <cfif qry_getemails.recordcount>class="formerror"</cfif>>
					<cfif (len(attributes.un) OR len(attributes.uid) OR len(attributes.customer_id))AND qry_getemails.recordcount is 1> #qry_getemails.email#
					<cfelse>
						#qry_getemails.recordcount# email addresses selected 
					</cfif>			
				</td>
			</tr>	
	
	
	 <!--- Subject --->
			<tr>
				<td align="right">Subject:</td>
				<td style="background-color: ###Request.GetColors.formreq#;"></td>
		 		<td><input type="text" name="Subject" size="53" value="#attributes.subject#" class="formfield"/></td>
			</tr>	
			
	 <!--- message --->
			<tr>
				<td align="right" valign="top">Message:</td>
				<td style="background-color: ###Request.GetColors.formreq#;"></td>
		 		<td>
			 	<cfset config = StructNew()>
				<cfset config.LinkBrowser = "false">
				<cfset config.FlashBrowser = "false">			
				<cfmodule 
					template="../../../customtags/fckeditor/fckeditor.cfm" 
					instanceName="body"
					height="200" 						
					toolbarSet="Basic" 
					config="#config#"
					Value="#attributes.body#"
					/>
				</td>
			</tr>	
			
	 <!--- preview --->
			<tr>
				<td align="right"></td>
				<td></td>
		 		<td><input type="checkbox" name="Preview" value="1" checked="checked" />Preview message before sending</td>
			</tr>	
			
	<cfinclude template="../../../includes/form/put_space.cfm">

	 <!--- submit ---->
		<tr>
			<td colspan="2">&nbsp;</td>
			<td>
			<input type="submit" name="Submit" value=" Send Message " class="formbutton"/>
			&nbsp;&nbsp;
			<input type="button" value="Reselect Emails" onclick="javascript:window.history.go(-1);" class="formbutton"/>
			&nbsp;
			<input type="button" value="Cancel" onclick="JavaScript:location.href='#self#?#attributes.xfa_success##request.token2#';" class="formbutton"/>
			</td>
			<cfinclude template="../../../includes/form/put_requiredfields.cfm">	
			</tr>
		</form>
	</table>
</cfoutput>
</cfmodule>	
	