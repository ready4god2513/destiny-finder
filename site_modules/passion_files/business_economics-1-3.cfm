
<div class="sort_name">Business and Economics</div>
        <br />
        <h3>Instructions</h3>
<p>Pick the two sub-spheres you are drawn to impact. Only use undecided if you’re really not sure.</p>
        
		<form name="form<cfoutput>#VARIABLES.vCount#</cfoutput>" action="act_passion_survey.cfm" method="post" id="sort_form_<cfoutput>#ATTRIBUTES.sort_id#</cfoutput>">
			
					<label><input type="checkbox" name="business_economics" value="Finance, Investment, Insurance and Realestate">Finance, Investment, Insurance and Realestate</label>
					<label><input type="checkbox" name="business_economics" value="Science, Technology, Energy and R&amp;D">Science, Technology, Energy and R&amp;D</label>
					<label><input type="checkbox" name="business_economics" value="Manufacturing, Distribuation and Service">Manufacturing, Distribuation and Service</label>
					<label><input type="checkbox" name="business_economics" value="Trades, Transportation, and Technical Services">Trades, Transportation, and Technical Services</label>
					<label><input type="checkbox" name="business_economics" value="Tourism, Travel, Hospitatily and Culinary">Tourism, Travel, Hospitatily and Culinary</label>
					<label><input type="checkbox" name="business_economics" value="Sales, Marketing and Advertising">Sales, Marketing and Advertising</label>
                    <label><input type="checkbox" name="business_economics" value="Undecided">Undecided</label>
                    <!---<label><input type="checkbox" name="business_economics" value="Other">Other&nbsp;<input name="business_economics" style="border:hidden; background-color:#F7F1E4; margin-left:5px; width:220px;" †ype="text" maxlength="30" placeholder="(limit 30 characters)" a></label>--->
		
			
             <!---CLIP #1--->
			<input style="margin:20px 0px 20px 250px; float:left" type="image" src="/site_images/next_btn.jpg" name="submit" value="Submit"/>
           <input type="hidden" value="<cfoutput>#Encrypt('5,causes_societal-2-1,business_economics,sphere_sub1','keyei3v2','CFMX_COMPAT','Hex')#</cfoutput>" name="nxpz3" />
		</form>
<br class="clear"/>
         <br class="clear"/>
        <cfset progbar= (308 / 27) * (VARIABLES.vCount - 1)>
        <div class="percent_complete_label">% of survey completed</div><div class="percent_completed"><img src="../site_images/progbar_pix.png" width="<cfoutput>#progbar#</cfoutput>" height="21"></div>
		

<!---#1
	   <div style="float:left;margin:10px 40px 0px 40px;">
          Instructions:<br />
            Pick the one sphere (A-E) you're drawn to impact. Then pick the two sub-spheres you are drawn to impact. Only use undecided if you're really not sure.
Fill in the "Other" blank if you don't find an answer close enough to your interest.
 </div>
 
 --->