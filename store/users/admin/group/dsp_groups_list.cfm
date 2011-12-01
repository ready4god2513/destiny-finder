
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the list of Groups for the admin. Called by users.admin&group=list --->

<!--- Create the string with the filter parameters --->	
<cfset addedpath="&fuseaction=users.admin&group=list">
	<cfloop list="name,description,wholesale,discounts,promotions" index="counter">
	<cfif isdefined('attributes.' & counter) and len(evaluate('attributes.' & counter))>
		<cfset addedpath="#addedpath#&#counter#=" & evaluate('attributes.' & counter)>
	</cfif>
	</cfloop>
		
<cfparam name="currentpage" default="1">

<!--- Create the page through links, max records set to 20 --->	
<cfmodule template="../../../customtags/pagethru.cfm" 
	totalrecords="#qry_get_groups.recordcount#" 
	currentpage="#currentpage#"
	templateurl="#self#"
	addedpath="#addedpath##request.token2#"
	displaycount="20" 
	imagepath="#request.appsettings.defaultimages#/icons/" 
	imageheight="12" 
	imagewidth="12"
	hilightcolor="###request.getcolors.mainlink#" 
	>
			
<!--- Check for permissions link --->
<cfmodule template="../../../access/secure.cfm"
	keyname="access"
	requiredPermission="1"
	>				
	<cfif ispermitted>	
		<cfset display_permission_link = 1>
	<cfelse>
		<cfset display_permission_link = 0>
	</cfif>	

<!--- Check for discounts link --->	
	<cfmodule template="../../../access/secure.cfm"
	keyname="product"
	requiredPermission="4"
	>
	<cfif ispermitted>	
		<cfset display_discount_link = 1>
	<cfelse>
		<cfset display_discount_link = 0>
	</cfif>	

	
<cfmodule template="../../../customtags/format_output_admin.cfm"
	box_title="User Groups"
	width="600"
	>

<cfoutput>
<table width="100%" cellspacing="4" border="0" cellpadding="0" class="formtext" style="color: ###Request.GetColors.OutputTText#;">		

	<tr>
		<td colspan="3">
			<a href="#self#?fuseaction=users.admin&group=add#Request.Token2#">New Group</a></td>
		<td colspan="4" align="right">#pt_pagethru#</td>
	</tr>	
	
	<form action="#self#?fuseaction=users.admin&group=list#request.token2#" method="post">
	
		<tr>
			<td><span class="formtextsmall"><br/></span>
			<input type="submit" value="Search" class="formbutton"/>
			</td>			
	
			<td><span class="formtextsmall">name<br/></span>
			<input type="text" name="name" size="10" maxlength="25" class="formfield" value="#attributes.name#"/>
			</td>				
	
			<td><span class="formtextsmall">description<br/></span>
			<input type="text" name="description" size="20" maxlength="25" class="formfield" value="#attributes.description#"/>
			</td>				
	
			<td><span class="formtextsmall">wholesale<br/></span>
			<select name="wholesale" class="formfield">
			<option value="">all</option>
			<option value="0" #doSelected(attributes.wholesale,0)#>no</option>
			<option value="1" #doSelected(attributes.wholesale,1)#>yes</option>
		</select>	
			</td>	
			
			<td><span class="formtextsmall">discounts<br/></span>
			<select name="discounts" class="formfield">
			<option value="">all</option>
			<option value="0" #doSelected(attributes.discounts,0)#>no</option>
			<option value="1" #doSelected(attributes.discounts,1)#>yes</option>
		</select>	
			</td>	
			
			<td><span class="formtextsmall">promotions<br/></span>
			<select name="promotions" class="formfield">
			<option value="">all</option>
			<option value="0" #doSelected(attributes.promotions,0)#>no</option>
			<option value="1" #doSelected(attributes.promotions,1)#>yes</option>
		</select>	
			</td>					
			
			<td align="center"><br/><a href="#self#?fuseaction=users.admin&group=list#Request.Token2#">ALL</a></td>
		
		</tr>
		</form>		
			
		<tr>
			<td colspan="7" style="BACKGROUND-COLOR: ###Request.GetColors.outputHBgcolor#;">
			<img src="#Request.AppSettings.defaultimages#/spacer.gif" alt="" height="1" width="1" /></td>
		</tr>		
		
<cfif qry_get_groups.recordcount gt 0>
		
	<cfparam name="currentpage" default="1">

		<cfloop query="qry_get_groups" startrow="#PT_StartRow#" endrow="#PT_EndRow#">
			<cfset attributes.gid = group_id>
			<cfinclude template="qry_get_group_discounts.cfm">
			<cfinclude template="qry_get_group_promotions.cfm">
			<tr>
				<td>
			<a href="#self#?fuseaction=users.admin&group=edit&gid=#group_id##Request.Token2#">
			Edit #group_id#</a></td>
			<td colspan="2"><b>#name#</b><br/>#description#</td>
			<td><cfif wholesale is 1>Yes<cfelse>No</cfif></td>
			<td><cfloop index="num" list="#DiscountList#">
			<cfif display_discount_link><a href="#self#?fuseaction=product.admin&discount=edit&discount_id=#num##Request.Token2#">#num#</a><cfelse>#num#</cfif><cfif num is not Listlast(DiscountList)> | </cfif>
				</cfloop>
			</td>
			<td><cfloop index="num" list="#PromotionList#">
			<cfif display_discount_link><a href="#self#?fuseaction=product.admin&promotion=edit&promotion_id=#num##Request.Token2#">#num#</a><cfelse>#num#</cfif><cfif num is not Listlast(PromotionList)> | </cfif>
				</cfloop>
			</td>
			<td><a href="#self#?fuseaction=users.admin&user=list&show=all&gid=#group_id##Request.Token2#">view users</a><br/>
<cfif display_permission_link><a href="#self#?fuseaction=users.admin&group=permissions&gid=#group_id##Request.Token2#">permissions</a></cfif></td>
		</td>
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
	
