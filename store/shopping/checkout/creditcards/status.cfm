
<!--- CONNECT TO THE COM OR CREATE IT IF NO CONNECTION EXISTS--->

<cftry>
  <cfobject 
        action="CONNECT" 
        class="LpiCom_6_0.LinkPointTxn" 
        name="LPI_CFX_COM" 
        type="COM">


 	<!--- ELSE CREATE THE OBJECT --->

<cfcatch>
    <cfobject 
        action="CREATE" 
        class="LpiCom_6_0.LinkPointTxn" 
        name="LPI_CFX_COM" 
        type="COM"> 
</cfcatch>
</cftry>

<!--- SEND THE TRANSACTION USING THE COM --->
	<cfset resp = LPI_CFX_COM.send(keyfile,host,port,outXML)> 

<!--- RETRIEVE THE RESPONSE XML, CREATE A DOC ROOT --->

<!--- SET THE STANDARD RESPONSE FOR TELECHECK --->
	<cfif listcontainsnocase(outxml, "telecheck", ">")>

<!--- RESPONSE CONTAINS WHITE SPACE WHICH CAUSES AN ERROR SO TRIM IT --->
		<cfset resp = trim(resp)>

<!--- CREDIT CARD RESPONSES NEED A DOC ROOT, WRAP RESPONSE --->
	<cfelse>
		<cfset resp = '<response>#resp#</response>'>
	</cfif>

<!--- SET THE XML DOC IN A VARIABLE --->
	<cfset XMLResp = XmlParse(resp)> 

<!--- SET THE DOC ROOT TO A VARIABLE --->
	<cfset rootResp = XMLResp.XmlRoot> 


<!--- USED TO SEE THE XML DOCUMENT STRUCTURE (NOT FOR LIVE SITE) --->
<!--- <cfdump var=#XMLResp#> --->

<!--- LOOP THROUGH THE RETURN ELEMENTS --->
	<cfloop from="1" to="#arrayLen(rootResp)#" index="i">

<!--- CHECK IF THE SPECIFIED ELEMENT EXISTS. SET IT'S VALUE --->
<cfif isDefined('rootResp.r_error')><cfset r_error = "#rootResp[i].r_error.xmltext#"><cfelse><cfset r_error = ""></cfif>
<cfif isDefined('rootResp.r_approved')><cfset r_approved = "#rootResp[i].r_approved.xmltext#"><cfelse><cfset r_approved = ""></cfif>
<cfif isDefined('rootResp.r_ordernum')><cfset r_ordernum = "#rootResp[i].r_ordernum.xmltext#"><cfelse><cfset r_ordernum = ""></cfif>
<cfif isDefined('rootResp.r_code')><cfset r_code = "#rootResp[i].r_code.xmltext#"><cfelse><cfset r_code = ""></cfif>
<cfif isDefined('rootResp.r_tdate')><cfset r_tdate = "#rootResp[i].r_tdate.xmltext#"><cfelse><cfset r_tdate = ""></cfif>
<cfif isDefined('rootResp.r_time')><cfset r_time = "#rootResp[i].r_time.xmltext#"><cfelse><cfset r_time = ""></cfif>
<cfif isDefined('rootResp.r_ref')><cfset r_ref = "#rootResp[i].r_ref.xmltext#"><cfelse><cfset r_ref=""></cfif>
<cfif isDefined('rootResp.r_authresponse')><cfset r_authresponse = "#rootResp[i].r_authresponse.xmltext#"><cfelse><cfset r_authresponse = ""></cfif>
<cfif isDefined('rootResp.r_message')><cfset r_message = "#rootResp[i].r_message.xmltext#"><cfelse><cfset r_message = ""></cfif>
<cfif isDefined('rootResp.r_avs')><cfset r_avs = "#rootResp[i].r_avs.xmltext#"><cfelse><cfset r_avs = ""></cfif>
<cfif isDefined('rootResp.r_csp')><cfset r_csp = "#rootResp[i].r_csp.xmltext#"><cfelse><cfset r_csp = ""></cfif>
<cfif isDefined('rootResp.r_vpasresponse')><cfset r_vpasresponse= "#rootResp[i].r_vpasresponse.xmltext#"><cfelse><cfset r_vpasresponse = ""></cfif>
<!--- <cfif isDefined('rootResp.r_score')><cfset r_score = "#rootResp[i].r_score.r_providerone.xmltext#"><cfelse><cfset r_score = "0"></cfif> --->
<cfif isDefined('rootResp.r_shipping')><cfset r_shipping = "#rootResp[i].r_shipping.xmltext#"><cfelse><cfset r_shipping = ""></cfif>
<cfif isDefined('apiversion')><cfset r_apiversion = "#apiversion#"><cfelse><cfset apiversion = ""></cfif>
<!--- END THE LOOP --->
	</cfloop>