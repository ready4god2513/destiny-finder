
<cfinclude template="/templates/header.cfm">
<link rel="stylesheet" type="text/css" href="../site_styles/main.css">
<link rel="stylesheet" type="text/css" href="../site_styles/word_sort.css">
<div class="page_content">
<div class="assessment_radio box">
<div class="sort_name">I feel most passionate about the following social causes:</div>
        <br />
        
		<form action="" method="post" id="">
			
					<label><input type="radio" name="passion" checked value="Human Reproduction" />Human Reproduction</label>
					<label><input type="radio" name="passion" value="Broken Families" />Broken Families</label>
					<label><input type="radio" name="passion" value="Economic issues" />Economic issues</label>
					<label><input type="radio" name="passion" value="Ignorance" />Ignorance </label>
					<label><input type="radio" name="passion" value="Justice Issues" />Justice Issues</label>
                    <label><input type="radio" name="passion" value="Political" />Political </label>
                    <label><input type="radio" name="passion" value="None" />None</label>
		
				
			
             <!---CLIP #1--->
			<input class="btn primary" type="submit" name="submit" value="Next Step" />
           
		</form>
         <br class="clear"/>
        <div class="percent_complete_label">% of survey completed</div>
        <div class="percent_completed"><img src="/site_images/progbar_pix.png" width="0" height="21"></div>
</div><!--<div class="assessment_radio box">-->
</div><!--<div class="page_content">-->
<cfinclude template="/templates/footer.cfm">	
			

            
<!---#1
	   <div style="float:left;margin:10px 40px 0px 40px;">
          Instructions:<br />
            Pick the one sphere (A-E) you're drawn to impact. Then pick the two sub-spheres you are drawn to impact. Only use undecided if you're really not sure.
Fill in the "Other" blank if you don't find an answer close enough to your interest.
 </div>
 
 --->