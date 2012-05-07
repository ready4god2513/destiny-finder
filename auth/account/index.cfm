<cfinclude template="../../site_modules/require_login.cfm" />

<cfset obj_queries = CreateObject("component","cfcs.queries") />
<cfset foxyCart = CreateObject("component","cfcs.foxycart") />

<cfparam name="URL.gateway" default="1">
<cfparam name="VARIABLES.page" default="user">
<cfparam name="VARIABLES.gateway_id" default="">
<cfparam name="VARIABLES.subtitle" default="Profile">

<cfparam name="URL.page" default="#VARIABLES.page#">

<!--- RETRIEVE THE PAGE CONTENT --->
<cfset qContent = obj_queries.get_content(page="#URL.page#")>

<cfmodule template="../../templates/site_wrapper.cfm"
	page_name="#qContent.content_name#"
    url_page="#URL.page#"
	gateway_id="#URL.gateway#"
	header_image="#qContent.content_header_img#"
	html_title="#qContent.content_html_title#"
	meta_desc="#qContent.content_meta_desc#">
	
	<div class="row">
		<div class="span11">
			<section id="main">
				<div class="row">
					<h2 class="span6">My Account</h2>
					<div class="pull-right">
						<h6><cfoutput>#REQUEST.user.user_first_name# #REQUEST.user.user_last_name#</cfoutput></h6>
						<h6><cfoutput>#REQUEST.user.user_email#</cfoutput></h6>
					</div>
					
				</div>
	
				<cfinclude template="../../site_modules/assessment/profiler.cfm" />
				
				<div class="row">
					<div id="account-settings" class="span6">
						<h2>Settings</h2>
						<a href="/auth/account/settings" class="btn btn-info">Account Settings</a>
					</div>
				</div>
	
				<h2>My Transactions</h2>
				<cfset transactions = foxyCart.getCustomerTransactions(email = REQUEST.user.user_email) />
				
				<cfif arraylen(transactions) GT 0>
					<table class="table table-striped table-bordered table-condensed">
						<thead>
							<tr>
								<th>Product</th>
								<th>Price</th>
								<th>Quantity</th>
								<th>Date</th>
							</tr>
						</thead>
						<tbody>
							<cfloop from="1" to="#arraylen(transactions.transaction)#" index="i">
								<cfoutput>
									<tr>
										<td>
											<cfif transactions.transaction[i].transaction_details.transaction_detail.product_name.xmlText EQ "1 Hour of Coaching">
												<a href="/about/?page=coachingintake" class="btn btn-info">Set up Coaching</a>
											<cfelse>
												#transactions.transaction[i].transaction_details.transaction_detail.product_name.xmlText#
											</cfif>
										</td>
										<td>#transactions.transaction[i].transaction_details.transaction_detail.product_price.xmlText#</td>
										<td>#transactions.transaction[i].transaction_details.transaction_detail.product_quantity.xmlText#</td>
										<td>#DateFormat(transactions.transaction[i].transaction_date.xmlText, "mmm dd, yyyy")#</td>
									</tr>
								</cfoutput>
							</cfloop>
						</tbody>
					</table>
				<cfelse>
					<div class="alert-message block-message warning">
						You do not yet have any transaction history.
					</div>
				</cfif>
			</section>
		</div>

		<cfinclude template="../../templates/sidebar.cfm" />
	</div>

</cfmodule>