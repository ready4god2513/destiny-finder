<cfparam name="URL.assessment_id" default="1">
<cfparam name="ATTRIBUTES.assessment_id" default="#val(URL.assessment_id)#">
<cfparam name="FORM.passion_file" default="sphere-1.cfm">


<cfinclude template="/site_modules/passion_files/#FORM.passion_file#" />