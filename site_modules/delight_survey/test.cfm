<h2>Introduction</h2>
<p>
	God has designed you with talents and abilities that can be used to bless and serve others. And He has designed you to enjoy doing certain things that bless and serve others. If you can put the two together, you are on track for your destiny! If I absolutely love photography and I'm really good at it, that is something I should look at seriously in terms of my destiny. 
</p>
<p>
	The Delight Survey matches your strongest talents (things you are really good at doing) with your greatest loves (things you love to do or are most passionate about). As they say, do what you love!
</p>
<p>
	It's important to be realistic in terms of our talents. Wishing it doesn't make it true. Think about what you have done in which you excelled. What have you done for which you have received compliments, positive responses or awards?
</p>
<p>
	Now sometimes our talents don't match our loves. I might love ballet and want to be a ballerina, but if I don't have good coordination and balance, my destiny probably won't be to star in the New York Ballet. On the other hand, if I love dance and I'm really good at getting all my friends organized for dances, maybe I'll wind up managing the New York Ballet!
</p>
<p>
	We want you to think outside the box. Don't limit yourself and don't be afraid to enter something that may seem trivial to others. You are unique! As you start thinking of answers, more will come to you. List as many as you can and then match the ones that are the same or similar. 
</p>
<p>
	This may seem like a quick exercise, but take some time on it because as you come up with answers, they will spark more in your mind. If you retake the survey, your previous answers will be lost, so write them down (or take a picture of them with your camera phone) so you can re-enter them and add more if you do retake it.
</p>

<cfoutput>
	<form action="/profile/?page=assessment&assessment_id=6&gift_type_id=0" method="POST" id="listing-aptitudes">
		<h3>Talents</h3>
		<p>
			Instructions: List your top talents, the
			things you do best (skills, professions,
			strengths, abilities, hobbies, sports,
			etc.). Use as few words as possible.
			Don't limit yourself.
		</p>
		<p>
			<strong>Examples:</strong> accounting, basketball, organizing, singing, fishing, video games, finding bargains, gardening, sewing, coaching, writing poetry, video games, programming, decorating, photography, growing herbs, organizing information, leading hiking trips,  first aid, fixing cars, building houses, creating ads, trivia, dancing, arranging flowers, counseling children, running summer camps, swimming, managing groups, travel, retrieving data, managing money, getting travel bargains, internet research, training animals, boating teaching middle schoolers, mothering, leading groups, putting on art shows, welding, diagramming, building websites, photoshop, carpentry, blogging, promotion, graphics, military video games, writing articles, hair styling, physics, etc.
		</p>
		
		<cfloop from="1" to="20" index="i">
			<div class="control-group">
				<input type="text" id="aptitudes#i#" class="span6" name="aptitudes" placeholder="#i#." />
			</div>
		</cfloop>
		
		<h3>Loves</h3>
		<p>
			Instructions: List the top things you
			love to do or are most passionate
			about (skills, professions, strengths,
			abilities, hobbies, sports, etc ). Don't
			limit yourself.
		</p>
		<p>
			<strong>Examples:</strong> accounting, basketball, organizing, singing, fishing, video games, finding bargains, gardening, sewing, coaching, writing poetry, video games, programming, decorating, photography, growing herbs, organizing information, leading hiking trips,  first aid, fixing cars, building houses, creating ads, trivia, dancing, arranging flowers, counseling children, running summer camps, swimming, managing groups, travel, retrieving data, managing money, getting travel bargains, internet research, training animals, boating teaching middle schoolers, mothering, leading groups, putting on art shows, welding, diagramming, building websites, photoshop, carpentry, blogging, promotion, graphics, military video games, writing articles, hair styling, physics, etc.
		</p>
		
		<cfloop from="1" to="20" index="i">
			<div class="control-group">
				<input type="text" id="loves#i#" class="span6" name="loves" placeholder="#i#." />
			</div>
		</cfloop>
		
		<h3>Delights</h3>
		<p>
			Instructions: Find the talents and
			loves that match. Include ones that
			are similar to each other but not an
			exact match such as playing guitar
			and music.
		</p>
		<p>
			Enter the more specific of the two.
			Example: match "playing guitar" and
			"music" - enter "playing guitar."
		</p>
		
		<cfloop from="1" to="10" index="i">
			<div class="control-group">
				<input type="text" id="delights#i#" class="span6" name="delights" placeholder="#i#." />
			</div>
		</cfloop>

		<div class="form-actions">
			<input type="submit" name="submit" value="Submit Answers" class="btn btn-info" />
		</div>
	</form>
</cfoutput>

<script>
	$(function(){
		// Form Validations
		$("#listing-aptitudes").validate();
	});
</script>