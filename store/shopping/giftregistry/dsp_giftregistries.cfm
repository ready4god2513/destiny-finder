
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This page outputs the gift registries query. --->

<cfoutput>
<table cellspacing="2" cellpadding="0" border="0" width="100%" class="mainpage">
	<tr>
		<th align="left">Name</th>
		<th align="left">Event</th>	
		<th align="left">Registry No.</th>	
		<td></td>
	</tr>
	
	<cfloop query="qry_Get_registries" startrow="#PT_StartRow#" endrow="#PT_EndRow#">
	<tr><td colspan="4"><cfmodule template="../../customtags/putline.cfm" linetype="thin"></td></tr>
	<tr>
		<td><strong>#Registrant#</strong>
			<cfif len(OtherName)><br/>Groom: #OtherName#</cfif>
		</td>
		<td><cfif len(event_date)>#dateformat(Event_Date,"mm/yyyy")#</cfif>
		<cfif len(City) or len(State)><br/>#City# #State#</cfif>
		</td>	
		<td>## #giftregistry_ID#</td>
		<td align="right"><a href="#XHTMLFormat('#request.self#?fuseaction=shopping.giftregistry&do=display&giftregistry_ID=#GiftRegistry_ID##request.token2#')#">view registry</a></td>
	</tr>
	</cfloop>

</table> </cfoutput>