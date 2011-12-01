<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the list of discounts. Called by product.admin&discount=list --->

<!--- Create the string with the filter parameters --->	
<cfset addedpath="&fuseaction=product.admin&Discount=list">
	<cfloop list="name,coup_code,display,current,accesskey" index="counter">
		<cfif isdefined('attributes.' & counter) and len(evaluate('attributes.' & counter))>
			<cfset addedpath="#addedpath#&#counter#=" & evaluate('attributes.' & counter)>
		</cfif>
	</cfloop>

<cfinclude template="../../../access/admin/accesskey/qry_get_accesskeys.cfm">
<cfparam name="currentpage" default="1">

<!--- Create the page through links, max records set to 20 --->
<cfmodule template="../../../customtags/pagethru.cfm" 
	totalrecords="#qry_get_discounts.recordcount#" 
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
		box_title="Discount Manager"
		width="600"
		>
		

<cfoutput>	
<table width="100%" cellspacing="4" border="0" cellpadding="0" class="formtext" style="color: ###Request.GetColors.OutputTText#;">	

	<tr>
		<td colspan="4">
			<a href="#self#?fuseaction=product.admin&Discount=add#Request.Token2#">New Discount</a></td>
		<td colspan="4"
		align="right">#pt_pagethru#</td>
	</tr>

	<form action="#self#?fuseaction=product.admin&Discount=list#request.token2#" method="post">
	
	<tr>
		<td><span class="formtextsmall"><br/></span>
		<input type="submit" value="Search" class="formbutton"/></td>	
	
		<td><span class="formtextsmall">name<br/></span>
			<input type="text" name="Name" size="20" maxlength="25" class="formfield" value="#attributes.Name#"/></td>				
	
		<td><span class="formtextsmall">coupon code<br/></span>
			<input type="text" name="Coup_code" size="10" maxlength="25" class="formfield" value="#attributes.Coup_code#"/></td>		
			
		<td><span class="formtextsmall">accesskey<br/></span>
		<select name="AccessKey" size="1" class="formfield">
			<option value="" #doSelected(attributes.accesskey,'')#>all</option>
			<cfloop query="qry_get_accesskeys">
			<option value="#accesskey_ID#" #doSelected(attributes.accesskey,qry_get_accesskeys.accesskey_ID)#>#name#</option>
			</cfloop>
		</select>	
		</td>			
	
		<td><span class="formtextsmall">display<br/></span>
			<input type="text" name="display" size="20" maxlength="25" class="formfield" value="#attributes.display#"/></td>				
	
		<td colspan="2"><span class="formtextsmall">active<br/></span>
		<select name="current" class="formfield">
			<option value="" #doSelected(attributes.current,'')#>all</option>
			<option value="current" #doSelected(attributes.current,'current')#>current</option>
			<option value="scheduled" #doSelected(attributes.current,'scheduled')#>scheduled</option>
			<option value="expired" #doSelected(attributes.current,'expired')#>expired</option>
		</select>
		</td>				
			
		<td><br/><a href="#self#?fuseaction=product.admin&Discount=list#Request.Token2#">ALL</a><br/>
		</td></tr>
		</form>
		
		<tr>
			<td colspan="8" style="BACKGROUND-COLOR: ###Request.GetColors.outputHBgcolor#;">
			<img src="#Request.AppSettings.defaultimages#/spacer.gif" alt="" height="1" width="1" /></td>
		</tr>	

<cfif qry_get_Discounts.recordcount gt 0>					
	<cfloop query="qry_get_Discounts" startrow="#PT_StartRow#" endrow="#PT_EndRow#">
		<tr>
			<td><a href="#self#?fuseaction=product.admin&discount=edit&discount_id=#Discount_ID##Request.Token2#">
			Edit #Discount_ID#</a></td>		

		<td>#Name#</td>		

		<td>#Coup_code#</td>	
		
		<td>#AccessKey_name#</td>	

		<td>#display#</td>		

		<td>#DateFormat(startdate,'mm/dd/yy')#</td>		

		<td>#DateFormat(enddate,'mm/dd/yy')#</td>	
		
			<td><!--- links ---></td>
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
<!---- CLOSE MODULE ----->
</cfmodule>

		
