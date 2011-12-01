
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the list of standard addons. Called by product.admin&stdaddon=list --->

<!--- Check user's access level --->
<cfmodule template="../../../access/secure.cfm"	keyname="product" requiredPermission="1">

<!--- Create the string with the filter parameters --->	
<cfset addedpath="&fuseaction=product.admin&Stdaddon=list">
	<cfloop list="std_name,std_type,std_display,stdrequired,username,product_id,cid" index="counter">
		<cfif isdefined('attributes.' & counter) and len(evaluate('attributes.' & counter))>
			<cfset addedpath="#addedpath#&#counter#=" & evaluate('attributes.' & counter)>
		</cfif>
	</cfloop>


<cfparam name="currentpage" default="1">

<!--- Create the page through links, max records set to 20 --->
<cfmodule template="../../../customtags/pagethru.cfm" 
	totalrecords="#qry_get_stdaddons.recordcount#" 
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
	box_title="Standard Addons Manager"
	width="600"
	>
	
<cfoutput>		
<table width="100%" cellspacing="4" border="0" cellpadding="0" class="formtext" style="color: ###Request.GetColors.OutputTText#;">		

	<tr>
		<td colspan="4">
			<a href="#self#?fuseaction=product.admin&Stdaddon=add<cfif isdefined("attributes.product_id")>&product_id=#attributes.product_id#</cfif><cfif isdefined("attributes.cid")>&cid=#attributes.cid#</cfif>#Request.Token2#">New Addon</a></td>
		<td colspan="3"	align="right">#pt_pagethru#</td>
	</tr>

	<form action="#self#?fuseaction=product.admin&Stdaddon=list<cfif isdefined("attributes.product_id")>&product_id=#attributes.product_id#</cfif><cfif isdefined("attributes.cid")>&cid=#attributes.cid#</cfif>#request.token2#" method="post">
	
	<cfif isdefined("attributes.Stdaddon")>
		<input type="hidden" name="Stdaddon" value="#attributes.Stdaddon#"/>
	</cfif>
	
	<tr>
		<td><span class="formtextsmall"><br/></span>
		<input type="submit" value="Search" class="formbutton"/>
		</td>	
	
		<td><span class="formtextsmall">name<br/></span>
			<input type="text" name="std_name" size="25" maxlength="50" class="formfield" value="#HTMLEditFormat(attributes.std_name)#"/>
		</td>	

		<!--- if full product admin, show search for users --->
		<cfif ispermitted>
			<td><span class="formtextsmall">user<br/></span>
			<input type="text" name="username" size="15" maxlength="25" class="formfield" value="#HTMLEditFormat(attributes.username)#"/>
			</td>	
		<cfelse>
			<td></td>
		</cfif>

		<td><span class="formtextsmall">type<br/></span>
		<select name="std_type"  class="formfield">
			<option value="" #doSelected(attributes.std_type,'')#>All</option>
			<option value="textbox" #doSelected(attributes.std_type,'textbox')#>textbox</option>
			<option value="checkbox" #doSelected(attributes.std_type,'checkbox')#>checkbox</option>
			<option value="quantity" #doSelected(attributes.std_type,'quantity')#>quantity</option>
			<option value="textfield" #doSelected(attributes.std_type,'textfield')#>textfield</option>
			<option value="calendar" #doSelected(attributes.std_type,'calendar')#>calendar</option>
		</select>
		</td>				
	
		<td><span class="formtextsmall">display<br/></span>
		<select name="std_display"  class="formfield">
			<option value="" #doSelected(attributes.std_display,'')#>All</option>
			<option value="1" #doSelected(attributes.std_display,1)#>Yes</option>
			<option value="0" #doSelected(attributes.std_display,0)#>No</option>
		</select>
		</td>	
		
		<td><span class="formtextsmall">required<br/></span>
		<select name="stdrequired"  class="formfield">
			<option value="" #doSelected(attributes.stdrequired,'')#>All</option>
			<option value="1" #doSelected(attributes.stdrequired,1)#>Yes</option>
			<option value="0" #doSelected(attributes.stdrequired,0)#>No</option>
		</select></td>			
		
		<td><br/><a href="#self#?fuseaction=product.admin&Stdaddon=list<cfif isdefined("attributes.product_id")>&product_id=#attributes.product_id#</cfif><cfif isdefined("attributes.cid")>&cid=#attributes.cid#</cfif>#Request.Token2#">ALL</a>
		</td></tr>
		</form>
		
		<tr>
			<td colspan="6" style="BACKGROUND-COLOR: ###Request.GetColors.outputHBgcolor#;">
			<img src="#Request.AppSettings.defaultimages#/spacer.gif" alt="" height="1" width="1" /></td>
		</tr>	

<cfif qry_get_Stdaddons.recordcount gt 0>					
	<cfloop query="qry_get_Stdaddons" startrow="#PT_StartRow#" endrow="#PT_EndRow#">
		<tr>
			<td><a href="#self#?fuseaction=product.admin&Stdaddon=edit&Std_ID=#Std_ID#<cfif isdefined("attributes.product_id")>&product_id=#attributes.product_id#</cfif><cfif isdefined("attributes.cid")>&cid=#attributes.cid#</cfif>#Request.Token2#">
			Edit #Std_ID#</a></td>		

		<td>#std_name#</td>
		
		<!--- if full product admin, show user that owns this addon --->
		<cfif ispermitted>
		<td>#username#</td>	
		<cfelse><td></td>
		</cfif>
		
		<td>#std_type#</td>		

		<td><cfif std_display is 1>Yes<cfelse>No</cfif></td>	
		
		<td><cfif std_required is 1>Yes<cfelse>No</cfif></td>
		
			<td><!--- links ---></td>
			</tr>
			
			</cfloop>	
	</table>
		
	<div align="right" class="formtext">#pt_pagethru#</div>
		
	<cfelse>	
		<td colspan="7">
		<br/>
		No records selected
		</td>
	</table>	
	</cfif>

</cfoutput>
<!---- CLOSE MODULE ----->
</cfmodule>
		
