<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Downloads the product list to a Froogle-compatible data feed. Called by product.admin?do=froogle --->

<cfinclude template="../../../includes/puthtmlcompress.cfm">

<cfscript>
/**
 * Removes HTML from the string.
 * 
 * @param string 	 String to be modified. 
 * @return Returns a string. 
 * @author Raymond Camden (ray@camdenfamily.com) 
 * @version 1, December 19, 2001 
 */
function StripHTML(str) {
	return REReplaceNoCase(str,"<[^>]*>","","ALL");
}

/**
 * Deletes the n rightmost elements from the specified list.
 * Modified by RCamden
 * 
 * @param list 	 The list to modify. 
 * @param numElements 	 The number of elements to delete. 
 * @param delimiter 	 The delimiter to use. Defaults to a comma. 
 * @return Returns a string. 
 * @author Shaun Ambrose (shaun.ambrose@arcorsys.com) 
 * @version 1, April 24, 2002 
 */
function ListDeleteRight(list, numElements) {
	var i=0;
	var delimiter=",";
	
	if (Arraylen(arguments) gt 2) {
		delimiter=arguments[3];
	}
	
	if (numElements gt ListLen(list, delimiter)) return "";
	
	for (i=1; i lte numElements; i=i+1) {
		list=listDeleteAt(list, listLen(list, delimiter), delimiter);
	}
	return list;
}
</cfscript>

<!--- Check user's access level --->
<cfmodule template="../../../access/secure.cfm"	keyname="product" requiredPermission="1">

<cfset Tab=Chr(9)>
<cfset LineFeed=Chr(10)>

<!--- Retrieve Product Data --->
<cfquery name="qry_get_products" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
SELECT Product_ID, Name, Short_Desc, Long_Desc, Sm_Image, Lg_Image, Base_Price, User_ID, SKU,
Goog_Brand, Goog_Condition, Goog_Expire, Goog_Prodtype
FROM #Request.DB_Prefix#Products
WHERE Display = 1
AND Prod_Type <> 'membership'
AND AccessKey = 0
AND Base_Price <> 0
<!--- If not full product admin, filter by user --->
<cfif not ispermitted>	
AND User_ID = #Session.User_ID# </cfif>
</cfquery>

<cfset ProdList = ValueList(qry_get_products.Product_ID)>

<!--- Get Custom Fields for google export --->
<cfquery name="CustomFields" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
SELECT Google_Code
FROM #Request.DB_Prefix#Prod_CustomFields
WHERE Google_Use = 1
ORDER BY Custom_ID
</cfquery>

<!--- Set file path --->
<cfset FilePath = GetDirectoryFromPath(ExpandPath("*.*"))>
<cfset theFile = "#FilePath#files#request.slash#froogle.txt">

<!--- Set the header row --->
<cfset headers = "link#Tab#title#Tab#id#Tab#description#Tab#image_link#Tab#brand#Tab#condition#Tab#product_type#tab#expiration_date#tab#price">

<!--- Add any custom fields --->
<cfloop query="CustomFields">
	<cfset headers = headers & "#tab##Google_Code#">
</cfloop>

<!--- Write out the file --->
<cffile action="WRITE" file="#theFile#" output="#headers#" nameconflict="OVERWRITE" addnewline="Yes">

<cfloop query="qry_get_products">

	<!--- Get Custom Data --->
	<cfquery name="GetCustomInfo" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	SELECT PI.*, PC.Google_Code
	FROM #Request.DB_Prefix#Prod_CustomFields PC
	LEFT OUTER JOIN #Request.DB_Prefix#Prod_CustInfo PI
	ON (PI.Custom_ID = PC.Custom_ID
		AND PI.Product_ID = #qry_get_products.Product_ID#)
	WHERE PC.Google_Use = 1
	ORDER BY PC.Custom_ID
	</cfquery>
	
	<cfif qry_get_products.User_ID IS NOT 0>
		<cfset subdir = "User#qry_get_products.User_ID#/">
	<cfelse>
		<cfset subdir = "">
	</cfif>
	
	<!--- Set optional stuff --->
	<cfif len(Long_Desc)>
		<cfset description = HtmlCompressFormat(StripHTML(Long_Desc), "3")>
	<cfelse>
		<cfset description = HtmlCompressFormat(StripHTML(Short_Desc), "3")>
	</cfif>
	
	<cfif len(Lg_Image)>
		<cfset prodimage = "#Request.StoreURL##request.appsettings.defaultimages#/#subdir##Lg_Image#">
	<cfelseif len(Sm_image)>
		<cfset prodimage = "#Request.StoreURL##request.appsettings.defaultimages#/#subdir##Sm_Image#">
	<cfelse>
		<cfset prodimage = "">
	</cfif>
	
	<cfset prodline = "#Request.StoreURL##self#?fuseaction=product.display&Product_ID=#Product_ID##Tab##Name##Tab##SKU##Tab##description##Tab##prodimage##Tab##goog_brand##Tab##goog_condition##Tab##goog_prodtype##tab##DateFormat(goog_Expire, "yyyy-mm-dd")##tab##Base_Price#">

<!--- Add any custom fields --->
<cfloop query="GetCustomInfo">
	<cfset prodline = prodline & "#tab##CustomInfo#">
</cfloop>
	
	<!--- Append each product line to the file --->
	<cffile action="append" file="#theFile#" output="#prodline#">

</cfloop>


<!--- Send down to the user --->
<cfheader name="Content-Disposition" value="attachment; filename=froogle.txt">
<cfcontent type="text/plain" file="#theFile#" deletefile="No" reset="No">








