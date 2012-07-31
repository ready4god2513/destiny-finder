<cfset foxyCart = CreateObject("component","cfcs.foxycart") />

<div id="product-listing">

	<cfif NOT REQUEST.user_id OR (REQUEST.user_id GT 0 AND NOT foxyCart.customerPurchasedCode(email = REQUEST.user.user_email, code = Hash("profiler")))>
		<article class="single-product">
			<div class="row">

				<div class="product-image span3">
					<img src="/assets/images/profiler-module.png" alt="Profiler Module"/>
				</div>

				<div class="span7">
					<h4>Profiler Module - $<span id="current-profiler-price"><strike>19.95</strike>14.95</span></h4>
					<p>
						This module is an online tool that produces a destiny profile that is a 
						comprehensive picture of yourself. Includes the Destiny, Motivational, Supernatural, 
						Passion and Delight surveys. You'll love it or your money back!
					</p>

					<p>
						<strong>Like us on Facebook for a Discount!</strong>
						<div class="fb-like" data-href="https://www.facebook.com/mydestinyfinder" data-send="false" data-width="450" data-show-faces="false"></div>
					</p>

					<p>
						<a href="/products/index.cfm?page=profiler305&amp;gateway=3&amp;parent_gateway=3">More info</a>
					</p>

					<form action="https://destinyfinder.foxycart.com/cart" method="post" accept-charset="utf-8">
						<input type="hidden" name="name" value="Profiler Module" />
						<input type="hidden" name="code" value="<cfoutput>#Hash("profiler")#</cfoutput>" />
						<input type="hidden" name="quantity_max" value="1" />
						<input type="hidden" name="quantity_min" value="1" />
						<input type="hidden" name="price" id="profiler-price" value="14.95" />
						<input type="hidden" name="image" value="<cfoutput>#REQUEST.site_url#</cfoutput>/assets/images/profiler-module.png" />
						<input type="submit" value="Add to Cart" class="btn btn-primary" />
					</form>
				</div>

			</div>
		</article>
	</cfif>

	<article class="single-product">
		<div class="row">

			<div class="product-image span3">
				<img src="/assets/images/coaching.png" alt="1 Hour of Coaching"/>
			</div>

			<div class="span7">
				<h4>1 Hour of Coaching - $60</h4>

				<p>
					We offer destiny coaching, similar to life coaching, that is extremely valuable. 
					This is telephone coaching with a real person. One session with a coach might save you a 
					year of frustration.
				</p>
				<p>
					One hour of coaching consists of 15 min prep, 30 min. telephone session with the coach, 
					15 minutes of note taking and review.
				</p>
				<p><a href="/products/index.cfm?page=coaching&amp;gateway=3&amp;parent_gateway=3">More info</a></p>

				<form action="https://destinyfinder.foxycart.com/cart" method="post" accept-charset="utf-8">
					<input type="hidden" name="name" value="1 Hour of Coaching" />
					<input type="hidden" name="code" value="<cfoutput>#Hash("1-hour-coaching")#</cfoutput>" />
					<input type="hidden" name="quantity_max" value="999" />
					<input type="hidden" name="quantity_min" value="1" />
					<input type="hidden" name="price" value="60.00" />
					<input type="hidden" name="image" value="<cfoutput>#REQUEST.site_url#</cfoutput>/assets/images/coaching.png" />
					<input type="submit" value="Add to Cart" class="btn btn-primary" />
				</form>
			</div>

		</div>
	</article>

</div>

<script>
function showDiscountedPrice()
{
	$("#profiler-price").val("9.95");
	$("#current-profiler-price").html("<strike>14.95</strike> $9.95");
};

window.fbAsyncInit = function() {
	FB.Event.subscribe("edge.create",
		function(response) {
			showDiscountedPrice();
		}
	);
};
</script>