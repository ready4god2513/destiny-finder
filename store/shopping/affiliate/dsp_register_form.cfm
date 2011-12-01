<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the registration form for new affiliates. Called by shopping.affiliate&do=register --->


<cfprocessingdirective suppresswhitespace="no">
<cfhtmlhead text="
<script type=""text/javascript"">
	<!--
		function CancelForm () {
		location.href = '#Request.SecureURL##self#?fuseaction=users.manager&redirect=yes#Request.AddToken#';
		}
	//-->
	</script>
">
</cfprocessingdirective>

<cfoutput>
<form name="editform" action="#XHTMLFormat('#self#?#cgi.query_string#')#" method="post">

<cfmodule template="../../customtags/format_input_form.cfm"
	box_title="Affiliate Registration"
	width="480">
	
	
	<tr align="left">
		<td colspan="3">
<p>Thanks for your interest in our affiliate program! Simply add links to our store on your site and you'll earn a #(get_User_Settings.AffPercent*100)#% commission on every sale made when a user follows that link and makes a purchase.</p>
				
<p>To join, simply enter the URL for your site and click the "Join" button.</p>
</td>
</tr>

<tr align="left">
<td nowrap="nowrap">Your Site URL:</td>
<td style="background-color: ###Request.GetColors.formreq#;" width="3">&nbsp;</td>
<td><input type="text" name="Aff_Site" size="50" maxlength="255" class="formfield"/></td>
</tr>
<tr align="left">
<td colspan="2"></td><td><br/>
<input type="submit" name="sub_affiliate" value="Join" class="formbutton"/> 
<input type="button" value="Cancel" class="formbutton" onclick="CancelForm();"/></td>
</tr>

</cfmodule>
</form>

<cfprocessingdirective suppresswhitespace="no">
<script type="text/javascript">
<!--
objForm = new qForm("editform");

objForm.required("Aff_Site");

objForm.Aff_Site.description = "Site URL";

qFormAPI.errorColor = "###Request.GetColors.formreq#";
//-->
</script>
</cfprocessingdirective>

</cfoutput>