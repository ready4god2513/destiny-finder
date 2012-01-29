<cfoutput>
	<cfif thistag.executionmode EQ "start">
		
		<article class="single-product">
			<div class="row">

				<div class="product-image span3">
					<img src="/assets/images/#ATTRIBUTES.image#" alt="#ATTRIBUTES.product_name#"/>
				</div>

				<div class="span12">
					<h4>#ATTRIBUTES.product_name#</h4>
					<p>#ATTRIBUTES.description#</p>

					<cfif #ATTRIBUTES.available# eq true>
						<form action="https://destinyfinder.foxycart.com/cart" method="post" accept-charset="utf-8">
							<input type="hidden" name="name" value="#ATTRIBUTES.product_name#" />
							<input type="hidden" name="price" value="#ATTRIBUTES.price#" />
							<input type="hidden" name="product_id" value="#ATTRIBUTES.product_id#" />
							<input type="hidden" name="image" value="#REQUEST.site_url#/assets/images/#ATTRIBUTES.image#" />
							<input type="submit" value="Add to Cart" class="btn primary" />
						</form>
					<cfelse>
						<a href="##" class="btn disabled">Coming Soon</a>
					</cfif>
				</div>

			</div>
		</article>
		
	</cfif>
</cfoutput>