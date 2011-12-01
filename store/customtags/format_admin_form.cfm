<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This page creates an input form box for the admin pages --->

<!--- Attributes --------------------------------------------------------------------->
<cfparam name="attributes.width" default="100%">
<cfparam name="attributes.box_title" default="">
<cfparam name="attributes.align" default="center">
<cfparam name="attributes.help_url" default="">
<cfparam name="attributes.help_text" default="">
<cfparam name="attributes.more_anchor" default="">
<cfparam name="attributes.required_Fields" default="1">
<cfparam name="attributes.menutabs" default="no">
<cfparam name="attributes.TText" default="#Request.GetColors.InputTText#">

<!--- START ---------------------------------------------------------------------------->
<cfif thistag.ExecutionMode is "Start">
<cfoutput>
<table style="PADDING-BOTTOM: 7px; PADDING-TOP: 7px" cellSpacing="0" cellPadding="0" width="#attributes.width#" border="0"  align="#attributes.align#" id="adminform">
  <tbody>
  <tr>
  <td class="emphasisBoxUpperLeft"></td>
  <td class="emphasisBoxTop"></td>
  <td class="emphasisBoxUpperRight"></td>
  </tr>
  <tr>
  <td class="emphasisBoxLeft" rowSpan="2">&nbsp;</td>
  <td class="emphasisBoxHeaderPurple<cfif attributes.menutabs>Clear</cfif>">#attributes.box_title#</td>
  <td class="emphasisBoxRight" rowSpan="2" align="right">&nbsp;
  <cfif attributes.help_url is not "">
			<a href="JavaScript: newWindow = openWin( '#attributes.help_url#', 'help', 'width=500,height=350,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()" style="color:#attributes.HText#;"><cfif len(attributes.help_text)>#attributes.help_text#<cfelse><img src="#Request.AppSettings.defaultimages#/helpicon.gif" width="17" height="17" border="0" alt="Help" align="right" /></cfif></a>
			<cfelseif attributes.more_anchor is not "">
				#attributes.more_anchor#
			</cfif>
	</td></tr>
<tr>
	
  <td class="emphasisBoxContent<cfif attributes.menutabs>Clear</cfif>">
  <table width="95%" border="0" cellspacing="4" cellpadding="0" class="formtext" align="center" style="color:###attributes.TText#;">
</cfoutput>
		

<cfelse><!--- END -------------------------------------------------->
	<cfif attributes.required_Fields>
	<cfinclude template="../includes/form/put_requiredfields.cfm">	
	</cfif>
	<cfoutput>
	</table></td></tr>
	 <tr>
	  <td class="emphasisBoxLowerLeft"></td>
	  <td class="emphasisBoxBottom"></td>
	  <td class="emphasisBoxLowerRight"></td>
	  </tr>
	  </tbody>
	</table>
	</cfoutput>
</cfif>
