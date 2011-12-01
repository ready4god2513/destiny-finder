
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This template is called when an Exception Error occurs. It automatically emails the site webmaster and dumps the error information into a secure directory that only admins can access. This page is defined on fbx_settings.cfm by adding the following bit of code to the Error Handler section:

	<cferror type="EXCEPTION" TEMPLATE="errors/fullhandler.cfm"
		MAILTO="#request.appsettings.webmaster#"> 

--->

<!--- Run browser detection --->
<cfif NOT isDefined("browserName")>
<cfinclude template="../includes/browserdetect.cfm">
</cfif>

<!--- Continue error handler only if not a search engine --->
<cfif browserName IS NOT "spider">
	
	<cfscript>
	request.varstodump="CFCATCH,ERROR,APPLICATION,ATTRIBUTES,CALLER,CGI,CLIENT,CFHTTP,FILE,FORM,REQUEST,SESSION,THIS,THISTAG,URL,VARIABLES,SERVER";
	request.varstoscrub="ATTRIBUTES,CGI,FORM,REQUEST,SESSION,URL,VARIABLES";
	request.securevars="CFID,CFTOKEN,user,pass,ds,DownloadPath,dbtype,servertype,encrypt_key,username,password,nameoncard,CardNumber,CVV2,CardZip,HTTP_COOKIE,SessionID,URLToken";
	request.theFileName=Replace(CreateUUID(),"-","","all");
	TopDirectory = GetDirectoryFromPath(ExpandPath("*.*"));
	request.errorDirectory=TopDirectory & "errors#request.slash#dumps#request.slash#";
	request.errorDomain="#Request.SecureURL##self#?fuseaction=home.admin&error=display&ID=";
	</cfscript>
	
	<cfsavecontent variable="variables.dataDump">
	<cfloop list="#request.varstodump#" index="loopItem">
		<!--- Don't expand the application memory var with all the components --->
	   <cfif IsDefined("#loopItem#") AND loopItem IS "APPLICATION">
	   		<cfset ApplicationVars = StructNew()>
	   		<cfloop item="each" collection="#Application#">
				<cfif Left(each, 3) IS NOT "obj">
					<cfset StructInsert(ApplicationVars, each, StructFind(Application, each))>
				</cfif>
			</cfloop>
	   	  <cfdump var="#ApplicationVars#" label="Application">
	   	  <!--- Clean Variables scope --->
	   <cfelseif IsDefined("#loopItem#") AND loopItem IS "VARIABLES">
	     <cfset VariableScopeVars = Duplicate(Variables)>
	     	<cfset listremove = "ApplicationVars,Attributes,CFError,Error,LB_,Buildmenu,checkforattack,checkSQLInject,getBrowser,GetItem,HTMLCompressFormat,LoadPattern,QueryRowtoStruct,Sanitize,SESFile,XHTMLFormat">
	   		<cfloop item="each" collection="#VariableScopeVars#">
				<cfif Left(each, 2) IS "do" OR ListFindNoCase(listremove,each)>
					<cfset StructDelete(VariableScopeVars, each)>
				</cfif>
			</cfloop>			
	   	  <cfdump var="#VariableScopeVars#" label="Variables">
	   	<cfelseif IsDefined("#loopItem#") AND ListFind(request.varstoscrub,loopItem)>
	      	<cfset ScrubbedVars = Duplicate(Evaluate(loopItem))>
	      	<cfloop item="each" collection="#ScrubbedVars#">
				<cfif ListFindNoCase(request.securevars,each)>
					<cfset ScrubbedVars[each] = "removed">
				</cfif>
			</cfloop>
			<cfdump var="#ScrubbedVars#" label="#loopitem#">
	   <cfelseif IsDefined("#loopItem#")>
	   		<cfdump var="#Evaluate(loopItem)#" label="#loopItem#">
	   </cfif> 
	</cfloop>
	</cfsavecontent>
	<cfsavecontent variable="variables.basicinfo">
	<cfoutput>
		<table width="100%" cellpadding="5" cellspacing="0" border="0">
		<cfloop collection="#error#" item="i">
			<cfset data = StructFind(error, i)>
			<cfif IsSimpleValue(data)>
			<tr>
				<td><font face="verdana" size="2"><strong>#Ucase(i)#:</strong><br/>#data#</font></td>
			</tr>
			</cfif>
		</cfloop>
	</table>
	</cfoutput>
	</cfsavecontent>
	<cffile
	   action="write"
	   file="#request.errorDirectory##request.theFileName#.cfm"
	   output="#variables.dataDump#"> 
      <cfmail to="#ERROR.MailTo#" from="#ERROR.MailTo#" subject="#cgi.server_name# Error"
         server="#request.appsettings.email_server#" port="#request.appsettings.email_port#"
         type="HTML">
        <br/><br/>
		 An error has been encountered on #cgi.server_name#:<br/><br/>
		 #basicinfo#<br/><br/>
         <a href="#request.errorDomain##request.theFileName#">View full error diagnostics</a><br/><br/>
         <a href="#Request.SecureURL##self#?fuseaction=home.admin&amp;error=list">See the complete error list</a><br/><br/>
      </cfmail>
	  
	<!--- If this is an admin page, try to refresh the error counter --->
	<cftry>
	  <cfif fusebox.fuseaction is "admin">
		<cfset innertext = Application.objMenus.getErrorDumps()>
	  	<script type="text/javascript">
			<cfoutput>parent.AdminMenu.document.getElementById('errorcount').innerHTML = '#innertext#';</cfoutput>
		</script>
	  </cfif>
		
		<cfcatch type="Any">
		</cfcatch>
	</cftry>
		
</cfif>

<cfinclude template="dsp_error.cfm">
