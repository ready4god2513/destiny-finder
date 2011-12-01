<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Prompts the user to confirm that they wish to delete a product addon. Called by product.admin&addon=change --->

<cfprocessingdirective suppresswhitespace="no">
<script type="text/javascript">
if (window.confirm("Are you sure you want to delete this addon?")) 
	{ var address="<cfoutput>#self#?fuseaction=product.admin&addon=delete&addon_id=#attributes.addon_id#&product_id=#attributes.product_id#&cid=#attributes.cid#</cfoutput>";      
	}
	else { 
		var address="<cfoutput>#self#?fuseaction=product.admin&do=addons&product_id=#attributes.product_id#&cid=#attributes.cid#</cfoutput>";
		}
   window.location = address;
</script>
</cfprocessingdirective>

