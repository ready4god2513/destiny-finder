<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This page creates an input form box --->

<!--- Attributes --------------------------------------------------------------------->
<cfparam name="attributes.width" default="100%">
<cfparam name="attributes.border" default="1">
<cfparam name="attributes.box_title" default="">
<cfparam name="attributes.align" default="center">
<cfparam name="attributes.help_url" default="">
<cfparam name="attributes.help_text" default="">
<cfparam name="attributes.more_anchor" default="">
<cfparam name="attributes.required_Fields" default="1">
<cfparam name="attributes.HBgcolor" default="#Request.GetColors.InputHBgcolor#">
<cfparam name="attributes.HText" default="#Request.GetColors.InputHText#">
<cfparam name="attributes.TBgcolor" default="#Request.GetColors.InputTBgcolor#">
<cfparam name="attributes.TText" default="#Request.GetColors.InputTText#">

<!--- START ---------------------------------------------------------------------------->
<cfif thistag.ExecutionMode is "Start">

	<cfif attributes.border><cfoutput>
		<table width="#attributes.width#" cellspacing="0" border="0" 
		cellpadding="#attributes.border#" bgcolor="###attributes.HBgColor#" align="#attributes.align#">
			<tr><td></cfoutput>
		<cfset innerwidth = "100%">
	<cfelse>
		<cfset innerwidth = attributes.width>
	</cfif>
 
<cfoutput>
<table width="#innerwidth#" cellspacing="0" border="0" cellpadding="2" bgcolor="###attributes.TBgcolor#">
	<tr bgcolor="###attributes.HBgcolor#" style="color:###attributes.HText#;">
		<th align="left" class="BoxTitle">
			<font color="###attributes.HText#">#attributes.box_title#</font>
		</th>
		<td align="right" class="formtext">	
			<cfif attributes.help_url is not "">
			<a href="JavaScript: newWindow = openWin( '#XHTMLFormat(attributes.help_url)#', 'help', 'width=500,height=350,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()" style="color:###attributes.HText#;"><cfif len(attributes.help_text)>#attributes.help_text#<cfelse><img src="#Request.AppSettings.defaultimages#/helpicon.gif" width="17" height="17" border="0" alt="Help" align="right" /></cfif></a>
			<cfelseif attributes.more_anchor is not "">
				#attributes.more_anchor#
			</cfif>
		</td>
	</tr>
	<tr>
		<td colspan="2">
		
		<table width="100%" border="0" cellspacing="4" cellpadding="0" class="formtext" align="center" style="color:###attributes.TText#;">
</cfoutput>
		

<cfelse><!--- END -------------------------------------------------->
	<cfif attributes.required_Fields>
	<cfinclude template="../includes/form/put_requiredfields.cfm">	
	</cfif>
	<cfoutput>
		</table>
		
	</td></tr></table>
	<cfif attributes.border is not "">
	</td></tr></table>
	</cfif>
	</cfoutput>
</cfif>
