<cfparam name="ATTRIBUTES.select_name" default="">
<cfparam name="ATTRIBUTES.selected_state" default="">

<cfset VARIABLES.state_abbrev_list = "AL,AK,AZ,AR,CA,CO,CT,DE,FL,GA,HI,ID,IL,IN,IA,KS,KY,LA,ME,MD,MA,MI,MN,MS,MO,MT,NE,NV,NH,NJ,NM,NY,NC,ND,OH,OK,OR,PA,RI,SC,SD,TN,TX,UT,VT,VA,WA,WV,WI,WY">
<cfset VARIABLES.state_list = "Alabama,Alaska,Arizona,Arkansas,California,Colorado,Connecticut,Delaware,Florida,Georgia,Hawaii,Idaho,Illinois,Indiana,Iowa,Kansas,Kentucky,Louisiana,Maine,Maryland,Massachusetts,Michigan,Minnesota,Mississippi,Missouri,Montana,Nebraska,Nevada,New Hampshire,New Jersey,New Mexico,New York,North Carolina,North Dakota,Ohio,Oklahoma,Oregon,Pennsylvania,Rhode Island,South Carolina,
South Dakota,Tennessee,Texas,Utah,Vermont,Virginia,Washington,West Virginia,Wisconsin,Wyoming">

<cfoutput>

	<select name="#ATTRIBUTES.select_name#">
		<cfloop from="1" to="#ListLen(VARIABLES.state_abbrev_list)#" index="i">
			<option value="#ListGetAt(VARIABLES.state_abbrev_list,i)#" <cfif ListGetAt(VARIABLES.state_abbrev_list,i) EQ ATTRIBUTES.selected_state>selected</cfif> >#ListGetAt(VARIABLES.state_list,i)#</option>
		</cfloop>
	</select>

</cfoutput>