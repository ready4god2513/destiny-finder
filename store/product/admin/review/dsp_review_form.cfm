<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the form to edit reviews. Called by product.admin&review=add|edit --->

<cfinclude template="../../../queries/qry_getpicklists.cfm">

<cfparam name="attributes.cid" default="">

<!--- Initialize the values for the form --->
<cfset fieldlist="Review_ID,User_ID,Anonymous,Anon_Name,Anon_Loc,anon_email,product_ID,Editorial,Title,Comment,Rating,Posted,Updated,Approved,NeedsCheck,Helpful_Total,Helpful_Yes">	
		
	<cfswitch expression="#review#">
			
		<cfcase value="add">
			<cfloop list="#fieldlist#" index="counter">
				<cfset temp = setvariable("attributes.#counter#", "")>
			</cfloop>
			<cfset attributes.Review_ID = 0>
			<!--- radio button defaults --->
			<cfset attributes.needsCheck = 0>
			<cfset attributes.uid = Session.User_ID>			
			<cfset action="#self#?fuseaction=product.admin&review=act&mode=i">
		    <cfset act_title="New Review">	
		</cfcase>
					
		<cfcase value="edit">
			<!--- Set the form fields to values retrieved from the record --->
			<cfloop list="#fieldlist#" index="counter">
				<cfset "attributes.#counter#" = evaluate("qry_get_review." & counter)>
			</cfloop>
			<cfset attributes.uid = qry_get_review.user_id>
			<cfset action="#self#?fuseaction=product.admin&review=act&mode=u">
			<cfset act_title="Update Review - #left(qry_get_review.title,20)#">
		</cfcase>
	</cfswitch>

	<cfquery name="GetUser" datasource="#Request.ds#" username="#Request.user#" password="#Request.pass#">
	SELECT Username	FROM #Request.DB_Prefix#Users
	WHERE User_ID = #attributes.UID#
	</cfquery>
		
		
<cfsetting enablecfoutputonly="no">
			
<cfmodule template="../../../customtags/format_admin_form.cfm"
	box_title="#act_title#"
	width="550"
	>
	
	<cfoutput>
	<form name="editform" action="#action##request.token2#" method="post">
	<input type="hidden" name="product_id" value="#attributes.product_id#"/>	
	<input type="hidden" name="Review_ID" value="#attributes.Review_ID#"/>
	<cfif isdefined("attributes.xfa_success")>
	<input type="hidden" name="xfa_success" value="#attributes.xfa_success#"/>
	</cfif>
	
	
	<cfif GetDetail.recordcount>
	
		<cfinclude template="../../../includes/form/put_space.cfm">
		
		<tr>
		<td align="right">
		<cfif len(GetDetail.Sm_Image)>
			<cfmodule template="../../../customtags/putimage.cfm" filename="#GetDetail.Sm_Image#" filealt="#GetDetail.Name#" imglink="#self#?fuseaction=product.display&product_ID=#attributes.product_ID##Request.Token2#"  User="#GetDetail.User_ID#" hspace="4" vspace="0" />
		</cfif>
		
		</td>
		<td></td>
		<td>
		<span class="prodname"><a href="#self#?fuseaction=product.display&product_ID=#attributes.product_ID##Request.Token2#" class="prodname_list">#GetDetail.Name#</a></span><br/>
		<cfif len(GetDetail.Short_Desc)>
			<cfmodule template="../../../customtags/puttext.cfm" Text="#GetDetail.Short_Desc#" Token="#Request.Token1#" ptag="no" class="cat_text_small" /><br/>
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
				<input type="hidden" name="UID" value="#attributes.UID#"/>
			</td>
		</tr>
			
<!--- anonymous --->
			<tr>
				<td align="RIGHT">Anonymous:</td>
				<td></td>
				<td>
					<input type="radio" name="Anonymous" value="1" #doChecked(attributes.Anonymous)# /> Yes 
					&nbsp;&nbsp;<input type="radio" name="Anonymous" value="0" #doChecked(attributes.Anonymous,0)# /> No
				</td>
			</tr>		
			
			
	<tr>
      <td valign="top" align="right">Display Name</td>
	  <td></td>
      <td>
	 	 <input type="text" name="anon_name" value="#attributes.anon_name#"  class="formfield"/>
		</td>
    </tr>

    <tr>
	  <td align="right">Anon Email</td></td>
	  <td></td>
      <td><input type="text" name="anon_email" size="45" value="#attributes.anon_email#" class="formfield"/>
	  </td>
    </tr>
			
    <tr>
	  <td align="right">Location</td></td>
	  <td></td>
      <td><input type="text" name="Anon_Loc" size="45" value="#attributes.Anon_Loc#" class="formfield"/><br/>
		<span class="formtextsmall">Example: Los Angeles, CA USA</span>
	  </td>
    </tr>
	
	
	<tr>
		<td align="RIGHT" class="formtitle"><br/>Review&nbsp;</td>
		<td colspan="2"><br/><cfmodule template="../../../customtags/putline.cfm" linetype="thin" linecolor="#Request.GetColors.InputHBgcolor#"/></td>
	</tr>
	
	<tr>
	  <td align="right">Title</td>
	  <td style="background-color: ###Request.GetColors.formreq#;" width="">&nbsp;</td>
      <td><input type="text" name="title" value="#attributes.title#" size="60" maxlength="50" class="formfield"/></td>
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
		<td></td>
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
				<td></td>
				<td>
				<cfmodule template="../../../customtags/calendar_input.cfm" ID="calposted" formfield="posted" formname="editform" value="#dateformat(attributes.posted,"mm/dd/yyyy")#" size="15" browser="#browsername#" bversion="#browserversion#" /> 
			</td>
			</tr>	
			
<!--- Posted --->
			<tr>
				<td align="RIGHT">Updated:</td>
				<td></td>
				<td>
				<cfmodule template="../../../customtags/calendar_input.cfm" ID="calupdated" formfield="Updated" formname="editform" value="#dateformat(attributes.posted,"mm/dd/yyyy")#" size="15" browser="#browsername#" bversion="#browserversion#" /> 
			</td>
			</tr>		
			
 <!--- Type --->
			<tr>
				<td align="RIGHT">Helpful:</td>
				<td></td>
				<td>
				<input type="text" name="Helpful_Yes" class="formfield" value="#attributes.Helpful_Yes#"  size="3" maxlength="5"/> users of <input type="text" name="Helpful_Total" class="formfield" value="#attributes.Helpful_Total#"  size="3" maxlength="5"/> found this review helpful
			</td>
			</tr>
			
		
<!--- approved --->
			<tr>
				<td align="RIGHT">Approved:</td>
				<td></td>
				<td>
					<input type="radio" name="approved" value="1" #doChecked(attributes.approved)# /> Yes
					 &nbsp;&nbsp;<input type="radio" name="approved" value="0" #doChecked(attributes.approved,0)# /> No
				</td
			</tr>
			
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


<cfif review is "edit">
		<input type="submit" name="submit_Review" value="Delete" class="formbutton" onclick="return confirm('Are you sure you want to delete this review?');"/>
</cfif>

	</td>
	
	</tr>
	</form>	

<cfprocessingdirective suppresswhitespace="no">
<script type="text/javascript">
objForm = new qForm("editform");

objForm.required("title,comment,Helpful_Yes,Helpful_Total");

objForm.posted.description = "date posted";
objForm.Updated.description = "date updated";

objForm.posted.validateDate();
objForm.Updated.validateDate();
objForm.Helpful_Yes.validateNumeric();
objForm.Helpful_Total.validateNumeric();

// make sure helpful totals are positive values
objForm.Helpful_Yes.validateExp("parseInt(this.value) < 0");
objForm.Helpful_Total.validateExp("parseInt(this.value) < 0");

qFormAPI.errorColor = "###Request.GetColors.formreq#";

</script>
</cfprocessingdirective>

	
</cfoutput>		
			
<!--- close module --->
</cfmodule>
	