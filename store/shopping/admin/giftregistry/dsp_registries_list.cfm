
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the list of Galleries. Called by shopping.admin&giftregistry=list --->

<cfparam name="attributes.displaycount" default="20">

<!--- Create the string with the filter parameters --->		
<cfset addedpath="&fuseaction=shopping.admin&giftregistry=#attributes.giftregistry#">
	<cfloop list="uid,uname,giftregistry_ID,name,city,giftregistry_Type,event_Date,display_status" index="counter">
	<cfif isdefined('attributes.' & counter) and len(evaluate('attributes.' & counter))>
		<cfset addedpath="#addedpath#&#counter#=" & evaluate('attributes.' & counter)>
	</cfif>
	</cfloop>
		
<cfparam name="currentpage" default="1">

<cfinclude template="../../../queries/qry_getpicklists.cfm">

<!--- Create the page through links, max records set by the display count --->		
<cfmodule template="../../../customtags/pagethru.cfm" 
	totalrecords="#qry_get_giftregistrys.recordcount#" 
	currentpage="#currentpage#"
	templateurl="#request.self#"
	addedpath="#addedpath##request.token2#"
	displaycount="#attributes.displaycount#" 
	imagepath="#request.appsettings.defaultimages#/icons/" 
	imageheight="12" 
	imagewidth="12"
	hilightcolor="###request.getcolors.mainlink#" 
	>
			
<cfmodule template="../../../customtags/format_output_admin.cfm"
	box_title="Gift Registry Manager"
	width="600"
	>	

<cfoutput>	
<table width="100%" cellspacing="4" border="0" cellpadding="0" class="formtext" style="color: ###Request.GetColors.OutputTText#;">	

	<tr>
		<td colspan="4">
			<a href="#request.self#?fuseaction=shopping.admin&giftregistry=add#Request.Token2#">New Registry</a></td>
		<td colspan="4"	align="right">#pt_pagethru#</td>
	</tr>

	<form action="#request.self#?fuseaction=shopping.admin&giftregistry=list#request.token2#" method="post">

	<tr>
		<td><span class="formtextsmall"><br/></span>
		<input type="submit" value="Search" class="formbutton"/></td>
	
		<td><span class="formtextsmall">ID<br/></span>
			<input type="text" name="giftregistry_ID" size="5" maxlength="25" class="formfield" value="#attributes.giftregistry_ID#"/></td>	

		<td><span class="formtextsmall">name (event or person)<br/></span>
			<input type="text" name="name" size="20" maxlength="25" class="formfield" value="#HTMLEditFormat(attributes.name)#"/></td>	
	
		<td><span class="formtextsmall">city/state<br/></span>
			<input type="text" name="city" size="8" maxlength="25" class="formfield" value="#HTMLEditFormat(attributes.city)#"/></td>	
	
		<td><span class="formtextsmall">type<br/></span>
		<select name="giftregistry_Type" size="1" class="formfield">
			<option value="">all</option>
			<cfmodule template="../../../customtags/form/dropdown.cfm"
			mode="valuelist"
			valuelist="#qry_getpicklists.giftregistry_type#"
			selected="#attributes.giftregistry_type#"
			/>
	 	</select>
		</td>	

		<td><span class="formtextsmall">event date*<br/></span>
			<input type="text" name="event_Date" size="8" maxlength="25" class="formfield" value="#attributes.event_Date#"/></td>	
	
		<td><span class="formtextsmall">status<br/></span>
			<select name="display_status" class="formfield">
			<option value="" #doSelected(attributes.display_status,'')#>all</option>
			<option value="off" #doSelected(attributes.display_status,'off')#>off</option>
			<!--- <option value="editor" #doSelected(attributes.display_status,'editor')#>editor</option> --->
			<option value="upcoming" #doSelected(attributes.display_status,'upcoming')#>upcoming</option>
			<option value="over" #doSelected(attributes.display_status,'over')#>over</option>
			<option value="expired" #doSelected(attributes.display_status,'expired')#>expired</option>		
			</select>	
		</td>			
			
		<td><span class="formtextsmall"><br/></span>
		<a href="#request.self#?fuseaction=shopping.admin&giftregistry=list#Request.Token2#">ALL</a><br/>
		</td></tr>
		</form>
		
	<tr>
		<td colspan="8" style="BACKGROUND-COLOR: ###Request.GetColors.outputHBgcolor#;">
		<img src="#Request.AppSettings.defaultimages#/spacer.gif" alt="" height="1" width="1" /></td>
	</tr>		
	
<cfif qry_get_giftregistrys.recordcount gt 0>
	<cfloop query="qry_get_giftregistrys" startrow="#PT_StartRow#" endrow="#PT_EndRow#">
		<tr>
			<td><a href="#request.self#?fuseaction=shopping.admin&giftregistry=edit&giftregistry_ID=#giftregistry_id##Request.Token2#">Edit #giftregistry_id#</a></td>
			
			<td colspan="3">
			<a href="#request.self#?fuseaction=shopping.giftregistry&do=display&giftregistry_ID=#giftregistry_ID##request.token2#" target="store">#left(Event_name,41)#<cfif len(Event_name) gt 41>...</cfif></a>
			</td>
			
			<td>#giftregistry_type#</td>

			<td>#dateformat(Event_Date,"mm/dd/yyyy")#</td>
					
			<td>
		<cfif live is "0"><font color="red">off</font>
		<!--- <cfelseif approved is "0"><font color="gold">editor</font> --->
		<cfelseif Event_Date gt now()>upcoming
		<cfelseif Event_Date lte now() AND expire GT Now()><font color="orange">over</font>
		<cfelse><font color="red">expired</font>
		</cfif>		
			</td>
	
			<td><a href="#request.self#?fuseaction=shopping.admin&giftregistry=listitems&giftregistry_ID=#giftregistry_id##Request.Token2#">Gift Items</a></td>	
	
		</tr>
		<tr class="formtextsmall">
			<td>&nbsp;</td>
			<td colspan="3">#Registrant# #OtherName#</td>
			<td colspan="3">#city# #state#</td>
			<td>&nbsp;</td>
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

<div class="formtextsmall" align="center">(*) search for event date should be entered in the format yy-mm-dd;<br/>partial dates used to search by year, then month, then day.</div>
