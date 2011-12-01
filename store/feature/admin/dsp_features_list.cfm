
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the list of features. Called by feature.admin&feature=list --->

<cfparam name="attributes.displaycount" default="20">

<!--- Create the string with the filter parameters --->		
<cfset addedpath="&fuseaction=feature.admin&feature=#attributes.feature#">
	<cfloop list="uid,username,search_string,feature_type,accesskey,display_status,highlight,order,cid,nocat" index="counter">
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
			
	
<cfmodule template="../../customtags/format_output_admin.cfm"
	box_title="Feature Manager"
	width="600"
	>
	
	<cfoutput>	
<table width="100%" cellspacing="4" border="0" cellpadding="0" class="formtext" style="color: ###Request.GetColors.OutputTText#;">	

	<tr>
		<td colspan="4">
			<a href="#self#?fuseaction=Feature.admin&Feature=add<cfif len(attributes.cid)>&cid=#attributes.cid#</cfif>#Request.Token2#">New Feature</a> | <a href="#self#?#replace(addedpath,"list","listform")##request.token2#">Edit Form</a></td>
		<td colspan="4"
		align="right">#pt_pagethru#</td>
	</tr>

	<form action="#self#?fuseaction=Feature.admin&Feature=list#request.token2#" method="post">
	
	<tr>
		<td><span class="formtextsmall"><br/></span>
		<input type="submit" value="Search" class="formbutton"/></td>
			
		<td><span class="formtextsmall">name, author, text<br/></span>
			<input type="text" name="search_string" size="20" maxlength="25" class="formfield" value="#HTMLEditFormat(attributes.search_string)#"/></td>	
			
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
		</select>	
		</td>				
	
		<td><span class="formtextsmall">display<br/></span>
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
		<a href="#self#?fuseaction=Feature.admin&Feature=list#Request.Token2#">ALL</a><br/>
		</td></tr>
		</form>

<!---- Category Browse --------->		
	<tr>
		<td colspan="6">
		<cfparam name="attributes.cid" default="">
		<cfif attributes.cid is not "">
			in category <cfinclude template="../../category/admin/dsp_parent_breadcrumb.cfm"><br/>
			<!---- include subcats ---->
			<cfset attributes.parent_ID = attributes.cid>
			<cfset all = 1>
			<cfinclude template="../../category/qry_get_subcats.cfm">
			<cfinclude template="../../category/admin/dsp_subcats_breadcrumb.cfm">
		<cfelse>
			<a href="#self#?cid=0#replace(addedpath,'&nocat=1','','ALL')##Request.Token2#">Browse Categories</a>
		</cfif>		
		</td>
		<td colspan="2" align="right" valign="top">
			<cfif attributes.nocat is not "1">
			<a href="#self#?fuseaction=Feature.admin&Feature=list&nocat=1#Request.Token2#">Uncategorized</a>
			<cfelse>
			<strong>Uncategorized</strong>
			</cfif>
		</td>
		</tr>	
		
		<tr>
			<td colspan="8" style="BACKGROUND-COLOR: ###Request.GetColors.outputHBgcolor#;"><img src="#Request.AppSettings.defaultimages#/spacer.gif" alt="" height="1" width="1" /></td>
		</tr>
			
<cfif qry_get_Features.recordcount gt 0>					
	<cfloop query="qry_get_Features" startrow="#PT_StartRow#" endrow="#PT_EndRow#">
		<tr>
			<td><a href="#self#?fuseaction=Feature.admin&Feature=edit&Feature_ID=#Feature_id#<cfif len(attributes.cid)>&cid=#attributes.cid#</cfif>#Request.Token2#">
			Edit #Feature_id#</a></td>
			
			<td colspan="2"><a href="#self#?fuseaction=feature.display&feature_ID=#feature_ID##Request.Token2#"  target="store">#left(name,41)#<cfif len(name) gt 41>...</cfif></a><br/><span class="formtextsmall"><cfif len(author)>#left(author,15)#<cfif len(author) gt 15>...</cfif></cfif><cfif len(author) and len(created)>, </cfif>#DateFormat(created,'mm/dd/yy')#  <cfif len(copyright)>&copy;#left(copyright,12)#<cfif len(copyright) gt 12>...</cfif></cfif></span>

		<cfif right(lg_image,4) is ".pdf">.PDF File</cfif>
</td>
			<td>#feature_type# </td>

			<td>#AccessKey_name#</td>
			
			<td>
		<cfif display is "0"><font color="red">off</font>
		<cfelseif approved is "0"><font color="gold">editor</font>
		<cfelseif expire is not "" and DateCompare(expire,now(),'d') is -1><font color="red">#DateFormat(expire,'m/d/yy')#</font>
		<cfelseif start is not "" and DateCompare(start,now(),'d') is 1><font color="gold">#DateFormat(start,'m/d/yy')#</font>
		<cfelse><font color="green">current</font>
		</cfif>		
			</td>
		
			<td><cfif highlight>Yes</cfif></td>
		
			<td><a href="#self#?fuseaction=Feature.admin&Feature=copy&dup=#Feature_id##Request.Token2#">
			copy</a></td>	

	
		</tr>
	
			</cfloop>	
	</table>
		
	<div align="right" class="formtext">#pt_pagethru#</div>
		
	<cfelse>	
		<td colspan="8">
		<br/>
		<span class="formerror">No records selected</span>
		</td>
	</table>	
	</cfif>
	
</cfoutput>

</cfmodule>

		
