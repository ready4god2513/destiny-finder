<cfparam name="ATTRIBUTES.URL" default="">
<cfset ATTRIBUTES.URL=Replace(ATTRIBUTES.URL, ";", "," ,"ALL")>
<cfset i=ListFindNoCase(ATTRIBUTES.URL,"MSXML")>
<cfif i NEQ 0>
	<cfset ATTRIBUTES.URL=ListDeleteAt(ATTRIBUTES.URL,i)>
	<cfinclude template="Shift4OTNXML.cfm">
	<cfexit method="EXITTAG">
</cfif>
<!---

NAME:

	CF_Shift4OTN Custom Tag

DESCRIPTION:

	ColdFusion Custom Tag for providing a real-time credit card
	and check transaction processing interface to Shift4's
	$$$ ON THE NET(tm) application.
	
	See Shift4's web site at www.shift4.com for current product
	information and pricing.
	
AUTHOR:

	Steven M. Sommers (steve@shift4.com)
	09-Mar-2001

COPYRIGHT:

	Copyright (c) 2001 Shift4 Corporation. ALL RIGHTS RESERVED.
	
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

	03/09/2001 -- Initial release.
	
	05/18/2001(ish) -- Changed the URL selection logic to
	first check for a single URL entry list. The original
	code did not work with the 4.0 or 4.01 versions of the
	CF server.
	
	06/18/2001 -- Added the "Result" parameter to replace
	the "Name" parameter. Either parameter can be used but
	for compatibility with CFMODULE, "Result" must be used.
	
	06/27/2001 -- Added automatic retry logic when multiple
	URL's are passed and an HTTP error is detected.
	
	07/20/2001 -- Added STX/ETX/RETRANSMIT logic to detect
	incomplete transactions received by the server.
	
	12/10/2001 -- Added logic to strip out blank lines prior
	to the first OK.
	
	12/14/2001 -- Placed the trace output into HTML comments.
	
	10/04/2002 -- Some modifications because of some
	incompatibilities with CFMX.
	
	10/07/2002 -- Some cosmetic clean-up of the prior change
	to make the code easier to read.
	
	11/07/2002 -- Added the Right() string logic around the
	GetTickCount() function. Based on a message in the
	Macromedia Support Forum (and a customer displaying the
	same symptoms), GetTickCount can overflow the integer
	logic in ColdFusion and by using only the right 8
	digits, eliminates this issue.
	
	04/10/2003 -- Cleaned up Shift4OTNExample to use
	ErrorIndicator instead of ErrorText for the primary
	error check logic. Modified the Shift4OTN.cfm tag to
	work better with Verbose="NO". Verbose should always
	be on (the default) for ColdFusion but this tag is
	used as an example for other scripting environments
	and some cannot easily handle the verbose data.
	
	04/29/2003 -- Added a CFTRY/CFCATCH block around the
	CFHTTP call. It appears that CFHTTP can still throw
	an exception even if ThrowOnError="no".
	
	10/07/2004 -- Added USERAGENT in the CFHTTP tag to
	emulate an IE 5.0 request. This was required due to
	the latest security patches from Microsoft.
	
	04/17/2007 -- Several changes to improve the error
	handling. Added seamless support for direct server
	to server vs. server to UTG.

--->

<cfset HttpFailure	= 98980>
<cfset XmlFailure	= 98981>
<cfset TagException	= 98989>

<cfif IsDefined("ATTRIBUTES.Name") and not IsDefined("ATTRIBUTES.Result")>
	<cfset ATTRIBUTES.Result = ATTRIBUTES.Name>
<cfelse>
	<cfparam name="ATTRIBUTES.Result" default="Shift4OTN">
</cfif>

<cfparam name="ATTRIBUTES.Options" default="">
<cfparam name="ATTRIBUTES.FunctionRequestCode" default="1B">
<cfparam name="ATTRIBUTES.FormFields" default="">

<cfparam name="ATTRIBUTES.Timeout" default="">
<cfset ATTRIBUTES.Timeout=Val(ATTRIBUTES.Timeout)>
<cfif ATTRIBUTES.Timeout LTE 0>
	<cfset ATTRIBUTES.Timeout=45>
</cfif>

<cfparam name="ATTRIBUTES.ProxyServer" default="">
<cfparam name="ATTRIBUTES.ProxyPort" default="80">
<cfparam name="ATTRIBUTES.ProxyUserName" default="">
<cfparam name="ATTRIBUTES.ProxyPassword" default="">

<cfset ATTRIBUTES.Verbose = "YES">
<cfloop index="key" list="Result,URL,SerialNumber,UserName,Password,FunctionRequestCode">
	<cfif not IsDefined("ATTRIBUTES.#key#")>
		<cfabort showerror="CF_Shift4OTN tag error: '#key#' parameter required">
	</cfif>
</cfloop>

<!--- UTG uses APISerialNumber and APIPassword instead of SerialNumber and Password / this sets both --->
<cfparam name="ATTRIBUTES.APISerialNumber" default="#ATTRIBUTES.SerialNumber#">
<cfparam name="ATTRIBUTES.APIPassword" default="#ATTRIBUTES.Password#">

<cfset ATTRIBUTES.TagStartTime = GetTickCount()>

<cfloop index="key" list="#ATTRIBUTES.FormFields#">
	<cfif not StructKeyExists(Attributes,"#key#")>
		<cfset tmp = StructInsert(Attributes,key,StructFind(Form,"#key#"))>
	</cfif>
</cfloop>
<cfset ATTRIBUTES.FunctionRequestCode=ReplaceList(UCase(ATTRIBUTES.FunctionRequestCode),"03,13,04,14","1B,1C,1D,1E")>
<cfif ListFindNoCase(ATTRIBUTES.FormFields,"Verbose") NEQ 0>
	<cfset ATTRIBUTES.Verbose=(FORM.Verbose is "YES")>
</cfif>

<cfif IsDefined("ATTRIBUTES.ExpirationYear") and Val(ATTRIBUTES.ExpirationYear) GTE 100>
	<!--- UTG cannot handle four digit years / this will be corrected in the near future --->
	<cfset ATTRIBUTES.ExpirationYear=Val(ATTRIBUTES.ExpirationYear) mod 100>
</cfif>

<cfset tmp=ATTRIBUTES.URL>
<cfset cnt = ListLen(tmp)>
<cfset start = 1>
<cfif cnt GT 1>
	<cfset start = (Val(Right(GetTickCount(),8)) mod cnt) + 1>
</cfif>
<cfset i = start>

<cfset CRLF = Chr(13) & Chr(10)>
<cfset TAB = "        ">
<cfset transmitcnt = 0>
<cfset cfhttp_StatusCode="">
<cfset urllist="">
<cfloop condition="1 EQ 1">
	<cfif cnt LTE 1>
		<cfset Shift4OtnUrl = Replace(tmp, ",", "" ,"ALL")>
	<cfelse>
		<cfset Shift4OtnUrl = Trim(ListGetAt(tmp,i))>
	</cfif>
	
	<cfset p = Find("://",Shift4OtnUrl)>
	<cfif p GT 0>
		<cfset Shift4OtnUrl = Right(Shift4OtnUrl,Len(Shift4OtnUrl) - p - 2)>
	</cfif>

	<cfif Shift4OtnUrl is "" or Shift4OtnUrl is "/">
		<cfabort showerror="CF_Shift4OTN tag error: '#Shift4OtnUrl#' is not a valid URL">
	</cfif>
	<cfif Right(Shift4OtnUrl,1) is "/">
		<cfset Shift4OtnUrl = Left(Shift4OtnUrl,Len(Shift4OtnUrl) - 1)>
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
	
	<cfoutput><!-- TRACE #DateFormat(Now(),"mm/dd/yyyy")# #TimeFormat(Now(),"HH:mm:ss")#: cnt=#cnt#, start=#start#, i=#i#, url=#Shift4OtnUrl# -->#CRLF#</cfoutput>
	<cfset exceptmsg="">
	<cfloop condition="1 EQ 1">
		<cfset transmitcnt = transmitcnt + 1>
		<cfoutput><!-- TRACE #DateFormat(Now(),"mm/dd/yyyy")# #TimeFormat(Now(),"HH:mm:ss")#:  transmitcnt=#transmitcnt# -->#CRLF#</cfoutput>
		<cfset ATTRIBUTES.PostStartTime = GetTickCount()>
		<cftry>
			<cfset cfhttp_StatusCode="">
			<cfset urllist=urllist & "<li>#Shift4OtnUrl#</li>">
			<cfhttp url="#Shift4OtnUrl#/api/S4Tran_Action.cfm" method="POST" port="#Shift4OtnPort#" username="#ATTRIBUTES.ProxyUserName#" password="#ATTRIBUTES.ProxyPassword#" resolveurl="false" proxyserver="#ATTRIBUTES.ProxyServer#" proxyport="#ATTRIBUTES.ProxyPort#" timeout="#ATTRIBUTES.Timeout#" throwonerror="no" useragent="Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.0; T312461; .NET CLR 1.1.4322)">
				<cfhttpparam type="FORMFIELD" name="STX" value="Yes">
				<cfloop index="key" list="#StructKeyList(Attributes)#">
					<cfif ListFindNoCase("ProxyServer,ProxyPort,ProxyUserName,ProxyPassword",key) EQ 0>
						<cfif Val(ListFirst(SERVER.ColdFusion.ProductVersion)) GTE 5>
							<cfhttpparam type="FORMFIELD" name="#key#" value="#StructFind(Attributes,'#key#')#">
						<cfelse>
							<cfhttpparam type="FORMFIELD" name="#key#" value="#URLEncodedFormat(StructFind(Attributes,'#key#'))#">
						</cfif>
					</cfif>
				</cfloop>
				<cfhttpparam type="FORMFIELD" name="ETX" value="Yes">
			</cfhttp>
			<cfcatch type="Any">
				<cfset cfhttp_StatusCode="EXCEPTION">
				<cfif IsDefined("Message")>
					<cfset exceptmsg=Message>
				<cfelseif IsDefined("ErrorCode")>
					<cfset exceptmsg=ErrorCode>
				<cfelseif IsDefined("Detail")>
					<cfset exceptmsg=Detail>
				<cfelseif IsDefined("Type")>
					<cfset exceptmsg=Type>
				<cfelse>
					<cfset exceptmsg="Unknown communication failure">
				</cfif>
			</cfcatch>
		</cftry>
		<cfset ATTRIBUTES.PostFinishTime = GetTickCount()>
		<cfset ATTRIBUTES.PostTotalTime = ATTRIBUTES.PostFinishTime - ATTRIBUTES.PostStartTime>
		<cfif cfhttp_StatusCode is "">
			<cfset cfhttp_StatusCode=Trim(cfhttp.StatusCode)>
		</cfif>
		<cfif transmitcnt GTE 10>
			<cfbreak>
		</cfif>
		<cfoutput><!-- TRACE #DateFormat(Now(),"mm/dd/yyyy")# #TimeFormat(Now(),"HH:mm:ss")#: statuscode=#cfhttp_StatusCode# -->#CRLF#</cfoutput>
		<cfif cfhttp_StatusCode is "-1 null"
			or ListFind("200,202",Left("#cfhttp_StatusCode#XXX",3)) EQ 0
			or not IsDefined("cfhttp.FileContent")
			or Trim(ListGetAt(cfhttp.FileContent,1,CRLF)) is not "RETRANSMIT">
			<cfbreak>
		</cfif>
	</cfloop>
	
	<cfif transmitcnt GTE 10>
		<cfbreak>
	</cfif>

	<cfset filecontent = "">
	<cfif Left("#cfhttp_StatusCode#XXX",1) is "0" or ListFind("200,202",Left("#cfhttp_StatusCode#XXX",3)) GT 0>
		<cfloop index="i" from="1" to="#ListLen(cfhttp.FileContent,CRLF)#">
			<cfscript>
				l = Trim(ListGetAt(cfhttp.FileContent,i,CRLF));
				if (filecontent is not "" or l is not "")
					filecontent = ListAppend(filecontent,l,CRLF);
			</cfscript>
		</cfloop>
		<!--- <cfoutput><!-- TRACE #DateFormat(Now(),"mm/dd/yyyy")# #TimeFormat(Now(),"HH:mm:ss")#: FileContents=#filecontent# -->#CRLF#</cfoutput> --->
		<cfoutput><!-- TRACE #DateFormat(Now(),"mm/dd/yyyy")# #TimeFormat(Now(),"HH:mm:ss")#:<cfloop index="i" from="1" to="#ListLen(filecontent,CRLF)#"><cfif i GT 2><cfbreak></cfif>#CRLF##TAB##ListGetAt(filecontent,i,CRLF)#</cfloop>#CRLF#-->#CRLF#</cfoutput>
		<cfif ListFindNoCase("OK,ERROR",Trim(ListGetAt(filecontent,1,CRLF))) GT 0>
			<cfbreak>
		</cfif>
	</cfif>
	
	<cfif cnt LTE 1>
		<cfbreak>
	</cfif>
	
	<cfset i = i + 1>
	<cfif i GT cnt>
		<cfset i = 1>
	</cfif>
	<cfif i EQ start>
		<cfbreak>
	</cfif>
</cfloop>
<cfset ATTRIBUTES.TagFinishTime = GetTickCount()>
<cfset ATTRIBUTES.TagTotalTime = ATTRIBUTES.TagFinishTime - ATTRIBUTES.TagStartTime>

<cfset VARIABLES.Result = StructNew()>
<cfloop index="field" list="#StructKeyList(ATTRIBUTES)#">
	<cfif ListFindNoCase("ProxyServer,ProxyPort,ProxyUserName,ProxyPassword",field) EQ 0>
		<cfset "VARIABLES.Result.#field#" = StructFind(ATTRIBUTES,field)>
	</cfif>
</cfloop>

<cfset urllist="<h2>URL LIST:</h2><ul>#urllist#</ul>">

<cfset VARIABLES.Result.RawLine1 = "">
<cfset VARIABLES.Result.RawLine2 = "">
<cfset VARIABLES.Result.ErrorText = "">
<cfset VARIABLES.Result.ErrorIndicator = "N">
<cfset VARIABLES.Result.PrimaryErrorCode = 0>
<cfset VARIABLES.Result.SecondaryErrorCode = 0>
<cfset VARIABLES.Result.ShortError = "">
<cfset VARIABLES.Result.LongError = "">
<cfset VARIABLES.Result.ResponseCode = "">
<cfset VARIABLES.Result.Authorization="">
<cfset VARIABLES.Result.ValidAVS="">
<cfset VARIABLES.Result.CVV2Valid="">
<cfset VARIABLES.Result.cfhttp_StatusCode=cfhttp_StatusCode>
<cfif Left("#cfhttp_StatusCode#XXX",1) is not "0" and ListFind("200,202",Left("#cfhttp_StatusCode#XXX",3)) EQ 0>
	<cfset VARIABLES.Result.ErrorIndicator = "Y">
	<cfset VARIABLES.Result.PrimaryErrorCode = HttpFailure>
	<cfset VARIABLES.Result.SecondaryErrorCode = Val(Left(cfhttp_StatusCode&"XXX",3))>
	<cfset VARIABLES.Result.ShortError = "HTTP ERROR: " & VARIABLES.Result.PrimaryErrorCode>
	<cfset VARIABLES.Result.LongError = "HTTP ERROR: " & cfhttp_StatusCode & urllist>
	<cfif exceptmsg is not "" and exceptmsg is not cfhttp_StatusCode>
		<cfset VARIABLES.Result.LongError = VARIABLES.Result.LongError & " -- " & exceptmsg>
	</cfif>
<cfelse>
	<cfset VARIABLES.Result.RawLine1=Trim(ListGetAt(filecontent,1,CRLF))>
	<cfset VARIABLES.Result.RawLine2="">
	<cfif ListLen(filecontent,CRLF) GT 1>
		<cfset VARIABLES.Result.RawLine2=Trim(ListGetAt(filecontent,2,CRLF))>
	</cfif>
	<cfif VARIABLES.Result.RawLine1 is "ERROR" and ListLen(VARIABLES.Result.RawLine2) GT 1>
		<cfset VARIABLES.Result.ErrorIndicator="Y">
		<cfset VARIABLES.Result.PrimaryErrorCode=Val(ListFirst(VARIABLES.Result.RawLine2))>
		<cfif VARIABLES.Result.PrimaryErrorCode EQ 0>
			<cfset VARIABLES.Result.PrimaryErrorCode=9999>
		</cfif>
		<cfset VARIABLES.Result.ShortError=ListDeleteAt(VARIABLES.Result.RawLine2,1)>
		<cfset VARIABLES.Result.LongError=VARIABLES.Result.ShortError & urllist>
	<cfelseif VARIABLES.Result.RawLine1 is not "OK">
		<cfset VARIABLES.Result.ErrorIndicator = "Y">
		<cfset VARIABLES.Result.PrimaryErrorCode = 9999>
		<cfset VARIABLES.Result.ShortError = "UNKNOWN TEXT ERROR">
		<cfset VARIABLES.Result.LongError = "UKNOWN TEXT ERROR: " & filecontent & urllist>
		<cfset VARIABLES.Result.ErrorText = filecontent & urllist>
	<cfelse>
		<cfset rawlist="TranID,Invoice,CardType,ResponseCode,PreauthorizedAmount,Authorization,ValidAVS,CVV2Valid">
		<cfset rawargc=ListLen(VARIABLES.Result.RawLine2)>
		<cfloop index="i" from="1" to="#ListLen(rawlist)#">
			<cfset var="VARIABLES.Result.#ListGetAt(rawlist,i)#">
			<cfset "#var#"="">
			<cfif i LTE rawargc>
				<cfset "#var#"=Trim(Replace(ListGetAt(VARIABLES.Result.RawLine2,i),"""","","ALL"))>
			</cfif>
		</cfloop>
		<cfloop index="line" list="#filecontent#" delimiters="#CRLF#">
			<cfset p = Find("=",line)>
			<cfif p GT 0>
				<cfset key = Left(line,p - 1)>
				<cfset value = URLDecode(Right(line,Len(line) - p))>
				<cfset "VARIABLES.Result.#key#" = value>
			</cfif>
		</cfloop>
	</cfif>
</cfif>

<cfset "CALLER.#ATTRIBUTES.Result#" = VARIABLES.Result>

<cfset ThisTag.GeneratedContent = "">