
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the list of gift certificates. Called by shopping.admin&certificate=list --->

<!--- Create the string with the filter parameters --->	
<cfset addedpath="&fuseaction=Shopping.admin&certificate=list">
<cfloop list="Cert_Code,Cust_Name,CertAmount,Order_No,current,valid,show" index="counter">
	<cfif isdefined('attributes.' & counter) and len(evaluate('attributes.' & counter))>
		<cfset addedpath="#addedpath#&#counter#=" & evaluate('attributes.' & counter)>
	</cfif>
</cfloop>

	
<cfparam name="currentpage" default="1">

<!--- Create the page through links, max records set to 20 --->
	<cfmodule template="../../../customtags/pagethru.cfm" 
		totalrecords="#qry_get_certificates.recordcount#" 
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
		box_title="Gift Certificate Manager"
		width="450"
		>
		

<cfoutput>		
<table width="100%" cellspacing="4" border="0" cellpadding="0" class="formtext" style="color: ###Request.GetColors.OutputTText#;">		

	<tr>
		<td colspan="3">
			<a href="#self#?fuseaction=shopping.admin&certificate=add#Request.Token2#">New Certificate</a></td>
		<td colspan="4"
		align="right">#pt_pagethru#</td>
	</tr>

	<form action="#self#?fuseaction=shopping.admin&certificate=list#request.token2#" method="post">
	<input type="hidden" name="show" value="all"/>

	<tr>
		<td><span class="formtextsmall"><br/></span>
		<input type="submit" value="Search" class="formbutton"/></td>	
	
		<td><span class="formtextsmall">code<br/></span>
			<input type="text" name="Cert_Code" size="25" maxlength="25" class="formfield" value="#attributes.Cert_Code#"/></td>			
	
		<td><span class="formtextsmall">customer<br/></span>
			<input type="text" name="cust_name" size="20" maxlength="25" class="formfield" value="#attributes.cust_name#"/></td>
			
		<td><span class="formtextsmall">amount<br/></span>
			<input type="text" name="certamount" size="8" maxlength="25" class="formfield" value="#attributes.certamount#"/></td>	
			
		<td><span class="formtextsmall">order no<br/></span>
			<input type="text" name="order_no" size="10" maxlength="25" class="formfield" value="#attributes.order_no#"/></td>			
	
		<td><span class="formtextsmall">valid<br/></span>
			<select name="valid" class="formfield">
			<option value="" #doSelected(attributes.valid,'')#>all</option>
			<option value="1" #doSelected(attributes.valid,1)#>yes</option>
			<option value="0" #doSelected(attributes.valid,0)#>no</option>
			</select></td>

		<td><span class="formtextsmall">active<br/></span>
		<select name="current" class="formfield">
			<option value="" #doSelected(attributes.current,'')#>all</option>
			<option value="current" #doSelected(attributes.current,'current')#>current</option>
			<option value="scheduled" #doSelected(attributes.current,'scheduled')#>scheduled</option>
			<option value="expired" #doSelected(attributes.current,'expired')#>expired</option>
		</select>
		</td>	
			
		<td><br/><a href="#self#?fuseaction=shopping.admin&certificate=list&show=all#Request.Token2#">ALL</a><br/> <a href="#self#?fuseaction=shopping.admin&certificate=list&show=recent#Request.Token2#">Recent</a>
		</td></tr>
		</form>
		
	<tr>
	<td colspan="7"><cfif attributes.show IS "recent">Recently Added<cfelseif attributes.show IS "All">All Certificates</cfif></td>
	</tr>
		
		<tr>
			<td colspan="7" style="BACKGROUND-COLOR: ###Request.GetColors.outputHBgcolor#;">
			<img src="#Request.AppSettings.defaultimages#/spacer.gif" alt="" height="1" width="1" /></td><tr>
		
<cfif qry_get_certificates.recordcount gt 0>					
	<cfloop query="qry_get_certificates" startrow="#PT_StartRow#" endrow="#PT_EndRow#">
		<tr>
			<td><a href="#self#?fuseaction=shopping.admin&certificate=edit&cert_id=#cert_ID##Request.Token2#">
			Edit #cert_ID#</a></td>
		
			<td>#Cert_Code#</td>

			<td>#cust_name#</td>

			<td>#dollarformat(certamount)#</td>
			
			<td>#iif(isNumeric(Order_No), Evaluate(De('Order_No+Get_Order_Settings.BaseOrderNum')), DE(''))#</td>
		
			<td>#yesnoformat(valid)#</td>
			
			<td colspan="2">#DateFormat(startdate,'mm/dd/yy')#

				#DateFormat(enddate,'mm/dd/yy')#</td>
	
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

		
