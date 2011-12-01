
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the list of users for the admin. Called by users.admin&user=list --->

<!--- Create the string with the filter parameters --->	
<cfset addedpath="&fuseaction=users.admin&user=list">
	<cfloop list="uid,un,email,email_bad,subscribe,affiliate,cid,gid,account_id,birthdate,CardisValid,currentbalance,show" index="counter">
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
	addedpath="#addedpath#"
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
	
<cfmodule template="../../../customtags/format_output_admin.cfm"
	box_title="Users"
	width="680"
		>
		
<cfoutput>	
<table width="100%" cellspacing="4" border="0" cellpadding="0" class="formtext" style="color: ###Request.GetColors.OutputTText#;">		


	<tr>
		<td colspan="4">
			<a href="#self#?fuseaction=users.admin&user=add#Request.Token2#">New User</a> | <a href="#self#?#replace(addedpath,"list","listform")##Request.Token2#">Edit Form</a></td>
		<td colspan="4"	align="right">#pt_pagethru#</td>
	</tr>
		
<form action="#self#?fuseaction=users.admin&user=list#request.token2#" method="post">

		<input type="hidden" name="show" value="all"/>
		<tr>
			<td><span class="formtextsmall"><br/></span>
			<input type="submit" value="Search" class="formbutton"/>
			</td>
					
		<td><span class="formtextsmall">username<br/></span>
			<input type="text" name="un" size="8" maxlength="25" class="formfield" value="#attributes.un#"/>
			</td>	
					
		<td><span class="formtextsmall">email<br/></span>
			<input type="text" name="email" size="18" maxlength="25" class="formfield" value="#attributes.email#"/>
			<select name="email_bad" class="formfield">
			<option value="">all</option>
			<option value="good" #doSelected(attributes.email_bad,"good")#>good</option>
			<option value="lock" #doSelected(attributes.email_bad,"lock")#>lock</option>
			<option value="bad" #doSelected(attributes.email_bad,"bad")#>bad</option>
		</select>	
			</td>	
		
<!--- 		<td><span class="formtextsmall">subscr<br/></span>
		<select name="subscribe" class="formfield">
			<option value="">all</option>
			<option value="0" #doSelected(attributes.subscribe,0)#>no</option>
			<option value="1" #doSelected(attributes.subscribe,1)#>yes</option>
		</select>	
			</td>	 --->
			
		<td><span class="formtextsmall">affiliate<br/></span>
		<select name="affiliate" class="formfield">
			<option value="">all</option>
			<option value="0" #doSelected(attributes.affiliate,0)#>no</option>
			<option value="1" #doSelected(attributes.affiliate,1)#>yes</option>
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
			<input type="text" name="cid" size="4" maxlength="25" class="formfield" value="#attributes.cid#"/>
			</td>	
		
		<td>
			<span class="formtextsmall">acct<br/></span>
			<input type="text" name="account_id" size="2" maxlength="25" class="formfield" value="#attributes.account_id#"/>
			</td>					
						
			</form>
	
		<td align="center"><span class="formtextsmall">&nbsp;<br/></span>
			<a href="#self#?fuseaction=users.admin&user=list&show=All#Request.Token2#">ALL</a><br/> <a href="#self#?fuseaction=users.admin&user=list&show=recent#Request.Token2#">Recent</a>
			</td>	
	</tr>
	
	<tr>
	<td colspan="8"><cfif attributes.show IS "recent">Recent Activity<cfelseif attributes.show IS "All">All Users</cfif></td>
	</tr>
		
	<tr>
			<td colspan="8" style="BACKGROUND-COLOR: ###Request.GetColors.outputHBgcolor#;">
			<img src="#Request.AppSettings.defaultimages#/spacer.gif" alt="" height="1" width="1" /></td>
	</tr>
		
		
	<cfif qry_get_users.recordcount gt 0>
		
		<cfloop query="qry_get_users" startrow="#PT_StartRow#" endrow="#PT_EndRow#">
		<tr>
			<td><a href="#self#?fuseaction=users.admin&user=edit&uid=#user_id##Request.Token2#">
				Edit #user_id#</a></td>
				
		<cfif username is email>
			<td colspan="2" <cfif emaillock is not "verified" and emaillock is not "">bgcolor="yellow"<cfelseif emailisbad is "1">bgcolor="red"</cfif>>
				<a href="#self#?fuseaction=users.admin&user=summary&UID=#user_id##Request.Token2#">#email#</a></td>		
		<cfelse>
			<td<cfif disable is "1"> bgcolor="red"</cfif>><a href="#self#?fuseaction=users.admin&user=summary&UID=#user_id##Request.Token2#">#username#</a></td>
			<td	<cfif emaillock is not "verified" and emaillock is not "">bgcolor="yellow"<cfelseif emailisbad is "1">bgcolor="red"</cfif>><a href="#self#?fuseaction=users.admin&email=write&UID=#user_id##Request.Token2#">#email#</a> </td>
		</cfif>		

			<!--- <td><cfif subscribe is 1>Yes<cfelse>No</cfif></td> --->
			
			<td><cfif affiliate_ID is NOT 0>Yes<cfelse>No</cfif></td>
						
			<cfif group_id>
			<td>
				<a href="#self#?fuseaction=users.admin&group=list&gid=#group_id##Request.Token2#">#groupname#</a>
			</td>
			<cfelse>
			<form action="#self#?fuseaction=users.admin&user=list#request.token2#" method="post" target="_self">
			<input type="hidden" name="assign" value="#user_ID#"/>
			<input type="hidden" name="addedpath" value="#addedpath#"/>
			<td>
				<select name="newgroup" size="1" class="formfield" onChange="submit()">
				<option value="">assign group...</option>
				<cfmodule template="../../../customtags/form/dropdown.cfm"
				mode="combolist"
				valuelist="#group_picklist#"
				selected="#attributes.gid#"
				/></select>
			</td>
			</form>
			</cfif>			

			<td align="center"><a href="#self#?fuseaction=users.admin&customer=list&uid=#User_id#&show=#Request.Token2#">#customer_id# | #shipto# </a></td>
	
			<td align="center"><a href="#self#?fuseaction=users.admin&account=list&uid=#User_ID##Request.Token2#">#accounts#</a></td>

			<td class="formtextsmall">
			<a href="#self#?fuseaction=users.admin&user=affiliate&uid=#User_id##Request.Token2#">affiliate</a><br/>
			<cfif display_permission_link>
			<a href="#self#?fuseaction=users.admin&user=permissions&uid=#User_id##Request.Token2#">permissions</a></cfif>
			</td>
			</td>
			</tr>
			</cfloop>
			</table>
			<div align="center" class="formtext">#pt_pagethru#</div>
		<cfelse>	
			<td colspan="8">
			<br/>
			No records selected
			</td>
			</table>	
		</cfif>

</cfoutput>
</cfmodule>