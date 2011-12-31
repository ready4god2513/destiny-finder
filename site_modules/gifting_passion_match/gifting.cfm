
<div class="sort_name">Gifting and Passion Match</div>
        <br />
        <h3>Top 10 Giftings</h3>
 
<p>List the top 10 things (skills, professions, strengths, abilities, hobbies, sports, etc.) you are most gifted in or good at.</p>
<p>Use as few words as possible.</p>
<p>Example: accounting, basketball, organizing, singing, fishing, writing poetry, video games, finding bargains, statistical analysis, programming</p>
        
		<form name="form<cfoutput>#VARIABLES.vCount#</cfoutput>" action="act_giftingpassion_survey.cfm" method="post" id="sort_form_<cfoutput>#ATTRIBUTES.sort_id#</cfoutput>">
			
					<label><input type="text" name="gift_01" /></label>
					<label><input type="text" name="gift_02" /></label>
					<label><input type="text" name="gift_03" /></label>
					<label><input type="text" name="gift_04" /></label>
					<label><input type="text" name="gift_05" /></label>
					<label><input type="text" name="gift_06" /></label>
					<label><input type="text" name="gift_07" /></label>
					<label><input type="text" name="gift_08" /></label>
					<label><input type="text" name="gift_09" /></label>
					<label><input type="text" name="gift_10" /></label>
                   
		
			
             <!---CLIP #1--->
			<input style="margin:20px 0px 20px 250px; float:left" type="image" src="/site_images/next_btn.jpg" name="submit" value="Submit"/>
           <input type="hidden" value="<cfoutput>#Encrypt('5,causes_societal-2-1,business_economics,sphere_sub1','keyei3v2','CFMX_COMPAT','Hex')#</cfoutput>" name="nxpz3" />
		</form>
<br class="clear"/>
         <!---< PROGRESS BAR ------
         <br class="clear"/>
        <cfset progbar= (308 / 27) * (VARIABLES.vCount - 1)>
        
			<div class="percent_complete_label">% of survey completed</div><div class="percent_completed"><img src="/site_images/progbar_pix.png" width="<cfoutput>#progbar#</cfoutput>" height="21"></div>--->
            
	

