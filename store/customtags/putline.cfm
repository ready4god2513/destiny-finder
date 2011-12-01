
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This is a custom tag used for outputting the lines on the store. It takes attributes for the linetype and alignment and one that passes the image base location --->

<cfif thistag.ExecutionMode is "start">
<cfparam name="Attributes.linetype" default="Thick">
<cfparam name="Attributes.linecolor" default="#Request.GetColors.linecolor#">
<cfparam name="Attributes.align" default="Center">
<cfparam name="Attributes.width" default="100%">
<cfparam name="Attributes.imgBase" default="#request.appsettings.defaultimages#">

<cfif Attributes.linetype IS "Thick">	
	<cfif len(Request.MainLine)>
		<cfoutput><cfif Request.MainLine IS "HR" and len(attributes.linecolor)>
		 <div class="thickline" style="color: ###Attributes.linecolor#; background-color: ###Attributes.linecolor#;  width: #Attributes.width#;"><hr /></div>
		<cfelse><img src="#Attributes.imgBase#/#Request.MainLine#" alt="" /></cfif></cfoutput>
	</cfif>
<cfelse>
	<cfif len(Request.MinorLine)>
		<cfoutput><!----<span align="#Attributes.align#">--->
		<cfif Request.MinorLine IS "HR" and len(attributes.linecolor)>
		<div class="thinline" style="color: ###Attributes.linecolor#; background-color: ###Attributes.linecolor#; width: #Attributes.width#;"><hr /></div>
		<cfelse><img src="#Attributes.imgBase#/#Request.MinorLine#" alt="" />
		</cfif><!----</span>----></cfoutput>
	</cfif>
</cfif>
</cfif>


