
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the list of giftwrap options. Called by product.admin&giftwrap=list --->
	
		
<cfmodule template="../../../customtags/format_output_admin.cfm"
	box_title="Gift Wrapping Manager"
	width="550"
	>

<cfoutput>			
<table width="100%" cellspacing="4" border="0" cellpadding="0" class="formtext" style="color: ###Request.GetColors.OutputTText#;">		

	<tr>
		<td colspan="3">
			<a href="#request.self#?fuseaction=shopping.admin&giftwrap=add#Request.Token2#">Add Giftwrap</a> | <a href="#request.self#?fuseaction=shopping.admin&giftwrap=listform#Request.Token2#">List Edit</a></td>
		<td colspan="2" align="right">&nbsp;<!--- #pt_pagethru# ---></td>
	</tr>

	<tr>
		<td colspan="5" style="BACKGROUND-COLOR: ###Request.GetColors.outputHBgcolor#;">
		<img src="#Request.AppSettings.defaultimages#/spacer.gif" alt="" height="1" width="1" /></td>
	</tr>	
	
	
<!--- Make list of product IDs to send to next page --->
<cfset GiftwrapList = "">

	<tr>
		<th width="10%"></th>
		<th width="48%" align="left">Name</th>
		<th width="15%">Price</th>	
		<th width="15%">Priority</th>
		<th width="12%">Display</th>
	</tr>

	
<cfif qry_get_giftwraps.recordcount gt 0>					
	<cfloop query="qry_get_giftwraps">
		<!--- Add Giftwrap ID to the list --->
		<cfset GiftwrapList = ListAppend(GiftwrapList, giftwrap_ID)>
		<tr>
			<td><a href="#request.self#?fuseaction=shopping.admin&giftwrap=edit&giftwrap_ID=#giftwrap_ID##Request.Token2#">
			Edit #giftwrap_ID#</a></td>		

		<td>#Name#</td>		

		<td align="center">#LSCurrencyFormat(price)#</td>

		<td align="center">#iif(Priority IS 9999, 0, Priority)#</td>

		<td align="center"><cfif display is 1>Yes<cfelse>No</cfif></td>

	</tr>
			
			</cfloop>	
	</table>
	
	<cfelse>	
		<td colspan="5">
		<br/>
		No records selected
		</td>
	</table>	
	</cfif>

</cfoutput>
<!---- CLOSE MODULE ----->
</cfmodule>
		
