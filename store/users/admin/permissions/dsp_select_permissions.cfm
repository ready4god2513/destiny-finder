
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This page takes a circuit name and displays a selectbox with the available permissions. Called from dsp_priv_form.cfm --->

<cfparam name="attributes.circuit" default="access">

<!--- <cfoutput>
	<strong>#UCase(attributes.circuit)# ADMIN</strong>
	<select name="#attributes.circuit#" size="8" multiple style="width: 200px;">
	<cfloop query="qry_get_perm_list">
	<option value="#BitValue#">#name#</option>
	</cfloop>
	</select>
	<input type="hidden" name="#attributes.circuit#_bits" value="0"/>
</cfoutput> --->
<cfoutput>
<strong>#UCase(attributes.circuit)# ADMIN</strong>
<div id="#attributes.circuit#_BitsControl" class="multiSelectControl"></div>
	<select name="#attributes.circuit#_Bits" id="#attributes.circuit#_Bits" size="8" multiple="multiple">
	<cfloop query="qry_get_perm_list">
		<option value="#BitValue#" #doSelected(BitAnd(keyvalue, BitValue))#>#name#</option>
	</cfloop>
 	</select>
 	<script type="text/javascript">
		#attributes.circuit#_BitsObj = new mxAjax.MultiSelect({
			executeOnLoad: true,
			target: "#attributes.circuit#_Bits",
			cssClass: "multiSelect"
		});
	</script> 
</cfoutput>