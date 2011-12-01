
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Review add and update form ---->			

<cfparam name="attributes.parent_ID" default="0">

<cfif attributes.parent_ID IS NOT 0>

	<cfquery name="Parent_Review"  datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" maxrows="1">
	SELECT R.Review_ID, R.Anonymous, R.Anon_Name, R.Anon_Loc, R.Posted,	R.Title, R.Comment, U.Username
	FROM #Request.DB_Prefix#FeatureReviews R 
	LEFT JOIN #Request.DB_Prefix#Users U on R.User_ID = U.User_ID
	WHERE Review_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.parent_ID#">
	</cfquery>

</cfif>			
			
<!--- Initialize Review Fields --->
<cfloop list="Review_ID,Feature_ID,Anonymous,Anon_Name,Anon_Loc,Anon_Email,Title,Comment,Rating" index="counter">
	<cfparam name="attributes.#counter#" default="#evaluate('qry_get_review.' & counter)#">
</cfloop>

<cfif NOT len(attributes.anon_name) AND len(Session.Realname)>
	<cfset attributes.anon_name = Session.Realname>
	<cfset attributes.Anonymous = 0>
</cfif>

<cfset action="#self#?fuseaction=feature.reviews&do=update#PCatNoSES##request.token2#">

<cfif attributes.Review_ID IS 0>
	<cfset formaction="Add">
	<cfparam name="attributes.Anonymous" default="1">
<cfelse>
	<cfset formaction="Update">
</cfif>

<cfparam name="attributes.box_title" default="Your Comment">

<!--- <cfmodule template="../../customtags/puttitle.cfm" TitleText="Your Opinion" class="feature"> --->

<cfhtmlhead text="
 <script type=""text/javascript"">
 <!--
 function CancelForm() {
 window.location.href='#self#?fuseaction=feature.display&feature_id=#attributes.Feature_ID#&redirect=1#request.token2#';
 }
 // --> 
 </script>
">

<cfoutput>
<form name="editform"  action="#XHTMLFormat(action)#" method="post" enctype="multipart/form-data" >
<input type="hidden" name="Review_ID" value="#HTMLEditFormat(attributes.Review_ID)#"/>
<input type="hidden" name="UID" value="#HTMLEditFormat(attributes.UID)#"/>
<input type="hidden" name="Feature_ID" value="#HTMLEditFormat(attributes.Feature_ID)#"/>
<input type="hidden" name="Parent_ID" value="#HTMLEditFormat(attributes.Parent_ID)#"/>
	
<cfmodule template="../../customtags/format_input_form.cfm"
box_title="#formaction# #attributes.box_title#"
width="550"
required_fields="1"
>
	<tr align="left">
		<td align="right">
		<cfif len(GetDetail.Sm_Image)>
			<cfmodule template="../../customtags/putimage.cfm" filename="#GetDetail.Sm_Image#" filealt="#GetDetail.Name#" imglink="#XHTMLFormat(featurelink)#"  hspace="4" vspace="0" />
		</cfif>
		</td>
		<td></td>
		<td>
		<span class="prodname"><a href="#XHTMLFormat(featurelink)#" class="prodname_list">#GetDetail.Name#</a></span><br/>
		<cfif len(GetDetail.Short_Desc)>
			<cfmodule template="../../customtags/puttext.cfm" Text="#GetDetail.Short_Desc#" Token="#Request.Token1#" ptag="no" class="cat_text_small" /><br/>
		</cfif>
		
		<!--- If this is a response to another Review, print the review --->
		<cfif attributes.parent_ID>
			<br/><strong>Your Response:</strong>
			<blockquote>
				<strong>#Parent_review.title#</strong><br/>
				#Parent_review.comment#<br/>
				<strong>Posted By:</strong>
				 <cfif Parent_review.Anonymous is 1>anonymous<cfelseif len(Parent_review.anon_name)>#Parent_review.anon_name#<cfelse>#Parent_review.username#</cfif>
				&nbsp; <strong>Posted On: </strong>#dateformat(Parent_review.Posted,"mm/dd/yy")#<br/>
			</blockquote>
		</cfif>	
		
		</td>
	</tr> 

	<tr><td colspan="3"><cfmodule template="../../customtags/putline.cfm" linetype="thin" linecolor="#Request.GetColors.InputHBgcolor#"/></td></tr>

	<tr align="left">
		<td align="right">Your Rating</td>
		<td style="background-color: ###Request.GetColors.formreq#;" width="3">&nbsp;</td>
		<td> 
			<select name="rating">
				<option value="5" #doSelected(attributes.rating,5)#>Five Stars</option>
				<option value="4" #doSelected(attributes.rating,4)#>Four Stars</option>
				<option value="3" #doSelected(attributes.rating,3)#>Three Stars</option>
				<option value="2" #doSelected(attributes.rating,2)#>Two Stars</option>
				<option value="1" #doSelected(attributes.rating,1)#>One Star</option>
			</select>
		</td>
	</tr>

	
	<!--- Title ---->
	<tr align="left">
	  <td align="right">Title</td>
	  <td style="background-color: ###Request.GetColors.formreq#;"></td>
      <td><input type="text" name="title" value="#HTMLEditFormat(attributes.title)#" size="72" maxlength="100" class="formfield"/></td>
    </tr>

	
	<tr align="left">
      <td valign="top" align="right">Your Comment:</td>
	  <td style="background-color: ###Request.GetColors.formreq#;"></td>
      <td ><textarea rows="8" name="Comment" cols="55" class="formfield">#HTMLEditFormat(attributes.Comment)#</textarea></td>
    </tr>
	
	
	<!--- Name: Not used for responses to professional reviews --->

	<!--- If no user_ID, anonymous posting --->
	<cfif not Session.User_ID>
	<tr align="left">
      <td valign="top" align="right">Your Name:</td>
	  <td style="background-color: ###Request.GetColors.formreq#;"></td>
      <td>
	 	 <input type="text" name="anon_name" value="#HTMLEditFormat(attributes.anon_name)#" size="33" maxlength="100" class="formfield"/>
	  	 <input type="hidden" name="Anonymous" value="1"/> 
		</td>
    </tr>

    <tr align="left">
	  <td align="right">Email:</td></td>
	  <td></td>
      <td><input type="text" name="anon_email" size="38" value="#HTMLEditFormat(attributes.anon_email)#" class="formfield" maxlength="100"/>
	  </td>
    </tr>
	
	<cfelse>
	
	<tr align="left">
      <td valign="top" align="right">Your Name:</td>
	  <td style="background-color: ###Request.GetColors.formreq#;"></td>
      <td>
	  <input type="radio" name="Anonymous" value="0" #doChecked(attributes.Anonymous,0)# /> 
	  <input type="text" name="anon_name" size="33" value="#attributes.anon_name#"  maxlength="50" class="formfield"/><br/>
	  
	  <input type="radio" name="Anonymous" value="1" #doChecked(attributes.Anonymous)# /> 
	  Anonymous
	   	  
		</td>
    </tr>
	
	</cfif>
	
    <tr align="left">
	  <td align="right">Location</td>
	  <td></td>
      <td><input type="text" name="Anon_Loc" size="38" value="#HTMLEditFormat(attributes.Anon_Loc)#" class="formfield" maxlength="100"/><br/>
		<span class="formtextsmall">eg: 'Los Angeles, CA'</span>
	  </td>
    </tr>

	
	
    <tr align="left">
      <td colspan="2"></td>
      <td ><input type="submit" name="submit_Review" value="#formaction# #attributes.box_title#" class="formbutton"/>
		   
		   <input type="button" name="cancel" value="Cancel" class="formbutton" onclick="CancelForm();"/>
		</td>
    </tr>

</cfmodule>
</form>

<cfprocessingdirective suppresswhitespace="no">
<script type="text/javascript">
objForm = new qForm("editform");

objForm.required("rating,title,Comment,Anonymous");

objForm.Comment.description = "Comments";

qFormAPI.errorColor = "###Request.GetColors.formreq#";

</script>
</cfprocessingdirective>
</cfoutput>

