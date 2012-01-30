<cfset objAssessment = CreateObject('component','cfcs.assessment')>

<cfoutput>
<cfif isDefined('FORM.submit')>
	#objAssessment.invite_friend(user_id="#REQUEST.user_id#")#
	<cflocation url="index.cfm?page=invmod&assessment_id=1&gift_type_id=1">
    <cfabort>
</cfif>

<p><a href="index.cfm?page=invmod&assessment_id=1&gift_type_id=1">< Back</a></p>

<form action="#CGI.SCRIPT_NAME#?#CGI.QUERY_STRING#" method="post" name="profile" enctype="multipart/form-data">
    <table width="282" border="0" cellspacing="3" cellpadding="0" class="profile_table" >
      <tr>
        <td width="86" class="form_label">First Name:</td>
        <td width="187"><input type="text" name="user_first_name" size="20" value=""> </td>
      </tr>
      <tr>
        <td width="86" class="form_label">Last Name:</td>
        <td width="187"><input type="text" name="user_last_name" size="20" value=""> </td>
      </tr>
       <tr>
        <td width="86" class="form_label">Email:</td>
        <td width="187">
            <input type="text" name="user_email" size="20" value="">
        </td>
      </tr>
      <tr>
        <td colspan="2">
            <div align="center">
                <input type="submit" name="submit" value="Invite Friend">
            </div>
         </td>
      </tr>
  </table>
</form>

</cfoutput>