<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This page is called by the shopping.tracking fuseaction and used to display the tracking information for the order for UPS Tracking. --->

<!--- <cfdump var="#Result#"> --->

<cfmodule template="../../../customtags/format_output_box.cfm"
box_title="UPS OnLine<sup>&reg;</sup> Tools Tracking - Shipment ###ShipNumber#"
width="500"
align="left"
>

	
<cfoutput>	
<table>
	<tr>
		<td colspan="3" align="center" class="formerror"><br/>#attributes.Message#<br/><br/></td></tr>
	</table>
</cfoutput>

</cfmodule><br/>