
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Used to temporarily save the customer information entered in the address form. Called by shopping.checkout (step=address) --->

<cfparam name="attributes.shiptoyes" default ="0">
<cfparam name="attributes.phone2" default="">
<cfparam name="attributes.fax" default="">
<cfparam name="attributes.residence" default="1">

<cfif NOT len(attributes.state)>
	<cfset attributes.state = "Unlisted">
</cfif>

<cfset attributes.TableName = "TempCustomer">
<cfset Application.objUsers.UpdateCustomer(argumentcollection=attributes)>

		
