
<h2><cfoutput>#(VARIABLES.vCount - 1)#</cfoutput>. I feel drawn to work with people of the following religious orientation </h2>
        <br />
        <h3>Instructions</h3>
		<p>Select one that is truest for you.</p>
		<form name="form<cfoutput>#VARIABLES.vCount#</cfoutput>" action="act_passion_survey.cfm" class="survey-form" method="post" id="sort_form_<cfoutput>#ATTRIBUTES.sort_id#</cfoutput>">
			<div class="controls">
				<div class="inputs-list">
					<label class="radio"><input type="radio" name="religion" value="Hindu">Hindu</label>
					<label class="radio"><input type="radio" name="religion" value="Buddhist">Buddhist</label>
					<label class="radio"><input type="radio" name="religion" value="Moslem">Moslem</label>
					<label class="radio"><input type="radio" name="religion" value="Jewish">Jewish</label>
					<label class="radio"><input type="radio" name="religion" value="Christian">Christian</label>
                    <label class="radio"><input type="radio" name="religion" value="Atheist/Post-Christian">Atheist/Post-Christian</label>
                    <label class="radio"><input type="radio" name="religion" value="Agnostic">Agnostic</label>
                    <label class="radio"><input type="radio" name="religion" value="Higher Power/Mishmash">Higher Power/Mishmash</label>
                    <label class="radio"><input type="radio" name="religion" value="New Age">New Age</label>
                    <label class="radio"><input type="radio" name="religion" value="Occult/Wicca/Satanic">Occult/Wicca/Satanic</label>
                    <label class="radio"><input type="radio" name="religion" value="None">None</label>
				</ul>
			</div>
			
             <!---CLIP #1--->
			<div class="form-actions"><input class="btn btn-primary" type="submit" name="submit" value="Next Step" /></div>
            <input type="hidden" value="<cfoutput>#Encrypt('23,development-6-1,religion,impact_religious','keyei3v2','CFMX_COMPAT','Hex')#</cfoutput>" name="nxpz3" />
		</form>
<br class="clear"/>
        <cfset progbar= (308 / 27) * (VARIABLES.vCount - 1)>
        <div class="percent_complete_label">% of survey completed</div><div class="percent_completed"><img src="/assets/images/progbar_pix.png" width="<cfoutput>#progbar#</cfoutput>" height="21"></div>
