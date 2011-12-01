<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This is used to change the Product Review settings stored in the Settings table --->

<cfmodule template="../../../customtags/format_admin_form.cfm"
	box_title="Product Review Settings"
	width="450"
	>

	<cfoutput>
<form name="editform" action="#self#?fuseaction=product.admin&review=save#request.token2#" method="post">

	<!--- Use Product Reviews ----->
	<tr>
		<td align="RIGHT" nowrap="nowrap">Use Product Reviews:</td>
		<td style="background-color: ###Request.GetColors.formreq#;" width="3">&nbsp;</td>
		<td><input type="radio" name="ProductReviews" value="1" #doChecked(request.appsettings.ProductReviews)# /> Yes
		&nbsp;&nbsp; <input type="radio" name="ProductReviews" value="0" #doChecked(request.appsettings.ProductReviews,0)# /> No </td>
	</tr>
	<tr>
		<td colspan="2"></td>
		<td><span class="formtextsmall">Turns Product Reviews functionality on and off.</span></td>
	</tr>
	

	<!--- Approve ----->
	<tr>
		<td align="RIGHT" nowrap="nowrap">Approval Required:</td>
		<td style="background-color: ###Request.GetColors.formreq#;"></td>
		<td><input type="radio" name="ProductReview_Approve" value="1" #doChecked(request.appsettings.ProductReview_Approve)# /> Yes 
		&nbsp;&nbsp; <input type="radio" name="ProductReview_Approve" value="0" #doChecked(request.appsettings.ProductReview_Approve,0)# /> No </td>
	</tr>
	<tr>
		<td colspan="2"></td>
		<td><span class="formtextsmall">Set to YES if reviews should not be shown until approved by an Administrator.</span></td>
	</tr>
	
	<!--- Flag ----->
	<tr>
		<td align="RIGHT" nowrap="nowrap">Check Reviews:</td>
		<td style="background-color: ###Request.GetColors.formreq#;"></td>
		<td><input type="radio" name="ProductReview_Flag" value="1" #doChecked(request.appsettings.ProductReview_Flag)# /> Yes 
&nbsp;&nbsp; <input type="radio" name="ProductReview_Flag" value="0" #doChecked(request.appsettings.ProductReview_Flag,0)# /> No </td>
	</tr>
	<tr>
		<td colspan="2"></td>
		<td><span class="formtextsmall">Set to YES if Reviews should be flagged as "needs check" when created or updated. If Reviews are shown without requiring Admin approval, the Admin can still review all new and updated reviews by turning this setting on.</span></td>
	</tr>
	
	<!--- Required to Add ----->
	<tr>
		<td align="RIGHT" nowrap="nowrap" valign="top">Who can write a review:</td>
		<td style="background-color: ###Request.GetColors.formreq#;"></td>
		<td>
		<input type="radio" name="ProductReview_Add" value="0" #doChecked(request.appsettings.ProductReview_Add,0)# />Anyone - no login required.<br/>
		<input type="radio" name="ProductReview_Add" value="1" #doChecked(request.appsettings.ProductReview_Add,1)# />Registered Users - login required.<br/>
		<input type="radio" name="ProductReview_Add" value="2" #doChecked(request.appsettings.ProductReview_Add,2)# />Verified Users - login and verified email required.<br/>
		<input type="radio" name="ProductReview_Add" value="3" #doChecked(request.appsettings.ProductReview_Add,3)# />Purchasers - Only customers who purchased the product from this store.<br/>
		</td>
	</tr>

	
	<!--- Login Required to Rate reviews ----->
	<tr>
		<td align="RIGHT" nowrap="nowrap">Login Required to Rate:</td>
		<td style="background-color: ###Request.GetColors.formreq#;"></td>
		<td><input type="radio" name="ProductReview_Rate" value="1" #doChecked(request.appsettings.ProductReview_Rate)# /> Yes
		&nbsp;&nbsp; <input type="radio" name="ProductReview_Rate" value="0" #doChecked(request.appsettings.ProductReview_Rate,0)# /> No </td>
	</tr>
	<tr>
		<td colspan="2"></td>
		<td><span class="formtextsmall">Set to YES if users must login to rate a review as helpful.</span></td>
	</tr>
	
	<!--- Reviews to show ----->
	<tr>
		<td align="RIGHT" nowrap="nowrap">Reviews on Product Page</td>
		<td style="background-color: ###Request.GetColors.formreq#;"></td>
		<td><input type="text" name="ProductReviews_Page" class="formfield" value="#request.appsettings.ProductReviews_Page#" size="4" maxlength="10"/></td>
	</tr>
	<tr>
		<td colspan="2"></td>
		<td><span class="formtextsmall">Number of reviews to show on the product page.</span></td>
	</tr>
	
	<cfinclude template="../../../includes/form/put_space.cfm">
		
	<tr>
		<td>&nbsp;</td>
		<td></td>
		<td><input class="formbutton" type="submit" value="Save Changes"/>
		<input type="button" value="Cancel" onclick="javascript:window.history.go(-1);" class="formbutton"/>

		</td>
	</tr>
</form>

<cfprocessingdirective suppresswhitespace="no">
<script type="text/javascript">
objForm = new qForm("editform");

objForm.required("ProductReviews,ProductReview_Approve,ProductReview_Flag,ProductReview_Add,ProductReview_Rate,ProductReviews_Page");

objForm.ProductReviews_Page.description = "Reviews on Product Page";
objForm.ProductReviews_Page.validateNumeric();

qFormAPI.errorColor = "###Request.GetColors.formreq#";
</script>
</cfprocessingdirective>



</cfoutput>
</cfmodule>

