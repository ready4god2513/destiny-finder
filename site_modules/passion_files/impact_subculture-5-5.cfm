
<h2>I feel most drawn to impact the following subculture:</h2>
        <br />
        <h3>Instructions</h3>
		<p>Select one that is truest for you.</p>
        
		<form name="form<cfoutput>#VARIABLES.vCount#</cfoutput>" action="act_passion_survey.cfm" class="survey-form" method="post" id="sort_form_<cfoutput>#ATTRIBUTES.sort_id#</cfoutput>">
			<div class="input">
				<ul class="inputs-list">
					<li><label><input type="radio" name="subculture" value="Metro Urban/Hipster">Metro Urban/Hipster</label></li>
					<li><label><input type="radio" name="subculture" value="Yuppie">Yuppie</label></li>
					<li><label><input type="radio" name="subculture" value="Student">Student</label></li>
					<li><label><input type="radio" name="subculture" value="Punk/Hardcore/Skater">Punk/Hardcore/Skater</label></li>
					<li><label><input type="radio" name="subculture" value="Rave/Dance Club">Rave/Dance Club</label></li>
                    <li><label><input type="radio" name="subculture" value="Rap/Hip Hop">Rap/Hip Hop</label></li>
                    <li><label><input type="radio" name="subculture" value="Young Adult">Young Adult</label></li>
                    <li><label><input type="radio" name="subculture" value="Country/Western">Country/Western</label></li>
                    <li><label><input type="radio" name="subculture" value="LGBT">LGBT</label></li>
                    <li><label><input type="radio" name="subculture" value="High Society">High Society</label></li>
                    <li><label><input type="radio" name="subculture" value="Celebrity">Celebrity</label></li>
                    <li><label><input type="radio" name="subculture" value="None">None</label></li>
				</ul>
			</div>
			
             <!---CLIP #1--->
			<div class="actions"><input class="btn primary" type="submit" name="submit" value="Next Step" /></div>
            <input type="hidden" value="<cfoutput>#Encrypt('22,impact_religious-5-6,subculture,impact_subculture','keyei3v2','CFMX_COMPAT','Hex')#</cfoutput>" name="nxpz3" />
		</form>
<br class="clear"/>
        <cfset progbar= (308 / 27) * (VARIABLES.vCount - 1)>
        <div class="percent_complete_label">% of survey completed</div><div class="percent_completed"><img src="/assets/images/progbar_pix.png" width="<cfoutput>#progbar#</cfoutput>" height="21"></div>
       
<!---
	   <div style="float:left;margin:10px 40px 0px 40px;">
          Instructions:<br />
            Pick the one sphere (A-E) you're drawn to impact. Then pick the two sub-spheres you are drawn to impact. Only use undecided if you're really not sure.
Fill in the "Other" blank if you don't find an answer close enough to your interest.
 </div>
 
 --->