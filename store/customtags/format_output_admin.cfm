<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Attributes --->
<cfparam name="attributes.box_title" default="">
<cfparam name="attributes.width" default="100%">
<cfparam name="attributes.height" default="">
<cfparam name="attributes.align" default="center">
<cfparam name="attributes.TText" default="#Request.GetColors.OutputTText#">
<cfparam name="attributes.more" default="">
<cfparam name="attributes.headercolor" default="Purple">
<cfparam name="attributes.menutabs" default="no">

<!--- START --------------------------------------------------------->
<cfif thistag.ExecutionMode is "Start">

<cfoutput>
<table style="PADDING-BOTTOM: 7px; PADDING-TOP: 7px" cellspacing="0" cellpadding="0" width="#attributes.width#" border="0"  align="#attributes.align#">
  <tbody>
  <tr>
  <td class="emphasisBoxUpperLeft"></td>
  <td class="emphasisBoxTop"></td>
  <td class="emphasisBoxUpperRight"></td>
  </tr>
  <tr>
  <td class="emphasisBoxLeft" rowSpan="2">&nbsp;</td>
  <td class="emphasisBoxHeader#attributes.headercolor#<cfif attributes.menutabs>Clear</cfif>">#attributes.box_title#</td>
  <td class="emphasisBoxRight" rowSpan="2" align="right">&nbsp;</td>
  </tr>
<tr <cfif len(attributes.height)>height="#attributes.height#" valign="top"</cfif>>
	
  <td class="emphasisBoxContent<cfif attributes.menutabs>Clear</cfif>">
</cfoutput>

<cfelse><!--- END -------------------------------------------------->
			<cfoutput>
			</td></tr>
			<cfif len(attributes.more)>
			<tr>
				<td colspan="3" class="Outputtext" align="right">#attributes.more#</td>
			</tr>
			</cfif>
	<tr>
  <td class="emphasisBoxLowerLeft"></td>
  <td class="emphasisBoxBottom"></td>
  <td class="emphasisBoxLowerRight"></td>
  </tr>
  </tbody>
</table>
</cfoutput>
</cfif><!---- TAG END ------------------------------------------------>
