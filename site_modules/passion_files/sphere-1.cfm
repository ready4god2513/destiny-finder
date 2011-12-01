<script type="text/javascript" language="javascript">
<!-- 
// validate that the user has checked one of the radio buttons
function isValidRadio(radio) {
    var valid = false;
    for (var i = 0; i < radio.length; i++) {
        if (radio[i].checked) {
            return true;
        }
    }
    alert("Please make a choice from the radio buttons.");
    return false;
}
// batch validation router
function validateForm(form) {
   if (isValidRadio(form.sphere)) {
       return true;
       } 
	   return false;
   }
// --> 
</script>
<div class="sort_name">Sphere</div>
        <br />
        <h3>Instructions</h3>
<p>Pick the one sphere you’re drawn to impact.  Only use undecided if you’re really not sure.</p>
		<form name="form" action="act_passion_survey.cfm" method="post" id="sort_form_<cfoutput>#ATTRIBUTES.sort_id#</cfoutput>">
		
					<label><input type="radio" name="sphere" value="Family and Individual">Family and Individual</label>
					<label><input type="radio" name="sphere" value="Culture and Lifestyle">Culture and Lifestyle</label>
					<label><input type="radio" name="sphere" value="Business and Economics">Business and Economics</label>
					<label><input type="radio" name="sphere" value="Government Legal and NonProfit">Government, Legal and Non-Profit</label>
					<label><input type="radio" name="sphere" value="Religion and Spirituality">Religion and Spirituality</label>
			        <!--- 	1 = Family and Individual
							2 = Culture and Lifestyle
							3 = Business and Economics
							4 = Government, Legal and Non-Profit
					        5 = Religion and Spirituality   --->
			
             <!--- <div style="float:left;margin:10px 40px 0px 40px;">
            Instructions:<br />
            Pick the one sphere (A-E) you're drawn to impact. Then pick the two sub-spheres you are drawn to impact. Only use undecided if you're really not sure.
Fill in the "Other" blank if you don't find an answer close enough to your interest.
 </div>--->
			<input style="margin:20px 0px 20px 250px;" type="image" src="/site_images/next_btn.jpg" name="submit" value="Submit" onClick="validateForm(this);" />
            <input type="hidden" value="<cfoutput>#Encrypt('2,sphere-1,sphere,sphere','keyei3v2','CFMX_COMPAT','Hex')#</cfoutput>" name="nxpz3" />
		</form>
        
        <cfset progbar= 0>
        <div class="percent_complete_label">% of survey completed</div><div class="percent_completed"><img src="../site_images/progbar_pix.png" width="<cfoutput>#progbar#</cfoutput>" height="21"></div>

			