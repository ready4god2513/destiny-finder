
<cfinclude template="/templates/header.cfm">
<link rel="stylesheet" type="text/css" href="../site_styles/main.css">
<link rel="stylesheet" type="text/css" href="../site_styles/word_sort.css">
<div class="page-content">
<div class="assessment_radio box">
<h3>I’m most troubled by the following human problems:</h3>
        <br />
        
		<form action="" method="post" id="">
			
					<label><input type="radio" name="human_problems" checked value="Physical Problems" />Physical Problems</label>
					<label><input type="radio" name="human_problems" value="Psychological Illness" />Psychological Illness</label>
					<label><input type="radio" name="human_problems" value="Addictions" />Addictions</label>
					<label><input type="radio" name="human_problems" value="Crime and Imprisonment" />Crime and Imprisonment </label>
					<label><input type="radio" name="human_problems" value="Sin Issues" />Sin Issues </label>
                    <label><input type="radio" name="human_problems" value="Spiritual Strongholds " />Spiritual Strongholds </label>
                    <label><input type="radio" name="human_problems" value="None" />None</label>
		
		
				
			
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