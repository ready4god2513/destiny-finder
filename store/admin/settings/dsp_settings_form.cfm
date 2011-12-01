<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the form to edit the main site settings. Called by home.admin&settings=edit --->

<!--- Replace HTML breaks with carriage returns --->
<cfset HTMLBreak = Chr(60) & 'br/' & Chr(62)>
<cfset Merchant = Replace(Request.AppSettings.Merchant, HTMLBreak, '', "ALL")>

<cfinclude template="../../includes/imagepreview.js">
<cfinclude template="../../includes/charCount.js">

<!--- Get List of Locales --->
<cfinclude template="../../queries/qry_getlocales.cfm">

<!--- Get list of Currency Exchanges --->
<cfquery name="getExchanges" dbtype="query">
	SELECT DISTINCT CurrExchange FROM GetLocales
	ORDER BY CurrExchange
</cfquery>

<!--- Get the email username, password and server --->
<cfset NumAmpersands = ListLen(Request.AppSettings.email_server, "@")>
<cfif NumAmpersands GT 1>
	<cfset auth_settings = ListDeleteAt(Request.AppSettings.email_server, NumAmpersands, "@")>
	<cfset attributes.email_server = ListLast(Request.AppSettings.email_server, "@")>
	<cfset attributes.email_user = ListGetAt(auth_settings, 1, ":")>
	<cfset attributes.email_pass = ListGetAt(auth_settings, 2, ":")>
<cfelse>
	<cfset attributes.email_server = Request.AppSettings.email_server>
	<cfset attributes.email_user = "">
	<cfset attributes.email_pass = "">
</cfif>

<cfmodule template="../../customtags/format_admin_form.cfm"
	box_title="Main Settings"
	width="550"
	>

<cfoutput>
<form name="editform" action="#self#?fuseaction=home.admin&settings=save#request.token2#" method="post">

<!---- sitename ----->
<tr><td align="RIGHT" width="33%">Site Name:</td>
<td style="background-color: ###Request.GetColors.formreq#;" width="4">&nbsp;</td>
<td width="67%"><input type="text" name="sitename" value="#HTMLEditFormat(Request.AppSettings.sitename)#" size="30" maxlength="50" class="formfield"/></td></tr>

<!---- Merchant ----->
<tr><td valign="top" align="RIGHT">Company Address:<br/><span class="formtextsmall">(Printed on order receipts)</span></td><td style="background-color: ###Request.GetColors.formreq#;"></td><td><textarea name="Merchant" cols="30" rows="6" wrap="virtual" class="formfield">#HTMLEditFormat(ReplaceNoCase(Merchant,"<br>", "", "ALL"))#</textarea></td></tr>

<!---- HomeCountry ----->
<tr><td align="RIGHT">Home Country:</td><td style="background-color: ###Request.GetColors.formreq#;"></td><td><select name="HomeCountry" size="1" class="formfield">
<cfloop query="GetCountries">
   <option value="#Abbrev#^#Name#" #doSelected(Request.AppSettings.HomeCountry,'#Abbrev#^#Name#')#>#Name#</option>
</cfloop>
</select></td></tr>

<tr><td align="RIGHT">Locale:</td><td style="background-color: ###Request.GetColors.formreq#;"></td><td>  <select name="Locale" size="1" class="formfield">
<cfloop query="GetLocales">
   <option value="#Name#" #doSelected(Request.AppSettings.Locale,GetLocales.Name)#>#Name#</option>
</cfloop>
</select></td></tr>

<!---- DefaultImages ----->
<tr><td align="RIGHT">
Images Directory:</td><td></td><td><input type="text" name="DefaultImages" value="#Request.AppSettings.defaultimages#" size="30" maxlength="100" class="formfield"/></td></tr>

<!--- admin new window ---->
<tr><td align="RIGHT">
Open Admin Links<br/> in New Window:</td><td style="background-color: ###Request.GetColors.formreq#;"></td>
<td><input type="radio" name="admin_new_window" value="1" #doChecked(Request.AppSettings.admin_new_window)# /> Yes  
&nbsp;&nbsp;<input type="radio" name="admin_new_window" value="0" #doChecked(Request.AppSettings.admin_new_window,0)# /> No
</td></tr>

<!--- admin Editor ---->
<!--- <tr><td align="RIGHT">
Admin Editor:</td><td style="background-color: ###Request.GetColors.formreq#;"></td>
<td><select name="Editor" size="1" class="formfield">
	<option value="Default" #doSelected(Request.AppSettings.Editor,'Default')#>Default Editor</option>
	<option value="InnovaASP" #doSelected(Request.AppSettings.Editor,'InnovaASP')#>InnovaStudio (ASP)</option>
	<option value="InnovaPHP" #doSelected(Request.AppSettings.Editor,'InnovaPHP')#>InnovaStudio (PHP)</option>
</select>
</td></tr> --->

<tr>
	<td align="RIGHT" class="formtitle"><br/>Layout Settings&nbsp;</td>
	<td colspan="2"><br/><cfmodule template="../../customtags/putline.cfm" linetype="thin" linecolor="#Request.GetColors.InputHBgcolor#"/></td>
	</tr>	
	
<!---- sitelogo ----->
<tr><td align="RIGHT">Site Logo:</td><td></td><td>
<input type="text" name="SiteLogo" value="#Request.AppSettings.SiteLogo#" size="30" maxlength="100" class="formfield"/> <a href="JavaScript: newWindow = openWin('#self#?fuseaction=home.admin&select=image&fieldname=SiteLogo&fieldvalue=#Request.AppSettings.SiteLogo##Request.Token2#', 'images', 'width=520,height=290,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=0,resizable=1'); newWindow.focus()" class="formtextsmall">Image Manager</a> </td></tr>
	
<!---- Palette  ----->
<tr><td align="RIGHT">
Default Palette:</td><td style="background-color: ###Request.GetColors.formreq#;"></td><td>
<select name="color_id" size="1" class="formfield">
<cfloop query="qry_Get_Colors">
   <option value="#color_id#" #doSelected(Request.AppSettings.color_id,qry_Get_Colors.color_id)#>#palette_name#</option>
</cfloop></select>

</td></tr>

<tr><td align="RIGHT" valign="baseline">Default Fuseaction:</td><td></td><td><input type="text" name="Default_Fuseaction" value="#Request.AppSettings.Default_Fuseaction#" size="38" class="formfield"/><br/><span class="formtextsmall">page.home, etc.</span>
</td></tr>	

<tr><td align="RIGHT">
Default Columns:</td><td style="background-color: ###Request.GetColors.formreq#;"></td>
<td><input type="text" name="CColumns" value="#Request.AppSettings.CColumns#" size="2" class="formfield"/>Subcategories &nbsp;&nbsp;<input type="text" name="PColumns" value="#Request.AppSettings.PColumns#" size="2" class="formfield"/>Content 
</td></tr>
	
<tr>
	<td align="RIGHT" class="formtitle"><br/>Email Settings&nbsp;</td>
	<td colspan="2"><br/><cfmodule template="../../customtags/putline.cfm" linetype="thin" linecolor="#Request.GetColors.InputHBgcolor#"/></td>
	</tr>	

<!---- MerchantEmail ----->
<tr><td valign="top" align="RIGHT">Company Email:</td><td style="background-color: ###Request.GetColors.formreq#;"></td><td><input type="text" name="MerchantEmail" value="#Request.AppSettings.MerchantEmail#" size="30" maxlength="50" class="formfield"/></td></tr>

<!---- Webmaster ----->
<tr><td valign="top" align="RIGHT">Webmaster Email:</td><td style="background-color: ###Request.GetColors.formreq#;"></td><td><input type="text" name="Webmaster" value="#Request.AppSettings.Webmaster#" size="30" maxlength="50" class="formfield"/></td></tr>

<!---- email_server ----->
<tr><td valign="top" align="RIGHT">SMTP Server:</td><td style="background-color: ###Request.GetColors.formreq#;"></td><td><input type="text" name="email_server" value="#attributes.email_server#" size="30" maxlength="75" class="formfield"/></td></tr>

<!---- email_port ----->
<tr><td valign="top" align="RIGHT">SMTP Port:</td><td style="background-color: ###Request.GetColors.formreq#;"></td><td><input type="text" name="email_port" value="#Request.AppSettings.email_port#" size="5" maxlength="50" class="formfield"/></td></tr>

<!---- smtp username ----->
<tr><td valign="top" align="RIGHT">SMTP Username:</td><td></td><td><input type="text" name="email_user" value="#attributes.email_user#" size="30" maxlength="75" class="formfield"/></td></tr>

<!---- smtp password ----->
<tr><td valign="top" align="RIGHT">SMTP Password:</td><td></td><td><input type="text" name="email_pass" value="#attributes.email_pass#" size="30" maxlength="50" class="formfield"/></td></tr>

<!--- Moved to the config.cfm page --->
<!--- <tr>
	<td align="RIGHT" class="formtitle"><br/>File Downloads&nbsp;</td>
	<td colspan="2"><br/><cfmodule template="../../customtags/putline.cfm" linetype="thin" linecolor="#Request.GetColors.InputHBgcolor#"/></td>
	</tr>	
	
<!---- FilePath ----->
<tr><td align="RIGHT" valign="top">
Path to Downloads:</td><td></td><td><input type="text" name="FilePath" value="#Request.AppSettings.filepath#" size="60" maxlength="150" class="formfield"/><br/>
<span class="formtextsmall">Actual server path to directory for downloadable products.</span></td></tr>

<!---- MimeTypes ----->
<tr><td align="RIGHT" valign="top">
Mime Types Allowed:</td><td></td><td><input type="text" name="Mimetypes" value="#Request.AppSettings.Mimetypes#" size="60" maxlength="255" class="formfield"/></td></tr>
<tr><td colspan="2"></td><td valign="top"><span class="formtextsmall">List of mime types allowed when uploading downloadable products (be aware of issues with allowing executable types!)</span></td></tr>
 --->
<tr>
	<td align="RIGHT" class="formtitle"><br/>SEO Settings&nbsp;</td>
	<td colspan="2"><br/><cfmodule template="../../customtags/putline.cfm" linetype="thin" linecolor="#Request.GetColors.InputHBgcolor#"/></td>
	</tr>	
	
<!---- UseSES ----->
<tr><td align="RIGHT">Use SES Links:</td><td style="background-color: ###Request.GetColors.formreq#;"></td>
<td><input type="radio" name="UseSES" value="1" #doChecked(Request.AppSettings.UseSES)# />Yes 
<input type="radio" name="UseSES" value="0" #doChecked(Request.AppSettings.UseSES,0)# />No</td></tr>

 <!--- Metatag Description --->
	<tr>
		<td align="RIGHT" valign="top">Metatag Description:</td>
		<td></td>
 		<td><textarea name="metadescription" id="metadescription" cols="46" rows="2" class="formfield" wrap="VIRTUAL" onkeyup="CheckFieldLength(metadescription, 'charcount', 'remaining', 255);" onkeydown="CheckFieldLength(metadescription, 'charcount', 'remaining', 255);" onmouseout="CheckFieldLength(metadescription, 'charcount', 'remaining', 255);">#Request.AppSettings.metadescription#</textarea><br/>
		<span class="formtextsmall">Default metatag description for the site, used when none other available.</span><br/>
		<small><span id="charcount">0</span> characters entered.   |   <span id="remaining">20</span> characters remaining.</small><br/>
		</td>
	</tr>
	
<!--- Keywords --->
	<tr>
		<td align="RIGHT" valign="top">Metatag Keywords:</td>
		<td></td>
 		<td><textarea name="Keywords" id="Keywords" cols="46" rows="2" class="formfield" wrap="VIRTUAL" onkeyup="CheckFieldLength(Keywords, 'charcount2', 'remaining2', 255);" onkeydown="CheckFieldLength(Keywords, 'charcount2', 'remaining2', 255);" onmouseout="CheckFieldLength(Keywords, 'charcount2', 'remaining2', 255);">#Request.AppSettings.Keywords#</textarea><br/>
		<span class="formtextsmall">Default metatag keywords for the site, used when none other available.</span><br/>
		<small><span id="charcount2">0</span> characters entered.   |   <span id="remaining2">20</span> characters remaining.</small><br/>
		</td>
	</tr>

<!---- Features ----->
<cfif listfindnocase(StructKeyList(fusebox.circuits),"FEATURE")>
<tr>
	<td align="RIGHT" class="formtitle"><br/>Features&nbsp;</td>
	<td colspan="2"><br/><cfmodule template="../../customtags/putline.cfm" linetype="thin" linecolor="#Request.GetColors.InputHBgcolor#"/></td>
	</tr>
<tr><td align="RIGHT">RootCategory:</td><td></td><td>
<select name="featureRoot" size="1" class="formfield">
<option value="0"></option>
<cfloop query="qry_Get_allCats">
   <option value="#category_id#" #doSelected(Request.AppSettings.featureRoot,category_id)#>#category_id#: #name#</option>
</cfloop>
</select>
</td></tr>
<tr><td align="RIGHT">Max Features:</td><td></td><td>
<cfif Request.AppSettings.Maxfeatures IS NOT 9999>
<cfset Maxfeatures = Request.AppSettings.Maxfeatures>
<cfelse>
<cfset Maxfeatures = "">
</cfif>
<input type="text" name="Maxfeatures" value="#Maxfeatures#" size="5" class="formfield"/>
</td></tr>
</CFIF>


<!---- Products ----->
<cfif listfindnocase(StructKeyList(fusebox.circuits),"PRODUCT")>
<tr>
	<td align="RIGHT" class="formtitle"><br/>Products&nbsp;</td>
	<td colspan="2"><br/><cfmodule template="../../customtags/putline.cfm" linetype="thin" linecolor="#Request.GetColors.InputHBgcolor#"/></td>
	</tr>
	
<tr><td align="RIGHT">RootCategory:</td><td></td><td>
<select name="ProdRoot" size="1" class="formfield">
	<option value="0">Home</option>
<cfloop query="qry_Get_allCats">
   <option value="#category_id#" #doSelected(Request.AppSettings.ProdRoot,category_id)#>#category_id#: #name#</option>
</cfloop>
</select>
</td></tr>
<tr><td align="RIGHT">Max Products:</td><td></td><td>
<cfif Request.AppSettings.MaxProds IS NOT 9999>
<cfset MaxProducts = Request.AppSettings.MaxProds>
<cfelse>
<cfset MaxProducts = "">
</cfif>
<cfif Request.AppSettings.Maxprods IS NOT 9999>
<cfset Maxprods = Request.AppSettings.Maxprods>
<cfelse>
<cfset Maxprods = "">
</cfif>
<input type="text" name="Maxprods" value="#Maxprods#" size="5" validate="integer" message="Maximum number of products must be an integer value!" class="formfield"/></td></tr>

<!---- MoneyUnit -----><!---- WeightUnit ----->
<tr><td align="RIGHT">Units of:</td><td style="background-color: ###Request.GetColors.formreq#;"></td><td>Money:
<input type="text" name="MoneyUnit" value="#Request.AppSettings.MoneyUnit#" size="8" maxlength="50" class="formfield"/> &nbsp; Weight: <input type="text" name="WeightUnit" value="#Request.AppSettings.WeightUnit#" size="8" maxlength="50" class="formfield"/>  &nbsp; Size: <input type="text" name="SizeUnit" value="#Request.AppSettings.SizeUnit#" size="8" maxlength="50" class="formfield"/></td></tr>

<!---- InvLevel ----->
<tr><td align="RIGHT" valign="baseline">Inventory Control:</td><td style="background-color: ###Request.GetColors.formreq#;"></td>
<td><input type="radio" name="InvLevel" value="None" #doChecked(Request.AppSettings.InvLevel,'None')# />None 
&nbsp;<input type="radio" name="InvLevel" value="Store" #doChecked(Request.AppSettings.InvLevel,'Store')# />Store 
&nbsp;<input type="radio" name="InvLevel" value="Admin" #doChecked(Request.AppSettings.InvLevel,'Admin')#/>Admin 
&nbsp;<input type="radio" name="InvLevel" value="Mixed" #doChecked(Request.AppSettings.InvLevel,'Mixed')# />Mixed</td></tr>
<tr><td colspan="2"></td><td valign="top"><span class="formtextsmall">
"Store" subtracts quantities when the order is placed; "Admin" subtracts when the order is filled. "Mixed" subtracts when placed for online, when filled for offline.</span>
</td></tr>

<!--- <tr><td align="RIGHT">Currency Exchange:</td><td style="background-color: ###Request.GetColors.formreq#;"></td><td>  
<select name="CurrExchange" size="1" class="formfield">
<option value="None" #doSelected(Request.AppSettings.CurrExchange,'None')#>None</option>
<cfloop query="getExchanges">
   <option value="#CurrExchange#" #doSelected(Request.AppSettings.CurrExchange,getExchanges.CurrExchange)#>#CurrExchange#</option>
</cfloop>
</select> &nbsp;&nbsp;
Store Label: <input type="text" name="CurrExLabel" value="#Request.AppSettings.CurrExLabel#" size="20" maxlength="30" class="formfield"/>
</td></tr>
<tr><td colspan="2"></td><td valign="top"><span class="formtextsmall">
Used to display a second price for products, using a daily currency exchange rate.</span>
</td></tr> --->

<input type="hidden" name="CurrExchange" value="None">
<input type="hidden" name="CurrExLabel" value="">

<tr><td align="RIGHT">Cache Products:</td><td style="background-color: ###Request.GetColors.formreq#;"></td>
<td><input type="radio" name="CachedProds" value="1" #doChecked(Request.AppSettings.CachedProds)# /> Yes 
&nbsp;&nbsp; <input type="radio" name="CachedProds" value="0" #doChecked(Request.AppSettings.CachedProds,0)# /> No </td></tr>
<tr><td colspan="2"></td><td valign="top"><span class="formtextsmall">
This setting will cache the product queries for improved performance. You will need to manually refresh the cached data using the 'Refresh Cache' admin option after updating or adding products.</span>
</td></tr>

	<!---- ShowInStock ----->
<tr><td align="RIGHT">Show ## in Stock:</td><td style="background-color: ###Request.GetColors.formreq#;"></td>
<td><input type="radio" name="ShowInStock" value="1" #doChecked(Request.AppSettings.ShowInStock)# /> Yes 
&nbsp;&nbsp; <input type="radio" name="ShowInStock" value="0" #doChecked(Request.AppSettings.ShowInStock,0)# /> No </td></tr>	

	<!---- OutofStock ----->	
<tr><td align="RIGHT">Show Out of Stock:</td><td style="background-color: ###Request.GetColors.formreq#;"></td>
<td><input type="radio" name="OutofStock" value="1" #doChecked(Request.AppSettings.OutofStock)# /> Yes 
&nbsp;&nbsp; <input type="radio" name="OutofStock" value="0" #doChecked(Request.AppSettings.OutofStock,0)# /> No </td></tr>

	<!---- ShowRetail ----->
<tr><td align="RIGHT">Show Retail Prices:</td><td style="background-color: ###Request.GetColors.formreq#;"></td>
<td><input type="radio" name="ShowRetail" value="1" #doChecked(Request.AppSettings.ShowRetail)# /> Yes 
&nbsp;&nbsp; <input type="radio" name="ShowRetail" value="0" #doChecked(Request.AppSettings.ShowRetail,0)# /> No </td></tr>


<!--- wishlists ---->
<tr><td align="RIGHT">
Offer Wishlists:</td><td style="background-color: ###Request.GetColors.formreq#;"></td>
<td><input type="radio" name="wishlists" value="1" #doChecked(Request.AppSettings.wishlists)# /> Yes  
&nbsp;&nbsp; <input type="radio" name="wishlists" value="0" #doChecked(Request.AppSettings.wishlists,0)# /> No
</td></tr>

	<!---- ItemSort ----->
<tr><td align="RIGHT">Sort Products By:</td><td style="background-color: ###Request.GetColors.formreq#;"></td>
<td><input type="radio" name="ItemSort" value="SKU" #doChecked(Request.AppSettings.ItemSort,'SKU')# /> SKU 
&nbsp;&nbsp;<input type="radio" name="ItemSort" value="Name" #doChecked(Request.AppSettings.ItemSort,'Name')# /> Name </td></tr>


	<!---- OrderButtonText ----->
<tr><td align="RIGHT">Order Button Text:</td><td style="background-color: ###Request.GetColors.formreq#;"></td><td>
<input type="text" name="OrderButtonText" value="#Request.AppSettings.OrderButtonText#" size="10" maxlength="50" class="formfield"/></td></tr>

	<!---- OrderButtonImage ----->
<tr><td align="RIGHT">Order Button Image:</td><td></td><td>
<input type="text" name="OrderButtonImage" value="#Request.AppSettings.OrderButtonImage#" size="30" maxlength="100" class="formfield"/> <a href="JavaScript: newWindow = openWin('#self#?fuseaction=home.admin&select=image&fieldname=OrderButtonImage&fieldvalue=#Request.AppSettings.OrderButtonImage#', 'images', 'width=520,height=290,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=0,resizable=1'); newWindow.focus()" class="formtextsmall">Image Manager</a> </td></tr>
</CFIF>

<tr>
	<td align="RIGHT" class="formtitle"><br/>Search&nbsp;</td>
	<td colspan="2"><br/><cfmodule template="../../customtags/putline.cfm" linetype="thin" linecolor="#Request.GetColors.InputHBgcolor#"/></td>
	</tr>
<tr><td align="RIGHT">Search Type:</td><td style="background-color: ###Request.GetColors.formreq#;"></td>
<td><input type="radio" name="UseVerity" value="1" #doChecked(Request.AppSettings.UseVerity)# /> Verity &nbsp;&nbsp; <input type="radio" name="UseVerity" value="0" #doChecked(Request.AppSettings.UseVerity,0)# /> Database </td></tr>

	<!---- CollectionName ----->
<tr><td align="RIGHT">
Verity Collection:</td><td></td><td>
<input type="text" name="CollectionName" value="#Request.AppSettings.CollectionName#" size="30" maxlength="100" class="formfield"/>
</td></tr>

<cfif Request.AppSettings.UseVerity is 1>
<tr><td></td>
	<td colspan="2"><input type="submit" name="act_verity" value="Reindex Verity Collection" class="formbutton"/><br/>
		<input type="submit" name="act_verity" value="Optimize Verity Collection" class="formbutton"/></td></tr>
</cfif>


<tr><td>&nbsp;</td><td></td><td><br/><input class="formbutton" type="submit" value="Save Changes"/> 			<input type="button" value="Cancel" onclick="javascript:window.history.go(-1);" class="formbutton"/>
</td></tr>

</form>

</cfoutput>
<cfprocessingdirective suppresswhitespace="no">
<script type="text/javascript">
objForm = new qForm("editform");

objForm.required("sitename,Merchant,HomeCountry,Locale,MerchantEmail,Webmaster,CColumns,PColumns,email_server,email_port,color_id");

objForm.MerchantEmail.validateEmail();
objForm.Webmaster.validateEmail();

objForm.CColumns.validateNumeric();
objForm.PColumns.validateNumeric();
objForm.email_port.validateNumeric();


objForm.sitename.description = "site name";
objForm.Merchant.description = "company address";
objForm.HomeCountry.description = "home country";
objForm.MerchantEmail.description = "company email";
objForm.Webmaster.description = "webmaster email";
objForm.CColumns.description = "default columns for subcategories";
objForm.PColumns.description = "default columns for content";
objForm.email_server.description = "email server";
objForm.email_port.description = "email port";
objForm.color_id.description = "default palette";

//if SMTP username or password entered, require the other
objForm.email_pass.createDependencyTo("email_user");
objForm.email_pass.description = "SMTP password";

objForm.email_user.createDependencyTo("email_pass");
objForm.email_user.description = "SMTP username";




<cfif listfindnocase(StructKeyList(fusebox.circuits),"FEATURE")>
	objForm.Maxfeatures.validateNumeric();
	objForm.Maxfeatures.description = "max features";
</cfif>

<cfif listfindnocase(StructKeyList(fusebox.circuits),"PRODUCT")>
	objForm.required("MoneyUnit,WeightUnit,OrderButtonText");
	objForm.Maxprods.validateNumeric();
	
	objForm.Maxprods.description = "max products";
	objForm.MoneyUnit.description = "unit of money";
	objForm.WeightUnit.description = "unit of weight";
	objForm.OrderButtonText.description = "order button text";
</cfif>

<cfif listfindnocase(StructKeyList(fusebox.circuits),"SEARCH")>
	objForm.CollectionName.createDependencyTo("UseVerity", "1");
	objForm.CollectionName.description = "verity collection";
	objForm.UseVerity.enforceDependency();
</cfif>

qFormAPI.errorColor = "<cfoutput>###Request.GetColors.formreq#</cfoutput>";
</script>
</cfprocessingdirective>

</cfmodule>

