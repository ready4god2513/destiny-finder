<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->
	
<!--- Creates the qForms code for county selectbox. Called from put_contact.cfm. ---->

<!--- Create a list of states with counties --->
<cfset StateList = "">

<cfsavecontent variable="countryscripts">
<script type="text/javascript">
	<!--
	// this is the default struct to use for the blank options to prefix
	// when populating a select box
	stcBlank = new Object();
	stcBlank[""] = " ";
	
	// create a structure to store all the county information in
	stcCounties = new Object();
	
	/**********************************************************
	 Loop through each state and create an object with the counties
	**********************************************************/
	
	<cfoutput query="GetCounties" group="State">
		stcCounties["#GetCounties.State#"] = new Object();		
		<cfset StateList = ListAppend(StateList, GetCounties.State)>
		<cfoutput>
		stcCounties["#GetCounties.State#"]["#GetCounties.Name#"] = "#GetCounties.Name#";
		</cfoutput>	
	</cfoutput>
	
	<cfoutput>
	// create dependencies for states with counties
	function requireCounties() {
		<cfloop list="#StateList#" index="state">
			objForm.County.createDependencyTo("State", "#state#");
		</cfloop>
		objForm.State.enforceDependency();
	}
	function requireCountiesShipTo() {
		<cfloop list="#StateList#" index="state">
			objForm.County_shipto.createDependencyTo("State_shipto", "#state#");
		</cfloop>
		objForm.State_shipto.enforceDependency();
	}
	
	// function used to pre-populate the drop-downs
 	function setDefault(field,previous){
		objForm[field].setValue(previous);
	} 
	
	</cfoutput>
	//-->
	</script>
</cfsavecontent>

<cfhtmlhead text="#countryscripts#">