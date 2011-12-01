<!---
	--------------------------------------------------------------------------------

	 Copyright 2003 LinkPoint International, Inc. All Rights Reserved.

	 This software is the proprietary information of LinkPoint International, Inc.
	 Use is subject to license terms.


	### YOU REALLY DO NOT NEED TO EDIT THIS FILE! ###


	lpcfm.cfm - LinkPoint API ColdFusion module
	REVISION =  lpcfm.cfm, v 3.0 12/30/03 08:22:13 cgebert
	VERSION  =  3.0.020
	---------------------------------------------------------------------------------
--->

		<!--- THERE IS NO NEED TO EDIT THIS FILE. DOING SO WOULD BE BAD --->

<!--- INCLUDE STORE SPECIFIC SETTINGS FILE --->


<!--- BUILD XML STRING --->

<!--- ORDER OPTIONS NODE --->
<cfset outXML = "<order><orderoptions>">

	<cfif isDefined('ordertype')>
		<cfset outXML = "#outXML#<ordertype>#ordertype#</ordertype>">
	</cfif>

	<cfif isDefined('result')>
		<cfset outXML = "#outXML#<result>#result#</result>">
	</cfif>

<cfset outXML = "#outXML#</orderoptions>">

<!--- CREDIT CARD NODE --->


<cfset outXML = "#outXML#<creditcard>">

	<cfif isDefined('cardnumber')>
		<cfset outXML = "#outXML#<cardnumber>#cardnumber#</cardnumber>">
	</cfif>

	<cfif isDefined('cardexpmonth')>
		<cfset outXML = "#outXML#<cardexpmonth>#cardexpmonth#</cardexpmonth>">
	</cfif>

	<cfif isDefined('cardexpyear')>
		<cfset outXML = "#outXML#<cardexpyear>#cardexpyear#</cardexpyear>">
	</cfif>

	<cfif isDefined('cvmvalue')>
		<cfset outXML = "#outXML#<cvmvalue>#cvmvalue#</cvmvalue>">
	</cfif>
	
	<cfif isDefined('cvmindicator')>
		<cfset outXML = "#outXML#<cvmindicator>#cvmindicator#</cvmindicator>">
	</cfif>

	<cfif isDefined('track')>
		<cfset outXML = "#outXML#<track>#track#</track>">
	</cfif>

<cfset outXML = "#outXML#</creditcard>">

<!--- BILLING NODE --->

<cfset outXML = "#outXML#<billing>">

	<cfif isDefined('name')>
		<cfset outXML = "#outxml#<name>#name#</name>">
	</cfif>
	
	<cfif isDefined('company')>
		<cfset outXML = "#outxml#<company>#company#</company>">
	</cfif>

	<cfif isDefined('address')>
		<cfset outXML = "#outxml#<address1>#address#</address1>">
	
	<cfelseif isDefined('address1')>
		<cfset outXML = "#outxml#<address1>#address1#</address1>">
	</cfif>

	<cfif isDefined('address2')>
		<cfset outXML = "#outxml#<address2>#address2#</address2>">
	</cfif>

	<cfif isDefined('city')>
		<cfset outXML = "#outxml#<city>#city#</city>">
	</cfif>

	<cfif isDefined('state')>
		<cfset outXML = "#outxml#<state>#state#</state>">
	</cfif>

	<cfif isDefined('zip')>
		<cfset outXML = "#outxml#<zip>#zip#</zip>">
	</cfif>

	<cfif isDefined('country')>
		<cfset outXML = "#outxml#<country>#country#</country>">
	</cfif>

	<cfif isDefined('userid')>
		<cfset outXML = "#outxml#<userid>#userid#</userid>">
	</cfif>

	<cfif isDefined('email')>
		<cfset outXML = "#outxml#<email>#email#</email>">
	</cfif>

	<cfif isDefined('phone')>
		<cfset outXML = "#outxml#<phone>#phone#</phone>">
	</cfif>

	<cfif isDefined('fax')>
		<cfset outXML = "#outxml#<fax>#fax#</fax>">
	</cfif>

	<cfif isDefined('addrnum')>
		<cfset outXML = "#outxml#<addrnum>#addrnum#</addrnum>">
	</cfif>

<cfset outXML = "#outXML#</billing>">

<!--- SHIPPING NODE --->

<cfset outXML = "#outXML#<shipping>">

	<cfif isDefined('sname')>
		<cfset outXML = "#outxml#<name>#sname#</name>">
	</cfif>
	
	<cfif isDefined('saddress')>
		<cfset outXML = "#outxml#<address1>#saddress#</address1>">
	
	<cfelseif isDefined('saddress1')>
		<cfset outXML = "#outxml#<address1>#saddress1#</address1>">
	</cfif>

	<cfif isDefined('saddress2')>
		<cfset outXML = "#outxml#<address2>#saddress2#</address2>">
	</cfif>

	<cfif isDefined('scity')>
		<cfset outXML = "#outxml#<city>#scity#</city>">
	</cfif>

	<cfif isDefined('sstate')>
		<cfset outXML = "#outxml#<state>#sstate#</state>">
	<cfelseif isDefined('state')>
		<cfset outXML = "#outXML#<state>#state#</state>">
	</cfif>

	<cfif isDefined('szip')>
		<cfset outXML = "#outxml#<zip>#szip#</zip>">
	</cfif>

	<cfif isDefined('scountry')>
		<cfset outXML = "#outxml#<country>#scountry#</country>">
	</cfif>

	<cfif isDefined('scarrier')>
		<cfset outXML = "#outxml#<carrier>#scarrier#</carrier>">
	</cfif>

	<cfif isDefined('sitems')>
		<cfset outXML = "#outxml#<items>#sitems#</items>">
	</cfif>

	<cfif isDefined('sweight')>
		<cfset outXML = "#outxml#<weight>#sweight#</weight>">
	</cfif>

	<cfif isDefined('stotal')>
		<cfset outXML = "#outxml#<total>#stotal#</total>">
	</cfif>

<cfset outXML = "#outXML#</shipping>">

<!--- TRANSACTION NODE --->

<cfset outXML = "#outXML#<transactiondetails>">

	<cfif isDefined('oid')>
		<cfset outXML = "#outXML#<oid>#oid#</oid>">
	</cfif>

	<cfif isDefined('ponumber')>
		<cfset outXML = "#outXML#<ponumber>#ponumber#</ponumber>">
	</cfif>

	<cfif isDefined('recurring')>
		<cfset outXML = "#outXML#<recurring>#recurring#</recurring>">
	</cfif>

	<cfif isDefined('taxexempt')>
		<cfset outXML = "#outXML#<taxexempt>#taxexempt#</taxexempt>">
	</cfif>

	<cfif isDefined('terminaltype')>
		<cfset outXML = "#outXML#<terminaltype>#terminaltype#</terminaltype>">
	</cfif>

	<cfif isDefined('ip')>
		<cfset outXML = "#outXML#<ip>#ip#</ip>">
	</cfif>

	<cfif isDefined('reference_number')>
		<cfset outXML = "#outXML#<reference_number>#reference_number#</reference_number>">
	</cfif>

	<cfif isDefined('transactionorigin')>
		<cfset outXML = "#outXML#<transactionorigin>#transactionorigin#</transactionorigin>">
	</cfif>

	<cfif isDefined('tdate')>
		<cfset outXML = "#outXML#<tdate>#tdate#</tdate>">
	</cfif>

<cfset outXML = "#outXML#</transactiondetails>">

<!--- MERCHANT INFO NODE --->

<cfset outXML = "#outXML#<merchantinfo>">

	<cfif isDefined('configfile')>
		<cfset outXML = "#outXML#<configfile>#configfile#</configfile>">
	</cfif>

	<cfif isDefined('keyfile')>
		<cfset outXML = "#outXML#<keyfile>#keyfile#</keyfile>">
	</cfif>

	<cfif isDefined('host')>
		<cfset outXML = "#outXML#<host>#host#</host>">
	</cfif>

	<cfif isDefined('port')>
		<cfset outXML = "#outXML#<port>#port#</port>">
	</cfif>

	<cfif isDefined('appname')>
		<cfset outXML = "#outXML#<appname>#appname#</appname>">
	</cfif>

<cfset outXML = "#outXML#</merchantinfo>">

<!--- PAYMENT NODE --->

<cfset outXML = "#outXML#<payment>">

	<cfif isDefined('chargetotal')>
		<cfset outXML = "#outXML#<chargetotal>#chargetotal#</chargetotal>">
	</cfif>

	<cfif isDefined('tax')>
		<cfset outXML = "#outXML#<tax>#tax#</tax>">
	</cfif>

	<cfif isDefined('vattax')>
		<cfset outXML = "#outXML#<vattax>#vattax#</vattax>">
	</cfif>

	<cfif isDefined('shipping')>
		<cfset outXML = "#outXML#<shipping>#shipping#</shipping>">
	</cfif>

	<cfif isDefined('subtotal')>
		<cfset outXML = "#outXML#<subtotal>#subtotal#</subtotal>">
	</cfif>

<cfset outXML = "#outXML#</payment>">

<!--- CHECK NODE --->

	<cfif isDefined('voidcheck')>
		<cfset outXML = "#outXML#<telecheck><void>1</void></telecheck>">
	<cfelseif isDefined('routing')>
		<cfset outXML = "#outXML#<telecheck>">
		<cfset outXML = "#outXML#<routing>#routing#</routing>">


	<cfif isDefined('account')>
		<cfset outXML = "#outXML#<account>#account#</account>">
	</cfif>

	<cfif isDefined('bankname')>
		<cfset outXML = "#outXML#<bankname>#bankname#</bankname>">
	</cfif>
	
	<cfif isDefined('bankstate')>
		<cfset outXML = "#outXML#<bankstate>#bankstate#</bankstate>">
	</cfif>

	<cfif isDefined('ssn')>
		<cfset outXML = "#outXML#<ssn>#ssn#</ssn>">
	</cfif>

	<cfif isDefined('dl')>
		<cfset outXML = "#outXML#<dl>#dl#</dl>">
	</cfif>

	<cfif isDefined('dlstate')>
		<cfset outXML = "#outXML#<dlstate>#dlstate#</dlstate>">
	</cfif>

	<cfif isDefined('checknumber')>
		<cfset outXML = "#outXML#<checknumber>#checknumber#</checknumber>">
	</cfif>

	<cfif isDefined('accounttype')>
		<cfset outXML = "#outXML#<accounttype>#accounttype#</accounttype>">
	</cfif>

<cfset outXML = "#outXML#</telecheck>">

</cfif>

<!--- PERIODIC NODE --->

	<cfif isDefined('startdate')>
		<cfset outXML = "#outXML#<periodic>">	
	
		<cfset outXML = "#outXML#<startdate>#startdate#</startdate>">
	
			
	<cfif isDefined('installments')>
		<cfset outXML = "#outXML#<installments>#installments#</installments>">
	</cfif>
	
	<cfif isDefined('threshold')>
		<cfset outXML = "#outXML#<threshold>#threshold#</threshold>">
	</cfif>

	<cfif isDefined('periodicity')>
		<cfset outXML = "#outXML#<periodicity>#periodicity#</periodicity>">
	</cfif>
		
	<cfif isDefined('pbcomments')>
		<cfset outXML = "#outXML#<pbcomments>#pbcomments#</pbcomments>">
	</cfif>
	
	<cfif isDefined('action')>
		<cfset outXML = "#outXML#<action>#action#</action>">
	</cfif>

<cfset outXML = "#outXML#</periodic>">

</cfif>

<!--- NOTES NODE --->

<cfif isDefined('comments') OR isDefined('referred')>

<cfset outXML = "#outXML#<notes>">

	<cfif isDefined('comments')>
		<cfset outXML = "#outXML#<comments>#comments#</comments>">
	</cfif>
	
	<cfif isDefined('referred')>
		<cfset outXML = "#outXML#<referred>#referred#</referred>">
	</cfif>

<cfset outXML = "#outXML#</notes>">
</cfif>

<!--- ITEMS AND OPTIONS NODE --->

<cfset outXML = "#outXML#<items>">

	<cfif isDefined('item_id')>

<cfloop from="1" to="#arrayLen(items)#" index="Idx">
		<cfset outXML = "#outXML#<item>">
		<cfset outXML = "#outXML#<id>#items[Idx][1]#</id>">

	<cfif isDefined('item_description')>
		<cfset outXML = "#outXML#<description>#items[Idx][2]#</description>">
	</cfif>

	<cfif isDefined('item_quantity')>
		<cfset outXML = "#outXML#<quantity>#items[Idx][3]#</quantity>">
	</cfif>

	<cfif isDefined('item_price')>
		<cfset outXML = "#outXML#<price>#items[Idx][4]#</price>">
	</cfif>

	<cfif isDefined('item_serial')>
		<cfset outXML = "#outXML#<serial>#items[Idx][5]#</serial>">
	</cfif>

		<cfset outXML = "#outXML#</item>">
	
</cfloop>

</cfif>

<cfset outXML = "#outXML#</items>">

<cfset outXML = "#outXML#</order>">
<!--- DONE BUILDING XML STRING --->
<!--- SET THE API VERSION --->
	<!--- DO NOT EDIT IF YOU NEED ACCURATE SUPPORT ON THIS PRODUCT --->
		<cfset APIVERSION = "CF - v3.0.020 12/2003">
<!--- PROCESS THE ORDER AND SET THE ORDER RESULTS --->
<!--- <CFINCLUDE TEMPLATE = "status.cfm"> --->

<!--- USED TO SEE THE OUTGOING XML STRING FOR DEBUGGING 
<CFOUTPUT>
#htmleditformat(outXML)#
</CFOUTPUT>
--->