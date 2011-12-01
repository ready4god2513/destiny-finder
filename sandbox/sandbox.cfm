<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Untitled Document</title>
<style>
	body {
		font-family:Arial, Helvetica, sans-serif;
		font-size:12px;
		padding:10px;
	}
</style>
</head>
<body>
<!--- ARRAY TEST
<cfset VARIABLES.first_names = "Paul,Tony,Tom">
<cfset VARIABLES.last_names = "Ferree,Jenkins,Manners">

<cfset VARIABLES.thearray = ArrayNew(1)>

<cfloop from="1" to="3" index="i">

	<cfset VARIABLES.thearray[i] = {
	 	first_name = ListGetAt(VARIABLES.first_names,i),
	 	last_name = ListGetAt(VARIABLES.last_names,i)
	 }>
	
</cfloop>

<cfdump var="#VARIABLES.thearray#">

<cfset VARIABLES.serializedarray = SerializeJSON(VARIABLES.thearray)>
<br/>
<cfoutput>#VARIABLES.serializedarray#</cfoutput>
--->

<!--- STRUCTURE TEST
<cfset VARIABLES.thestruct = {
	first_name = "Paul",
	last_name = "Ferree"
}>
<cfset VARIABLES.thestruct.vehicle = {
	type = "car",
	color = "red"
}>
<cfset VARIABLES.thestruct.vehicle.info = {
	make = "chevy",
	theyear = "1999"
}> 

<strong>Created Structure:</strong>
<cfdump var="#VARIABLES.thestruct#">
<cfoutput>
	<br/>
	<pre>
		<cfset VARIABLES.serial_json = SerializeJson(VARIABLES.thestruct)>
		VARIABLES.serial_json = SerializeJson(VARIABLES.thestruct)
	</pre>
	<strong>Converted to JSON:</strong><br/>
		#SerializeJson(VARIABLES.thestruct)#
	<pre>
		<cfset VARIABLES.deserial_json = DeserializeJson(VARIABLES.serial_json)>
		VARIABLES.deserial_json = DeserializeJson(VARIABLES.serial_json)
	</pre>
	<br/>
	<cfoutput>
		<strong>Isolated value from deserialzed.<br/>
		VARIABLES.deserial_json.vehicle.info.make = </strong>#VARIABLES.deserial_json.vehicle.info.make#
	</cfoutput>
</cfoutput>

---->

<!---
<cfset VARIABLES.assessment = {
	question_id = 1,
	question_type = 'word_sort',
	question_answer = '5,4,3,1,2',
}>--->

<cfset VARIABLES.assessment_test = {
	static_label = "Sample Assessment Result Storage",
	assessment_id = 1,
	assessment_user_id = 44,
	assessment_test_details = {
		question_1 = 6,
		question_1_type = 1,
		question_1_answer = 1,
		question_2 = 7,
		question_2_type = 2,
		question_2_answer = "5,3,1,2,4"
	},
	assessment_result = "4,5"
}>


<cfdump var="#VARIABLES.assessment_test#">

<cfset VARIABLES.serialized_details = SerializeJSON(VARIABLES.assessment_test.assessment_test_details)>
<br/><br/>
<cfoutput><strong>Serialized test details: </strong>#VARIABLES.serialized_details#</cfoutput>

<cfset VARIABLES.listtest = "1,2,3,4,5">

<cfoutput>#SerializeJSON(VARIABLES.listtest)#</cfoutput>

</body>
</html>
