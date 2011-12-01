<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Custom tag used to create a styled box for displaying items. Use the attributes below to control the look and style of your box as well as the title displayed  --->

<!--- Attributes --->
<cfparam name="attributes.box_title" default="Featured Items">
<cfparam name="attributes.width" default="100%">
<cfparam name="attributes.border" default="2">
<cfparam name="attributes.align" default="center">
<cfparam name="attributes.HBgcolor" default="#Request.GetColors.BoxHBgcolor#">
<cfparam name="attributes.HText" default="#Request.GetColors.BoxHText#">
<cfparam name="attributes.TBgcolor" default="#Request.GetColors.BoxTBgcolor#">
<cfparam name="attributes.TText" default="#Request.GetColors.BoxTText#">
<cfparam name="attributes.more" default="">
<cfparam name="attributes.float" default="left">
<cfparam name="attributes.title_image" default="">

<!--- START --------------------------------------------------------->
<cfif thistag.ExecutionMode is "Start">

<cfif attributes.border>
	<cfoutput>
	<table width="#attributes.width#" cellspacing="0" border="0" cellpadding="#attributes.border#" bgcolor="###attributes.HBgColor#" <cfif len(attributes.float)>align="#attributes.float#"</cfif>>
		<tr>
			<td>
	</cfoutput>
	<cfset innerwidth = "100%">
<cfelse>
	<cfset innerwidth = attributes.width>
</cfif>

<cfoutput>
		<table width="#innerwidth#" cellspacing="0" border="0" cellpadding="0" bgcolor="###attributes.TBgcolor#">
			<tr>
				<td align="#attributes.align#" class="BoxTitle" bgcolor="###attributes.HBgcolor#" style="color:###attributes.HText#;">
				<cfif len(attributes.title_image)>
					<img src="#request.appsettings.defaultimages#/#attributes.title_image#" alt="#attributes.box_title#" />
				<cfelse>
					#attributes.box_title#
				</cfif>
				</td>
			</tr>
			<tr>
				<td align="center" class="boxtext" style="color:###attributes.TText#;">
</cfoutput>

<cfelse><!--- END -------------------------------------------------->

				<cfoutput>
				</td>
			</tr>
			<tr>
				<td class="boxtext" align="right" style="color:###attributes.TText#;">#attributes.more#</td>
			</tr>
		</table>
		
<cfif attributes.border>
		</td>
	</tr>
</table>
</cfif>
</cfoutput>
</cfif><!---- TAG END ------------------------------------------------>
