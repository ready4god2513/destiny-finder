<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Downloads the product list in a Bizrate-compatible data feed. Called by product.admin?do=bizrate --->

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

</cfscript>

<cfinclude template="../../../includes/puthtmlcompress.cfm">

<cfset Tab=Chr(9)>
<cfset LineFeed=Chr(10)>


<!--- Retrieve Product Data --->
<cfquery name="qry_get_products" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
SELECT P.Product_ID, A.Account_Name AS Manufacturer, P.Name AS Title, P.Long_Desc, P.Short_Desc, P.Lg_Image, P.Sm_Image, P.SKU, P.Vendor_SKU, P.Goog_Condition AS Condition, Weight, P.Base_Price AS Price, C.PassParam AS BizrateCategory
FROM ((#Request.DB_Prefix#Products P 
INNER JOIN #Request.DB_Prefix#Product_Category PC ON P.Product_ID = PC.Product_ID)
INNER JOIN #Request.DB_Prefix#Categories C ON PC.Category_ID = C.Category_ID)
LEFT JOIN #Request.DB_Prefix#Account A on P.Mfg_Account_ID = A.Account_ID
WHERE P.Display = 1
AND P.Prod_Type <> 'membership'
AND P.AccessKey = 0
AND P.Base_Price <> 0
AND C.PassParam like '%Bizrate=%'
</cfquery>

<!---
<cfdump var="#qry_get_products#"> 
--->

<!--- Set file path --->
<cfset FilePath = GetDirectoryFromPath(ExpandPath("*.*"))>
<cfset theFile = "#FilePath#files#request.slash#bizrate.txt">

<!--- Set the header row --->
<cfset headers = "Category#Tab#Manufacturer#Tab#Title#Tab#Description#Tab#Link#Tab#Image#Tab#SKU#Tab#Quantity on Hand#Tab#Condition#Tab#Shipping Weight (In Pounds, Not Required)#Tab#Shipping Cost (Not Required)#Tab#Bid (Not Required)#Tab#Promo Text (Not Required)#Tab#Other (Not Required)#Tab#Price">

<!--- Write out the file --->
<cffile action="WRITE" file="#theFile#" output="#headers#" nameconflict="OVERWRITE" addnewline="Yes">


<cfloop query="qry_get_products">
<!--- Pull Bizrate Category_ID --->
<cfloop index="ii" list="#BizrateCategory#" delimiters=",">
	<cfif listfirst(ii,"=") is "Bizrate">
		<cfset Category=listlast(ii,"=")>
	</cfif>
</cfloop>

<cfif len(Long_Desc)>
	<cfset Description = HtmlCompressFormat(StripHTML(Long_Desc), "3")>
<cfelse>
	<cfset Description = HtmlCompressFormat(StripHTML(Short_Desc), "3")>
</cfif>

<cfif len(Lg_Image)>
	<cfset Image = "#Request.StoreURL##request.appsettings.defaultimages#/#Lg_Image#">
<cfelseif len(Sm_image)>
	<cfset Image = "#Request.StoreURL##request.appsettings.defaultimages#/#Sm_Image#">
<cfelse>
	<cfset Image = "">
</cfif>

<cfif NOT len(SKU) AND Len(Vendor_SKU)>
	<cfset SKU = Vendor_SKU>
</cfif>

<cfif Not Len(Condition)>
	<cfset Condition = "New">
</cfif>

<cfif len(Category)>
	<cfset prodline = "#Category##Tab##Manufacturer##Tab##Title##Tab##Description##Tab##Request.StoreURL#index.cfm?fuseaction=product.display&product_ID=#product_ID##Tab##Image##Tab##SKU##Tab#In Stock#Tab##Goog_Condition##Tab##Weight##Tab##Tab##Tab##Tab##Tab##Price#">

	<!--- Append each product line to the file --->
	<cffile action="append" file="#theFile#" output="#prodline#">
</cfif>

</cfloop>

<!--- <cfabort> --->

<!--- Send down to the user --->
<cfheader name="Content-Disposition" value="attachment; filename=bizrate.txt">
<cfcontent type="text/plain" file="#theFile#" deletefile="No" reset="No">
