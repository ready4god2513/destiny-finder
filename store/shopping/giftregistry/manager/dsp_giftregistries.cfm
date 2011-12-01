
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This template is used to display the user's giftregistries. Called by shopping.giftregistries --->

<cfparam name="attributes.message" default="">
<cfparam name="attributes.currentpage" default="1">

<!--- Define URL for pagethrough --->
<cfset addedpath="&fuseaction=#attributes.fuseaction#">
<cfset action = "#request.self#?fuseaction=shopping.giftregistry#request.token2#">

<cfhtmlhead text="<script type='text/javascript' src='includes/openwin.js'></script>">

<cfmodule template="../../../customtags/puttitle.cfm" TitleText="Gift Registry" class="cat_title_large">

<!--- Create the page through links, max records set to 20 --->
<cfmodule template="../../../customtags/pagethru.cfm" 
	totalrecords="#qry_Get_registries.recordcount#" 
	currentpage="#attributes.currentpage#"
	templateurl="#request.self#"
	addedpath="#addedpath##request.token2#"
	displaycount="5" 
	imagepath="#request.appsettings.defaultimages#/icons/" 
	imageheight="12" 
	imagewidth="12"
	hilitecolor="###request.getcolors.mainlink#" >
	
	<cfoutput>
	
	<cfif len(attributes.message)>
	<div class="formerror"><b>#attributes.message#</b><br/><br/></div>
	</cfif>
	
	<cfloop query="qry_Get_registries" startrow="#pt_StartRow#" endrow="#pt_EndRow#">
	<br/><br/>
	<table cellspacing="2" cellpadding="2" border="0" width="100%" class="formtext">
	
		<tr>
			<td class="formtitle" width="70%"><!--- ID #giftregistry_ID#:  --->#Event_Name#</td>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<td><!--- #GiftRegistry_Type# --->Event Date - #DateFormat(Event_Date,'MM/DD/YY')#</td>
			<td><a href="#XHTMLFormat('#action#&manage=edit&giftregistry_id=#giftregistry_ID#')#">Edit Registry Info</a></td>
		</tr>	
		<tr>
			<td>#Registrant# <cfif len(OtherName)>& #OtherName#</cfif></td>
			<td>
				<cfif request.appsettings.prodroot IS NOT 0>
					<a href="#XHTMLFormat('#self#?fuseaction=category.display&category_ID=#request.appsettings.prodroot##Request.Token2#')#">
				<cfelse>
					<a href="#XHTMLFormat('#self##Request.Token1#')#">
				</cfif>Add Products to Registry</a></td>
		</tr>	
		<tr>
			<td>Searchable by Name: <cfif Private is 1>Private (Use ID ##)<cfelse>Yes</cfif></td>
			<td><a href="#XHTMLFormat('#action#&manage=items&giftregistry_id=#giftregistry_ID#')#">View the Registry</a></td>
		</tr>	
		<tr>
			<td>Status: <cfif live is 1>Active thru <cfelse>Not Active. Removed on </cfif>  #dateformat(Expire,"mm/dd/yy")#</td>
			<td><a href="javascript:newWindow=openWin('#XHTMLFormat('#action#&manage=print&giftregistry_id=#giftregistry_ID#')#','Registry','width=700,height=500,toolbar=0,location=0,directories=0,status=0,menuBar=1,scrollBars=1,resizable=1'); newWindow.focus();">Print Registry</a></td>
		</tr>		
<tr>
			<td>&nbsp;</td>
			<td><a href="#XHTMLFormat('#action#&manage=notify&giftregistry_id=#giftregistry_ID#')#">Notify Friends</a></td>
		</tr>	
		
		
		<!----------------
		<tr>
			<td>Event</td>
			<td>Event Type</td>
			<td>Event Date</td>
			<td>Searchable</td>
			<td>Status</td>
			<td>Items</td>
		</tr>
		<tr>
			<td>#Event_Name#</td>
			<td>#GiftRegistry_Type#</td>
			<td>#DateFormat(Event_Date,'MM/DD/YY')#</td>
			<td><cfif Private is 1>Private<cfelse>Searchable</cfif></td>
			<td><cfif live is 1>Active<cfelse>Not Active</cfif></td>
			<td></td>
		</tr>
		<tr>
			<td colspan="6" align="center">
			<a href="#request.self#?fuseaction=category.display&category_ID=#request.appsettings.ProdRoot##request.token1#">Add Products</a> | 
			<a href="#request.self#?fuseaction=shopping.giftregistry&manage=items&giftregistry_id=#giftregistry_ID##request.token2#">View Products</a> | 
			<a href="#request.self#?fuseaction=shopping.giftregistry&manage=notify&giftregistry_id=#giftregistry_ID##request.token2#">Notify Friends</a> | 
			<a href="#request.self#?fuseaction=shopping.giftregistry&manage=edit&giftregistry_id=#giftregistry_ID##request.token2#">Edit Settings</a>
			</td>
		</tr>
		----------->
	</table>	
	
	<br/><br/>
	<cfmodule template="../../../customtags/putline.cfm" linetype="Thin">
	</cfloop>

	</cfoutput>

<!--- Hide link to create new registry --->
<!--- <cfoutput><div align="center">#pt_pagethru#</div><br/>

<a href="#request.self#?fuseaction=shopping.giftregistry&manage=add#request.token2#">Create a New Registry</a>
</cfoutput> --->

