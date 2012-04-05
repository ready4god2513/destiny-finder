<h5>I'm most troubled by the following human problems:</h5>
        <br />
        <h6>Instructions</h6>
		<p>Select two that are truest for you.</p>
        
		<form name="form<cfoutput>#VARIABLES.vCount#</cfoutput>" action="act_passion_survey.cfm" class="survey-form" method="post" id="sort_form_<cfoutput>#ATTRIBUTES.sort_id#</cfoutput>">
			
			<div class="controls">
				<div class="inputs-list">
					<label class="checkbox"><input type="checkbox" class="checkbox" name="causes_human" value="Physical Problems" />Physical Problems (Sickness, injury, birth defects, disabilities, etc.)</label>
					<label class="checkbox"><input type="checkbox" class="checkbox" name="causes_human" value="Psychological Illness" />Psychological Illness (Depression, bipolar disorder, OCD, ADD, neuroses, etc.)</label>
					<label class="checkbox"><input type="checkbox" class="checkbox" name="causes_human" value="Addictions" />Addictions (substance abuse, sexual addictions, pornography, gambling, eating disorders, etc.)</label>
					<label class="checkbox"><input type="checkbox" class="checkbox" name="causes_human" value="Crime and Imprisonment" />Crime and Imprisonment </label>
					<label class="checkbox"><input type="checkbox" class="checkbox" name="causes_human" value="Sin Issues" />Sin Issues (Immorality, greed, fear, anger, envy, pride, idolatry, rebellion, homosexual behavior (not orientation))</label>
                    <label class="checkbox"><input type="checkbox" class="checkbox" name="causes_human" value="Spiritual Strongholds " />Spiritual Strongholds (Occult, demonic oppression, etc.)</label>
					<label class="checkbox"><input type="text" name="causes_human" placeholder="Other causes"/></label>
				</ul>
			</div>
			
             <!---CLIP #1--->
			<div class="form-actions"><input class="btn btn-primary" type="submit" name="submit" value="Next Step" /></div>
            <input type="hidden" value="<cfoutput>#Encrypt('9,causes_ministries-2-3,causes_human,causes_human','keyei3v2','CFMX_COMPAT','Hex')#</cfoutput>" name="nxpz3" />
		</form>
<br class="clear"/>
        
        
      
<!---
	   <div style="float:left;margin:10px 40px 0px 40px;">
          Instructions:<br />
            Pick the one sphere (A-E) you're drawn to impact. Then pick the two sub-spheres you are drawn to impact. Only use undecided if you're really not sure.
Fill in the "Other" blank if you don't find an answer close enough to your interest.
 </div>
 
 --->