<cfparam name="URL.assessment_id" default="1">
<cfparam name="ATTRIBUTES.assessment_id" default="#val(URL.assessment_id)#">
<cfparam name="FORM.passion_file" default="sphere-1.cfm">
<cfset progbar = (VARIABLES.vCount / 25) * 100>

<cfinclude template="/site_modules/passion_files/#FORM.passion_file#" />

<div class="percent_complete_label">% of survey completed</div>
<div class="progress progress-info progress-striped active">
	<div class="bar" style="width: #progbar#%;"></div>
</div>