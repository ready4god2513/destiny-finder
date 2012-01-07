
<cfinclude template="/templates/header.cfm">
<link rel="stylesheet" type="text/css" href="../site_styles/main.css">
<link rel="stylesheet" type="text/css" href="../site_styles/word_sort.css">
<div class="page_content">
<div class="assessment_radio box">
<h3>Religion and Spirituality</h3>
        <br />
        
		<form action="" method="post" id="">
			
					<label><input type="radio" name="religion_spirituality" checked value="Administration">Administration</label>
					<label><input type="radio" name="religion_spirituality" value="Education and Training">Education and Training</label>
					<label><input type="radio" name="religion_spirituality" value="Church Leadership">Church Leadership</label>
					<label><input type="radio" name="religion_spirituality" value="Non-Profit Organizations">Non-Profit Organizations</label>
					<label><input type="radio" name="religion_spirituality" value="Para-church Ministry">Para-church Ministry</label>
					<label><input type="radio" name="religion_spirituality" value="Outreach and Missions">Outreach and Missions</label>
                    <label><input type="radio" name="religion_spirituality" value="Undecided">Undecided</label>
                    <label><input type="radio" name="religion_spirituality" value="Other">Other&nbsp;<input name="religion_spirituality" style="border:hidden; background-color:#F7F1E4; margin-left:5px; width:220px;" †ype="text" maxlength="30" placeholder="(limit 30 characters)" a></label>
		
		
				
			
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