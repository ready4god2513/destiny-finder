<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Provides information on Bizrate feed --->

<cfmodule template="../../../customtags/format_output_admin.cfm"
	box_title="BizRate Export"
	Width="550">
<table border="0" cellpadding="0" cellspacing="4" width="100%" class="formtext"
	style="color:###Request.GetColors.InputTText#" ><tr><td><br/>
Clicking the link below will download a file that you can submit to Bizrate.<br/><br/>

Bizrate requires that you submit your products correctly coded using THEIR category numbers. To achieve this, you must first correctly code each of your product categories with corresponding Bizrate category ID. Edit each product category by entering "Bizrate=xx" in the category's Parameter field where "xx" is the corresponding Bizrate category ID.<br/><br/>

Your feed will include all products in the categories that have a Bizrate entry in the category Parameter field. If a product is placed in more than one category on your site, then the feed may list that product more than once as well.<br/><br/>

<div align="center"><cfoutput><a href="#request.self#?fuseaction=product.admin&do=bizrate_download" class="formtitle">Download the Bizrate feed</a></cfoutput></div><br/>&nbsp;
</td></tr></table>

</cfmodule>