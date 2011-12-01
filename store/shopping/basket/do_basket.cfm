<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This template is used to output the shopping cart. Called by fbx_Switch.cfm --->

<cfparam name="variables.checkout" default="0">

<cfif NOT variables.checkout>
	<cfinclude template="estimator/act_ship_estimator.cfm">
</cfif>

<cfinclude template="dsp_basket.cfm">
<!--- call the page display fuseaction if not checkout --->
<cfif NOT variables.checkout>
	<cfset attributes.pageaction = "basket">
	<cfset fusebox.nextaction="page.display">
	<cfinclude template="../../lbb_runaction.cfm">
</cfif>
<!--- end fuseaction call --->

