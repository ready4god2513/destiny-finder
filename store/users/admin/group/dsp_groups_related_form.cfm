
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This page is used by discounts to add related user groups. It lists current related groups with links to edit or remove them, and allows the admin to select new groups to add as related. Called by product.admin&discount=groups --->

<!---
From Discounts:
<cfset startpath="fuseaction=product.admin&discount=groups&discount_id=#attributes.discount_id#">
<cfset box_title="Update Discount - #qry_get_discount.name#">
<cfparam name = "menu" default="../../../shopping/admin/discount/dsp_menu.cfm">

---->

<cfloop index="namedex" list="name,description,wholesale">
	<cfparam name="attributes.#namedex#" default="">
</cfloop>

<!--- Create the string with the filter parameters --->	
<cfset addedpath="&#startpath#">
	<cfloop list="name,description,wholesale" index="counter">
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
	
<cfmodule template="../../../customtags/format_output_admin.cfm"
	box_title="#box_title#"
	Width="600"
	menutabs="yes">
	
	<cfinclude template="#menu#">

<cfoutput>

<cfif qry_get_disc_groups.recordcount>
<table width="100%" cellspacing="4" border="0" cellpadding="0" class="formtext" style="color:###Request.GetColors.InputTText#">	
	<tr>
		<td class="formtitle" width="20%"><br/>Currently&nbsp;Related&nbsp;</td>
		<td><br/><cfmodule template="../../../customtags/putline.cfm" linetype="thin" linecolor="###Request.GetColors.inputHBgcolor#" /></td>
	</tr>	
</table>
<table width="90%" cellspacing="4" border="0" cellpadding="0" class="formtext"style="color:###Request.GetColors.InputTText#">	
	<cfloop query="qry_get_disc_groups">
	<tr>
		<td>#name#</td>
		<td>[<a href="#self#?#addedpath#&submit_related=#group_id##Request.Token2#">remove</a>]
		[<a href="#self#?fuseaction=users.admin&group=edit&gid=#Group_ID##Request.Token2#">edit</a>]
		</td>
	</tr>		
	</cfloop>
</table>

</cfif>	
	
<table width="100%" cellspacing="4" border="0" cellpadding="0" class="formtext" style="color:###Request.GetColors.InputTText#">	
	<tr>
		<td class="formtitle" width="20%"><br/>Add&nbsp;Related&nbsp;Groups&nbsp;</td>
		<td><br/><cfmodule template="../../../customtags/putline.cfm" linetype="thin" linecolor="#Request.GetColors.InputHBgcolor#"/></td>
	</tr>	
</table>	

<!-----------Search for more --------------->		
<table width="100%" cellspacing="4" border="0" cellpadding="0" class="formtext" style="color:###Request.GetColors.InputTText#">	

	<tr>
		<td colspan="5"	align="right">#pt_pagethru#</td>
	</tr>

	<form action="#self#?#startpath##request.token2#" method="post">
	
		<tr>
		<td align="center"><span class="formtextsmall"><br/></span>
		<input type="submit" value="Search" class="formbutton"/></td>
	
		<td><span class="formtextsmall">name<br/></span>
			<input type="text" name="name" size="20" maxlength="25" class="formfield" value="#attributes.name#"/></td>		
	
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
		
		<td valign="bottom"><a href="#self#?#startpath##Request.Token2#">ALL</a></td></tr>
		</form>		
		
		<tr>
			<td colspan="5" style="BACKGROUND-COLOR: ###Request.GetColors.inputHBgcolor#;">
			<img src="#Request.AppSettings.defaultimages#/spacer.gif" alt="" height="1" width="1" /></td>
		</tr>

	
		<cfif qry_get_groups.recordcount gt 0>		
		<form action="#self#?#addedpath##request.token2#" method="post">			
	
		<cfloop query="qry_get_groups" startrow="#PT_StartRow#" endrow="#PT_EndRow#">
		<cfif not listfind(valuelist(qry_get_disc_groups.group_id),group_id)>
		<tr>
			<td align="center"><input type="checkbox" name="add_related" value="#group_id#"/></td>
			<td colspan="2"><b>#name#</b><br/>#description#</td>
			<td><cfif wholesale is 1>Yes<cfelse>No</cfif></td>
			<td><!--- links --->
			<a href="#self#?fuseaction=users.admin&group=edit&gid=#Group_ID##Request.Token2#">edit</a>
			</td>

		</tr>
		</cfif>
		</cfloop>	
	</table>
		<div align="center"><input type="submit" name="submit_related" value="Add Groups" class="formbutton"/></div>
		</form>
		
		<div align="right" class="formtext">#pt_pagethru#</div>
	<cfelse>	
		<td colspan="5">
		<br/>
		No records selected
		</td>
	</table>	
	</cfif>	
	
	
	
	<table width="100%" cellspacing="4" border="0" cellpadding="0" class="formtext">	
		<tr>
		<td align="center">
<cfif isDefined("attributes.discount")>
<form action="#self#?fuseaction=product.admin&discount=list#request.token2#" method="post">
<cfmodule template="../../../customtags/putline.cfm" linetype="thin" linecolor="#Request.GetColors.InputHBgcolor#"/><br/>	
		<input type="submit" name="DONE" value="Back to Discount List" class="formbutton"/></form>	
<cfelseif isDefined("attributes.promotion")>
<form action="#self#?fuseaction=product.admin&promotion=list#request.token2#" method="post">
<cfmodule template="../../../customtags/putline.cfm" linetype="thin" linecolor="#Request.GetColors.InputHBgcolor#"/><br/>	
		<input type="submit" name="DONE" value="Back to Promotion List" class="formbutton"/></form>	
</cfif>
		</td>
    </tr>
	</table> 
</cfoutput>
<!---- CLOSE MODULE ----->
</cfmodule>

		
