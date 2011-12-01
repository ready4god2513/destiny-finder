
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the list of categories. Called by category.admin&category=list --->


<cfparam name="attributes.displaycount" default="20">
<cfparam name="attributes.separator" default="&raquo;">

<!--- Create the string with the filter parameters --->	
<cfset addedpath="&fuseaction=category.admin&category=#attributes.category#">
<cfloop list="pid,cid,catcore_id,name,accesskey,display,highlight,sale" index="counter">
	<cfif isdefined('attributes.' & counter) and len(evaluate('attributes.' & counter))>
		<cfset addedpath="#addedpath#&#counter#=" & evaluate('attributes.' & counter)>
	</cfif>
</cfloop>
<cfparam name="currentpage" default="1">

<cfinclude template="../../access/admin/accesskey/qry_get_accesskeys.cfm">
<cfinclude template="qry_get_catcores.cfm">
	<cfset catcore_picklist = "">
	<cfloop query="qry_get_catCores">
		<cfset catcore_picklist = ListAppend(catcore_picklist, 
		"#catcore_name#|#catcore_id#")>
	</cfloop>
	
<!--- Create the page through links, max records set by the display count --->	
<cfmodule template="../../customtags/pagethru.cfm" 
		totalrecords="#qry_get_categories.recordcount#" 
		currentpage="#currentpage#"
		templateurl="#self#"
		addedpath="#addedpath##request.token2#"
		displaycount="#attributes.displaycount#"  
		imagepath="#request.appsettings.defaultimages#/icons/" 
		imageheight="12" 
		imagewidth="12"
		hilightcolor="###request.getcolors.mainlink#" 
		>
			

<cfmodule template="../../customtags/format_output_admin.cfm"
	box_title="Categories Manager"
	width="700"
	>



	<cfoutput>		
<table width="100%" cellspacing="4" border="0" cellpadding="0" class="formtext" style="color: ###Request.GetColors.OutputTText#;">	

	<tr>
		<td colspan="4">
			<a href="#self#?#replace(addedpath,"list","listform")##request.token2#">Edit Form</a>
		</td>
		<td colspan="4"
		align="right">#pt_pagethru#</td>
	</tr>

	<form action="#self#?fuseaction=Category.admin&Category=list#request.token2#" method="post">
	
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
		
		<td valign="bottom"><a href="#self#?fuseaction=Category.admin&Category=list#Request.Token2#">ALL</a></td></tr>
		</form>
		
		<tr>
			<td colspan="8">
			<cfif attributes.pid is not "">
				<a href="#self#?fuseaction=category.admin&Category=add&PID=#attributes.pid##Request.Token2#">Add</a> category under
				<cfinclude template="dsp_parent_breadcrumb.cfm">
				 
			<cfelse>
				<a href="#self#?pid=0#addedpath##Request.Token2#">Browse Categories</a>
			</cfif>			
			</td>
		</tr>
		
		<tr>
			<td colspan="8" style="BACKGROUND-COLOR: ###Request.GetColors.outputHBgcolor#;"><img src="#Request.AppSettings.defaultimages#/spacer.gif" alt="" height="1" width="1" /></td>
		</tr>
		
	<cfif qry_get_categories.recordcount gt 0>					
	
		<cfloop query="qry_get_categories" startrow="#PT_StartRow#" endrow="#PT_EndRow#">
		<tr>
			<td><a href="#self#?fuseaction=Category.admin&Category=edit&CID=#Category_ID##Request.Token2#">
			Edit #Category_ID#</a></td>
		
			<td><a href="#self#?fuseaction=category.admin&category=list&pid=#Category_ID##Request.Token2#">#Name#&nbsp;#attributes.separator#</a> </td> 
			<td>#Catcore_name#</td>
			<td>#AccessKey_name#</td>
			<td><cfif Display>Yes</cfif></td>
			<td><cfif highlight>Yes</cfif></td>
			<td><cfif Sale>Yes</cfif></td>
			<td><!--- links --->
			
			<a href="#self#?fuseaction=category.display&category_id=#Category_ID##Request.Token2#" target="store">view</a>
			</td>

		</tr>
		</cfloop>	
	</table>
		
		<div align="right" class="formtext">#pt_pagethru#</div>
		
	<cfelse>	
		<td colspan="8">
		<br/>
		No records selected
		</td>
	</table>	
	</cfif>
</cfoutput>
</cfmodule>

		
