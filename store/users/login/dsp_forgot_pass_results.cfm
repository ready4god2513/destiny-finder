
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<cfparam name="errormess" default="">

<!--- Display results form ---->
<cfmodule template="../../customtags/format_input_form.cfm"
box_title="Password Help"
width="350"
border="1"
align="center"
required_fields="0"
>
	<tr><td align="center" class="formtitle">
<cfif NOT GetCustInfo.RecordCount>
	<cfoutput>
	<p class="formerror">Email not found.</p>
	<form action="#XHTMLFormat('#self#?fuseaction=users.forgot#Request.Token2#')#" method="post">
		<input type="submit" value="Try Another Address" class="formbutton"/>
	</form>

	<form action="#XHTMLFormat('#self#?fuseaction=users.#request.reg_form##Request.Token2#')#" method="post">
		<input type="submit" value="Register Now" class="formbutton"/>
	</form>	

	</cfoutput>
	
<cfelseif len(errormess)>
	<cfoutput>
	<p class="formerror">#errormess#</p>
	<form action="#XHTMLFormat('#self#?fuseaction=users.forgot#Request.Token2#')#" method="post">
		<input type="submit" value="Try Another Address" class="formbutton"/>
	</form>

	<form action="#XHTMLFormat('#session.page#')#" method="post">
		<input type="submit" value="Return to Store" class="formbutton"/>
	</form>	

	</cfoutput>

<cfelse>
	<cfoutput><p>Your password has been reset and emailed to you.</p></cfoutput>
</cfif>
	<cfoutput>
	<form action="#XHTMLFormat('#self##request.token1#')#" method="post" class="margins">
		<input type="submit" value="Back to Site" class="formbutton"/>
	</form>	
	</cfoutput>
	</td></tr>
</cfmodule>