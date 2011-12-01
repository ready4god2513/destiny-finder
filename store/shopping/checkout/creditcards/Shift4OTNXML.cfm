<cfparam name="ATTRIBUTES.URL" default="">
<cfset ATTRIBUTES.URL=Replace(ATTRIBUTES.URL, ";", "," ,"ALL")>
<cfset i=ListFindNoCase(ATTRIBUTES.URL,"MSXML")>
<cfif i NEQ 0>
	<cfset ATTRIBUTES.URL=ListDeleteAt(ATTRIBUTES.URL,i)>
</cfif>
<cfif not IsDefined("ATTRIBUTES.Action")>
	<!---
	
	NAME:
	
		CF_Shift4OTNXML Custom Tag
	
	DESCRIPTION:
	
		ColdFusion Custom Tag for providing a real-time credit card
		and check transaction processing interface to Shift4's
		$$$ ON THE NET(tm) application. This is an MSXML version
		of the same Shift4OTN tag that has been available since
		2001. The main reason for this module is for use on Windows
		CFMX servers where the Java runtime does not have the 128
		bit SSL support, which is required for credit card gateways.
		
		This is a leaner and cleaner version of the original and one
		day may be the basis for a rewrite to make a single tag with
		both functionalities (CFHTTP & MSXML).
		
		See Shift4's web site at www.shift4.com for current product
		information and pricing.
		
	AUTHOR:
	
		Steven M. Sommers (steve@shift4.com)
		27-Mar-2004
	
	COPYRIGHT:
	
		Copyright (c) 2004 Shift4 Corporation. ALL RIGHTS RESERVED.
		
	DISTRIBUTION RIGHTS:
	
		You are granted a non-exlusive, royalty-free right to use
		and distribute this Custom Tag Definition (hereafter "TAG")
		unless specifically stated otherwise. You are further granted
		permission to redistribute any of the TAG source code in source
		code form, provided that the original archive as found on the
		Shift4 web site (http://www.shift4.com) is distributed
		unmodified. For example, if you create a descendant or modified
		version of CF_Shift4OTN, you must include in the distribution
		package the Shift4OTN.zip file in the exact form that you
		downloaded it from http://www.shift4.com/downloads/shift4otn.zip.
	
	RESTRICTIONS:
	
		Without the express written consent of the author, you may not:
			a)	Distribute modified versions of TAG by itself. You must
				include the original archive as you found it at the
				Shift4 site.
			b)	Sell or lease any portion of TAG or TAG source code. You
				are, of course, free to sell any of your own original
				code that works with, enhances, etc., TAG source code.                                                         }
			c)	Distribute TAG source code for profit.
	
	WARRANTY:
	
		There is absolutely no warranty of any kind whatsoever with this
		TAG. This TAG is provided to you "AS-IS", and all risks and losses
		associated with it's use are assumed by you. In no event shall the
		author of this TAG, Steven M. Sommers nor Shift4 Corporation, be
		held liable for any damages or losses that may occur from use or
		misuse of this TAG.
		
	ATTRIBUTES:
	
		result				Application assigned structure name for results
		name				Application assigned structure name for results -- supported
							for compatibility -- newer interfaces should use "result"
							instead which will allow for use with CFMODULE (which
							happens to use the "name" parameter)
		options				Various option flags -- NOAUTODELETE is the only
							option supported at this time. By default, this
							tag automatically issues a transaction void if
							the transaction is not approved
		url					Shift4 assigned URL (comma seperated list
							if more than one URL is assigned)
		serialnumber		Shift4 assigned serial number
		username			Merchant assigned user name
		password			Merchant assigned password
		merchantid			Shift4 assigned merchant id
		functionrequestcode	1B = online authorization (preauth)
							1D = online sale (with or without a preauth)
		invoice				Application assigned
		cardnumber			Info from customer
		expirationmonth		Info from customer
		expirationyear		Info from customer
		zipcode				Info from customer
		primaryamount		Invoice amount
		secondaryamount		Secondary invoice amount (optional, must be 0.00
							if unsued), total amount of invoice is the
							primaryamount + secondaryamount
		notes				Any transaction notes
		formfields			Comma seperated list of field names to be 
							included in the transaction (optional)
	
	NOTES:
	
		This documentation and the associated example only shows the
		bare bones minimum for acquiring online e-commerce
		authorizations. Shift4 can provide a complete API if you
		require more functionality.
		
		Use of notes -- a great feature your application can have is
		the ability to embed an HTML formatted invoice in the notes.
		$$$ ON THE NET will actually embed this document into the
		transaction (minus any JavaScript or Appletes).
	
	USAGE:
	
		FunctionRequestCode:
			For service merchants, a functionrequestcode of 1D is all you
			need to use. If product shipment is involved, Shift4 recommends
			using a functionreuestcode of 1B at the time of the order,
			followed by a 1D transaction when the order ships. For this 
			two step process to work, you must supply the same merchantid, 
			invoice and cardnumber on the 1D request as the application
			supplied on the prior 1B request. Provided that the initial 
			invoice amount was greater than of equal to the final amount,
			the 1D request will return the same authorization code as the
			initial 1B request.
		
		Processing the response:
			You should always check ErrorText first. If ErrorText is not ""
			then you should abort the transaction and display the contents.
	
			ResponseCode is the next most important field. ResponseCode 
			will be one of the following:
				A	Approved
				R	Voice referral (call voice center), should never happen
					for e-commerce merchants -- if so, treat as declined
				D	Declined
				F	Address verification failure -- only possible if the 
					zip code was provided
					
			ValidAVS should be checked next. It is important to note that
			depending on the merchant setup and the dollar amount of the 
			transaction, you may receive a "A" ResponseCode with a ValidAVS
			of "N" (failed) and in other instances, you may simply receive
			a "F" ResponseCode with a ValidAVS of "N".
				Y	Address verification passed
				N	Address verification failed
				" "	Zip code not provided
	
	
	EXAMPLES:
	
		See Shift4OTNExample.cfm for a more detailed example. It is
		important that the application check the contents of ErrorText
		prior to continuing with any subsequent variable checks.
		
	MODIFICATION HISTORY:
	
		04/27/2004			Initial release.
	
	--->
</cfif>

<cfset HttpFailure	= 98980>
<cfset XmlFailure	= 98981>
<cfset TagException	= 98989>

<cfparam name="ATTRIBUTES.Action" default="">
<cfswitch expression="#ATTRIBUTES.Action#">
	<cfcase value="CREATE">
		<cflock timeout="15" throwontimeout="Yes" type="EXCLUSIVE" scope="APPLICATION">
			<cfif not IsDefined("APPLICATION.XmlArray") or ArrayLen(APPLICATION.XmlHttpArray) EQ 0>
				<cfobject type="com" name="REQUEST.XmlHttp" class="MSXML2.ServerXMLHTTP" action="create">
				<cfobject type="com" name="REQUEST.XmlDom" class="MSXML2.DOMDocument" action="create">
			<cfelse>
				<cfset REQUEST.XmlHttp=APPLICATION.XmlHttpArray[1][1]>
				<cfset REQUEST.XmlDom=APPLICATION.XmlHttpArray[1][2]>
				<cfset tmp=ArrayDeleteAt(APPLICATION.XmlHttpArray,1)>
			</cfif>
		</cflock>
		<cfexit method="EXITTAG">
	</cfcase>
	<cfcase value="DESTROY">
		<cfset atmp=ArrayNew(1)>
		<cfset atmp[1]=REQUEST.XmlHttp>
		<cfset atmp[2]=REQUEST.XmlDom>
		<cflock timeout="15" throwontimeout="Yes" type="EXCLUSIVE" scope="APPLICATION">
			<cfif not IsDefined("APPLICATION.XmlArray")>
				<cfset APPLICATION.XmlHttpArray=ArrayNew(1)>
			</cfif>
			<cfset tmp=ArrayAppend(APPLICATION.XmlHttpArray,atmp)>
		</cflock>
		<cfset tmp=StructDelete(REQUEST,"XmlHttp","NO")>
		<cfset tmp=StructDelete(REQUEST,"XmlDom","NO")>
		<cfexit method="EXITTAG">
	</cfcase>
</cfswitch>

<cfif IsDefined("ATTRIBUTES.FormFields")>
	<cfloop index="key" list="#ATTRIBUTES.FormFields#">
		<cfif not StructKeyExists(ATTRIBUTES,"#key#")>
			<cfset tmp=StructInsert(ATTRIBUTES,key,StructFind(Form,"#key#"))>
		</cfif>
	</cfloop>
</cfif>
<cfparam name="ATTRIBUTES.Name" default="Shift4OTN">
<cfparam name="ATTRIBUTES.Result" default="#ATTRIBUTES.Name#">
<cfparam name="ATTRIBUTES.Options" default="">
<cfparam name="ATTRIBUTES.FunctionRequestCode" default="1B">
<cfparam name="ATTRIBUTES.FormFields" default="">
<cfparam name="ATTRIBUTES.ProxyServer" default="">
<cfparam name="ATTRIBUTES.ProxyPort" default="80">
<cfparam name="ATTRIBUTES.ProxyUsername" default="">
<cfparam name="ATTRIBUTES.ProxyPassword" default="">
<cfset ATTRIBUTES.Verbose="YES">
<cfset ATTRIBUTES.ContentType="text/xml">

<cfloop index="key" list="Result,URL,SerialNumber,Username,Password,FunctionRequestCode">
	<cfif not IsDefined("ATTRIBUTES.#key#")>
		<cfabort showerror="CF_Shift4OTN tag error: '#key#' parameter required">
	</cfif>
</cfloop>

<cfset ATTRIBUTES.TagStartTime=GetTickCount()>
<cfset ATTRIBUTES.FunctionRequestCode=ReplaceList(UCase(ATTRIBUTES.FunctionRequestCode),"03,13,04,14","1B,1C,1D,1E")>
<cfif ListFindNoCase(ATTRIBUTES.FormFields,"Verbose") NEQ 0>
	<cfset ATTRIBUTES.Verbose=(FORM.Verbose is "YES")>
</cfif>

<cfset URLs=ListToArray(Replace(ATTRIBUTES.URL,";",",","ALL"))>
<cfloop index="i" from="1" to="#ArrayLen(URLs)#">
	<cfset j=RandRange(1,ArrayLen(URLs))>
	<cfif i NEQ j>
		<cfset tmp=URLs[i]>
		<cfset URLs[i]=URLs[j]>
		<cfset URLs[j]=tmp>
	</cfif>
</cfloop>

<cfset VARIABLES.Result=StructNew()>
<cfset VARIABLES.Result.ErrorIndicator="N">
<cfset VARIABLES.Result.PrimaryErrorCode=0>
<cfset VARIABLES.Result.SecondaryErrorCode=0>
<cfset VARIABLES.Result.ErrorText = "">
<cfset VARIABLES.Result.ShortError="">
<cfset VARIABLES.Result.LongError="">
<cfset VARIABLES.Result.RawLine1 = "">
<cfset VARIABLES.Result.RawLine2 = "">
<cfset VARIABLES.Result.ResponseCode = "">
<cfset VARIABLES.Result.Authorization="">
<cfset VARIABLES.Result.ValidAVS="">
<cfset VARIABLES.Result.CVV2Valid="">
<cfset VARIABLES.Result.aTrace=ArrayNew(1)>

<cfset aFormFields=ArrayNew(1)>
<cfloop index="key" list="#StructKeyList(ATTRIBUTES)#">
	<cfif ListFindNoCase("ProxyServer,ProxyPort,ProxyUsername,ProxyPassword,STX,ETX",key) EQ 0>
		<cfset tmp=ArrayAppend(aFormFields,"#key#=#URLEncodedFormat(StructFind(ATTRIBUTES,'#key#'))#")>
		<cfif not IsDefined("VARIABLES.Result.#key#") and ListFindNoCase("Username,Password,APIPassword",key) EQ 0>
			<cfset "VARIABLES.Result.#key#"=StructFind(ATTRIBUTES,"#key#")>
		</cfif>
	</cfif>
</cfloop>

<cfset exceptmsg="">
<cf_Shift4OTNXML Action="CREATE">
<cfscript>
	REQUEST.XmlHttp.setTimeouts(5000,5000,5000,30000);
	if (ATTRIBUTES.ProxyServer is not "") {
		REQUEST.XmlHttp.setProxy(0,ATTRIBUTES.ProxyServer,0);
		REQUEST.XmlHttp.setProxyCredentials(ATTRIBUTES.ProxyUsername,ATTRIBUTES.ProxyPassword);
	}
</cfscript>
<cftry>
	<cfset transmitcnt=0>
	<cfloop index="u" from="1" to="#ArrayLen(URLs)#">
		<cfset ATTRIBUTES.IterationStartTime=GetTickCount()>

		<cfset Shift4OtnUrl=URLs[u]>
		<cfset p=Find("://",Shift4OtnUrl)>
		<cfif p GT 0>
			<cfset Shift4OtnUrl=Right(Shift4OtnUrl,Len(Shift4OtnUrl)-p-2)>
		</cfif>
		<cfif Shift4OtnUrl is "" or Shift4OtnUrl is "/">
			<cfabort showerror="CF_Shift4OTN tag error: '#Shift4OtnUrl#' is not a valid URL">
		</cfif>
		<cfif Right(Shift4OtnUrl,1) is "/">
			<cfset Shift4OtnUrl=Left(Shift4OtnUrl,Len(Shift4OtnUrl)-1)>
		</cfif>

		<cfset Shift4Host=ListFirst(Shift4OtnUrl,"/")>
		<cfif Shift4Host is "localhost" or 
			(REFind("[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}",Shift4Host) EQ 1 and ListLen(Shift4Host,".") EQ 4)>
			<cfset Shift4OtnUrl = "http://" & Shift4OtnUrl>
			<cfset Shift4OtnPort=80>
		<cfelse>
			<cfset Shift4OtnUrl = "https://" & Shift4OtnUrl>
			<cfset Shift4OtnPort=443>
		</cfif>
		<cfset ATTRIBUTES.CGI_HOST=Shift4OtnUrl>
		<cfset ATTRIBUTES.Port=Shift4OtnPort>

		<cfloop index="routeretry" from="1" to="3">
			<cfscript>
				ArrayAppend(VARIABLES.Result.aTrace,"#DateFormat(Now(),'mm/dd/yyyy')# #TimeFormat(Now(),'HH:mm:ss')#: tagstart=#ATTRIBUTES.TagStartTime#, iterationstart=#ATTRIBUTES.IterationStartTime#, url=#Shift4OtnUrl#");
				transmitcnt = transmitcnt + 1;
				REQUEST.XmlHttp.open("post","#Shift4OtnUrl#/api/S4Tran_Action.cfm",false);
				REQUEST.XmlHttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
				retval = REQUEST.XmlHttp.send("STX=YES&#ArrayToList(aFormFields,'&')#&ETX=YES");
				if (Val(retval) EQ 0)
					retval = REQUEST.XmlHttp.status;

				VARIABLES.Result.ErrorIndicator = "Y";
				VARIABLES.Result.PrimaryErrorCode = HttpFailure;
				VARIABLES.Result.SecondaryErrorCode = Val(retval);
				VARIABLES.Result.ShortError = "COM ERROR";
				VARIABLES.Result.LongError = "HTTP COM FAILURE";
				if (Val(retval) EQ 0 or Val(retval) EQ 200) {
					REQUEST.XmlDom.async = "NO";
					if (REQUEST.XmlDom.load(REQUEST.XmlHttp.responseXML)) {
						nodelist = REQUEST.XmlDom.getElementsByTagName("*");
						nodeelems = nodelist.length;
						for (i = 0; i LT nodeelems; i = i + 1) {
							node = nodelist.item(i);
							StructInsert(VARIABLES.Result,node.nodeName,node.text,"YES");
						}
						node = 0;
						nodelist = 0;
					} else {
						VARIABLES.Result.PrimaryErrorCode = #XmlFailure#;
						VARIABLES.Result.ShortError = "XML ERROR";
						VARIABLES.Result.LongError = "XML PARSING ERROR: #REQUEST.XmlHttp.responseText# (retval=#retval#)";
					}
				}
				ArrayAppend(VARIABLES.Result.aTrace,"#DateFormat(Now(),'mm/dd/yyyy')# #TimeFormat(Now(),'HH:mm:ss')#: retval=#retval#, ErrorIndicator=#VARIABLES.Result.ErrorIndicator#, PrimaryErrorCode=#VARIABLES.Result.PrimaryErrorCode#, SecondaryErrorCode=#VARIABLES.Result.SecondaryErrorCode#");
			</cfscript>
			<cfif VARIABLES.Result.PrimaryErrorCode NEQ XmlFailure>
				<cfbreak>
			</cfif>
		</cfloop>
		<cfif VARIABLES.Result.PrimaryErrorCode NEQ HttpFailure and VARIABLES.Result.PrimaryErrorCode NEQ XmlFailure>
			<cfbreak>
		</cfif>
	</cfloop>
	
	<cfcatch type="Any">
		<cfdump var="#CFCATCH#">
		<cfset VARIABLES.Result.ErrorIndicator="Y">
		<cfset VARIABLES.Result.PrimaryErrorCode=TagException>
		<cfset VARIABLES.Result.SecondaryErrorCode=0>
		<cfset VARIABLES.Result.ShortError="TAG EXCEPTION">
		<cfif IsDefined("Message")>
			<cfset exceptmsg=Message>
		<cfelseif IsDefined("ErrorCode")>
			<cfset exceptmsg=ErrorCode>
		<cfelseif IsDefined("Detail")>
			<cfset exceptmsg=Detail>
		<cfelseif IsDefined("Type")>
			<cfset exceptmsg=Type>
		<cfelse>
			<cfset exceptmsg="Unknown exception">
		</cfif>
		<cfset VARIABLES.Result.LongError = "TAG EXCEPTION: " & exceptmsg>
	</cfcatch>
</cftry>
<cf_Shift4OTNXML Action="DESTROY">

<cfset "CALLER.#ATTRIBUTES.Result#" = VARIABLES.Result>

<cfset ThisTag.GeneratedContent = "">
