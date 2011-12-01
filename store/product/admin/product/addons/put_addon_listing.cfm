
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Used to display the current addons for a product, with buttons to edit or delete the addon. Called from product\admin\product\dsp_addons_form.cfm --->

<!--- Default is to not show edit buttons --->
<cfparam name="Edit" default="No">

<!--- Initialize counter for Addons --->
<cfset Addoncount = 0>

<cfif NOT Compare(Edit, "No")>
		<cfoutput><td></cfoutput>
</cfif>


<!--- This entire page runs for each Addon --->
<cfloop query="qry_Get_Addons">

	<!--- Increment counter for options --->
	<cfset Addoncount = Addoncount + 1>

	<cfset Addonnum = qry_get_Addons.Addon_ID>

	<!--- Get the Addon prompt and type --->
	<cfif qry_get_Addons.Standard_ID IS 0>
		<cfset UserPrompt = qry_get_Addons.Prompt>
		<cfset DisplayType = qry_get_Addons.AddonType>
		<cfset StandAddon = 0>
	<cfelse>
		<cfset UserPrompt = qry_get_Addons.Std_Prompt>
		<cfset DisplayType = qry_get_Addons.Std_Type>
		<cfset StandAddon = 1>
	</cfif>

	<cfif NOT Compare(Edit, "Yes")>
		<cfoutput><td width="30%"></td><td align="left"></cfoutput>
	<cfelseif Addoncount MOD 4 IS 0>
		<cfoutput></td></tr><tr><td></td><td></cfoutput>
	</cfif>

	<cfoutput>
	<cfif DisplayType IS "textbox">
		#UserPrompt#<br/>
		<input type="text" name="Prompt" value="" size="15" maxlength="150"/>
	<cfelseif DisplayType IS "calendar">
		#UserPrompt#: 
		<input type="text" name="Prompt" value="" size="15" maxlength="150" class="formfield"/> <img src="#Request.Appsettings.DefaultImages#/icons/Calendar2.gif" alt="" width="16" height="16" border="0" align="top" />
	<cfelseif DisplayType IS "checkbox">
		<input type="checkbox" name="Prompt" value=""/>#UserPrompt# 
	<cfelseif DisplayType IS "quantity">
		<input type="text" name="Prompt" value="" size="3" maxlength="100"/>#UserPrompt#
	<cfelseif DisplayType IS "textfield">
	#UserPrompt#<br/>
		<textarea cols="25" rows="5" name="Prompt"></textarea>	
	</cfif>
	</cfoutput>
	
	<cfif NOT Compare(Edit, "Yes")>

		<!--- If form for editing addons, display button to edit the addon. Each button is named with the addon number --->
		<cfoutput></td><td><input type="submit" value="Edit" onclick="setAddon(#Addonnum#,#StandAddon#,'Edit')" class="formbutton"/>
		<input type="submit" value="Delete" onclick="setAddon(#Addonnum#,#StandAddon#,'Delete')" class="formbutton"/></td></tr></cfoutput>
	</cfif>

</cfloop>

<cfif NOT Compare(Edit, "No")>
	<cfoutput></td></cfoutput>
</cfif>


