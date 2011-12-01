
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the form to edit a list of users. Called by the fuseaction 
users.admin&user=listform --->

<!--- Create the string with the filter parameters --->	
<cfset addedpath="&fuseaction=users.admin&user=#attributes.user#">
<cfloop list="uid,un,email,email_bad,subscribe,cid,gid,account_id,birthdate,CardisValid,currentbalance,show" index="counter">
	<cfif isdefined('attributes.' & counter) and len(evaluate('attributes.' & counter))>
		<cfset addedpath="#addedpath#&#counter#=" & evaluate('attributes.' & counter)>
	</cfif>
</cfloop>

<!--- Get lists needed for filter select boxes --->
<cfinclude template="../../../queries/qry_getpicklists.cfm">
<cfinclude template="../group/qry_get_all_groups.cfm">
<cfset group_picklist = "">
	<cfloop query="qry_get_all_groups">
		<cfset group_picklist = ListAppend(group_picklist, 
		"#name#|#group_id#")>
	</cfloop>

<cfparam name="currentpage" default="1">

<!--- Create the page through links, max records set to 20 --->
<cfmodule template="../../../customtags/pagethru.cfm" 
	totalrecords="#qry_get_users.recordcount#" 
	currentpage="#currentpage#"
	templateurl="#self#"
	addedpath="#addedpath##request.token2#"
	displaycount="20" 
	imagepath="#request.appsettings.defaultimages#/icons/" 
	imageheight="12" 
	imagewidth="12"
	hilightcolor="###request.getcolors.mainlink#" 
	>
	
	
<cfmodule template="../../../access/secure.cfm"
	keyname="access"
	requiredPermission="1"
	>				
	<cfif ispermitted>	
		<cfset display_permission_link = 1>
	<cfelse>
		<cfset display_permission_link = 0>
	</cfif>	
		
	
<cfprocessingdirective suppresswhitespace="no">
<script type="text/javascript">
function batchdelete() {
if (window.confirm("Are you sure you want to continue? Deletions cannot be undone!")) 
	{  document.editform.Action.value = "Delete";
		document.editform.submit();
	} 
   }
</script>
</cfprocessingdirective>

			
<cfmodule template="../../../customtags/format_admin_form.cfm"
	box_title="Users"
	width="675"
	required_fields="0"
		>

<cfoutput>	

	<tr>
		<td colspan="6">
			<a href="#self#?fuseaction=users.admin&user=add#Request.Token2#">New User</a> | <a href="#self#?#replace(addedpath,"listform","list")##Request.Token2#">List View</a></td>
		<td colspan="6"
		align="right">#pt_pagethru#</td>
	</tr>
		
<form action="#self#?fuseaction=users.admin&user=listform#request.token2#" method="post">
<input type="hidden" name="show" value="all"/>

		<tr>
			<td><span class="formtextsmall"><br/></span>
			<input type="submit" value="Search" class="formbutton"/>
			</td>
					
		<td><span class="formtextsmall">username<br/></span>
			<input type="text" name="un" size="8" maxlength="25" class="formfield" value="#attributes.un#"/>
			</td>	
					
		<td><span class="formtextsmall">email<br/></span>
			<input type="text" name="email" size="16" maxlength="25" class="formfield" value="#attributes.email#"/>
			<select name="email_bad" class="formfield">
			<option value="">all</option>
			<option value="good" #doSelected(attributes.email_bad,"good")#>good</option>
			<option value="lock" #doSelected(attributes.email_bad,"lock")#>lock</option>
			<option value="bad" #doSelected(attributes.email_bad,"bad")#>bad</option>
		</select>	
			</td>	
		
		<td><span class="formtextsmall">subscr<br/></span>
		<select name="subscribe" class="formfield">
			<option value="">all</option>
			<option value="0" #doSelected(attributes.subscribe,0)#>no</option>
			<option value="1" #doSelected(attributes.subscribe,1)#>yes</option>
		</select>	
			</td>	
			
		<td><span class="formtextsmall">group<br/></span>
			<select name="gid" size="1" class="formfield">
				<option value="">all</option>
				<option value="0">unassigned</option>
				<cfmodule template="../../../customtags/form/dropdown.cfm"
				mode="combolist"
				valuelist="#group_picklist#"
				selected="#attributes.gid#"
				/></select>
			</td>	
				
		<td><span class="formtextsmall">bill | ship<br/></span>
			<input type="text" name="cid" size="7" maxlength="25" class="formfield" value="#attributes.cid#"/>
			</td>	

		</form>
					
	
		<td align="center"><span class="formtextsmall">&nbsp;<br/></span>
			<a href="#self#?fuseaction=users.admin&user=listform&show=All#Request.Token2#">ALL</a><br/> <a href="#self#?fuseaction=users.admin&user=listform&show=recent#Request.Token2#">Recent</a>
			</td>	
	</tr>
	
	<tr>
	<td colspan="8"><cfif attributes.show IS "recent">Recent Activity<cfelseif attributes.show IS "All">All Users</cfif></td>
	</tr>
	
	<tr>
		<td colspan="8" style="BACKGROUND-COLOR: ###Request.GetColors.inputHBgcolor#;">
		<img src="#Request.AppSettings.defaultimages#/spacer.gif" alt="" height="1" width="1" /></td>
	</tr>
			
	
	<!--- Make list of User IDs to send to next page --->
	<cfset UserList = "">

	<form name="editform" action="#self#?#replace(addedpath,"listform","actform")##request.token2#" method="post">
	<input type="hidden" name="Action" value="Move"/>
	
	<cfif qry_get_users.recordcount gt 0>
		
		<cfloop query="qry_get_users" startrow="#PT_StartRow#" endrow="#PT_EndRow#">
		<!--- Add the user ID to the list --->
		<cfset UserList = ListAppend(UserList, user_ID)>
		<tr>
			<td><a href="#self#?fuseaction=users.admin&user=edit&uid=#user_id##Request.Token2#">
				 Edit #user_id#</a></td>
			<td<cfif disable is "1"> bgcolor="red"</cfif>>#username#</td>
			<td	<cfif emaillock is not "verified" and emaillock is not "">bgcolor="yellow"<cfelseif emailisbad is "1">bgcolor="red"</cfif>>#firstname# #lastname#
			<td><cfif subscribe is 1>Yes<cfelse>No</cfif></td>
			<td><input type="checkbox" name="User_ID#User_ID#" value="1"/> <a href="#self#?fuseaction=users.admin&group=list&gid=#group_id##Request.Token2#">#groupname#</a></td>
			<td><a href="#self#?fuseaction=users.admin&customer=list&uid=#User_id##Request.Token2#">#customer_id# | #shipto# </a></td>
			<td class="formtextsmall">
			<a href="#self#?fuseaction=users.admin&user=affiliate&uid=#User_id##Request.Token2#">affiliate</a><br/>
<cfif display_permission_link>
			<a href="#self#?fuseaction=users.admin&user=permissions&uid=#User_id##Request.Token2#">permissions</a></cfif>
			</td>
			</td>
			</tr>
			</cfloop>
			
			<tr>
			<td colspan="12" align="center">
			<div align="right">#pt_pagethru#</div>
			<input type="submit" value="Batch Move" class="formbutton"/> 
			<input type="button" value="Batch Delete" onclick="batchdelete()" class="formbutton"/>
			</td>
		</tr>
			<input type="hidden" name="UserList" value="#UserList#"/>
				</form>
		<cfelse>	
		<tr>
			<td colspan="12">
			<br/>
			No records selected
			</td>
		</tr>
		</cfif>

</cfoutput>
</cfmodule>