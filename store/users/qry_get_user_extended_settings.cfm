
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This query gets the User CC Extended Settings --->
<!---  NOTES:	Currently these extended settings only work with the Shift $$$ ON THE NET gateway. Because of this, these settings are
				defaulted to the values required to allow for unaltered behavior if any of the other gateways are used. Eventually, these
				settings should be moved to the standard User Settings section. --->

<cfif not IsDefined("get_User_Extended_Settings")>
	<!--- these are the defaults for everyone - these settings emulate the original store functionality --->
	<cfscript>
		get_User_Extended_Settings								= StructNew();
		get_User_Extended_Settings.UserCCardEdit				= 1;	// used to show or hide the credit card "Update" button on the My Account page
		get_User_Extended_Settings.UserCCardDelete				= 0;	// used to show or hide the credit card "Delete" button on the My Account page
		get_User_Extended_Settings.UserCCardOnTheFlyUpdate		= 0;	// used to display the "Save/Update credit card on file" checkbox during the checkout process
	</cfscript>
	<cfif not IsDefined("get_Order_Settings")>
		<cfinclude template="../shopping/qry_get_order_settings.cfm">
	</cfif>
	<cfif get_Order_Settings.CCProcess IS "Shift4OTN">
		<cfif not IsDefined("get_Shift4OTN_Settings")>
			<cfinclude template="../shopping/checkout/creditcards/qry_get_Shift4OTN_Settings.cfm">
		</cfif>
		<cfscript>
			get_User_Extended_Settings.UserCCardEdit				= get_Shift4OTN_Settings.UserCCardEdit;
			get_User_Extended_Settings.UserCCardDelete				= get_Shift4OTN_Settings.UserCCardDelete;
			get_User_Extended_Settings.UserCCardOnTheFlyUpdate		= get_Shift4OTN_Settings.UserCCardOnTheFlyUpdate;
		</cfscript>
	</cfif>
</cfif>


