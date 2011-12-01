
<cfinclude template="/templates/header.cfm">
<link rel="stylesheet" type="text/css" href="../site_styles/main.css">
<link rel="stylesheet" type="text/css" href="../site_styles/word_sort.css">
<div class="page_content">
<div class="assessment_radio">
<div class="sort_name">I feel most drawn to impact people with the following ethnicity:</div>
        <br />
        
		<form action="" method="post" id="">
			
					<label><input type="radio" name="drawn_to_impact_ethnicity" checked value="Caucasian">Caucasian</label>
					<label><input type="radio" name="drawn_to_impact_ethnicity" value="Black">Black</label>
					<label><input type="radio" name="drawn_to_impact_ethnicity" value="Hispanic">Hispanic</label>
					<label><input type="radio" name="drawn_to_impact_ethnicity" value="Asian and Pacific Islander">Asian and Pacific Islander</label>
					<label><input type="radio" name="drawn_to_impact_ethnicity" value="Middle Eastern/Arabic">Middle Eastern/Arabic</label>
                    <label><input type="radio" name="drawn_to_impact_ethnicity" value="Mixed">Mixed</label>
                    <label><input type="radio" name="drawn_to_impact_ethnicity" value="Any">Any</label>
                    <label><input type="radio" name="drawn_to_impact_ethnicity" value="None">None</label>
		
		
				
			
             <!---CLIP #1--->
			<input style="margin:20px 0px 20px 250px; float:left" type="image" src="/site_images/next_btn.jpg" name="submit" value="Submit"/>
           
		</form>
         <br class="clear"/>
        <div class="percent_complete_label">% of survey completed</div>
        <div class="percent_completed"><img src="/site_images/progbar_pix.png" width="0" height="21"></div>
</div><!--<div class="assessment_radio">-->
</div><!--<div class="page_content">-->
<cfinclude template="/templates/footer.cfm">	
			

            
<!---#1
	   <div style="float:left;margin:10px 40px 0px 40px;">
          Instructions:<br />
            Pick the one sphere (A-E) you're drawn to impact. Then pick the two sub-spheres you are drawn to impact. Only use undecided if you're really not sure.
Fill in the "Other" blank if you don't find an answer close enough to your interest.
 </div>
 
 --->