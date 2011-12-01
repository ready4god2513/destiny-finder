
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the list of Customer records for the admin. Called by users.admin&customer=list --->

<!--- Create the string with the filter parameters --->	
<cfset addedpath="&fuseaction=users.admin&customer=list">
	<cfloop list="uid,un,custname,company,location,phone,email,lastused,order,show" index="counter">
	<cfif isdefined('attributes.' & counter) and len(evaluate('attributes.' & counter))>
		<cfset addedpath="#addedpath#&#counter#=" & evaluate('attributes.' & counter)>
	</cfif>
	</cfloop>

<cfparam name="currentpage" default="1">

<!--- Create the page through links, max records set to 20 --->
<cfmodule template="../../../customtags/pagethru.cfm" 
	totalrecords="#qry_get_customers.recordcount#" 
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
	box_title="Customer Addresses"
	width="600"
		>
		
<cfoutput>	
<table width="100%" cellspacing="4" border="0" cellpadding="0" class="formtext" style="color: ###Request.GetColors.OutputTText#;">						
				
	<!--- Navigation Row --->
		<tr>
			<td colspan="5">
			<a href="#self#?fuseaction=users.admin&customer=add<cfif attributes.uid is not ''>&uid=#attributes.uid#</cfif>#Request.Token2#">
			New Customer Address</a>
			</td>
			<td colspan="4"	align="right">#pt_pagethru#</td>

		</tr>
		
	<!--- List Filters/search form --->	
	<form action="#self#?fuseaction=users.admin&customer=list#request.token2#" method="post">
		<tr>
			<input type="hidden" name="show" value="all"/>
			
			<td><span class="formtextsmall">&nbsp;<br/></span>
			<input type="submit" value="Search" class="formbutton"/>
			</td>
			
			<td>
			<span class="formtextsmall">user</span><br/>
			<input type="text" name="un" size="8" maxlength="25" value="#attributes.un#" class="formfield"/>
			</td>	
	
			<td>
			<span class="formtextsmall">name (first or last)</span><br/>
			<input type="text" name="Custname" size="20" maxlength="25" value="#attributes.Custname#" class="formfield"/>
			</td>	
			
	
			<td>
			<span class="formtextsmall">company</span><br/>
			<input type="text" name="company" size="10" maxlength="25" value="#attributes.company#" class="formfield"/>
			</td>	
			
	
			<td>
			<span class="formtextsmall">address</span><br/>
			<input type="text" name="location" size="15" maxlength="25" value="#attributes.location#" class="formfield"/>
			</td>	
			
	
			<td>
			<span class="formtextsmall">phone</span><br/>
			<input type="text" name="phone" size="12" maxlength="25" value="#attributes.phone#" class="formfield"/>
			</td>	
			
	
			<td>
			<span class="formtextsmall">email</span><br/>
			<input type="text" name="email" size="12" maxlength="25" value="#attributes.email#" class="formfield"/>
			</td>	
			
	
			<td>
			<span class="formtextsmall">last use after</span><br/>
			<input type="text" name="lastused" size="10" maxlength="25" value="#attributes.lastused#" class="formfield"/>
			</td>		
				</form>
	
		<td align="center"><span class="formtextsmall">&nbsp;<br/></span>
			<a href="#self#?fuseaction=users.admin&customer=list&show=All#Request.Token2#">ALL</a><br/> <a href="#self#?fuseaction=users.admin&customer=list&show=recent#Request.Token2#">Recent</a>
			</td>	
	</tr>
	
	<tr>
	<td colspan="8"><cfif attributes.show IS "recent">Recent Activity<cfelseif attributes.show IS "All">All Customer Addresses</cfif></td>
	</tr>

		<tr>
			<td colspan="9" style="BACKGROUND-COLOR: ###Request.GetColors.outputHBgcolor#;">
			<img src="#Request.AppSettings.defaultimages#/spacer.gif" alt="" height="1" width="1" /></td>
		</tr>
		
	<!--- Output List --->		
		<cfif qry_get_Customers.recordcount gt 0>
			
			<cfloop query="qry_get_Customers" startrow="#PT_StartRow#" endrow="#PT_EndRow#">
			<tr>
				<td>
				<a href="#self#?fuseaction=users.admin&customer=edit&Customer_ID=#Customer_ID##Request.Token2#">
				Edit #Customer_ID#</a></td>
		
				<td class="formtextsmall"><a href="#self#?fuseaction=users.admin&user=summary&UID=#user_id##Request.Token2#">#un#</a> <cfif billto is customer_id>(b)<cfelseif shipto is customer_id>(s)</cfif>
				</td>
		
			<td class="formtextsmall">#firstname# #lastname#
				<cfif len(company)><br/>#company#</cfif>
			</td>
			
			<td colspan="2" class="formtextsmall">
				#Address1#, <cfif Address2 IS NOT "">#Address2#</cfif>
				<br/>#City#, <cfif Compare(State, "Unlisted")>#State# <cfelse>#State2# </cfif> #Zip# <cfif Country IS NOT "" AND Country IS NOT "US^United States">#ListGetAt(Country, 2, "^")#</cfif>
				</td>
			<td colspan="2" class="formtextsmall">#phone#
				<br/><a href="mailto:#email#">#email#</a>
			</td>
			<td class="formtextsmall">#dateformat(lastused,"mm/dd/yyyy")#</td>
			<td></td>
			</tr>
			</cfloop>
			</table>
			<div align="center" class="formtext">#pt_pagethru#</div>
			
		<cfelse>	
			<td colspan="9">
			<br/>
			No records selected
			</td>
			</table>	
		</cfif>
</cfoutput>
</cfmodule>