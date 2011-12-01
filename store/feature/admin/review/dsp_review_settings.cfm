<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This is used to change the Feature Review settings stored in the Settings table --->

<cfmodule template="../../../customtags/format_admin_form.cfm"
	box_title="Feature Review Settings"
	width="450"
	>

	<cfoutput>
<form name="editform" action="#self#?fuseaction=feature.admin&review=save#request.token2#" method="post">

	<!--- Use Feature Reviews ----->
	<tr>
		<td align="RIGHT" nowrap="nowrap">Use Feature Reviews:</td>
		<td style="background-color: ###Request.GetColors.formreq#;" width="3">&nbsp;</td>
		<td><input type="radio" name="FeatureReviews" value="1" #doChecked(request.appsettings.FeatureReviews)# /> Yes 
		&nbsp;&nbsp; <input type="radio" name="FeatureReviews" value="0" #doChecked(request.appsettings.FeatureReviews,0)# /> No </td>
	</tr>
	<tr>
		<td colspan="2"></td>
		<td><span class="formtextsmall">Turns Feature Reviews functionality on and off.</span></td>
	</tr>
	

	<!--- Approve ----->
	<tr>
		<td align="RIGHT" nowrap="nowrap">Approval Required:</td>
		<td style="background-color: ###Request.GetColors.formreq#;"></td>
		<td><input type="radio" name="FeatureReview_Approve" value="1" #doChecked(request.appsettings.FeatureReview_Approve)# /> Yes
		&nbsp;&nbsp; <input type="radio" name="FeatureReview_Approve" value="0" #doChecked(request.appsettings.FeatureReview_Approve,0)# /> No </td>
	</tr>
	<tr>
		<td colspan="2"></td>
		<td><span class="formtextsmall">Set to YES if reviews should not be shown until approved by an Administrator.</span></td>
	</tr>
	
	<!--- Flag ----->
	<tr>
		<td align="RIGHT" nowrap="nowrap">Check Reviews:</td>
		<td style="background-color: ###Request.GetColors.formreq#;"></td>
		<td><input type="radio" name="FeatureReview_Flag" value="1" #doChecked(request.appsettings.FeatureReview_Flag)# /> Yes
		&nbsp;&nbsp; <input type="radio" name="FeatureReview_Flag" value="0" #doChecked(request.appsettings.FeatureReview_Flag,0)# /> No </td>
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
		<input type="radio" name="FeatureReview_Add" value="0" #doChecked(request.appsettings.FeatureReview_Add,0)# />Anyone - no login required.<br/>
		<input type="radio" name="FeatureReview_Add" value="1" #doChecked(request.appsettings.FeatureReview_Add,1)# />Registered Users - login required.<br/>
		<input type="radio" name="FeatureReview_Add" value="2" #doChecked(request.appsettings.FeatureReview_Add,2)# />Verified Users - login and verified email required.<br/>
		</td>
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


</cfoutput>
</cfmodule>

<cfprocessingdirective suppresswhitespace="no">
<script type="text/javascript">
objForm = new qForm("editform");

objForm.required("FeatureReviews,FeatureReview_Approve,FeatureReview_Flag,FeatureReview_Add");

qFormAPI.errorColor = "###Request.GetColors.formreq#";
</script>
</cfprocessingdirective>
