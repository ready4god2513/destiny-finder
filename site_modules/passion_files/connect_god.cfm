<h5>10. I connect with God the most through:</h5>
<cfinclude template="instructions-multiple.cfm">

<form name="form<cfoutput>#VARIABLES.vCount#</cfoutput>" action="act_passion_survey.cfm" class="survey-form" method="post" id="sort_form_<cfoutput>#ATTRIBUTES.sort_id#</cfoutput>">

	<div class="controls">
		<div class="inputs-list">
			<label class="checkbox"><input type="checkbox" class="checkbox" name="connect_god" value="Worship and Music" />Worship and Music</label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="connect_god" value="Prayer" />Prayer</label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="connect_god" value="Bible Study" />Bible Study</label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="connect_god" value="Devotional Reading" />Devotional Reading</label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="connect_god" value="Fellowship and Community" />Fellowship and Community</label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="connect_god" value="Serving Others" />Serving Others</label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="connect_god" value="Journaling" />Journaling</label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="connect_god" value="Artistic Expression" />Artistic Expression</label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="connect_god"><input type="text" name="connect_god" placeholder="Other sphere"/></label>
			<label class="checkbox"><input type="checkbox" class="checkbox" name="connect_god" value="undecided">Undecided</label>
		</div>
	</div>


	<!---CLIP #1--->
	<div class="form-actions"><input class="btn btn-primary" type="submit" name="submit" value="Next Step" /></div>
	<input type="hidden" value="<cfoutput>#Encrypt('14,scope_org-3-1,connect_god,connect_god','keyei3v2','CFMX_COMPAT','Hex')#</cfoutput>" name="nxpz3" />
</form>