
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the List Edit form for categories. This page is used to make common changes to multiple categories at one time. Called by category.admin&category=listform --->

<cfparam name="attributes.displaycount" default="20">
<cfparam name="attributes.pid" default="">
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
		<cfset catcore_picklist = ListAppend(catcore_picklist,"#catcore_name#|#catcore_id#")>
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
	
	
		
<cfmodule template="../../customtags/format_admin_form.cfm"
	box_title="Categories Manager"
	width="600"
	required_fields="0"
	>

<cfoutput>	
	<tr>
		<td colspan="4">
			<a href="#self#?#replace(addedpath,"listform","list")#">List View</a>
		</td>
		<td colspan="5"
		align="right">#pt_pagethru#</td>
	</tr>

	<form name="searchform" action="#self#?fuseaction=Category.admin&Category=listform#request.token2#" method="post">
	
	<tr>
		<td><span class="formtextsmall"><br/></span>
		<input type="submit" value="Search" class="formbutton"/></td>
	
		<td><span class="formtextsmall">name<br/></span>
			<input type="text" name="Name" size="16" maxlength="25" class="formfield" value="#HTMLEditFormat(attributes.Name)#"/></td>	
	
		<td colspan="2"><span class="formtextsmall">content<br/></span>
			<select name="catcore_ID" size="1" class="formfield">
				<option value="">all</option>
				<cfmodule template="../../customtags/form/dropdown.cfm"
				mode="combolist"
				valuelist="#catcore_picklist#"
				selected="#attributes.catcore_id#" />
			</select>
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
		
		<td valign="bottom"><a href="#self#?fuseaction=Category.admin&Category=listform#Request.Token2#">ALL</a></td></tr>
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
			<td colspan="9" style="BACKGROUND-COLOR: ###Request.GetColors.inputHBgcolor#;"><img src="#Request.AppSettings.defaultimages#/spacer.gif" alt="" height="1" width="1" /></td>
		</tr>
	<tr>
		<th>Edit</th>
		<th>Category</th>
		<th align="center" width="30%">Priority</th>
		<th align="center" width="30%" nowrap="nowrap">Cols for<br/> Subcats</th>
		<th align="center" width="30%" nowrap="nowrap">Cols for<br/> Content</th>
		<th align="center" width="3%">Display</th>
		<th align="center" width="3%">New</th>
		<th align="center" width="3%" nowrap="nowrap">Sale</th>
		<th align="center" width="3%" nowrap="nowrap"></th>			
		</tr>
		
<!--- Make list of category nums to send to next page --->
<cfset CategoryList = "">

<form name="editform" action="#self#?#replace(addedpath,"listform","actform")##request.token2#" method="post">
		
<cfif qry_get_categories.recordcount gt 0>					
	<cfloop query="qry_get_categories" startrow="#PT_StartRow#"  endrow="#PT_EndRow#">
	<!--- Add category ID to the list --->
	<cfset CategoryList = ListAppend(CategoryList, Category_ID)>
		<tr>
			<td><a href="#self#?fuseaction=Category.admin&Category=edit&CID=#Category_ID##Request.Token2#">
			Edit #Category_ID#</a></td>
		
			<td><a href="#self#?fuseaction=category.admin&category=list&pid=#Category_ID##Request.Token2#">#Name#&nbsp;#attributes.separator#</a></td>
<td align="center"><input type="text" name="Priority#Category_ID#" value="#doPriority(Priority,0)#" size="3" maxlength="15" class="formfield"/></td>
<td align="center"><input type="text" name="CColumns#Category_ID#" value="#CColumns#" size="3" maxlength="15" class="formfield"/></td>
<td align="center"><input type="text" name="PColumns#Category_ID#" value="#PColumns#" size="3" maxlength="15" class="formfield"/></td>
<td align="center"><input type="checkbox" name="Display#Category_ID#" value="1" #doChecked(Display)#/></td>
<td align="center"><input type="checkbox" name="Highlight#Category_ID#" value="1" #doChecked(Highlight)#/></td>
<td align="center"><input type="checkbox" name="Sale#Category_ID#" value="1" #doChecked(Sale)#/></td>
			<td><!--- links --->
			
			<a href="#self#?fuseaction=category.display&category_id=#Category_ID##Request.Token2#" target="store">view</a>
			</td>
		</tr>
		</cfloop>	
	<tr>
		<td colspan="9" align="center">
		<div align="right">#pt_pagethru#</div>
		<input type="hidden" name="CategoryList" value="#CategoryList#"/>
		<input type="submit" name="Action" value="Save Changes" class="formbutton"/>
		</td>
	</tr>
</form>

	
<cfprocessingdirective suppresswhitespace="no">
<script type="text/javascript">

objForm = new qForm("editform");

<cfloop index="Category_ID" list="#CategoryList#">
	objForm.Priority#Category_ID#.description = "priority number #category_id#";
	objForm.PColumns#Category_ID#.description = "content columns #category_id#";
	objForm.CColumns#Category_ID#.description = "sub-category columns #category_id#";
</cfloop>

<cfloop index="Category_ID" list="#CategoryList#">
	objForm.Priority#Category_ID#.validateNumeric();
	objForm.Priority#Category_ID#.validateRange('0','9999');
	objForm.PColumns#Category_ID#.validateRange('1','6');
	objForm.CColumns#Category_ID#.validateRange('1','6');
</cfloop>

qFormAPI.errorColor = "###Request.GetColors.formreq#";

</script>
</cfprocessingdirective>


	<cfelse>	
	<tr>
		<td colspan="9">
		<br/>
		No records selected
		</td>
	</tr>
	</cfif>

</cfoutput>
</cfmodule>


		
