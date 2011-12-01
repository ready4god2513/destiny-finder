
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Saves the UserSettings. Called from users.admin&settings=save. --->

<cfmodule template="../../../customtags/intlchar.cfm" string="#Trim(attributes.TermsText)#">
<cfset TermsText = String>

<cfset AffPercent = iif(isNumeric(attributes.AffPercent), Evaluate(DE('#attributes.AffPercent#/100')), 0)>

<cfquery name="EditUserSettings" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	UPDATE #Request.DB_Prefix#UserSettings
	SET UseRememberMe = #attributes.UseRememberMe#,
	EmailAsName = #attributes.EmailAsName#,
	StrictLogins = #attributes.StrictLogins#,
	MaxDailyLogins = #iif(isNumeric(attributes.MaxDailyLogins), attributes.MaxDailyLogins, 0)#,
	MaxFailures = #iif(isNumeric(attributes.MaxFailures), attributes.MaxFailures, 0)#,
	UseStateList = #attributes.UseStateList#,
	UseStateBox = #attributes.UseStateBox#,
	RequireCounty = #attributes.RequireCounty#,
	UseCountryList = #attributes.UseCountryList#,
	UseResidential = #attributes.UseResidential#,
	UseGroupCode = #attributes.UseGroupCode#,
	UseBirthdate = #attributes.UseBirthdate#,
	UseTerms = #attributes.UseTerms#,
	TermsText = '#TermsText#',
	UseCCard = #attributes.UseCCard#,
	UseEmailConf = #attributes.UseEmailConf#,
	UseEmailNotif = #attributes.UseEmailNotif#,
	MemberNotify = #attributes.MemberNotify#,
	AllowAffs = #attributes.allowaffs#,
	AffPercent = <cfqueryparam value="#AffPercent#" cfsqltype="CF_SQL_DOUBLE">,
	AllowWholesale = #attributes.allowWholesale#,
	UseShipTo = #attributes.UseShipTo#,
	UseAccounts = #attributes.UseAccounts#,
	ShowAccount = #attributes.ShowAccount#,
	ShowDirectory = #attributes.ShowDirectory#,
	ShowSubscribe = #attributes.ShowSubscribe#
</cfquery>

<!--- Get New Settings --->
<cfset Request.Cache = CreateTimeSpan(0, 0, 0, 0)>
<cfinclude template="../../qry_get_user_settings.cfm">



