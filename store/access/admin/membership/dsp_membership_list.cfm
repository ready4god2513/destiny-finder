<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the list of memberships for the admin. Called by the fuseaction access.admin&membership=list --->

<cfinclude template="../accesskey/qry_get_accesskeys.cfm">

<!--- Create the string with the filter parameters --->	
<cfset addedpath="&fuseaction=access.admin&membership=list">
<cfloop list="isexpired,isused,valid,user,membership_type,product,accesskey,show" index="counter">
	<cfif isdefined('attributes.' & counter) and len(evaluate('attributes.' & counter))>
		<cfset addedpath="#addedpath#&#counter#=" & evaluate('attributes.' & counter)>
	</cfif>
</cfloop>

<cfparam name="currentpage" default="1">

<!--- Create the page through links, max of 20 records per page --->
<cfmodule template="../../../customtags/pagethru.cfm" 
	totalrecords="#qry_get_memberships.recordcount#" 
	currentpage="#currentpage#"
	templateurl="#cgi.script_name#"
	addedpath="#addedpath##request.token2#"
	displaycount="20" 
	imagepath="#request.appsettings.defaultimages#/icons/" 
	imageheight="12" 
	imagewidth="12"
	hilitecolor="###request.getcolors.mainlink#" >
			
			
				
<cfmodule template="../../../customtags/format_output_admin.cfm"
	box_title="Memberships"
	width="550"
	>
	
<cfoutput>
<table width="100%" cellspacing="4" border="0" cellpadding="0" class="formtext" style="color: ###Request.GetColors.OutputTText#;">	

	<tr>
		<td colspan="5">
			<a href="#self#?fuseaction=access.admin&membership=add">New Membership</a></td>
		<td colspan="4" align="right">#pt_pagethru#</td>
	</tr>
	
	<!--- search form--->
	<form action="#self#?fuseaction=access.admin&membership=list#request.token2#" method="post">
	<input type="hidden" name="show" value="all"/>
	<tr>
		<td><span class="formtextsmall"><br/></span>
		<input type="submit" value="Search" class="formbutton"/></td>
		<td><span class="formtextsmall">username/email<br/></span>
		<input type="text" name="User" size="12" maxlength="25" class="formfield" value="#attributes.User#"/>
		</td>
		<td><span class="formtextsmall">type<br/></span>
		<select name="membership_Type"  class="formfield">
		<option value="" #doSelected(attributes.membership_Type,'')#>All</option>
		<option value="promo" #doSelected(attributes.membership_Type,'promo')#>promo</option>
		<option value="download" #doSelected(attributes.membership_Type,'download')#>download</option>
		<option value="membership" #doSelected(attributes.membership_Type,'membership')#>membership</option>
		</select> 
		</td>
		<td><span class="formtextsmall">prod name<br/></span>
		<input type="text" name="Product" size="7" maxlength="25" class="formfield" value="#attributes.Product#"/>
		</td>
		<td><span class="formtextsmall">accesskey<br/></span>
		<select name="AccessKey" size="1" class="formfield">
			<option value="" #doSelected(attributes.accesskey,'')#>all</option>
			<cfloop query="qry_get_accesskeys">
			<option value="#accesskey_ID#" #doSelected(attributes.accesskey,qry_get_accesskeys.accesskey_ID)#>#name#</option>
			</cfloop>
		</select>	
		</td>
		<td><span class="formtextsmall">expired<br/></span>
		<select name="IsExpired"  class="formfield">
		<option value="" #doSelected(attributes.IsExpired,'')#>All</option>
		<option value="current" #doSelected(attributes.IsExpired,'current')#>current</option>
		<option value="recur" #doSelected(attributes.IsExpired,'recur')#>recurring</option>
		<option value="expired" #doSelected(attributes.IsExpired,'expired')#>expired</option>
		<option value="future" #doSelected(attributes.IsExpired,'future')#>future</option>
		<option value="suspended" #doSelected(attributes.IsExpired,'suspended')#>suspended</option>
		</select> 
		</td>
		<td><span class="formtextsmall">used<br/></span>
		<select name="Isused"  class="formfield">
		<option value="" #doSelected(attributes.Isused,'')#>All</option>
		<option value="yes" #doSelected(attributes.Isused,'yes')#>yes</option>
		<option value="no" #doSelected(attributes.Isused,'no')#>no</option>
		</select> 
		</td>
		<td><span class="formtextsmall">valid<br/></span>
		<select name="Valid"  class="formfield">
		<option value="" #doSelected(attributes.Valid,'')#>All</option>
		<option value="Yes" #doSelected(attributes.Valid,'Yes')#>Yes</option>
		<option value="No" #doSelected(attributes.Valid,'No')#>No</option>
		</select>		
		</td>		
		</form>
		<td><br/><a href="#self#?fuseaction=access.admin&membership=list&show=All#Request.Token2#">ALL</a><br/> <a href="#self#?fuseaction=access.admin&membership=list&show=recent#Request.Token2#">Recent</a></td>
	</tr>
	
	<tr>
		<td colspan="9"><cfif attributes.show IS "recent">Recent Activity<cfelseif attributes.show IS "All">All Users</cfif></td>
	</tr>
	
	<tr>
		<td colspan="9" style="BACKGROUND-COLOR: ###Request.GetColors.outputHBgcolor#;"><img src="#Request.AppSettings.defaultimages#/spacer.gif" alt="" height="1" width="1" /></td>
		</tr>	
	
<cfif qry_get_memberships.recordcount gt 0>

		<tr>
			<th>no.</th>
			<th align="left" colspan="2">user | product</th>
			<th align="left">key(s)</th>		
			<th align="left">days</th>
			<th align="left">accesses</th>
			<th align="left" colspan="2">start|expire</td>	
			<th align="left">valid</th>
			</tr>			

			
	<cfloop query="qry_get_Memberships" startrow="#PT_StartRow#" endrow="#PT_EndRow#">
		<tr>
			<td>
			<a href="#self#?fuseaction=access.admin&Membership=edit&Membership_ID=#Membership_ID##Request.Token2#">
			Edit #Membership_ID#</td>
			<td colspan="2"><a href="#self#?fuseaction=users.admin&user=summary&UID=#user_ID##Request.Token2#">#username#</a></td>
	
			<td>#AccessKey_ID#</td>
			<td>#time_count#</td>
			<td><cfif len(access_count) AND access_count IS NOT 0>#access_used# of #access_count#
			<cfelseif recur><strong>RECUR</strong> 
				<cfif recur_product_ID> to  #recur_product_ID#</cfif>
			</cfif></td>
			<td  colspan="2"><nobr>#Dateformat(start, "mm/dd/yy")#-<cfif len(suspend_begin_date)>
			<font color="red">#Dateformat(suspend_begin_date, "mm/dd/yy")#</font>
			<cfelse>#Dateformat(Expire, "mm/dd/yy")#</cfif></nobr>
			</td>			
			<td><cfif len(expire) AND DateCompare(Expire,now()) lt 1><font color="red">Expired</font>
			<cfelseif Disable is 1><span style="color:red;">FRAUD</span>
			<cfelseif valid is 0><a href="#self#?fuseaction=access.admin&membership=approve&membership_id=#membership_id##Request.Token2#">Validate</a><cfelseif len(start) AND DateCompare(start,now()) lt 1><span style="color:green; font-weight:bold;">Current</span><cfelse><span style="color:green;">Future</span></cfif></td>
			</tr>

		<tr>
			<td>&nbsp;</td>
			<td>#membership_Type#</td>
			<td colspan="4">#product_ID#: #product#</td>
			
			<!--- Recurring with BAD CCard ---->
			<cfif Recur AND (CardisValid is 0 OR NOT isDate(CardExpire) OR DateCompare(CardExpire,now(),'d') lt 1 )>
			<td bgcolor="red" colspan="3" align="right">BAD CARD</td>
			<cfelse>
			
				<cfif Recur AND DateCompare(CardExpire,now(),'m') is 0>
				<td bgcolor="yellow" colspan="3" align="right">
				<cfelse><td colspan="3" align="right"></cfif>

					<cfif Recur>Proc Now <a href="#self#?fuseaction=access.admin&membership=bill_recurring&membership_ID=#membership_ID#&offline=1#request.token2#">Offline</a><cfif CardisValid AND CardExpire gte Now()> | <a href="#self#?fuseaction=access.admin&membership=bill_recurring&membership_ID=#membership_ID##request.token2#">Online</a></cfif>
				</td></cfif>

			</cfif>
			
		</TR>				
			
	</cfloop>	
	</table>

	<div align="center" class="formtext">#pt_pagethru#</div>
	
<cfelse>	
	<tr>
		<td colspan="9"><br/>No records selected</td>
	</tr>
	</table>	

</cfif>		
</cfoutput>
		
</cfmodule>

		
		
