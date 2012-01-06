
<div class="sort_name">Gifting and Passion Match</div>
        <br />
        <h3>Top 10 Matchup</h3>
 
<p>Does anything appear in both lists? If so, list them:</p>
        
		<form name="form<cfoutput>#VARIABLES.vCount#</cfoutput>" action="act_gifting_passion_match.cfm" method="post" id="sort_form_<cfoutput>#ATTRIBUTES.sort_id#</cfoutput>">
			
					<label><input type="text" name="match_01" /></label>
					<label><input type="text" name="match_02" /></label>
					<label><input type="text" name="match_03" /></label>
					<label><input type="text" name="match_04" /></label>
					<label><input type="text" name="match_05" /></label>
					<label><input type="text" name="match_06" /></label>
					<label><input type="text" name="match_07" /></label>
					<label><input type="text" name="match_08" /></label>
					<label><input type="text" name="match_09" /></label>
					<label><input type="text" name="match_10" /></label>
                   
		
			
             <!---CLIP #1--->
			<input class="btn primary" type="submit" name="submit" value="Next Step" />
           <input type="hidden" value="<cfoutput>#Encrypt('5,causes_societal-2-1,business_economics,sphere_sub1','keyei3v2','CFMX_COMPAT','Hex')#</cfoutput>" name="nxpz3" />
		</form>
<br class="clear"/>
         <!---< PROGRESS BAR ------
         <br class="clear"/>
        <cfset progbar= (308 / 27) * (VARIABLES.vCount - 1)>
        
			<div class="percent_complete_label">% of survey completed</div><div class="percent_completed"><img src="/site_images/progbar_pix.png" width="<cfoutput>#progbar#</cfoutput>" height="21"></div>--->
            
	

