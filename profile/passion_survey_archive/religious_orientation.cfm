
<cfinclude template="/templates/header.cfm">
<link rel="stylesheet" type="text/css" href="../site_styles/main.css">
<link rel="stylesheet" type="text/css" href="../site_styles/word_sort.css">
<div class="page-content">
<div class="assessment_radio box">
<h3>Religious Orientation </h3>
        <br />
		<form action="" method="post" id="">
			
					<label><input type="radio" name="family_individual" checked value="Hindu">Hindu</label>
					<label><input type="radio" name="family_individual" value="Buddhist">Buddhist</label>
					<label><input type="radio" name="family_individual" value="Moslem">Moslem</label>
					<label><input type="radio" name="family_individual" value="Jewish">Jewish</label>
					<label><input type="radio" name="family_individual" value="Christian">Christian</label>
                    <label><input type="radio" name="family_individual" value="Atheist/Post-Christian">Atheist/Post-Christian</label>
                    <label><input type="radio" name="family_individual" value="Agnostic">Agnostic</label>
                    <label><input type="radio" name="family_individual" value="Higher Power/Mishmash">Higher Power/Mishmash</label>
                    <label><input type="radio" name="family_individual" value="New Age">New Age</label>
                    <label><input type="radio" name="family_individual" value="Occult/Wicca/Satanic">Occult/Wicca/Satanic</label>
                    <label><input type="radio" name="family_individual" value="None">None</label>
	
		
				
			
             <!---CLIP #1--->
			<input class="btn primary" type="submit" name="submit" value="Next Step" />
           
		</form>
         <br class="clear"/>
        <div class="percent_complete_label">% of survey completed</div>
        <div class="percent_completed"><img src="/site_images/progbar_pix.png" width="0" height="21"></div>
</div><!--<div class="assessment_radio box">-->
</div><!--<div class="page-content">-->
<cfinclude template="/templates/footer.cfm">	
			

            
<!---#1
	   <div style="float:left;margin:10px 40px 0px 40px;">
          Instructions:<br />
            Pick the one sphere (A-E) you're drawn to impact. Then pick the two sub-spheres you are drawn to impact. Only use undecided if you're really not sure.
Fill in the "Other" blank if you don't find an answer close enough to your interest.
 </div>
 
 --->