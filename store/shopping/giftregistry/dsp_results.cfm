
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Used to output the listing of gift registries. Called by shopping.giftregistry&do=results --->

<cfparam name="attributes.currentpage" default=1>

<!--- Define URL for pagethrough --->
<cfset addedpath="&fuseaction=#attributes.fuseaction#">

<!--- Create the string with the filter parameters --->	
<cfloop index="namedex" list="do,name,sort,order">
	<cfif isdefined("attributes.#namedex#") and Evaluate("attributes." & namedex) is not "">
		<cfset addedpath="#addedpath#&#namedex#=" & Evaluate('attributes.' & namedex)>
	</cfif>
</cfloop>

<cfparam name="attributes.displaycount" default= "20">

<!--- Create the page through links, max records set by the display count --->
<cfmodule template="../../customtags/pagethru.cfm" 
	totalrecords="#qry_Get_registries.recordcount#" 
	currentpage="#attributes.currentpage#"
	templateurl="#request.self#"
	addedpath="#addedpath##request.token2#"
	displaycount="#attributes.displaycount#" 
	imagepath="#request.appsettings.defaultimages#/icons/" 
	imageheight="12" 
	imagewidth="12"
	hilitecolor="###request.getcolors.mainlink#" >
	
	
<cfif qry_Get_registries.recordcount gt 0>

	<cfinclude template="put_searchheader.cfm">
	<cfinclude template="dsp_giftregistries.cfm">
	<cfinclude template="put_searchfooter.cfm">
	
<cfelse>

	<cfoutput>
		<p class="ResultHead">No Gift Registries found. Be sure to enter valid search criteria.	
		<cfmodule template="../../customtags/putline.cfm" linetype="Thick">
		</p>
	</cfoutput>


</cfif>
<p>&nbsp;</p>
<div class="formtitle">Search Again</div>

<cfoutput>
<form name="searchform" method="post"
action="#XHTMLFormat('#request.self#?fuseaction=shopping.giftregistry&do=results#request.Token2#')#" >
<table cellpadding="0" cellspacing="6" class="formtext">
	<tr>
		<td>Name:</td>
		<td><input type="text" name="Name" size="20" maxlength="30" value="" class="formfield"/></td>
		<td>City or State:</td>
		<td><input type="text" name="city" size="20" maxlength="30" value="" class="formfield"/></td>		
  	   	<td><input type="submit" name="frm_submit" value="Search" class="formbutton"/></td>
 	</tr>
</table>
</form>
</cfoutput>