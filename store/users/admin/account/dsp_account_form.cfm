
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the form to add and edit Accunts. Called by the fuseaction users.admin&account=add|edit --->

<!--- Initialize the values for the form --->
<cfset fieldlist="account_ID,Customer_ID,Account_name,type1,Description,Policy,logo,Rep,web_url,map_url,terms,dropship_email,PO_text,directory_live">


<cfswitch expression="#account#">
	<cfcase value="add">
		<!--- Initialize the values for the form --->
		<cfloop list="#fieldlist#" index="counter">
			<cfset setvariable("attributes.acc_#counter#", "")>
		</cfloop>
		
		<cfset attributes.acc_customer_id= 0>
		<cfset action="#self#?fuseaction=users.admin&account=act&mode=i">
	    <cfset act_title="Add Account">
		<cfset act_button="Add">	
		<cfset attributes.uid = "0">
		<cfset attributes.acc_web_url = "http://">
	</cfcase>
			
	<cfcase value="edit">
		<!--- Set the form fields to values retrieved from the record --->					
		<cfloop list="#fieldlist#" index="counter">
			<cfset "attributes.acc_#counter#" = evaluate("qry_get_account." & counter)>
		</cfloop>
			
		<cfset attributes.uid = qry_get_Account.User_ID>
		<cfset attributes.cid = qry_get_Account.customer_id>
		
		<cfset action="#self#?fuseaction=users.admin&account=act&mode=u">
		<cfset act_title="Update Account">
		<cfset act_button="Update">
				
	</cfcase>
</cfswitch>

<!--- Get select list options --->
<cfinclude template="../../../queries/qry_getpicklists.cfm">

<cfquery name="GetUser" datasource="#Request.ds#" username="#Request.user#" password="#Request.pass#" >
	SELECT Username
	FROM #Request.DB_Prefix#Users
	WHERE User_ID = #attributes.UID#
</cfquery>



<cfinclude template="../../../includes/imagepreview.js">
<cfmodule template="../../../customtags/format_admin_form.cfm"
	box_title="#act_title#"
	width="450"
	>

<!--- Table --->
<cfoutput>
	<form name="editform" action="#action##request.token2#" method="post" target="_self" >
	<input type="hidden" name="fieldlist" value="#fieldlist#"/>
	<input type="hidden" name="Acc_Account_ID" value="#attributes.Acc_account_id#"/>
	<input type="hidden" name="XFA_success" value="#URLDecode(attributes.XFA_success)#"/>
	 <!--- Account ID --->
		<tr>
			<td align="right">Account ID:</td>
			<td width="4"></td>
			<td><cfif attributes.Acc_account_ID is not "">
					#attributes.Acc_account_ID#
				<cfelse>
					New
				</cfif></td>
		</tr>
	
	 <!--- User_ID --->
	 	<tr>
			<td align="right">User:</td>
			<td></td>
			<td><input type="text" name="UName" value="#GetUser.Username#" size="20" maxlength="50" class="formfield"/>
			</td>
		</tr>
		

 	<!--- Company --->
		<tr>
			<td align="right">Account Name:</td>
			<td style="background-color: ###Request.GetColors.formreq#;" width="3">&nbsp;</td>
			<td><input type="text" name="Acc_Account_name" value="#attributes.Acc_Account_name#" size="37" maxlength="100" class="formfield"/></td>
			</tr>
			
			
 	<!--- type1 --->
		<tr>
			<td align="right">Type:</td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
			<td>
   <cfif attributes.Acc_type1 is "manufacturer" or attributes.Acc_type1 is "vendor">
    #attributes.acc_type1#
    <input type="hidden" name="Acc_type1" value="#attributes.Acc_type1#"/>
   <cfelse>
    <select name="Acc_type1" size="1" class="formfield">
   		<option value="manufacturer" #doSelected(attributes.Acc_type1,"manufacturer")#>manufacturer</option>
		<option value="vendor" #doSelected(attributes.Acc_type1,"vendor")#>vendor</option>
		<option value="retailer" #doSelected(attributes.Acc_type1,"retailer")#>retailer</option>
  	  	<cfloop index="acc" list="#qry_getPicklists.acc_type1#">
    		<option value="#acc#" #doSelected(attributes.Acc_type1,acc)#>#acc#</option>
      	</cfloop>
    </select>
   </cfif>

</td>
			</tr>
			
 <!--- Customer_ID --->			
		<tr>
			<td align="right">Address ID:</td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
			<td><input type="text" name="Acc_Customer_ID" value="#attributes.Acc_Customer_ID#" size="7" maxlength="100" class="formfield"/>
			<span class="formtextsmall">account address ID from Customer Address module</span></td>
			</tr>	
			
 <!--- Description --->	
		<tr>
			<td align="right" valign="top">Description:</td>
			<td></td>
			<td><textarea cols="32" name="Acc_Description" rows="5" class="formfield">#attributes.Acc_Description#</textarea></td>
			</tr>
 
 <!--- Policy ---> 
		<tr>
			<td align="right" valign="top">Policy:</td>
			<td></td>
			<td><textarea cols="32" name="Acc_Policy" rows="3" class="formfield">#attributes.Acc_Policy#</textarea>
			</td>
			</tr>

 <!--- logo --->
		<tr>
			<td align="right">Logo:</td>
			<td></td>
			<td><input type="text" name="Acc_logo" size="30" maxlength="100" class="formfield" value="#attributes.Acc_logo#"/> 
<a href="JavaScript: newWindow = openWin('#self#?fuseaction=home.admin&select=image&fieldname=Acc_logo&fieldvalue=#attributes.Acc_logo#&dirname=/accounts', 'images', 'width=520,height=290,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=0,resizable=1'); newWindow.focus()" class="formtextsmall">Image Manager</a>
			</td>
			</tr>
			
			
 <!--- Web URL --->		
		<tr>
			<td align="right">Company URL:</td>
			<td></td>
			<td><input type="text" name="Acc_web_url" value="#attributes.Acc_web_url#" size="40" maxlength="100" class="formfield"/></td>
			</tr>	
			
   <!--- Map URL --->		
	<tr>
		<td align="right">Store Map:</td>
		<td></td>
		<td><input type="text" name="Acc_map_url" value="#attributes.Acc_map_url#" size="40" class="formfield"/><br/>
			<span class="formtextsmall">Link to a map of the store location (google, etc.)</span>
		</td>
	</tr>					
			
 <!--- rep --->		
			<tr>
			<td align="right">Rep:</td>
			<td></td>
		 	<td>
			<select name="Acc_Rep" size="1" class="formfield">
			<option value="" #doSelected(attributes.Acc_Rep,'')#></option>
			<cfmodule template="../../../customtags/form/dropdown.cfm"
			mode="valuelist"
			valuelist="#qry_getpicklists.acc_rep#"
			selected="#attributes.Acc_Rep#"
			/>
	 		</select>
			</td></tr>			

			
 <!--- terms --->		
		<tr>
			<td align="right">Terms:</td>
			<td></td>
			<td><input type="text" name="Acc_Terms" value="#attributes.Acc_Terms#" size="40" maxlength="50" class="formfield"/></td>
			</tr>		
				
 <!--- terms --->		
		<tr>
			<td align="right">Dropship Email:</td>
			<td></td>
			<td><input type="text" name="Acc_dropship_email" value="#attributes.Acc_dropship_email#" size="40" maxlength="100" class="formfield"/></td>
			</tr>						

 <!--- PO note --->		
		<tr>
			<td align="right">P.O. Note:</td>
			<td></td>
			<td><input type="text" name="Acc_PO_text" value="#attributes.Acc_PO_text#" size="40" maxlength="50" class="formfield"/></td>
			</tr>		
				
 <!--- Directory Live --->		
		<tr>
			<td align="right">Directory Live:</td>
			<td></td>
			<td><input type="radio" name="Acc_directory_live" value="1" #doChecked(attributes.Acc_directory_live)# /> Yes  
			&nbsp;&nbsp;<input type="radio" name="Acc_directory_live" value="0" #doChecked(attributes.Acc_directory_live,0)# /> No
		</td>
			</tr>		
				
				
	<tr>
			<td colspan="2">&nbsp;</td>
			<td>
			<input type="submit" name="submit" value="#act_button#" class="formbutton"/> 
			<input type="button" value="Cancel" onclick="javascript:window.history.go(-1);" class="formbutton"/>
			<cfif account is "edit"> <input type="submit" name="submit" value="Delete" class="formbutton"  onclick="return confirm('Are you sure you want to delete this account?');" />
</cfif>
			</td></tr>
			
	</form>	

<cfprocessingdirective suppresswhitespace="no">
<script type="text/javascript">
objForm = new qForm("editform");

objForm.required("Acc_Account_name,Acc_Customer_ID,Acc_type1");

objForm.Customer_ID.validateNumeric();

objForm.UName.description = "user";
objForm.Acc_Account_name.description = "account name";
objForm.Acc_Customer_ID.description = "customer ID";
objForm.Acc_type1.description = "vendor type";

qFormAPI.errorColor = "###Request.GetColors.formreq#";
</script>
</cfprocessingdirective>

</cfoutput>

</cfmodule>