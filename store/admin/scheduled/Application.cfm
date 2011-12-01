
<cfset request.self = "index.cfm">
<cfset fusebox.IsHomeCircuit = "Yes">

<!--- This folder holds pages that can be scheduled to run automatically by the ColdFusion server. --->
<cfinclude template="../../fbx_Settings.cfm">

<cfparam name="Session.User_ID" default="0">

<cfparam name="Session.BasketNum" default="">
