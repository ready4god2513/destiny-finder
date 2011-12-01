<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Called from users.manager to display the user's "My Account" page. --->
<cfinclude template="../qry_get_user.cfm">

<cfset attributes.customer_ID = qry_get_User.customer_id>

<cfif get_User_Settings.ShowAccount OR get_User_Settings.AllowWholesale>
	<cfinclude template="../qry_get_account.cfm">
</cfif>

<!--- Insert text entered in the Page Manager --->
<cfmodule template="../../#self#"
	fuseaction="page.manager"
	>

	
<!--- Start Layout Table which holds the User's registration information. --->
<table class="formtext" width="468" align="center" >
<tr><td colspan="2">

	<cfoutput>
	<!--- Registration table, the first row of the Layout Table ----->
	<table class="formtext" cellspacing="0" cellpadding="2" width="100%" style="BACKGROUND-COLOR: ###Request.GetColors.OutputtBGCOLOR#; COLOR: ###Request.GetColors.OutputtTEXT#;">
		<tr style="BACKGROUND-COLOR: ###Request.GetColors.OutputHBGCOLOR#; COLOR: ###Request.GetColors.OutputHTEXT#;">
		<th colspan="2" align="left">Log in Information</th>
		<td align="right"><a href="#XHTMLFormat('#self#?fuseaction=users.logout#Request.Token2#')#" class="managerbutton">&nbsp; logout&nbsp;</a></td>
	</tr>
	
	<cfif get_User_Settings.EmailAsName>
	<tr>
		<td width="18%">Sign in:</td>
		<td width="60%">#qry_get_user.email# 
		<cfif qry_get_user.emailLock is "verified">(confirmed)
		<cfelseif len(qry_get_user.emailLock)>
		<br/><a href="#XHTMLFormat('#self#?fuseaction=users.unlock#Request.Token2#')#" class="formerror"><strong>Click Here To Confirm Your Email Address.</strong></a>
		</cfif>
		</td>
		<td width="22%" align="right"><a href="#XHTMLFormat('#self#?fuseaction=users.password#Request.Token2#')#">edit sign in</a></td>
	</tr>
	<cfelse>
	<tr>
		<td width="18%">Username:</td>
		<td width="60%">#qry_get_user.Username#</td>
		<td width="22%" align="right"><a href="#XHTMLFormat('#self#?fuseaction=users.password#Request.Token2#')#">edit password</a></td>
	</tr>
	<tr>
		<td>Email:</td>
		<td>#qry_get_user.email# 
		<cfif len(qry_get_user.emailLock) AND qry_get_user.emailLock neq "verified">
		<br/><a href="#XHTMLFormat('#self#?fuseaction=users.unlock#Request.Token2#')#" class="formerror">Click to Confirm this Email Address.</a>
		<cfelseif qry_get_user.EmailIsBad is 1>
		<br/><a href="#XHTMLFormat('#self#?fuseaction=users.email#Request.Token2#')#" class="formerror">Please Update</a>
		<cfelseif qry_get_user.emailLock is "verified">(confirmed)
		</cfif>
		</td>
		<td align="right"><a href="#XHTMLFormat('#self#?fuseaction=users.email#Request.Token2#')#">change</a></td>
	</tr>
	</cfif>
	
	<cfif get_User_Settings.UseBirthdate>
	<tr>
		<td>Birth date:</td>
		<td>#dateformat(qry_get_user.birthdate, "mm/dd/yyyy")#</td>
		<td align="right"><a href="#XHTMLFormat('#self#?fuseaction=users.birthdate#Request.Token2#')#">change</a></td>
	</tr>
	</cfif>
	
	<cfif get_User_Settings.UseCCard>
	<tr>
		<td>Credit Card:</td>
		<td><cfif not len(qry_get_user.cardtype)>
		<a href="#XHTMLFormat('#self#?fuseaction=users.ccard#Request.Token2#')#" class="formerror">
		No Card On File - PLEASE UPDATE</a>
		<cfelse>#qry_get_user.cardtype# Card - 
			<cfif NOT isDate(qry_get_user.CardExpire) OR DateCompare(qry_get_user.CardExpire,now(),'m') lt 1>
			<a href="#XHTMLFormat('#self#?fuseaction=users.ccard#Request.Token2#')#" class="formerror">
			PLEASE UPDATE</a>
			<cfelseif qry_get_user.CardisValid is 0>
			PENDING APPROVAL
			<cfelse>
			Current
			</cfif>
		</cfif></td>
		<td align="right"><a href="#XHTMLFormat('#self#?fuseaction=users.ccard#Request.Token2#')#">update</a></td>
	</tr>
	</cfif>
	
	<cfif get_User_Settings.ShowSubscribe>
	<tr>
		<td>Subscribe:</td>
		<td><cfif qry_get_user.Subscribe>Yes<cfelse>No</cfif></td>
		<td align="right"><a href="#XHTMLFormat('#self#?fuseaction=users.subscribe#Request.Token2#')#">change</a></td>
	</tr>
	</cfif>

</table>
</cfoutput>
	
		</td>
	</tr>

	<!--- Account Information on row 2 of the Layout Table --->
<cfif get_User_Settings.ShowAccount and qry_get_account.recordcount>	
	<tr><td colspan="2">
	
	<cfoutput>
		<!--- Account information --->
		<table class="formtext" cellspacing="0" cellpadding="2" width="100%" style="BACKGROUND-COLOR: ###Request.GetColors.OutputtBGCOLOR#; COLOR: ###Request.GetColors.OutputtTEXT#;">
				<tr style="BACKGROUND-COLOR: ###Request.GetColors.OutputHBGCOLOR#; COLOR: ###Request.GetColors.OutputHTEXT#;">
		<th colspan="3" align="left">Business Account</th>
	</tr>
	<tr>
		<td width="25%">Account Name:</td>
		<td width="60%"><cfif len(qry_get_account.account_name)>#qry_get_account.account_name#<cfelse>No</cfif></td>
		<td width="15%" align="right"><a href="#self#?fuseaction=users.account#Request.Token2#">change</a></td>
	</tr>
	<tr>
		<td>Account Type:</td>
		<td>#qry_get_account.type1#</td>
		<td align="right"></td>
	</tr>
	</cfoutput>	
	
	<cfif get_User_Settings.ShowDirectory>
	<tr>
		<td>Directory:</td>
		<td>	<cfif qry_get_account.customer_id gt 0>
					<cfset attributes.customer_ID = qry_get_account.customer_id>
					<cfinclude template="../qry_get_customer.cfm">
					<cfoutput>
					<cfif qry_get_customer.Company IS NOT "">#qry_get_customer.Company#, </cfif>
					#qry_get_customer.Address1#
					</cfoutput>
				<cfelse>
					Not Listed
				</cfif>
		</td>
	<cfoutput>
	<td align="right"><a href="#XHTMLFormat('#self#?fuseaction=users.address#iif(attributes.customer_id is not 0, DE('book'), DE(''))#&show=bill#iif(attributes.customer_id is 0, DE('&customer_id=0'), DE(''))##Request.Token2#')#">change</a></td>
	</cfoutput>
	</tr>
	</cfif>
	</table>
	</cfif>
	
	</td></tr>

	<!--- Third row of Layout Table has billing and shipping address --->
<cfoutput>	
	<tr>
		<!--- Contact/default billing address --->
		<td align="left" valign="top" style="BACKGROUND-COLOR: ###Request.GetColors.OutputtBGCOLOR#;"  <cfif not get_User_Settings.UseShipTo>colspan="2"</cfif> >	
			<!--- This table needs to be 100% in case no shipping address allowed --->
			<table class="formtext" cellspacing="0" cellpadding="2" width="100%" style="BACKGROUND-COLOR: ###Request.GetColors.OutputtBGCOLOR#; COLOR: ###Request.GetColors.OutputtTEXT#;">
				<tr style="BACKGROUND-COLOR: ###Request.GetColors.OutputHBGCOLOR#; COLOR: ###Request.GetColors.OutputHTEXT#;">
					<th align="left">Contact/Bill to:</th>
					<td align="right"><a href="#XHTMLFormat('#self#?fuseaction=users.address#iif(attributes.customer_id is not 0, DE('book'), DE(''))#&show=customer#iif(attributes.customer_id is 0, DE('&customer_id=0'), DE(''))##Request.Token2#')#" style="COLOR: ###Request.GetColors.OutputHTEXT#;">change</a></td>
				</tr>
</cfoutput>				
				<tr>
					<td colspan="2">
						<cfif qry_get_User.customer_id gt 0>
						<cfset attributes.customer_ID = qry_get_User.customer_id>
						<cfinclude template="put_customer.cfm">
						<cfelse>
						No customer information
						</cfif>
					</td>
				</tr>
			</table>			
		</td>

		<!--- Default shipto information --->
		<cfif get_User_Settings.UseShipTo>
		<cfoutput>	
				<!--- shipto --->
		<td align="left" valign="top" style="BACKGROUND-COLOR: ###Request.GetColors.OutputtBGCOLOR#;" width="50%">
			<!--- <cfset attributes.customer_ID = qry_get_User.shipto> --->
			<table class="formtext" cellspacing="0" cellpadding="2" width="230" style="BACKGROUND-COLOR: ###Request.GetColors.OutputtBGCOLOR#; COLOR: ###Request.GetColors.OutputtTEXT#;">
				<tr style="BACKGROUND-COLOR: ###Request.GetColors.OutputHBGCOLOR#; COLOR: ###Request.GetColors.OutputHTEXT#;">
					<th align="left">Ship to:</th>
					<td align="right"><a href="#XHTMLFormat('#self#?fuseaction=users.address#iif(attributes.customer_id is not 0, DE('book'), DE(''))#&show=ship#iif(attributes.customer_id is 0, DE('&customer_id=0'), DE(''))##Request.Token2#')#" style="COLOR: ###Request.GetColors.OutputHTEXT#;">change</a></td>
				</tr>
			</cfoutput>
				<tr>
					<td colspan="2">
			<cfif qry_get_user.shipto>
				<cfif qry_get_user.shipto and qry_get_user.shipto is not qry_get_user.customer_id>
					<cfset attributes.customer_ID = qry_get_User.shipto>
					<cfinclude template="put_customer.cfm">
				<cfelse>
					Same
				</cfif>
			<cfelse>
				No shipping information
			</cfif>
				</td>
				</tr>
			</table>
		</td>	
	</cfif>

	</tr>
</table><!--- end layout table --->	


<br/>

<!--- Table to hold links to additional user information --->
<table class="mainpage" width="468" align="center">
	<tr>
		<td><ul>
<cfoutput>	

	<li> <a href="#XHTMLFormat('#self#?fuseaction=shopping.history#Request.Token2#')#"><b>Order History</b></a> - View and check the status of your orders.<br/><br/></li>

	<cfif get_User_Settings.AllowWholesale and qry_get_account.recordcount is 0>
	<li> <a href="#XHTMLFormat('#self#?fuseaction=users.account#Request.Token2#')#"><b>Wholesale &amp; Distributor Accounts</b></a> - For access to Professional information, wholesale pricing and terms, please click here to open a Business Account.<br/><br/></li>
	</cfif>
	
	<cfif qry_get_user.Affiliate_ID IS NOT 0>
	<li> <a href="#XHTMLFormat('#self#?fuseaction=shopping.affiliate&do=report#Request.Token2#')#"><b>Affiliate Center</b></a> - View your affiliate information and reports.<br/><br/></li>
 
 	<cfelseif get_User_Settings.AllowAffs>
  	<li> <a href="#XHTMLFormat('#self#?fuseaction=shopping.affiliate&do=register#Request.Token2#')#"><b>Web Affiliate Signup</b></a> - 
Start earning money today by becoming an affiliate for our store. Simply create links from your site to our homepage, category or product pages, and you will receive a percentage of each order that is filled! It's free and it's easy, so sign-up right now!<br/><br/></li>
	</cfif>
	
	<cfif Request.AppSettings.wishlists>
	<li> <a href="#XHTMLFormat('#self#?fuseaction=shopping.wishlist#Request.Token2#')#"><b>WishList</b></a> - View your personal shopping/wish list.<br/><br/></li>
	</cfif>
	
	<cfif Request.AppSettings.GiftRegistry>
	<li> <a href="#XHTMLFormat('#self#?fuseaction=shopping.giftregistry#Request.Token2#')#"><b>Gift Registries</b></a> - View, edit and create gift registries accessible to others. <br/><br/></li>
	</cfif>
   
  	<li> <a href="#XHTMLFormat('#self#?fuseaction=access.memberships#Request.Token2#')#"><b>Site Access</b></a> - A list of your current memberships and purchased downloads.<br/><br/></li>

  	<li> <a href="#XHTMLFormat('#self#?fuseaction=access.download#Request.Token2#')#"><b>File Downloads</b></a> - Download purchased products here.<br/><br/></li>
<cfif request.appsettings.ProductReviews>
  	<li> <a href="#XHTMLFormat('#self#?fuseaction=product.reviews&do=manager#Request.Token2#')#"><b>My Reviews</b></a> - View and edit my product reviews.<br/><br/></li>

		<cfif request.appsettings.ProductReview_Add is 2 and qry_get_user.emaillock is not "verified">
		<blockquote>You must confirm your email address.<br/><br/>
				<li><a href="#XHTMLFormat('#self#?fuseaction=users.unlock&#request.token2#')#">Click Here To Confirm Your Email Address.</a></li>
		</blockquote>
		</cfif>	
		<br/>
</cfif>	


</cfoutput>
		</ul>
		</td>
	</tr>
</table>


