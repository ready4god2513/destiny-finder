
<cfinclude template="/templates/header.cfm">
<link rel="stylesheet" type="text/css" href="../site_styles/main.css">
<link rel="stylesheet" type="text/css" href="../site_styles/word_sort.css">
<div class="page-content">
<div class="assessment_radio box">
<h3>The group size I prefer to work with is</h3>
        <br />
        
		<form action="" method="post" id="">
			
					<label><input type="radio" name="group_size" checked value="One-on-one">One-on-one</label>
					<label><input type="radio" name="group_size" value="Small Group">Small Group (10+)</label>
					<label><input type="radio" name="group_size" value="Mid-sized Group">Mid-sized Group (50+)</label>
					<label><input type="radio" name="group_size" value="Large Group">Large Group (100+)</label>
					<label><input type="radio" name="group_size" value="Mega-size Group">Mega-size Group (1000+)</label>
                    <label><input type="radio" name="group_size" value="International – Itinerate">International – Itinerate</label>
		
		
				
			
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