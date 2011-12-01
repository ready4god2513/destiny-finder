
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Display GiftWrap Form --->
	
<cfset giftlink = "#request.self#?fuseaction=shopping.giftwrap&item=#attributes.item##Request.Token2#">

<cfmodule template="../../customtags/format_output_box.cfm"
	box_title="Select Gift Wrapping"
	align="center"
	border="1"
	width="520"
	>
	<cfoutput>
	<table width="100%" cellspacing="0" border="0" cellpadding="3" class="formtext" style="color: ###Request.GetColors.OutputTText#;">	

		<tr>
			<td colspan="2">
			<div class="formtext" style="margin: 10 10 10 10;">
			Please make your gift wrapping selection by clicking an image or name.</div></td>
		</tr>

	<cfloop query="qry_get_giftwraps">
		
		<tr>
			<td><cfmodule template="../../customtags/putimage.cfm" filename="#Sm_Image#" filealt="#Name#" hspace="4" vspace="0" imglink="#XHTMLFormat('#giftlink#&giftwrap_ID=#giftwrap_ID#')#"></td>
			<td>
			<a href="#XHTMLFormat('#giftlink#&giftwrap_ID=#giftwrap_ID#')#" class="cat_title_small" #doMouseOver('Select This Giftwrap')#>#Name#</a><br/>
			<cfmodule template="../../customtags/puttext.cfm" Text="#Short_Desc#" Token="#Request.Token1#" ptag="no" class="cat_text_small"><br/>
			Price: #LSCurrencyFormat(Price)#
			</td>
		</tr>
	
	</cfloop>
	<tr>
		<td colspan="2" align="center"><br/>
			<form action="#XHTMLFormat("#giftlink#&giftwrap_ID=0#Request.token2#")#" method="post">
			<input name="cancel" type="submit" value="No Giftwrapping" class="formbutton">
		<br/>
		</form>
		</td>
	</tr>
	</table>
	</cfoutput>
</cfmodule>
