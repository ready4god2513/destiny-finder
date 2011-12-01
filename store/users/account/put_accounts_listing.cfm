<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This template outputs a formatted acount listing on results page --->

<cfoutput>
<table width="98%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
 	<td>
  		<cfif len(logo)>
			<cfmodule template="../../customtags/putimage.cfm" filename="#logo#" filealt="#Account_Name#" addbr="yes" />
		<cfelse>
			<span class="listingtitle">#account_name#</span><br/>
		</cfif>
	<cfif description is not "">
		<cfmodule template="../../customtags/puttext.cfm" Text="#description#" Token="#Request.Token1#"
		 class="listingsubtitle" ptag="no" /><br/>
	</cfif>
		<span class="listingtext">
		<!--- #company#,--->
		<cfif Len(trim(address1))>#address1#<br/></cfif>
		<cfif Len(trim(address2))>#address2#<br/></cfif>
		<cfif Len(city)>#city#, </cfif>
		<cfif Len(state) AND state IS NOT "Unlisted">#state#<cfelseif state IS "Unlisted" and Len(state2)>#state2# </cfif>
		<cfif Len(zip)>#zip# </cfif>
		<cfif len(country)and country is not request.appsettings.homecountry> &nbsp;<br/>#listgetat(Country,2,'^')#</cfif>
		</span><br/>
		
		<div style="margin-top:5px;" class="listingsubtext">
		<cfif Len(phone)>phone: #phone# &nbsp;<br/> </cfif>
		<cfif Len(phone2)>other phone: #phone2# &nbsp;<br/> </cfif>
		<cfif Len(fax)>fax: #fax#<br/></cfif>
		<cfif trim(web_url) is not "" AND trim(web_url) is not "http://">
			<a href='#XHTMLFormat(web_url)#' target='_new'>#XHTMLFormat(web_url)#</a><br/>
		</cfif>
		<cfif len(email) AND email is not request.appsettings.merchantemail>
		<!--- Make replacements for @ and . in address string to HIDE email address from spambots. --->
		<cfset email = Replace(email, "@", "&##64;", "All")>
		<cfset email = Replace(email, ".", "&##46;", "All")>
		email: <a href='mailto&##58;#email#'>#email#</a><br/>
		</cfif>
		<cfif trim(map_url) is not "" AND trim(map_url) is not "http://">
			<form action="#XHTMLFormat(map_url)#" method="post" target="map" class="margins">
				<input type="submit" value="Store Map" class="listingsubtext"/>
			</form>
		</cfif>
		</div>
		
	
 <!--- ADMIN EDIT LINK --->
<!--- Shopping Permission 4 = user/group admin --->
<cfmodule template="../../access/secure.cfm"
	keyname="users"
	requiredPermission="4"
	>		
	<p class="menu_admin">[<a href="#XHTMLFormat('#Request.SecureURL##self#?fuseaction=users.admin&account=edit&account_ID=#account_id##Request.AddToken#')#" #doAdmin()#>Edit Account #account_id#</a>]</p>
</cfmodule>

	 </td>
  </tr>
</table>
</cfoutput>
