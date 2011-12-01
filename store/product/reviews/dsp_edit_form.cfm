<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Review add and update form ---->			
	
<!--- Initialize Review Fields --->
<cfloop list="Anonymous,Anon_Name,Anon_Loc,Anon_Email,Title,Comment,Rating" index="counter">
	<cfparam name="attributes.#counter#" default="#evaluate('qry_get_review.' & counter)#">
</cfloop>

<cfif NOT len(attributes.anon_name) and len(Session.Realname)>
	<cfset attributes.anon_name = Session.Realname>
	<cfset attributes.Anonymous = 0>
</cfif>

<cfset action="#self#?fuseaction=product.reviews&do=update#PCatNoSES##request.token2#">

<cfif attributes.Review_ID IS 0>
	<cfset formaction="Add">
	<cfparam name="attributes.Anonymous" default="1">
<cfelse>
	<cfset formaction="Update">
</cfif>

<cfparam name="attributes.box_title" default="Product Review">

<!--- <cfmodule template="../../customtags/puttitle.cfm" TitleText="Product Reviews" class="product"> --->


<cfoutput>
<form name="editform"  action="#XHTMLFormat(action)#" method="post" >
<input type="hidden" name="Review_ID" value="#attributes.Review_ID#"/>
<input type="hidden" name="UID" value="#attributes.UID#"/>
<input type="hidden" name="product_ID" value="#attributes.product_ID#"/>
	
<cfmodule template="../../customtags/format_input_form.cfm"
box_title="#formaction# #attributes.box_title#"
width="550"
required_fields="1"
>

	<tr align="left">
		<td align="right">
		<cfif len(GetDetail.Sm_Image)>
			<cfmodule template="../../customtags/putimage.cfm" filename="#GetDetail.Sm_Image#" filealt="#GetDetail.Name#" imglink="#XHTMLFormat(prodlink)#" hspace="3" vspace="2" class="listingimg"  User="#GetDetail.User_ID#" />
		</cfif>
		</td>
		<td></td>
		<td>
		<h2 class="product"><a href="#XHTMLFormat(prodlink)#" #doMouseover(GetDetail.Name)#>#GetDetail.Name#</a></h2><br/>
		<cfif len(GetDetail.Short_Desc)>
			<cfmodule template="../../customtags/puttext.cfm" Text="#GetDetail.Short_Desc#" Token="#Request.Token1#" ptag="no" class="cat_text_small" /><br/>
		</cfif>
		</td>
	</tr> 

	<tr><td colspan="3"><cfmodule template="../../customtags/putline.cfm" linetype="thick" linecolor="#Request.GetColors.InputHBgcolor#"/></td></tr>
	<tr align="left">
		<td align="right">Product Rating</td>
		<td style="background-color: ###Request.GetColors.formreq#;" width="3">&nbsp;</td>
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

	
	<!--- Title ---->
	<tr align="left">
	  <td align="right">Title</td>
	  <td style="background-color: ###Request.GetColors.formreq#;"></td>
      <td><input type="text" name="title" value="#HTMLEditFormat(attributes.title)#" size="72" maxlength="75" class="formfield"/></td>
    </tr>

	
	<tr align="left">
      <td valign="top" align="right">Your Comments</td>
	  <td style="background-color: ###Request.GetColors.formreq#;"></td>
      <td ><textarea rows="8" name="Comment" cols="55" class="formfield">#HTMLEditFormat(attributes.Comment)#</textarea></td>
    </tr>
	
	
	<!--- Name: Not used for responses to professional reviews --->

	<!--- If no user_ID, anonymous posting --->
	<cfif not Session.User_ID>
	<tr align="left">
      <td valign="top" align="right">Your Name</td>
	  <td style="background-color: ###Request.GetColors.formreq#;"></td>
      <td>
	 	 <input type="text" name="anon_name" value="#HTMLEditFormat(attributes.anon_name)#" size="33" maxlength="50" class="formfield"/>
	  	 <input type="hidden" name="Anonymous" value="1"/> 
		</td>
    </tr>

    <tr align="left">
	  <td align="right">Your Email?</td></td>
	  <td></td>
      <td><input type="text" name="anon_email" size="38" value="#HTMLEditFormat(attributes.anon_email)#" class="formfield" maxlength="75"/>
	  </td>
    </tr>
	
	<cfelse>
	
	<tr align="left">
      <td valign="top" align="right">Your Name</td>
	  <td style="background-color: ###Request.GetColors.formreq#;"></td>
      <td>
	  <input type="radio" name="Anonymous" value="0" #doChecked(attributes.Anonymous,0)# /> 
	  <input type="text" name="anon_name" size="33"  maxlength="50" value="#attributes.anon_name#" class="formfield"/><br/>
	  
	  <input type="radio" name="Anonymous" value="1" #doChecked(attributes.Anonymous)# /> 
	  Keep me anonymous		
	   	  
		</td>
    </tr>
	
	</cfif>
	
    <tr align="left">
	  <td align="right" valign="top">Where are you?</td>
	  <td></td>
      <td><input type="text" name="Anon_Loc" size="38" value="#HTMLEditFormat(attributes.Anon_Loc)#" class="formfield" maxlength="75"/><br/>
		<span class="formtextsmall">Example: Los Angeles, CA USA</span>
	  </td>
    </tr>

	
	
    <tr align="left">
      <td colspan="2"></td>
      <td ><br/>
	  <input type="submit" name="submit_review" value="#formaction# #attributes.box_title#" class="formbutton"/>
		   
		<input type="button" name="cancel" value="Cancel" class="formbutton" onclick="history.go(-1);"/>
		</td>
    </tr>

</cfmodule>

</form>

<cfprocessingdirective suppresswhitespace="No">
<script type="text/javascript">
objForm = new qForm("editform");

objForm.required("title,Comment");

qFormAPI.errorColor = "###Request.GetColors.formreq#";

</script>
</cfprocessingdirective>

</cfoutput>
