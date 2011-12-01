
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the page to add and edit related features. Displays search fields to find features and any currently related features. Called by feature.admin&feature=related --->

<!---
From Features:
<cfset startpath="fuseaction=feature.admin&feature=related&feature_id=#attributes.feature_id#">
<cfset box_title="Update Feature - #qry_get_feature.name#">
<cfparam name = "menu" default="dsp_tab_menu.cfm">

---->

<!--- Create the string with the filter parameters --->	
<cfset addedpath="&#startpath#">
	<cfloop list="uid,uname,search_string,feature_type,accesskey,display_status,highlight,order,cid,nocat" index="counter">
	<cfif isdefined('attributes.' & counter) and len(evaluate('attributes.' & counter))>
		<cfset addedpath="#addedpath#&#counter#=" & evaluate('attributes.' & counter)>
	</cfif>
	</cfloop>
	
	
<cfparam name="currentpage" default="1">

<!--- Create the page through links, max records set to 20 --->
<cfmodule template="../../customtags/pagethru.cfm" 
	totalrecords="#qry_get_features.recordcount#" 
	currentpage="#currentpage#"
	templateurl="#self#"
	addedpath="#addedpath##request.token2#"
	displaycount="20" 
	imagepath="#request.appsettings.defaultimages#/icons/" 
	imageheight="12" 
	imagewidth="12"
	hilightcolor="###request.getcolors.mainlink#" 
	>
		

<cfinclude template="../../access/admin/accesskey/qry_get_accesskeys.cfm">
<cfinclude template="../../queries/qry_getpicklists.cfm">				
		
	
<cfmodule template="../../customtags/format_output_admin.cfm"
	box_title="#box_title#"
	Width="600"
	menutabs="yes">
	
	<cfinclude template="#menu#">
	
<cfif qry_get_Feature_item.recordcount>
<cfoutput>
<table width="100%" cellspacing="4" border="0" cellpadding="0" class="formtext" style="color:###Request.GetColors.InputTText#">
	<tr>
		<td class="formtitle" width="20%">Currently&nbsp;Related&nbsp;</td>
		<td ><cfmodule template="../../customtags/putline.cfm" linetype="thin" linecolor="#Request.GetColors.InputHBgcolor#"/></td>
	</tr>	
</table>
<table width="90%" cellspacing="4" border="0" cellpadding="0" class="formtext" style="color:###Request.GetColors.InputTText#">	</cfoutput>	
	<cfoutput query="qry_get_Feature_item">
	<tr>
		<td>#name#</td>
		<td>#author#</td>
		<td>#copyright#</td>
		<td>[<a href="#self#?#addedpath#&submit_related=#feature_ID##Request.Token2#">remove</a>]
		[<a href="#self#?fuseaction=feature.admin&feature=edit&feature_ID=#feature_ID##Request.Token2#">edit</a>]
		[<a href="#self#?fuseaction=feature.display&feature_ID=#feature_ID##Request.Token2#" target="store">view</a>]
		</td>
	</tr>		
	</cfoutput>
</table>
<br/>	
</cfif>	


<cfoutput>	
<table width="100%" cellspacing="4" border="0" cellpadding="0" class="formtext" style="color:###Request.GetColors.InputTText#">	
	<tr>
		<td class="formtitle" width="20%">Add&nbsp;Related&nbsp;Feature&nbsp;</td>
		<td ><cfmodule template="../../customtags/putline.cfm" linetype="thin" linecolor="#Request.GetColors.InputHBgcolor#"/></td>
	</tr>	
</table>	

<!-----------Search for more --------------->		
<table width="100%" cellspacing="4" border="0" cellpadding="0" class="formtext" style="color:###Request.GetColors.InputTText#">	

	<tr>
		<td colspan="8"	align="right">#pt_pagethru#</td>
	</tr>

	<form action="#self#?#startpath##request.token2#" method="post">
	
<tr>
		<td><span class="formtextsmall"><br/></span>
		<input type="submit" value="Search" class="formbutton"/></td>
			
		<td><span class="formtextsmall">name, author, text<br/></span>
			<input type="text" name="search_string" size="20" maxlength="25" class="formfield" value="#HTMLEditFormat(attributes.search_string)#"/></td>	
			
	
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
			
	
		<td><span class="formtextsmall">order by<br/></span>
			<select name="order" class="formfield">
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
			
		<td><span class="formtextsmall"><br/></span>
		<a href="#self#?#startpath##Request.Token2#">ALL</a><br/>
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
			<a href="#self#?#startpath#&nocat=1#Request.Token2#">Uncategorized</a>
			<cfelse>
			<strong>Uncategorized</strong>
			</cfif>
		</td>
		</tr>	
		<tr>
			<td colspan="8" style="BACKGROUND-COLOR: ###Request.GetColors.inputHBgcolor#;"><img src="#Request.AppSettings.defaultimages#/spacer.gif" alt="" height="1" width="1" /></td>
		</tr>
	

<cfif qry_get_features.recordcount gt 0>					

	<form action="#self#?#addedpath##request.token2#" method="post">
	
	<cfloop query="qry_get_features" startrow="#PT_StartRow#" endrow="#PT_EndRow#">
	<cfif not listfind("#valuelist(qry_get_feature_item.feature_id)#","#feature_id#") AND qry_get_features.feature_ID IS NOT attributes.feature_ID>
		<tr>
			<td rowspan="2" valign="top"><input type="checkbox" name="add_related" value="#feature_id#"/></td>
			<td colspan="6"><a href="#self#?fuseaction=feature.display&feature_ID=#feature_ID##Request.Token2#">#left(name,65)#<cfif len(name) gt 65>...</cfif></a><br/><span class="formtextsmall"><cfif len(author)>#left(author,25)#<cfif len(author) gt 25>...</cfif></cfif><cfif len(author) and len(created)>, </cfif>#DateFormat(created,'mm/dd/yy')#  <cfif len(copyright)>&copy;#left(copyright,25)#<cfif len(copyright) gt 25>...</cfif></cfif></span></td>
			<td class="formtextsmall"></td>	
		</tr>
	
		<tr>
			<td class="formtextsmall"><cfif right(lg_image,4) is ".pdf">.PDF File</cfif></td>	
			
			<td class="formtextsmall">#feature_type#</td>
		
			<td class="formtextsmall">#AccessKey_name#</td>
		
			<td class="formtextsmall">
		<cfif display is "0"><font color="red">off</font>
		<cfelseif approved is "0"><font color="gold">editor</font>
		<cfelseif expire is not "" and DateCompare(expire,now(),'d') is -1><font color="red">expired</font>
		<cfelseif start is not "" and DateCompare(start,now(),'d') is 1><font color="gold">scheduled</font>
		<cfelse><font color="green">current</font>
		</cfif></td>
		
			<td class="formtextsmall"><cfif highlight>Yes</cfif></td>
		
			<td class="formtextsmall" colspan="2"><font color="green">#DateFormat(start,'m/d/yy')#</font><cfif expire is not ""> <font color="red">#DateFormat(expire,'m/d/yy')#</font></cfif></td>	
	
		</tr>
	
	</cfif>
	</cfloop>	
	</table>
	
	<div align="center"><input type="submit" name="submit_related" value="Add Features" class="formbutton"/></div>
	
	</form>		
		
	<div align="right" class="formtext">#pt_pagethru#</div>
		
	<cfelse>	
	
		<td colspan="9">
		<br/>
		No records selected
		</td>
	</tr>		
	</table>	
	
	</cfif>
	
	<table width="100%" cellspacing="4" border="0" cellpadding="0" class="formtext">	
		<tr><form action="#self#?fuseaction=feature.admin&feature=list&cid=#attributes.cid##request.token2#" method="post">
		<td align="center">
			<cfmodule template="../../customtags/putline.cfm" linetype="thin" linecolor="#Request.GetColors.InputHBgcolor#"/>	<br/>	
		<input type="hidden" name="act" value="choose"/>
		<input type="submit" name="DONE" value="Back to Feature List" class="formbutton"/><br/><br/>	
		</td>
    </form></tr>
	</table> 
</cfoutput>

<!---- CLOSE MODULE ----->
</cfmodule>

		
