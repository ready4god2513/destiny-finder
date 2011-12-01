<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This template displays a user's memberships. It is linked from the user's account page. Called by the access.memberships fuseaction --->

<cfset MembershipActive = 0>
<cfset MembershipWillRecur = 0>

<cfmodule template="../customtags/format_box.cfm"
	box_title="Current Memberships"
	border="1"
	align="left"
	float="center"
	Width="480"
	HBgcolor="#Request.GetColors.InputHBGCOLOR#"
	Htext="#Request.GetColors.InputHtext#"
	TBgcolor="#Request.GetColors.InputTBgcolor#">
	
	<cfoutput>
	<table border="0" cellpadding="0" cellspacing="4" width="100%" class="formtext"
	style="color:###Request.GetColors.InputTText#"></cfoutput>

	<cfif NOT qry_get_Memberships.RecordCount>
		<tr><td align="center" colspan="3" class="formtitle">
			<p><br/>No current memberships found.</p></td></tr>
			
	<cfelse>
		<tr>
			<th align="center">Membership</th>
			<th align="center">Status</th>
			<th align="center">Start</th>
			<th align="center">Expires</th>
		</tr>

		<cfoutput query="qry_get_Memberships">
		<tr>
			<td><cfif prod_type is "download" AND access_count gt access_used AND Valid AND (NOT Len(Expire) OR DateCompare(Expire, Now()) GT 0) AND (NOT Len(Start) OR DateCompare(Start, Now()) LTE 0)>
			<a href="#XHTMLFormat('#self#?fuseaction=access.download&ID=#membership_id##Request.Token2#')#">#product#</a>
			<cfelseif len(product)>#product# <cfelse>Membership</cfif></td>
			<td><cfif prod_type is "download" and access_count lte access_used>DOWNLOADED<cfelseif NOT Valid>NOT APPROVED<cfelseif len(Expire) AND DateCompare(Expire, Now()) LTE 0>EXPIRED<cfelseif len(Start) AND DateCompare(Start, Now()) GT 0>INACTIVE<cfelse>ACTIVE<cfset MembershipActive = 1></cfif></td>
			<td align="center"><cfif len(start)>#dateformat(Start, "mm/dd/yyyy")#<cfelse>Now</cfif> </td>
			<td align="center"><cfif len(Expire)>#dateformat(expire, "mm/dd/yyyy")#<cfelse>Never</cfif> </td>
		</tr>
	<cfif recur>	
		<tr>
			<td colspan="4" align="center"><span class="caution">
			This Membership will auto-renew on #dateformat(expire, "mm/dd/yyyy")#</span><br/><br/>
			<form action="#XHTMLFormat('#self#?fuseaction=access.cancelrecur#Request.Token2#')#" method="post" name="recur" class="nomargins">
			<input type="hidden" name="Product_ID" value="#iif(Recur_Product_ID GT 0, Recur_Product_ID, product_ID)#"/>
			<input type="hidden" name="Membership_ID" value="#membership_ID#"/>			
			<input type="submit" name="do_renew" class="formbutton" value="Renew Now"/> &nbsp; 
			<input type="submit" name="cancel_recur" class="formbutton" value="Cancel This Renewal"/><br/><br/>			
			</form>
			</td>
		</tr>
		
		<cfset MembershipWillRecur = 1>
		
		</cfif>
		</cfoutput>
		
	</cfif>
	
	<!--- Show if not a custom tag call --->
	<cfif not IsDefined("ThisTag.ExecutionMode")>
	<tr>
		<td align="center" colspan="4" class="formtitle">
			<cfoutput>
			<form action="#XHTMLFormat('#Request.SecureURL##self#?fuseaction=users.manager#Request.AddToken#')#" method="post" class="margins">
			</cfoutput>
			<input type="submit" value="Back to My Account" class="formbutton"/>
			</form>
		</td>
	</tr>
	</cfif>
	
	</table>

</cfmodule>



	<!---Display list of memberships if no current membership --->
	<cfif NOT MembershipActive or NOT MembershipWillRecur>
	<br/>
	<table border="0" cellpadding="0" cellspacing="4" width="480" class="formtext" align="center">
		<tr><td>
		<span class="formtitle">Renew Your Membership</span>
		<br/><br/>
		<cfmodule template="../customtags/putline.cfm" linetype="thin">
		
		<cfmodule template="../index.cfm"
			fuseaction="product.list"
			category_id=""
			type="membership"
			searchheader="0"
			searchform="0"
			thickline="0"
			listing="membership"
			productCols="1"
			>
		</td></tr>
	</table>	
	</cfif>
