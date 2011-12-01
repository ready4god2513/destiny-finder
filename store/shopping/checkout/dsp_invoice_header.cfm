<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This template displays the invoice header; title, company, billto & shipto info. --->

<!--- Called by shopping.checkout (step=shipping|payment) --->

<!--- Title Header --->
<table width="520" border="0" cellspacing="0" cellpadding="6" align="center" class="formtext">
<cfoutput>
<tr>
	<th colspan="3" class="formbg" bgcolor="###Request.GetColors.BoxHBgcolor#"><span class="formheader"><b><font color="###Request.GetColors.BoxHText#">Current Order: #LSDateFormat(Now(), "mmmm d, yyyy")#, #TimeFormat(Now(), "h:mm tt")#</font></b></span></th>
</tr>
</cfoutput>

<!--- Addresses & Merchant --->
<tr>
	<td width="33%" valign="top">
		<!--- Print customer information --->
		<cfinclude template="put_billto.cfm">
		<cfoutput>
		#String#		
		<cfif attributes.step is "shipping" AND NOT PayPalExpress>
		<a href="#XHTMLFormat('#self#?fuseaction=shopping.checkout&step=address#Request.Token2#')#">[edit addresses]</a>
		</cfif>
		</cfoutput>
	</td>

	<td width="33%" valign="top">
		<!--- Print Ship To information --->
		<cfif GetShipTo.RecordCount>		
			<cfinclude template="put_shipto.cfm">
			<cfoutput>
			#String#
			<cfif attributes.step is "shipping" AND PayPalExpress>
			<a href="#XHTMLFormat('#self#?fuseaction=shopping.checkout&step=pp_express&edit_shipping=yes#request.token2#')#">[edit address]</a>
			</cfif>
			</cfoutput>
		</cfif>
	</td>

	<td width="34%" valign="top">
	<cfoutput>
	<cfif len(Request.AppSettings.Merchant)>
		<p>#Request.AppSettings.Merchant#<br/>
	</cfif>
	<cfif len(Request.AppSettings.MerchantEmail)>
		<a href="mailto:#Request.AppSettings.MerchantEmail#">#Request.AppSettings.MerchantEmail#</a>
	</cfif></p>
	</cfoutput>
	</td>
</tr>
</table><br/>

