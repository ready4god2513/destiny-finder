<cfset obj_queries = CreateObject("component","cfcs.queries")>
<cfset foxyCart = CreateObject("component","cfcs.foxycart")>

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
	
	<section id="main">
		<div class="row">
			<h2 class="span6">My Account</h2>
			<div class="pull-right">
				<a href="/auth/index.cfm?page=user" class="btn info">Account Settings</a>
			</div>
		</div>
		
		<cfif foxyCart.customerPurchasedCode(email = REQUEST.user.user_email, code = "308B35B53DFCA91CA2CA2B8F450AB382")>
			<cfinclude template="../../site_modules/assessment/profiler.cfm" />
		</cfif>
		
		<div class="row">
			<div class="span15">
				<h3>My Transactions</h3>
				<cfset transactions = foxyCart.getCustomerTransactions(email = REQUEST.user.user_email) />
				
				<table>
					<thead>
						<tr>
							<th>Product</th>
							<th>Price</th>
							<th>Quantity</th>
							<th>Date</th>
						</tr>
					</thead>
					<tbody>
						<cfloop from="1" to="#arraylen(transactions)#" index="i">
							<cfoutput>
								<tr>
									<td>#transactions.transaction[i].transaction_details.transaction_detail.product_name.xmlText#</td>
									<td>#transactions.transaction[i].transaction_details.transaction_detail.product_price.xmlText#</td>
									<td>#transactions.transaction[i].transaction_details.transaction_detail.product_quantity.xmlText#</td>
									<td>#DateFormat(transactions.transaction[i].transaction_date.xmlText, "mmm dd, yyyy")#</td>
								</tr>
							</cfoutput>
						</cfloop>
					</tbody>
				</table>
			</div>
		</div>
	</section>

</cfmodule>