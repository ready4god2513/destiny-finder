<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Used to display the order invoice in a separate window. Called from shopping.history and requires the Order Number to display.   --->

<cfset Order_No = Evaluate(attributes.Order - Get_Order_Settings.BaseOrderNum)>

<cfmodule template="../../access/secure.cfm"
  keyname="shopping"
  requiredPermission="2"
  > 
  <cfif ispermitted>   
	<cfset displaytype = "admin">
  <cfelse>
  	<cfset displaytype = "customer">
  </cfif>
  

<cfmodule template="put_order.cfm" Order_No="#Order_No#" Type="#displaytype#">

<br/><br/>

<!--- Bring window to the front --->
<script type="text/javascript">
window.focus();
</script>
