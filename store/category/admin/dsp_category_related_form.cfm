
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This page is used by discounts to add related categories. It lists current related categories with links to edit or remove them, and allows the admin to search and select new categories to add as related. Called by product.admin&discount=category --->

<!---
From Discounts:
<cfset startpath="fuseaction=product.admin&discount=category&discount_id=#attributes.discount_id#">
<cfset box_title="Update Discount - #qry_get_discount.name#">
<cfparam name = "menu" default="../../shopping/admin/discount/dsp_menu.cfm">

---->

<!--- Create the string with the filter parameters --->	
<cfset addedpath="&#startpath#">
	<cfloop list="pid,catcore_id,name,accesskey,display,highlight,sale" index="counter">
		<cfif isdefined('attributes.' & counter) and len(evaluate('attributes.' & counter))>
			<cfset addedpath="#addedpath#&#counter#=" & evaluate('attributes.' & counter)>
		</cfif>
	</cfloop>
	
<cfparam name="currentpage" default="1">
	
<cfinclude template="../../access/admin/accesskey/qry_get_accesskeys.cfm">
<cfinclude template="qry_get_catcores.cfm">
	<cfset catcore_picklist = "">
	<cfloop query="qry_get_catCores">
		<cfset catcore_picklist = ListAppend(catcore_picklist,"#catcore_name#|#catcore_id#")>
	</cfloop>
	
<!--- Create the page through links, max records set by the display count --->	
<cfmodule template="../../customtags/pagethru.cfm" 
		totalrecords="#qry_get_categories.recordcount#" 
		currentpage="#currentpage#"
		templateurl="#self#"
		addedpath="#addedpath##request.token2#"
		displaycount="20"  
		imagepath="#request.appsettings.defaultimages#/icons/" 
		imageheight="12" 
		imagewidth="12"
		hilightcolor="###request.getcolors.mainlink#" 
		>
	
<cfmodule template="../../customtags/format_output_admin.cfm"
	box_title="#box_title#"
	Width="600"
	menutabs="yes">
	
	<cfinclude template="#menu#">

<cfoutput>

<cfif qry_get_category_item.recordcount>
<table width="100%" cellspacing="4" border="0" cellpadding="0" class="formtext" style="color:###Request.GetColors.InputTText#">	
	<tr>
		<td class="formtitle" width="20%"><br/>Currently&nbsp;Related&nbsp;</td>
		<td><br/><cfmodule template="../../customtags/putline.cfm" linetype="thin" linecolor="#Request.GetColors.inputHBgcolor#" /></td>
	</tr>	
</table>
<table width="90%" cellspacing="4" border="0" cellpadding="0" class="formtext"style="color:###Request.GetColors.InputTText#">	
	<cfloop query="qry_get_category_item">
	<tr>
		<td><cfif len(ParentNames)>#Replace(ParentNames, ":", ": ", "ALL")#: </cfif>#name#</td>
		<td>[<a href="#self#?#addedpath#&submit_related=#category_id##Request.Token2#">remove</a>]
		[<a href="#self#?fuseaction=category.admin&category=edit&CID=#category_id##Request.Token2#">edit</a>]
		[<a href="#self#?fuseaction=category.display&category_id=#category_id##Request.Token2#">view</a>]
		</td>
	</tr>		
	</cfloop>
</table>

</cfif>	
	
<table width="100%" cellspacing="4" border="0" cellpadding="0" class="formtext" style="color:###Request.GetColors.InputTText#">	
	<tr>
		<td class="formtitle" width="20%"><br/>Add&nbsp;Related&nbsp;Category&nbsp;</td>
		<td><br/><cfmodule template="../../customtags/putline.cfm" linetype="thin" linecolor="#Request.GetColors.InputHBgcolor#"/></td>
	</tr>	
</table>	

<!-----------Search for more --------------->		
<table width="100%" cellspacing="4" border="0" cellpadding="0" class="formtext" style="color:###Request.GetColors.InputTText#">	

	<tr>
		<td colspan="9"	align="right">#pt_pagethru#</td>
	</tr>

	<form action="#self#?#startpath##request.token2#" method="post">
	
		<tr>
		<td><span class="formtextsmall"><br/></span>
		<input type="submit" value="Search" class="formbutton"/></td>
	
		<td><span class="formtextsmall">name<br/></span>
			<input type="text" name="Name" size="16" maxlength="25" class="formfield" value="#HTMLEditFormat(attributes.Name)#"/></td>		
	
		<td><span class="formtextsmall">template<br/></span>
			<select name="catcore_ID" size="1" class="formfield">
				<option value="">all</option>
				<cfmodule template="../../customtags/form/dropdown.cfm"
				mode="combolist"
				valuelist="#catcore_picklist#"
				selected="#attributes.catcore_id#"
				/></select>
			</td>	
	
		<td><span class="formtextsmall">access key<br/></span>
			<select name="AccessKey" size="1" class="formfield">
				<option value="" #doSelected(attributes.accesskey,'')#>all</option>
				<cfloop query="qry_get_accesskeys">
				<option value="#accesskey_ID#" #doSelected(attributes.accesskey,qry_get_accesskeys.accesskey_ID)#>#name#</option>
				</cfloop>
				</select>		
		</td>	
	
		<td><span class="formtextsmall">display<br/></span>
		<select name="display" class="formfield">
			<option value="">all</option>
			<option value="0" #doSelected(attributes.display,0)#>no</option>
			<option value="1" #doSelected(attributes.display,1)#>yes</option>
		</select></td>	
	
		<td><span class="formtextsmall">new<br/></span>
		<select name="highlight" class="formfield">
			<option value="">all</option>
			<option value="0" #doSelected(attributes.highlight,0)#>no</option>
			<option value="1" #doSelected(attributes.highlight,1)#>yes</option>
		</select></td>	
	
		<td><span class="formtextsmall">sale<br/></span>
		<select name="sale" class="formfield">
			<option value="">all</option>
			<option value="0" #doSelected(attributes.sale,0)#>no</option>
			<option value="1" #doSelected(attributes.sale,1)#>yes</option>
		</select></td>	
		
		<td valign="bottom"><a href="#self#?#startpath##Request.Token2#">ALL</a></td></tr>
		</form>		


<!---- Category Browse --------->		
		<tr>
			<td colspan="8">
			<cfif attributes.pid is not "">
				<cfinclude template="dsp_parent_breadcrumb.cfm">				 
			<cfelse>
				<cfparam name="attributes.separator" default="&raquo;">
				<a href="#self#?pid=0#addedpath##Request.Token2#">Browse Categories</a>
			</cfif>			
			</td>
		</tr>
	
		
		<tr>
			<td colspan="9" style="BACKGROUND-COLOR: ###Request.GetColors.inputHBgcolor#;"><img src="#Request.AppSettings.defaultimages#/spacer.gif" alt="" height="1" width="1" /></td>
		</tr>

	
		<cfif qry_get_categories.recordcount gt 0>		
		<form action="#self#?#addedpath##request.token2#" method="post">			
	
		<cfloop query="qry_get_categories" startrow="#PT_StartRow#" endrow="#PT_EndRow#">
		<cfif not listfind("#valuelist(qry_get_category_item.category_id)#","#category_id#") AND (NOT isDefined("attributes.category_ID") OR qry_get_categories.category_ID IS NOT attributes.category_ID)>
		<tr>
			<td align="center"><input type="checkbox" name="add_related" value="#category_id#"/></td>
			<cfset catlink = REReplaceNoCase(addedpath, "(pid=[0-9]+)", "pid=#category_ID#")>
			<td><a href="#self#?#catlink##Request.Token2#">#Name#&nbsp;#attributes.separator#</a> </td> 
			<td>#Catcore_name#</td>
			<td>#AccessKey_name#</td>
			<td><cfif Display>Yes</cfif></td>
			<td><cfif highlight>Yes</cfif></td>
			<td><cfif Sale>Yes</cfif></td>
			<td><!--- links --->
			
			<a href="#self#?fuseaction=category.display&category_id=#Category_ID##Request.Token2#">view</a>
			</td>

		</tr>
		</cfif>
		</cfloop>	
	</table>
		<div align="center"><input type="submit" name="submit_related" value="Add Categories" class="formbutton"/></div>
		</form>
		
		<div align="right" class="formtext">#pt_pagethru#</div>
	<cfelse>	
		<td colspan="8">
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
	<cfmodule template="../../customtags/putline.cfm" linetype="thin" linecolor="#Request.GetColors.InputHBgcolor#"/><br/>	
		<input type="submit" name="DONE" value="Back to Discount List" class="formbutton"/>
	</form>	
</cfif>
		</td>
    </tr>
	</table> 
</cfoutput>
<!---- CLOSE MODULE ----->
</cfmodule>

		
