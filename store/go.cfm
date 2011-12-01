<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This page provides a short, direct link to a particular page in the site. The default is to use it to display a product page, but you can customize for any particular fuseaction. --->

<cfif isdefined("url.ID")>
 <cflocation url="#request.self#?fuseaction=product.display&product_id=#url.ID#" addtoken="No">
<cfelse>
 <cflocation url="#request.self#" addtoken="No">
</cfif>


