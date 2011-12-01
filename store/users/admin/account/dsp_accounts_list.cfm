
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the list of accounts. The list can be filtered using the search fields.  Called by users.admin&account=list --->

<!--- Create the string with the filter parameters --->	
 <cfset addedpath="&fuseaction=users.admin&account=list">
	<cfloop list="uid,un,customer_id,location,account_name,type1,directory_live" index="counter">
	<cfif isdefined('attributes.' & counter) and len(evaluate('attributes.' & counter))>
		<cfset addedpath="#addedpath#&#counter#=" & evaluate('attributes.' & counter)>
	</cfif>
	</cfloop>

<cfparam name="currentpage" default="1">

<!--- Create the page through links, max records set to 20 --->
<cfmodule template="../../../customtags/pagethru.cfm" 
	totalrecords="#qry_get_accounts.recordcount#" 
	currentpage="#currentpage#"
	templateurl="#self#"
	addedpath="#addedpath##request.token2#"
	displaycount="20" 
	imagepath="#request.appsettings.defaultimages#/icons/" 
	imageheight="12" 
	imagewidth="12"
	hilightcolor="###request.getcolors.mainlink#" 
	>
	
<cfinclude template="../../../queries/qry_getpicklists.cfm">


<cfmodule template="../../../customtags/format_output_admin.cfm"
	box_title="Accounts"
	width="500"
		>

<cfoutput>	
<table width="100%" cellspacing="4" border="0" cellpadding="0" class="formtext" style="color: ###Request.GetColors.OutputTText#;">						

		<tr>
			<td colspan="2">
			<a href="#self#?fuseaction=users.admin&account=add<cfif attributes.uid is not ''>&uid=#attributes.uid#</cfif>#Request.Token2#">
			New Account</a>
			</td>
			<td colspan="5"	align="right">#pt_pagethru#</td>

		</tr>
	<form action="#self#?fuseaction=users.admin&account=list#request.token2#" method="post">

		<tr>
			
			<td><span class="formtextsmall">&nbsp;<br/></span>
			<input type="submit" value="Search" class="formbutton"/>
			</td>
			
			<td>
			<span class="formtextsmall">username</span><br/>
			<input type="text" name="un" size="12" maxlength="25" value="#attributes.un#" class="formfield"/>
			</td>	
	
			<td>
			<span class="formtextsmall">account name</span><br/>
			<input type="text" name="Account_name" size="25" maxlength="25" value="#attributes.Account_name#" class="formfield"/>
			</td>	
			
			<td>
			<span class="formtextsmall">Cust ID</span><br/>
			<input type="text" name="Customer_ID" size="3" maxlength="25" value="#attributes.Customer_ID#" class="formfield"/>
			</td>			
	
			<td>
			<span class="formtextsmall">acct type</span><br/>
			<select name="type1" size="1" class="formfield">
			<option value="">all</option>
			<option value="manufacturer" #doSelected(attributes.type1,"manufacturer")#>manufacturer</option>
			<option value="vendor" #doSelected(attributes.type1,"vendor")#>vendor</option>
			<option value="retailer" #doSelected(attributes.type1,"retailer")#>retailer</option>
			<cfmodule template="../../../customtags/form/dropdown.cfm"
			mode="valuelist"
			valuelist="#qry_getPicklists.acc_type1#"
			selected="#attributes.type1#"
			/>
            </select>
			</td>		
			
			<td>
			<span class="formtextsmall">directory</span><br/>
			<select name="directory_live" size="1" class="formfield">
				<option value="">all</option>
				<option value="1" #doSelected(attributes.directory_live,1)#>yes</option>
				<option value="0" #doSelected(attributes.directory_live,0)#>no</option>
            </select>
			</td>					
			</form>
				
			<td><span class="formtextsmall">&nbsp;<br/></span>
			<a href="#self#?fuseaction=users.admin&account=list#Request.Token2#">All</a>
			</td>			
		</tr>

		<tr>
			<td colspan="7" style="BACKGROUND-COLOR: ###Request.GetColors.outputHBgcolor#;">
			<img src="#Request.AppSettings.defaultimages#/spacer.gif" alt="" height="1" width="1" /></td>
		</tr>
	
	<cfif qry_get_Accounts.recordcount gt 0>
	
		<cfloop query="qry_get_Accounts" startrow="#PT_StartRow#" endrow="#PT_EndRow#">
		
		<tr>		
			<td>
				<a href="#self#?fuseaction=users.admin&account=edit&account_ID=#account_ID##Request.Token2#">
				Edit #Account_ID#</a></td>
		
			<td><a href="#self#?fuseaction=users.admin&user=edit&uid=#user_id##Request.Token2#">#un#</a>
				</td>
				
			<td>#account_name#</td>
			
			<td><a href="#self#?fuseaction=users.admin&customer=edit&customer_id=#customer_id##Request.Token2#">#customer_id#</a></td>
			
			<td>#type1#</td>
			<td><cfif directory_live is 1>Yes<cfelse>No</cfif></td>
			
			
			<td></td>
			</tr>
			</cfloop>
			</table>
			<div align="center" class="formtext">#pt_pagethru#</div>
			
		<cfelse>	
			<td colspan="7">
			<br/>
			No records selected
			</td>
			</table>	
		</cfif>

</cfoutput>
</cfmodule>
	
		
		
