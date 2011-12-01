
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This page creates the HTML body tag using the color palette settings. Used for layout pages and popup window pages. --->

<cfset BodyParams = ''>
	<cfif Request.GetColors.MainText is not ''> 
		<cfset BodyParams = BodyParams & ' text="###Request.GetColors.MainText#"'> 	
	</cfif>
	<cfif Request.GetColors.MainLink is not ''> 
		<cfset BodyParams = BodyParams & ' link="###Request.GetColors.MainLink#"'> 
	</cfif>
	<cfif Request.GetColors.MainVLink is not ''> 
		<cfset BodyParams = BodyParams & ' vlink="###Request.GetColors.MainVLink#" alink="###Request.GetColors.MainVLink#"'> 
	</cfif> 
	<cfif Request.GetColors.BGImage is not ''>	
		<cfset BodyParams = BodyParams & ' background="#Request.AppSettings.defaultimages#/#Request.GetColors.BGImage#"'>
	</cfif>
	<cfif Request.GetColors.BGColor is not ''>	
		<cfset BodyParams = BodyParams & ' bgcolor="###Request.GetColors.BGColor#"'> 	
	</cfif>

<cfoutput>
<body #BodyParams# <cfif isdefined('onload')>onload="#onload#"</cfif>>
</cfoutput>





