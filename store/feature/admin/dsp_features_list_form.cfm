
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the List Edit form for features. This page is used to make common changes to multiple features at one time. Called by feature.admin&feature=listform --->

	<!--- Set IsPermitted to feature_approve permission ---->
	<cfmodule template="../../access/secure.cfm"
	keyname="feature"
	requiredPermission="2"
	> 
		
	<cfparam name="attributes.displaycount" default="20">
	
	<!--- Create the string with the filter parameters --->		
	<cfset addedpath="&fuseaction=Feature.admin&Feature=#attributes.feature#">
		<cfloop list="uid,username,search_string,feature_type,accesskey,display_status,highlight,order,cid" index="counter">
	<cfif isdefined('attributes.' & counter) and len(evaluate('attributes.' & counter))>
		<cfset addedpath="#addedpath#&#counter#=" & evaluate('attributes.' & counter)>
	</cfif>
	</cfloop>

	<cfparam name="currentpage" default="1">

	<cfinclude template="../../access/admin/accesskey/qry_get_accesskeys.cfm">
	<cfinclude template="../../queries/qry_getpicklists.cfm">				
		
	<!--- Create the page through links, max records set by the display count --->	
	<cfmodule template="../../customtags/pagethru.cfm" 
		totalrecords="#qry_get_features.recordcount#" 
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
	box_title="Feature Manager"
	width="600"
	required_fields="0"
	>


<cfoutput>		
	<tr>
		<td colspan="4">
			<a href="#self#?fuseaction=Feature.admin&Feature=add<cfif len(attributes.cid)>&cid=#attributes.cid#</cfif>#Request.Token2#">New Feature</a>
			| <a href="#self#?#replace(addedpath,"listform","list")#">List View</a></td>
		<td colspan="5"
		align="right">#pt_pagethru#</td>
	</tr>

	<form action="#self#?fuseaction=Feature.admin&Feature=listform#request.token2#" method="post">
	
	<tr>
		<td><span class="formtextsmall"><br/></span>
		<input type="submit" value="Search" class="formbutton"/></td>
			
		<td><span class="formtextsmall">name, author, text<br/></span>
			<input type="text" name="name" size="20" maxlength="25" class="formfield" value="#HTMLEditFormat(attributes.name)#"/></td>	
			
			<td><span class="formtextsmall">order by<br/></span>
			<select name="order" class="formfield">
			<option value=""></option>
			<option value="Name" #doSelected(attributes.order,'Name')#>name</option>
			<option value="Username" #doSelected(attributes.order,'Username')#>username</option>
			<option value="Author" #doSelected(attributes.order,'Author')#>author</option>
			<option value="Copyright" #doSelected(attributes.order,'Copyright')#>copyright</option>
			<option value="Feature_Type" #doSelected(attributes.order,'Feature_Type')#>type</option>
			<option value="AccessKey" #doSelected(attributes.order,'AccessKey')#>accesskey</option>
			<option value="Start" #doSelected(attributes.order,'Start')#>start</option>
			<option value="Expire" #doSelected(attributes.order,'Expire')#>expire</option>
			<option value="Created" #doSelected(attributes.order,'Created')#>created</option>
			</select>	
			</td>		
	
		<td><span class="formtextsmall">type<br/></span>
		<select name="feature_type" size="1" class="formfield">
			<option value="">all</option>
			<cfmodule template="../../customtags/form/dropdown.cfm"
			mode="valuelist"
			valuelist="#qry_getpicklists.feature_type#"
			selected="#attributes.feature_type#"
			/>
	 	</select>
			</td>				
	
		<td><span class="formtextsmall">accesskey<br/></span>
		<select name="AccessKey" size="1" class="formfield">
			<option value="" #doSelected(attributes.accesskey,'')#>all</option>
			<cfloop query="qry_get_accesskeys">
			<option value="#accesskey_ID#" #doSelected(attributes.accesskey,qry_get_accesskeys.accesskey_ID)#>#name#</option>
			</cfloop>
		</select></td>				
	
		<td colspan="2"><span class="formtextsmall">display<br/></span>
		<select name="display_status" class="formfield">
			<option value="" #doSelected(attributes.display_status,'')#>all</option>
			<option value="off" #doSelected(attributes.display_status,'off')#>off</option>
			<option value="editor" #doSelected(attributes.display_status,'editor')#>editor</option>
			<option value="current" #doSelected(attributes.display_status,'current')#>current</option>
			<option value="scheduled" #doSelected(attributes.display_status,'scheduled')#>scheduled</option>
			<option value="expired" #doSelected(attributes.display_status,'expired')#>expired</option>
		</select></td>			
	
		<td><span class="formtextsmall">new<br/></span>
		<select name="highlight" class="formfield">
			<option value="">all</option>
			<option value="0" #doSelected(attributes.highlight,0)#>no</option>
			<option value="1" #doSelected(attributes.highlight,1)#>yes</option>
		</select></td>				
						
		<td><span class="formtextsmall"><br/></span>
		<a href="#self#?fuseaction=Feature.admin&Feature=listform#Request.Token2#">ALL</a><br/>
		</td></tr>
		</form>		
		
		<!---- Category Browse --------->		
	<tr>
		<td colspan="7">
		<cfparam name="attributes.cid" default="">
		<cfif attributes.cid is not "">
			in category <cfinclude template="../../category/admin/dsp_parent_breadcrumb.cfm"><br/>
			<!---- include subcats ---->
			<cfset attributes.parent_ID = attributes.cid>
			<cfset all = 1>
			<cfinclude template="../../category/qry_get_subcats.cfm">
			<cfinclude template="../../category/admin/dsp_subcats_breadcrumb.cfm">
		<cfelse>
			<a href="#self#?cid=0#addedpath##Request.Token2#">Browse Categories</a>
		</cfif>		
		</td>
		<td colspan="2" align="right" valign="top">
			<cfif attributes.nocat is not "1">
			<a href="#self#?fuseaction=Feature.admin&Feature=listform&nocat=1#Request.Token2#">Uncategorized</a>
			<cfelse>
			<strong>Uncategorized</strong>
			</cfif>
		</td>	
		</tr>			
		
		<tr>
			<td colspan="9" style="BACKGROUND-COLOR: ###Request.GetColors.inputHBgcolor#;"><img src="#Request.AppSettings.defaultimages#/spacer.gif" alt="" height="1" width="1" /></td>
		</tr>
		
	<tr>
		<th align="left">Edit</th>
		<th colspan="2" align="left">Article</th>
		<th align="center">Priority</th>
		<th align="center" width="30%" nowrap="nowrap">Start</th>
		<th align="center" width="30%" nowrap="nowrap">End</th>
		<th align="center" width="3%">Display</th>
		<th align="center" width="3%">App'd</th>
		<th align="center" width="3%" nowrap="nowrap">New</th>		
	</tr>	
	
<!--- Make list of feature IDs to send to next page --->
<cfset FeatureList = "">

<form name="editform" action="#self#?#replace(addedpath,"listform","actform")##request.token2#" method="post">

<cfif qry_get_Features.recordcount gt 0>					
	<cfloop query="qry_get_Features" startrow="#PT_StartRow#" endrow="#PT_EndRow#">
	<!--- Add feature ID to the list --->
	<cfset FeatureList = ListAppend(FeatureList, Feature_ID)>
		<tr>
			<td><a href="#self#?fuseaction=Feature.admin&Feature=edit&Feature_ID=#Feature_id##Request.Token2#">
			Edit #Feature_id#</a></td>
		
			<td colspan="2">
			<a href="#self#?fuseaction=feature.display&feature_ID=#feature_ID##Request.Token2#" target="store">#left(name,65)#<cfif len(name) gt 65>...</cfif></a>

		<td align="center"><input type="text" name="Priority#Feature_ID#" value="#doPriority(Priority,0)#" size="3" maxlength="15" class="formfield"/></td>
		<td align="center"><input type="text" name="start#Feature_ID#" value="#DateFormat(start,'mm/dd/yyyy')#" size="8" maxlength="15" class="formfield"/></td>
		<td align="center"><input type="text" name="expire#Feature_ID#" value="#DateFormat(expire,'mm/dd/yyyy')#" size="8" maxlength="15" class="formfield"/></td>
		<td align="center"><input type="checkbox" name="Display#feature_id#" value="1" #doChecked(Display)#/></td>
		<td align="center">
		<!--- ispermited set to feature_approve above --->
		<cfif ispermitted>
			<input type="checkbox" name="Approved#feature_id#" value="1" #doChecked(Approved)#/>
		<cfelse>
			<cfif approved>yes<cfelse>no</cfif>
		</cfif>
		</td>
		<td align="center"><input type="checkbox" name="Highlight#feature_id#" value="1" #doChecked(Highlight)#/></td>

		
		</tr>	
		</cfloop>	
	
		<tr><td colspan="9" align="center">
		<div align="right">#pt_pagethru#</div>
	<input type="submit" name="Action" value="Save Changes" class="formbutton"/>
	<input type="hidden" name="FeatureList" value="#FeatureList#"/>
		</td></tr>
	</form>	

<cfprocessingdirective suppresswhitespace="no">
<script type="text/javascript">
objForm = new qForm("editform");

<cfloop index="feature_ID" list="#FeatureList#">
	objForm.Priority#feature_ID#.description = "priority number #feature_ID#";
	objForm.start#feature_ID#.description = "start date #feature_ID#";
	objForm.expire#feature_ID#.description = "expiration date #feature_ID#";
</cfloop>

<cfloop index="feature_ID" list="#FeatureList#">
	objForm.Priority#feature_ID#.validateNumeric();
	objForm.Priority#feature_ID#.validateRange('0','9999');
	objForm.start#feature_ID#.validateDate();
	objForm.expire#feature_ID#.validateDate();
</cfloop>

qFormAPI.errorColor = "###Request.GetColors.formreq#";
</script>
</cfprocessingdirective>

	<cfelse>	
		<td colspan="9">
		<br/>
		<span class="formerror">No records selected</span>
		</td>
	</cfif>
</cfoutput>

</cfmodule>
