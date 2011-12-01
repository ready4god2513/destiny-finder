<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This page is used for all rate types to output the selection choice for instore pickup. Called by the various put_choose*.cfm pages  --->

<cfparam name="NoShipping" default="0">

<!--- Add the option for instore pickup if turned on --->
<cfif ShipSettings.InStorePickup AND NOT NoShipping>	
	<cfoutput><br/><input type="radio" name="RateID" value="NA" />In-Store Pickup - No Charge</cfoutput>
</cfif> 	
	
	

