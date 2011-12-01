<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Used to output error messages on various admin pages --->

	<cfif len(attributes.Message)>
	<tr>
		<td colspan="3" align="center"><br/><span class="formerror"><cfoutput>#attributes.Message#</cfoutput><br/><br/></td></tr>
	</cfif>


	