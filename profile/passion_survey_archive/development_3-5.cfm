
<cfinclude template="/templates/header.cfm">
<link rel="stylesheet" type="text/css" href="../site_styles/main.css">
<link rel="stylesheet" type="text/css" href="../site_styles/word_sort.css">
<div class="page_content">
<div class="assessment_radio">
<div class="sort_name">Choose the stage you want to be at in 3-5 years:</div>
        <br />
		<form action="" method="post" id="">
			
					<label><input type="radio" name="development" checked value="Child">Child</label>
					<label><input type="radio" name="development" value="Adolescent">Adolescent</label>
					<label><input type="radio" name="development" value="Young Adult">Young Adult</label>
					<label><input type="radio" name="development" value="Adult">Adult</label>
					<label><input type="radio" name="development" value="Senior">Senior</label>
			
			
             <!--- <div style="float:left;margin:10px 40px 0px 40px;">
            Instructions:<br />
            Pick the one sphere (A-E) you're drawn to impact. Then pick the two sub-spheres you are drawn to impact. Only use undecided if you're really not sure.
Fill in the "Other" blank if you don't find an answer close enough to your interest.
 </div>--->
			<input style="margin:20px 0px 20px 250px;" type="image" src="/site_images/next_btn.jpg" name="submit" value="Submit"/>
		</form>
        
        <div class="percent_complete_label">% of survey completed</div><div class="percent_completed"><img src="/site_images/progbar_pix.png" width="0" height="21"></div>
</div>  
</div>
<cfinclude template="/templates/footer.cfm">	
			

            
			