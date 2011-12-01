<cfparam name="ATTRIBUTES.processing_url" default="index.cfm">
<cfparam name="ATTRIBUTES.destination_url" default="index.cfm">

<cfset obj_login = CreateObject("component","cfcs.login")>


<cfif isDefined('FORM.user_name')>
	<cfset Cffp = CreateObject("component","cfformprotect.cffpVerify").init() />
    <!--- now we can test the form submission --->
    <cfif Cffp.testSubmission(form)>
		<!--- RUN THE LOGIN FUNCTION --->
        <cfset VARIABLES.process_login = obj_login.login_form_action()>
        
        <cfif VARIABLES.process_login EQ "login_fail">
            <cfset VARIABLES.login_message = "I'm sorry your username and password did not match.">
        <cfelse>
            <cflocation url="/profile/?page=profiler" addtoken="no">
            <cfabort>
        </cfif>
    <cfelse>
      <cflocation url="/index.cfm" addtoken="no">
      <cfabort>
    </cfif>
</cfif>

<cfoutput>
	<div id="form_wrapper">
    
    <h2>Account Login</h2>
    <br />	
     <table>
     <cfset Cffp = CreateObject("component","cfformprotect.cffpVerify").init() />
     <cfform id="login_box" name="form" action="#ATTRIBUTES.processing_url#" method="post">	
     <cfinclude template="../../cfformprotect/cffp.cfm">	  
     	 <tr>
             <td colspan="2">  
             <h2>Beta Version Launches!</h2><br />
We're excited to unveil the first stage of 
destinyfinder.com with the Free Destiny Survey! <br />
Take the first step to discover your destiny.<br />
We'll be rolling out the rest of this amazing system shortly.<br /><br />           
             <cfif isDefined('VARIABLES.login_message')>
                <cfoutput>#HTMLEditFormat(VARIABLES.login_message)#</cfoutput>
             </cfif>&nbsp;
             </td>
         </tr>
		 <tr>
		 	<td colspan="2">
				<div style="font-weight:bold;">Please Login</div><!---<div style="font-weight:bold;">--->
            </td>
		 </tr>
         <tr>
          	<td>&nbsp;</td>
            <td></td>
          </tr>
		  <tr>
			<td width="1%">Username:&nbsp;</td>
			<td width="99%"><cfinput type="text" style="width:180px;" name="user_name" required="yes" message="Username cannot be blank!"></td>
		  </tr>
		  <tr>
			<td>Password:&nbsp;</td>
			<td><cfinput type="password" style="width:180px;" name="password" required="yes" message="Password cannot be blank!"></td>
		  </tr>
		  <tr>
            <td></td>
			<td>
			  <input type="submit" name="submit" value="submit">
		    </td>
		  </tr>
          <tr>
          	<td>&nbsp;</td>
            <td></td>
          </tr>
          <tr>
            <td colspan="2"><div align="left"><span>Not a user yet?</span> <a href="index.cfm?page=user&create=1">Click here to create a free account.</a></div><!---<div align="left">---></td>
          </tr> 
          <tr>
          	<td colspan="2" height="99%"></td>
          </tr>
          </cfform>
          </table>
          </div><!---<div id="form_wrapper">--->
          <div style="float:left;">  
            <p>&nbsp;</p>
            <p>&nbsp;</p>
            <p>&nbsp;</p>
            <p>&nbsp;</p>
            <p>&nbsp;</p>
            <p>&nbsp;</p>
            <p>&nbsp;</p>
            <p>&nbsp;</p>
          </div>
</cfoutput>
	
