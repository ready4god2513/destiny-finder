
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Used to output the site logo or title on the page. Call from your layout pages --->
 
	<!--- Site logo or title --->			
<cfif len(request.appsettings.sitelogo)>
  	<cfmodule template="../customtags/putimage.cfm" fileName="#request.appsettings.sitelogo#" filealt="Home" imglink="#request.StoreURL##self##Request.Token1#">
<cfelse>
	<cfoutput><a href="#request.storeURL##self##Request.Token1#" #doMouseover('Home')# alt="Home" id="siteName">#request.AppSettings.siteName#</a></cfoutput>
</cfif>


			
			