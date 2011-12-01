<!---
cf_BofAinProcess
	Matt Robertson, MSB Designs, Inc.   http://mysecretbase.com
	Use and distribute freely.  No warranties express or implied.
--->
<!---
parameters (all are required):
	Referer					the merchant domain originating the request
	FieldNames				tilde-delimited list of all Bank of America e-Stores field 
							names being fed to this tag.
	FieldValues				tilde-delimited list of the values that correspond to the 
							above fields.
	
EXAMPLE:
	<CF_BofAinProcess
		Referer="mysecretbase.com"
		FieldNames="ioc_merchant_id~ioc_merchant_shopper_id~ioc_merchant_order_id~ioc_order_description~ioc_order_total_amount~ecom_billto_postal_name_first~ecom_billto_postal_name_last~ioc_billto_business_name~ecom_billto_postal_street_line1~ecom_billto_postal_city~ecom_billto_postal_stateprov~ecom_billto_postal_postalcode~ecom_billto_postal_countrycode~ecom_billto_online_email~ecom_payment_card_name~ecom_payment_card_number~ecom_payment_card_expdate_month~ecom_payment_card_expdate_year~ioc_cvv_indicator~ioc_auto_settle_flag~ioc_transaction_type"
		FieldValues="MYMERCHANTID~#CreateUUID()#~Item123~Type 123 Widget~$350.00~#form.FirstName#~#form.LastName#~#form.Firm#~#form.Address#~#form.City#~#form.StateProvince#~#form.PostalCode#~#form.Country#~#form.Email#~#form.CardHolder#~#form.CardNumber#~#form.CardExpMonth#~#form.CardExpYear#~0~Y~E">

RETURNED VARIABLES:
	This tag creates a structure named "estoresresults".  Your return values will retain 
	their normal BofA field names, so reference them as such:
		estoresresults.m
		estoresresults.IOC_shopper_id
		estoresresults.IOC_response_code
		
		... and so on.
		
	BAReturned = The raw result of the post is returned to the calling template in 
				 this variable
	
NOTES:
	The tag makes no attempt to validate inputs.  Do that yourself prior to the tag call.  
	Sending empty strings may break the tag.  Replace empty strings with " " 
	if you must send them.
	
--->
<cfparam name="variables.UseHeaderParm" default="N" type="string"> 
<cfparam name="attributes.TransactionType" default="payment" type="string"> <!--- or settlement --->

<!--- 
Decide whether to use header type CGI or HEADER to send the referer by 
checking what version number of CF we have.
--->
<cflock scope="SERVER" type="READONLY" timeout="10">
<cfif not Compare(Left(server.coldfusion.ProductVersion,1),6)>
	<cfset variables.UseHeaderParm="Y">
</cfif>
</cflock>
<!--- 
initiate the form post 
--->
<cfhttp 
	url="https://cart.bamart.com/#attributes.TransactionType#.mart" 
	method="post"
	port="443"
	redirect="no">
<!--- 
Set the referrer.  BofA may not accept this value from older CF versions despite the 
attempt to use the cgi scope appropriate to them here.  The tag will execute properly 
but BofA will refuse the submitted value.  Talk to E-Stores tech support for their 
workaround to this.
--->
<!--- --->
<cfif not CompareNoCase(variables.UseHeaderParm,"Y")>
	<cfhttpparam 
		type="HEADER" 
		name="referer" 
		value="#attributes.Referer#">
<cfelse>
	<cfhttpparam 
		type="CGI" 
		name="referer" 
		value="#attributes.Referer#">
</cfif>
<!--- 
set a counter 
--->
<cfset variables.LoopCounter=0>
<!--- 
loop over the submitted form fields and their corresponding values, creating one 
cfhttpparam statement for each
--->
<cfset attributes.FieldValues = replace(attributes.FieldValues,'~~','~ ~','ALL')>
<cfloop 
	list="#attributes.FieldNames#" 
	index="FieldItem" 
	delimiters="~">
	<!--- 
	increment the counter 
	--->
	<cfset variables.LoopCounter=variables.LoopCounter+1>
	<!--- 
	Pull the current field's value 
	--->
	<cfset variables.ThisValue=ListGetAt(attributes.FieldValues,variables.LoopCounter,"~")>
	<!--- 
	strip out any ampersands, which BofA doesn't like in a post 
	--->
	<cfset variables.ThisValue=Replace(variables.ThisValue,"&","","ALL")> 
	<!--- 
	add the form field parameter
	--->
	<cfhttpparam 
		type="FORMFIELD" 
		name="#FieldItem#" 
		value="#variables.ThisValue#">
</cfloop>
</cfhttp>
<!--- 
The BofA return string is effectively a list delimited by the string "<br/>".  
Change this to something that will work better with list processing.  chr(1)
has about zero chance of making it into this string on its own, so use that.
--->
<cfif attributes.TransactionType is "Settlement">
	<cfset variables.CleanList=ReplaceNoCase(cfhttp.FileContent,"IOC_",chr(1),"all")> 
<cfelse>
	<cfset variables.CleanList=ReplaceNoCase(cfhttp.FileContent,"<br/>",chr(1),"all")> 
</cfif>

<!--- 
create a structure that will hold the returned results 
--->
<cfset caller.eStoresResults=StructNew()>
<!--- 
loop over the returned results.  Treat each list item as a list itself, 
delimited by the "=" character
--->
<cfloop 
	list="#variables.CleanList#" 
	index="ParmRow" 
	delimiters="#chr(1)#">
	<!--- 
	if the returned value is empty, take this into account so the list operation 
	doesn't break 
	--->
	<cfif not Compare(ListLen(ParmRow,"="),2)>
		<!--- 
		there are two items in the list.  Store the field value 
		--->
		<cfset variables.TheValue=listGetAt(ParmRow,2,"=")>
	<cfelse>
		<!--- 
		The list does not have two values.  No response returned for this field.  
		Set the field to blank value 
		--->
		<cfset variables.TheValue="">
	</cfif>
	<!--- 
	write the name/value pair to the struct 
	--->
	<cfset variables.temp=Structinsert(caller.eStoresResults,listGetAt(ParmRow,1,"="),variables.TheValue)>
</cfloop>
<!--- 
return the raw string to the calling template in case somebody wants it 
--->
<cfset caller.BAReturned=cfhttp.FileContent>

