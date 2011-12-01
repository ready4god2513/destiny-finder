<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays a list of months available to show for the affiliate report. Called by shopping.affiliate&do=report --->
<cfmodule template="../../access/secure.cfm"
  keyname="users"
  requiredPermission="1"
  dsp_login_Required=""
 > 
<cfif ispermitted>   
	<cfparam name="attributes.uid" default="#Session.User_ID#">
<!--- If not permitted to see other people's order, force user ID to session user ID --->
<cfelse>
 	<cfset attributes.uid = Session.User_ID>	
</cfif>		

<cfinclude template="qry_get_affiliate_info.cfm">


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

<cfmodule template="../../customtags/format_box.cfm"
	box_title="Affiliate Center"
	border="1"
	align="left"
	float="center"
	Width="480"
	HBgcolor="#Request.GetColors.InputHBGCOLOR#"
	Htext="#Request.GetColors.InputHtext#"
	TBgcolor="#Request.GetColors.InputTBgcolor#">

	
	<cfinclude template="dsp_menu.cfm">
	
<cfoutput>
	<table border="0" cellpadding="0" cellspacing="4" width="100%" class="formtext"
	style="color:###Request.GetColors.InputTText#" >
	
	<cfif NOT GetInfo.Recordcount>
			<tr>
			<td align="center" class="formtitle">
				<p>Affiliate Information Incomplete!<br/> Please complete your registration.</p>
			</td>
		</tr>
		
	<cfelseif NOT GetDates.Recordcount>
		<tr>
			<td align="center" class="formtitle">
				<p>No Affiliate Orders Found</p>
			</td>
		</tr>

	<cfelse>
		<cfparam name="attributes.month" default="#LSDateFormat(Now(), "m, yyyy")#">
	
		<tr>
			<td align="center">
				<form action="#XHTMLFormat('#self#?fuseaction=shopping.affiliate&do=report&uid=#attributes.UID##request.token2#')#" method="post">
				AFFILIATE SALES REPORT for <select name="Month" size="1" class="formfield">
					<cfloop query="GetDates">
						<cfset ThisMonth = CreateDate(OrderYear, OrderMonth, 1)>
						<cfset theDate = LSDateFormat(ThisMonth, "m, yyyy")>
					<option value="#theDate#" #doSelected(attributes.month,theDate)#>#LSDateFormat(ThisMonth, "mmmm, yyyy")#</option>
					</cfloop>
				</select>
				&nbsp;<input type="submit" name="action" value="View" class="formbutton" />
				</form>
			</td>
		</tr>
		
		<cfif isdefined("attributes.action")>
		
			<cfinclude template="put_report.cfm">		
		
		</cfif>		
		
	</cfif>
	
		<tr>
			<td align="center">
			<form action="#XHTMLFormat('#Request.SecureURL##self#?fuseaction=users.manager#Request.AddToken#')#" method="post" class="margins">
				<input type="submit" name="Action" value="Back to My Account" class="formbutton" /> 
				</form>
			</td>
		</tr>
	
	</table>
</cfoutput>
</cfmodule>


