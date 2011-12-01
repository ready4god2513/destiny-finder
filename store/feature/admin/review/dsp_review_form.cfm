<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the form to edit reviews. Called by Feature.admin&review=add|edit --->

<cfinclude template="../../../queries/qry_getpicklists.cfm">

<cfparam name="attributes.cid" default="">

<!--- Initialize the values for the form --->
<cfset fieldlist="Review_ID,Anonymous,Anon_Name,Anon_Loc,Anon_Email,Feature_ID,Editorial,Title,Comment,Rating,Posted,Updated,Approved,NeedsCheck,children">	
		
	<cfswitch expression="#attributes.review#">
			
		<cfcase value="add">
			<cfloop list="#fieldlist#" index="counter">
				<cfset temp = setvariable("attributes.#counter#", "")>
			</cfloop>
			<cfset attributes.Review_ID = 0>
			<cfset attributes.Parent_ID = 0>
			<cfset attributes.children = 0>
			<cfset attributes.UID = Session.User_ID>			
			<cfset action="#self#?fuseaction=feature.admin&review=act&mode=i">
		    <cfset act_title="New Review">	
		</cfcase>
					
		<cfcase value="edit">
			<!--- Set the form fields to values retrieved from the record --->
			<cfloop list="#fieldlist#" index="counter">
				<cfset "attributes.#counter#" = evaluate("qry_get_review." & counter)>
			</cfloop>
			<cfset attributes.uid = qry_get_review.user_id>	
			<cfset attributes.Parent_ID = qry_get_review.parent_id>
			<cfset action="#self#?fuseaction=feature.admin&review=act&mode=u">
			<cfset act_title="Update Review - #left(qry_get_review.title,20)#">
		</cfcase>
		
	</cfswitch>

	<cfquery name="GetUser" datasource="#Request.ds#" username="#Request.user#" password="#Request.pass#" >
	SELECT Username FROM #Request.DB_Prefix#Users
	WHERE User_ID = #attributes.UID#
	</cfquery>
	
	<cfif attributes.parent_ID IS NOT 0>	
		<cfquery name="Parent_Review"  datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" maxrows="1">
		SELECT R.Review_ID, R.Anonymous, R.Anon_Name, R.Anon_Loc, R.Posted,	R.Title, R.Comment, U.Username
		FROM #Request.DB_Prefix#FeatureReviews R 
		LEFT JOIN #Request.DB_Prefix#Users U on R.User_ID = U.User_ID
		WHERE Review_ID = #attributes.parent_ID#
		</cfquery>
	</cfif>		
		
		
<cfsetting enablecfoutputonly="no">

	
<cfmodule template="../../../customtags/format_admin_form.cfm"
	box_title="#act_title#"
	width="550"
	>
	
	<cfoutput>
	<form name="editform" action="#action##request.token2#" method="post" >
	<input type="hidden" name="Feature_ID" value="#attributes.Feature_ID#"/>	
	<input type="hidden" name="Review_ID" value="#attributes.Review_ID#"/>
	<input type="hidden" name="Parent_ID" value="#attributes.Parent_ID#"/>
		
	<cfif isdefined("attributes.xfa_success")>
	<input type="hidden" name="xfa_success" value="#attributes.xfa_success#"/>
	</cfif>
	
	
	<cfif GetDetail.recordcount>
	
		<cfinclude template="../../../includes/form/put_space.cfm">
		
		<tr>
		<td align="right">
		<cfif len(GetDetail.Sm_Image)>
			<cfmodule template="../../../customtags/putimage.cfm" filename="#GetDetail.Sm_Image#" filealt="#GetDetail.Name#" imglink="#self#?fuseaction=feature.display&Feature_ID=#attributes.feature_ID##Request.Token2#"  hspace="3" vspace="2" class="listingimg">
		</cfif>
		
		</td>
		<td></td>
		<td>
		<span class="prodname"><a href="#self#?fuseaction=feature.display&feature_ID=#attributes.Feature_ID##Request.Token2#" class="prodname_list">#GetDetail.Name#</a></span><br/>
		<cfif len(GetDetail.Short_Desc)>
			<cfmodule template="../../../customtags/puttext.cfm" Text="#GetDetail.Short_Desc#" Token="#Request.Token1#" ptag="no" class="cat_text_small"><br/>
		</cfif>
		
		<!--- If this is a response to another Review, print the review --->
		<cfif isdefined("Parent_review.recordcount")>
			<br/><strong>Your Response to the Comment:</strong>
			<blockquote>
				<strong>#Parent_review.title#</strong><br/>
				#Parent_review.comment#<br/>
				<strong>Posted by:</strong>
				 <cfif Parent_review.Anonymous is 1>anonymous<cfelseif len(Parent_review.anon_name)>#Parent_review.anon_name#<cfelse>#Parent_review.username#</cfif>
				&nbsp; <strong>Posted on: </strong>#dateformat(Parent_review.Posted,"mm/dd/yy")#<br/>
			</blockquote>
		</cfif>	
		</td>
	</tr> 

	
	<tr><td colspan="3"><cfmodule template="../../../customtags/putline.cfm" linetype="thick" linecolor="#Request.GetColors.InputHBgcolor#"/></td></tr>
	
	</cfif>
	
	
	
<!--- review ID --->
			<tr>
				<td align="RIGHT" width="20%">Review ID:</td>
				<td width="4">&nbsp;</td>
				<td>
				<cfif attributes.Review_ID>
					#attributes.Review_ID#
				<cfelse>
					NEW
				</cfif>
				</td>
			</tr>

	 <!--- User_ID --->
	 	<tr>
			<td align="RIGHT">Username:</td>
			<td></td>
			<td><input type="text" name="UName" value="#GetUser.Username#" size="20" maxlength="50" class="formfield"/>
			</td>
		</tr>
			
<!--- anonymous --->
			<tr>
				<td align="RIGHT">Anonymous:</td>
				<td style="background-color: ###Request.GetColors.formreq#;" width="3">&nbsp;</td>
				<td>
					<input type="radio" name="Anonymous" value="1" #doChecked(attributes.Anonymous)# /> Yes  
					&nbsp;&nbsp;<input type="radio" name="Anonymous" value="0" #doChecked(attributes.Anonymous,0)# /> No
				</td>
			</tr>
			
			
			
	<tr>
      <td valign="top" align="right">Display Name</td>
	  <td></td>
      <td>
	 	 <input type="text" name="anon_name" value="#attributes.anon_name#" maxlength="100"  class="formfield"/>
		</td>
    </tr>

    <tr>
	  <td align="right">Anon Email</td></td>
	  <td></td>
      <td><input type="text" name="anon_email" size="45" value="#attributes.anon_email#" maxlength="100" class="formfield"/>
	  </td>
    </tr>
			
    <tr>
	  <td align="right">Location</td></td>
	  <td></td>
      <td><input type="text" name="Anon_Loc" size="45" value="#attributes.Anon_Loc#" maxlength="100" class="formfield"/><br/>
		<span class="formtextsmall">Example: Los Angeles, CA USA</span>
	  </td>
    </tr>
	
	<tr>
		<td align="RIGHT" class="formtitle"><br/>Review&nbsp;</td>
		<td colspan="2"><br/><cfmodule template="../../../customtags/putline.cfm" linetype="thin" linecolor="#Request.GetColors.InputHBgcolor#"/></td>
	</tr>
	
	<tr>
	  <td align="right">Title</td>
	  <td style="background-color: ###Request.GetColors.formreq#;"></td>
      <td><input type="text" name="title" value="#attributes.title#" size="60" maxlength="100" class="formfield"/></td>
    </tr>

	<tr>
      <td  colspan="3" align="center">	
		<cfset config = StructNew()>
		<cfset config.LinkBrowser = "false">
		<cfset config.FlashBrowser = "false">
			<cfmodule 
				template="../../../customtags/fckeditor/fckeditor.cfm" 
				instanceName="comment"
				height="300" 						
				toolbarSet="Basic" 
				config="#config#"
				Value="#attributes.comment#"
				/>
	 	</td>
    </tr>
	

	<tr>
		<td align="right">Rating</td>
		<td style="background-color: ###Request.GetColors.formreq#;"></td>
		<td> 
			<select name="rating" class="formfield">
				<option value="5" #doSelected(attributes.rating,5)#>5 Stars: Excellent</option>
				<option value="4" #doSelected(attributes.rating,4)#>4 Stars: Very Good</option>
				<option value="3" #doSelected(attributes.rating,3)#>3 Stars: Average</option>
				<option value="2" #doSelected(attributes.rating,2)#>2 Stars: Below Average</option>
				<option value="1" #doSelected(attributes.rating,1)#>1 Star: Avoid It</option>
			</select>
		</td>
	</tr>
	
		
	<tr>
		<td align="RIGHT" class="formtitle"><br/>Other&nbsp;</td>
		<td colspan="2"><br/><cfmodule template="../../../customtags/putline.cfm" linetype="thin" linecolor="#Request.GetColors.InputHBgcolor#"/></td>
	</tr>
	
	
	
<!--- Posted --->
			<tr>
				<td align="RIGHT">Date:</td>
				<td style="background-color: ###Request.GetColors.formreq#;"></td>
				<td>
				<cfmodule template="../../../customtags/calendar_input.cfm" ID="posted" formfield="posted" formname="editform" value="#dateformat(attributes.posted,"mm/dd/yyyy")#" size="15" browser="#browsername#" bversion="#browserversion#" /> 
			</td>
			</tr>	
			
<!--- Posted --->
			<tr>
				<td align="RIGHT">Updated:</td>
				<td></td>
				<td>
				<cfmodule template="../../../customtags/calendar_input.cfm" ID="Updated" formfield="Updated" formname="editform" value="#dateformat(attributes.Updated,"mm/dd/yyyy")#" size="15" browser="#browsername#" bversion="#browserversion#" /> 
			</td>
			</tr>			
			
<!--- approved --->
			<tr>
				<td align="RIGHT">Approved:</td>
				<td></td>
				<td>
					<input type="radio" name="approved" value="1" #doChecked(attributes.approved)# <cfif attributes.children>disabled</cfif>/> Yes  
					&nbsp;&nbsp;<input type="radio" name="approved" value="0" #doChecked(attributes.approved,0)# <cfif attributes.children>disabled</cfif>/> No
				</td
			</tr>
			<cfif attributes.children>
			<tr><td colspan="2"></td>
			<td><span class="formtextsmall">Disabled since this review has responses, those would need to be removed first.</span></td>
			</cfif>
			
<!--- needs check --->
			<tr>
				<td align="RIGHT">Needs Check:</td>
				<td></td>
				<td>
					<input type="radio" name="needsCheck" value="1" #doChecked(attributes.needsCheck)# /> Yes  
					&nbsp;&nbsp;<input type="radio" name="needsCheck" value="0" #doChecked(attributes.needsCheck,0)# /> No
				</td
			</tr>
						
		<cfinclude template="../../../includes/form/put_space.cfm">
			
		<tr>
			<td colspan="2">&nbsp;</td>
			<td>
			<input type="submit" name="submit_Review" value="<cfif review is 'edit'>Update<cfelse>Add review</cfif>" class="formbutton"/> 			
			<input type="button" value="Cancel" onclick="javascript:window.history.go(-1);" class="formbutton"/> 	


<cfif review is "edit" AND NOT attributes.children>
	<input type="submit" name="submit_Review" value="Delete" class="formbutton" onclick="return confirm('Are you sure you want to delete this review?');"/>
<cfelse>
	<input type="button" value="Delete" class="formbutton"  onclick="alert('This review has responses to it. You must remove them first before you can delete it.');"/>
</cfif>

	</td>
	
	</tr>
	</form>	

<cfprocessingdirective suppresswhitespace="no">
<script type="text/javascript">
objForm = new qForm("editform");

objForm.required("title,comment,posted");

objForm.posted.description = "date posted";
objForm.Updated.description = "date updated";

objForm.posted.validateDate();
objForm.Updated.validateDate();

qFormAPI.errorColor = "###Request.GetColors.formreq#";

</script>
</cfprocessingdirective>

	
</cfoutput>		
			
<!--- close module --->
</cfmodule>
	