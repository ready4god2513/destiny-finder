<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Used to output a list of article comments. Called from dsp_reviews_table.cfm --->

<cfset reviewlink = "#self#?fuseaction=feature.reviews&review_id=#review_id#">

<cfoutput>
	<tr>
		<td valign="top" align="left">#dateformat(posted,"mmm d, yyyy")#</td>
		<td valign="top" align="left"><a href="#XHTMLFormat('#reviewlink#&do=display#request.token2#')#"><strong>#title#</strong></a>
		<br/>
		<cfif len(attributes.Feature_ID)>
			<cfif Anonymous is 1>A Member<cfelseif user_ID><a href="#XHTMLFormat('#self#?fuseaction=feature.reviews&do=list&uid=#user_ID##request.token2#')#"><cfif len(anon_name)>#anon_name#<cfelse>#username#</cfif></a><cfelse>#anon_name#</cfif>
			
		<cfelse>Article: <a href="#XHTMLFormat('#self#?fuseaction=feature.display&feature_id=#feature_id##request.token2#')#" #doMouseover(Feature_Name)#>#Feature_Name#</a></cfif>
		
		</td>
		<td valign="top" align="left">
		
		<img src="#request.appsettings.defaultimages#/icons/#Rating#_med_stars.gif" alt="" />
		</td>
		<cfif attributes.do is "manager">
		<td valign="top" align="right">
			<!--- Written BY user --->
			<cfif user_id is Session.User_ID>
			[<a href="#XHTMLFormat('#reviewlink#&do=write#request.token2#')#">edit</a>] 
			[<a href="#XHTMLFormat('#reviewlink#&do=delete#request.token2#')#">delete</a>]
			</cfif>			
		</td>
		<cfelse>
			<td></td>
		</cfif>
	</tr>
	</cfoutput>