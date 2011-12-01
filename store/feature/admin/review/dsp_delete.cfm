<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Prompts the user to confirm that they wish to delete a feature review. Called by feature.admin&review=delete --->

<cfprocessingdirective suppresswhitespace="no">
<script type="text/javascript">
if (window.confirm("Are you sure you want to delete this feature review?")) 
	{ var address="<cfoutput>#self#?fuseaction=feature.admin&review=act&delete=#attributes.review_id#&XFA_success=#URLEncodedFormat(attributes.XFA_success)#</cfoutput>";      
	}
	else { 
		var address="<cfoutput>#Session.Page#</cfoutput>";
		}
   top.location = address;
</script>
</cfprocessingdirective>
