
<h2>Gifting and Passion Match</h2>
        <br />
        <h3>Top 10 Passions</h3>
 
<p>List the top 10 things (skills, professions, strengths, abilities, hobbies, sports, etc )you are most passionate about or love to do.</p>
<p>Use as few words as possible.</p>
<p>Example: accounting, basketball, organizing, singing, fishing, writing poetry, video games, finding bargains, statistical analysis, programming</p>
        
		<form name="form<cfoutput>#VARIABLES.vCount#</cfoutput>" action="act_gifting_passion_match.cfm" method="post" id="sort_form_<cfoutput>#ATTRIBUTES.sort_id#</cfoutput>">
			
					<label><input type="text" name="passion_01" /></label>
					<label><input type="text" name="passion_02" /></label>
					<label><input type="text" name="passion_03" /></label>
					<label><input type="text" name="passion_04" /></label>
					<label><input type="text" name="passion_05" /></label>
					<label><input type="text" name="passion_06" /></label>
					<label><input type="text" name="passion_07" /></label>
					<label><input type="text" name="passion_08" /></label>
					<label><input type="text" name="passion_09" /></label>
					<label><input type="text" name="passion_10" /></label>
                   
		
			
             <!---CLIP #1--->
			<input class="btn primary" type="submit" name="submit" value="Next Step" />
           <input type="hidden" value="<cfoutput>#Encrypt('5,causes_societal-2-1,business_economics,sphere_sub1','keyei3v2','CFMX_COMPAT','Hex')#</cfoutput>" name="nxpz3" />
		</form>
<br class="clear"/>
         <!---< PROGRESS BAR ------
         <br class="clear"/>
        <cfset progbar= (308 / 27) * (VARIABLES.vCount - 1)>
        
			<div class="percent_complete_label">% of survey completed</div><div class="percent_completed"><img src="/site_images/progbar_pix.png" width="<cfoutput>#progbar#</cfoutput>" height="21"></div>--->
            
	

