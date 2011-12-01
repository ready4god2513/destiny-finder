<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- iTransact custom tag --->

<cfparam name="attributes.action" default="AUTHONLY">
<cfparam name="attributes.proxy" default="">
<cfparam name="attributes.test" default="FALSE">
<cfparam name="attributes.emailcustomer" default="FALSE">
<cfparam name="attributes.emailmerchant" default="TRUE">
<cfparam name="attributes.merchantemail" default="">
<cfparam name="attributes.firstname" default="">
<cfparam name="attributes.lastname" default="">
 
		<cfhttp url="https://secure.itransact.com/cgi-bin/rc/ord.cgi" method="post">
			
<cfhttpparam type="FORMFIELD" name="vendor_id" value="25821">
<cfhttpparam type="FORMFIELD" name="home_page" value="http://www.cfwebstore.com">
<cfhttpparam type="formfield" name="ccnum" value="5454545454545454">
<cfhttpparam type="formfield" name="ccmo" value="December">
<cfhttpparam type="formfield" name="ccyr" value="2005">
		<cfhttpparam type='FORMFIELD' name='1-cost' value="2275.95">
   <cfhttpparam type='FORMFIELD' name='1-desc' value="Octane Laptop XL34">
  <cfhttpparam type='FORMFIELD' name='1-qty' value="1">
   <cfhttpparam type='FORMFIELD' name='2-cost' value="2275.95">
  <cfhttpparam type='FORMFIELD' name='2-desc' value="Octane Laptop XL34">
  <cfhttpparam type='FORMFIELD' name='2-qty' value="1">
<cfhttpparam type='FORMFIELD' name='4-cost' value="11.90">
  <cfhttpparam type='FORMFIELD' name='4-desc' value="Shipping">
<cfhttpparam type='FORMFIELD' name='4-qty' value="1">
   <cfhttpparam type='FORMFIELD' name='acceptcards' value="1">
   <cfhttpparam type='FORMFIELD' name='acceptchecks' value="1">
   <cfhttpparam type='FORMFIELD' name='address' value="13820 Berlin Trpl">
 <cfhttpparam type='FORMFIELD' name='allowreg' value="0">
  <cfhttpparam type='FORMFIELD' name='altaddr' value="0">
<cfhttpparam type='FORMFIELD' name='checkguar' value="0">
 <cfhttpparam type='FORMFIELD' name='city' value="Lovettsville">
<cfhttpparam type='FORMFIELD' name='cost1' value="2275.95">
<cfhttpparam type='FORMFIELD' name='cost2' value="2275.95">
  <cfhttpparam type='FORMFIELD' name='country' value="USA">
<cfhttpparam type='FORMFIELD' name='desc1' value="Octane Laptop XL34">
<cfhttpparam type='FORMFIELD' name='desc2' value="Octane Laptop XL34">
  <cfhttpparam type='FORMFIELD' name='email' value="maryjo@sld2.com">
 <cfhttpparam type='FORMFIELD' name='email_text' value="Thank you for using iTransact Corporation">
<cfhttpparam type='FORMFIELD' name='finalquant' value="3">
<cfhttpparam type='FORMFIELD' name='first_name' value="Mary Jo">
 <cfhttpparam type='FORMFIELD' name='last_name' value="Sminkey">
  <cfhttpparam type='FORMFIELD' name='mername' value="CFWebstore!">
<cfhttpparam type='FORMFIELD' name='mertext' value="">
 <cfhttpparam type='FORMFIELD' name='phone' value="540-882-4192">
 <cfhttpparam type='FORMFIELD' name='qty1' value="1">
<cfhttpparam type='FORMFIELD' name='qty2' value="1">
<cfhttpparam type='FORMFIELD' name='ret_addr' value="http://www.cfwebstore.com/cfwebstore/shopping/functions/itrans.cfm">
<cfhttpparam type='FORMFIELD' name='state' value="VA">
<cfhttpparam type='FORMFIELD' name='sub1' value="2275.95">
<cfhttpparam type='FORMFIELD' name='sub2' value="2275.95">
 <cfhttpparam type='FORMFIELD' name='subtotal' value="4551.90">
  <cfhttpparam type='FORMFIELD' name='totalprice' value="4563.80">
 <cfhttpparam type='FORMFIELD' name='totalship' value="0">
<cfhttpparam type='FORMFIELD' name='zip' value="20180">

	</cfhttp>
	
	<cfoutput>#CFHTTP.FileContent#</cfoutput>
	<cfabort>

		<!----------------------------------------------------------------------
	Create a local query object for result
  ---------------------------------------------------------------------->
<cfset q_auth = QueryNew("response_code,authorization_code,response_text,avs_code,trans_id")>
<cfset nil = QueryAddRow(q_auth)>

<cfif ListLen(cfhttp.FileContent) GTE 5>

	<cfset nil = QuerySetCell( q_auth, "response_code", Replace(ListGetAt(CFHTTP.FileContent, 1),'"','','ALL'))>
	<cfset nil = QuerySetCell( q_auth, "authorization_code", Replace(ListGetAt(CFHTTP.FileContent, 5),'"','','ALL'))>
	<cfset nil = QuerySetCell( q_auth, "response_text", Replace(ListGetAt(CFHTTP.FileContent, 4),'"','','ALL'))>
	<cfset nil = QuerySetCell( q_auth, "avs_code", Replace(ListGetAt(CFHTTP.FileContent, 6),'"','','ALL'))>
	<cfset nil = QuerySetCell( q_auth, "trans_id", Replace(ListGetAt(CFHTTP.FileContent, 7),'"','','ALL'))>
	
<cfelse>

	<cfset nil = QuerySetCell( q_auth, "response_code", "E")>
	<cfset nil = QuerySetCell( q_auth, "authorization_code", "")>
	<cfset nil = QuerySetCell( q_auth, "response_text", "Invalid Response from AuthorizeNet")>
	<cfset nil = QuerySetCell( q_auth, "avs_code", "")>
	<cfset nil = QuerySetCell( q_auth, "trans_id", "")>

</cfif>

<!----------------------------------------------------------------------
	Set caller query object
  ---------------------------------------------------------------------->
<cfset "Caller.#attributes.queryname#" = q_auth>


