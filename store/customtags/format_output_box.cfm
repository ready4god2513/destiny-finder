<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Attributes --->
<cfparam name="attributes.box_title" default="">
<cfparam name="attributes.width" default="100%">
<cfparam name="attributes.border" default="1">
<cfparam name="attributes.align" default="center">
<cfparam name="attributes.HBgcolor" default="#Request.GetColors.OutputHBgcolor#">
<cfparam name="attributes.HText" default="#Request.GetColors.OutputHText#">
<cfparam name="attributes.TBgcolor" default="#Request.GetColors.OutputTBgcolor#">
<cfparam name="attributes.TText" default="#Request.GetColors.OutputTText#">
<cfparam name="attributes.more" default="">

<!--- START --------------------------------------------------------->
<cfif thistag.ExecutionMode is "Start">

	<cfif attributes.border>
	<cfoutput>
	<table width="#attributes.width#" cellspacing="0" border="0" cellpadding="#attributes.border#" bgcolor="###attributes.HBgColor#" align="center">
		<tr>
			<td></cfoutput>
	</cfif>
	
	<cfoutput>
		<table border="0" cellspacing="0" cellpadding="2" width="#attributes.width#" align="center" bgcolor="###attributes.TBgcolor#" style="color:###attributes.TText#;">
		<cfif len(attributes.box_title)>
			<tr>
				<th align="#attributes.align#" bgcolor="###attributes.HBgcolor#" class="boxtitle"
				style="color:###attributes.HText#;">#attributes.box_title#</th>
			</tr>
		</cfif>
			<tr>
				<td align="center" ><!--- <font color="###attributes.TText#"> --->
	</cfoutput>

<cfelse><!--- END -------------------------------------------------->
	<!--- </font> --->
		<cfoutput>
		</td>
		</tr>
		<tr>
			<td class="Outputtext" align="right">#attributes.more#</td>
		</tr>
	</table>
			
	<cfif attributes.border>
	</td></tr></table>
	</cfif>
	</cfoutput>
</cfif><!---- TAG END ------------------------------------------------>
