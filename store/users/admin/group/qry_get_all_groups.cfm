
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Gets list of all Groups used in various admin pages. Called from: 		
	shopping\admin\discount\act_discount.cfm
	users\admin\email\dsp_email.cfm
	users\admin\email\dsp_select_form.cfm
	users\admin\user\act_users_list_form.cfm
	users\admin\user\dsp_users_list_form.cfm
	users\admin\user\dsp_users_list.cfm
	users\admin\user\dsp_user_form.cfm --->

<cfquery name="qry_get_all_groups"   datasource="#Request.ds#"	 username="#Request.user#"  password="#Request.pass#" >
	SELECT * FROM #Request.DB_Prefix#Groups
</cfquery>
		


