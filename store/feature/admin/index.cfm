
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This is the feature.admin circuit. It runs all the admin functions for the feature circuit --->

<!--- feature permissions 1 = feature admin --->
<cfmodule template="../../access/secure.cfm"
	keyname="feature"
	requiredPermission="1,2,4"
	> 
	<cfif ispermitted>
	
<cfif isdefined("attributes.feature")> 
			
		<cfset Webpage_title = "Feature article #attributes.Feature#">
		
		<cfswitch expression="#attributes.Feature#">
		
			<cfcase value="list">
				<cfinclude template="qry_get_features.cfm">
				<cfinclude template="dsp_features_list.cfm">
			</cfcase>
		
			<cfcase value="listform">
				<cfinclude template="qry_get_features.cfm">
				<cfinclude template="dsp_features_list_form.cfm">
			</cfcase>
			
			<cfcase value="add">
				<cfinclude template="dsp_feature_form.cfm">
			</cfcase>
			
			<cfcase value="edit">
				<cfinclude template="qry_get_feature_cats.cfm">
				<cfinclude template="qry_get_feature.cfm"> 
				<cfif qry_get_feature.recordcount>
					<cfinclude template="dsp_feature_form.cfm">
				<cfelse>
					<cfset attributes.error_message = "You do not have access to this Feature">
					<cfinclude template="../../includes/admin_confirmation.cfm">
				</cfif>
				
			</cfcase>
			
		<!--- Related Features -------->	
			<cfcase value="related">
				<cfinclude template="act_related.cfm">
				<cfinclude template="qry_get_feature.cfm">
				<cfinclude template="qry_get_feature_item.cfm">
				<cfinclude template="qry_get_features.cfm">
				<cfset startpath="fuseaction=feature.admin&feature=related&feature_id=#attributes.feature_id#">
				<cfset box_title="Update Feature - #qry_get_feature.name#">
				<cfparam name = "menu" default="dsp_tab_menu.cfm">
				<cfinclude template="dsp_feature_related_form.cfm">
			</cfcase>					
			
		<!--- Related Products -------->	
			<cfcase value="related_prod">
				<cfinclude template="act_related_prod.cfm">
				<cfinclude template="qry_get_feature.cfm">
				<cfinclude template="qry_get_feature_product.cfm">
				<cfinclude template="../../product/admin/product/qry_get_products.cfm">
				<cfset startpath="fuseaction=feature.admin&feature=related_prod&feature_id=#attributes.feature_id#">
				<cfset box_title="Update Feature - #qry_get_feature.name#">
				<cfparam name = "menu" default="../../../feature/admin/dsp_tab_menu.cfm">
				<cfinclude template="../../product/admin/product/dsp_products_related_form.cfm">
			</cfcase>		
	
			<cfcase value="act">
				<cfinclude template="act_feature.cfm">
				
					<cfset attributes.XFA_success="fuseaction=feature.admin&feature=list">
				<cfif len(attributes.CID)>
					<cfset attributes.XFA_success=attributes.XFA_success & 	"&cid=" & attributes.CID>
				</cfif>		
				
				<cfif isdefined("attributes.image_list") and len(attributes.image_list)>
					<cfinclude template="../../includes/remove_images.cfm">	
				<cfelse>
					<cfset attributes.box_title="Feature">
					<cfinclude template="../../includes/admin_confirmation.cfm">			
				</cfif>		
			</cfcase>
			
			<cfcase value="actform">
				<cfinclude template="act_feature_list.cfm">
				
				<cfset attributes.XFA_success= addedpath>
				<cfset attributes.box_title="Features">
				<cfinclude template="../../includes/admin_confirmation.cfm">	
			</cfcase>
		
			<cfcase value="copy">
				<cfinclude template="act_copy_feature.cfm">
				<cfset feature = "edit">
				
				<cfinclude template="qry_get_feature_cats.cfm">
				<cfinclude template="qry_get_feature.cfm"> 
				<cfinclude template="dsp_feature_form.cfm">
			</cfcase>
			
			<cfdefaultcase>
				<cfinclude template="qry_get_features.cfm">
				<cfinclude template="dsp_features_list.cfm">
			</cfdefaultcase>
			
		</cfswitch>
		
<!--- Feature Reviews Upgrade - start custom code --->
<cfelseif isdefined("attributes.review")>		
		
		<cfset Webpage_title = "Review #attributes.review#">
		
		<cfswitch expression="#attributes.review#">
		
			<cfcase value="list">
				<cfinclude template="review/qry_get_reviews.cfm">
				<cfinclude template="review/dsp_reviews_list.cfm">
			</cfcase>
		
			<cfcase value="listform">
				<cfinclude template="review/qry_get_reviews.cfm">
				<cfinclude template="review/dsp_reviews_list_form.cfm">
			</cfcase>
			
			<cfcase value="add">
				<cfinclude template="review/dsp_review_form.cfm">
			</cfcase>
			
			<cfcase value="edit">
				<cfinclude template="review/qry_get_review.cfm"> 
				<cfinclude template="review/dsp_review_form.cfm">
			</cfcase>
			
			<cfcase value="delete">
				<cfinclude template="review/dsp_delete.cfm">
			</cfcase>
			
			<cfcase value="act">
				<cfset attributes.UID = "">
				<cfinclude template="review/act_review.cfm">
				
				<cfparam name="attributes.XFA_success" default="fuseaction=review.admin&review=list">
				<cfset attributes.box_title="review">
				<cfinclude template="../../includes/admin_confirmation.cfm">			
			</cfcase>
			
			<cfcase value="actform">
				<cfinclude template="review/act_review_list.cfm">
				
				<cfset attributes.XFA_success = addedpath>
				<cfset attributes.box_title="review/reviews">
				<cfinclude template="../../includes/admin_confirmation.cfm">	
			</cfcase>
					
			<!--- feature Review Settings --->
			<cfcase value="settings">
				<cfinclude template="review/dsp_review_settings.cfm">
			</cfcase>
			
			<cfcase value="save">
				<cfinclude template="review/act_review_settings.cfm">
				<cfset attributes.XFA_success="fuseaction=feature.admin&review=settings&newWindow=Yes">
				<cfset attributes.menu_reload="yes">
				<cfset attributes.box_title="Review Settings">
				<cfinclude template="../../includes/admin_confirmation.cfm">					
			</cfcase>						
						
			<cfdefaultcase>
				<cfinclude template="review/qry_get_reviews.cfm">
				<cfinclude template="review/dsp_reviews_list.cfm">
			</cfdefaultcase>
			
		</cfswitch>
<!--- end custom code. --->
	
<cfelse>
	
	<cfinclude template="dsp_menu.cfm">
	
</cfif>

</cfif>


