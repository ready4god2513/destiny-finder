<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This page is used to output the disclaimer for automated rates. Called by the various put_choose*.cfm pages  --->

<cfparam name="thisType" default="UPS">

<cfif (ShipSettings.ShipBase OR ShipSettings.ShipHand) AND NOT NoShipping>
	<cfoutput><br/><br/>NOTICE: These fees do not necessarily represent #thisType# published rates and may include charges levied by #Request.AppSettings.SiteName#.<br/><br/></cfoutput>
</cfif>	
	
	

