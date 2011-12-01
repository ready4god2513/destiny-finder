
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the form to add and edit Customer records. Called by the fuseaction 
users.admin&customer=add|edit --->

<!---<cfinclude template="../user/qry_get_users.cfm">--->
<cfparam name="attributes.message" default="">
<cfinclude template="../../../queries/qry_getstates.cfm">
<cfinclude template="../../../queries/qry_getcounties.cfm">
<cfinclude template="../../../queries/qry_getcountries.cfm">


<!--- If counties found, create related selectbox code --->
<cfif GetCounties.RecordCount AND get_User_Settings.UseStateList>
	<cfinclude template="../../formfields/put_countyscripts.cfm">
	<cfset ShowCounties = "yes">
<cfelse>
	<cfset ShowCounties = "no">
</cfif>


<!--- Initialize the values for the form --->
<cfset fieldlist="firstname,LastName,Company,Address1,Address2,City,County,state,state2,zip,country,Phone,Phone2,fax,Email,Residence">

<cfswitch expression="#customer#">
	<cfcase value="add">
		
		<cfloop list="#fieldlist#" index="counter">
			<cfset setvariable("attributes.#counter#", "")>
		</cfloop>
		
		<cfparam name="attributes.uid" default="0">
		<cfset attributes.cid = "">
				
		<cfset action="#self#?fuseaction=users.admin&customer=act&mode=i">
	    <cfset act_title="Add Customer">
		<cfset act_button="Add">	
			
	</cfcase>
			
	<cfcase value="edit">
		<!--- Set the form fields to values retrieved from the record --->		
		<cfloop list="#fieldlist#" index="counter">
			<cfset "attributes.#counter#" = evaluate("qry_get_customer." & counter)>
		</cfloop>
			
		<cfset attributes.uid = qry_get_Customer.User_ID>
		<cfset attributes.cid = qry_get_Customer.customer_id>
		
		<cfset action="#self#?fuseaction=users.admin&customer=act&mode=u">
		<cfset act_title="Update Customer">
		<cfset act_button="Update">
				
	</cfcase>
</cfswitch>
		
<cfquery name="GetUser" datasource="#Request.ds#" username="#Request.user#" password="#Request.pass#" >
	SELECT Username
	FROM #Request.DB_Prefix#Users
	WHERE User_ID = #attributes.UID#
</cfquery>


<cfmodule template="../../../customtags/format_admin_form.cfm"
	box_title="#act_title#"
	width="450"
	>
	
	<!--- Table --->
<cfoutput>
	<form name="editform" action="#action##request.token2#" method="post" target="_self" >
	<input type="hidden" name="fieldlist" value="#fieldlist#"/>
	<input type="hidden" name="cid" value="#attributes.cid#"/>
	<input type="hidden" name="XFA_success" value="#attributes.XFA_success#"/>
	
	<cfinclude template="../../../includes/form/put_message.cfm">
	
	 <!--- User ID --->
		<tr>
			<td align="right">Customer ID:</td>
			<td width="4"></td>
			<td><cfif attributes.cid is not "">
					#attributes.cid#
				<cfelse>
					New
				</cfif></td>
		</tr>
	
	 <!--- User_ID --->
	 	<tr>
			<td align="right">User Name:</td>
			<td></td>
		<td><input type="text" name="UName" value="#GetUser.Username#" size="20" maxlength="50" class="formfield"/>	
	 		

			</td>
		</tr>
			
	<!--- First Name --->
		<tr>
			<td align="right">First Name:</td>
			<td style="background-color: ###Request.GetColors.formreq#;" width="3">&nbsp;</td>
			 <td><input type="text" name="FirstName" class="formfield" value="#attributes.firstname#" size="37" maxlength="50"/></td>
			</tr>
			
 	<!--- Last Name --->
		<tr>
			<td align="right">Last Name:</td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
			<td><input type="text" name="LastName" class="formfield" value="#attributes.LastName#" size="37" maxlength="100"/></td>
			</tr>
			
 	<!--- Company --->
		<tr>
			<td align="right">Company:</td>
			<td></td>
			<td><input type="text" name="Company" value="#attributes.Company#" size="37" maxlength="150" class="formfield"/></td>
			</tr>
			
	<!--- Address1 --->
		<tr>
			<td align="right">Address:</td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
			<td><input type="text" name="Address1" value="#attributes.Address1#" size="37" maxlength="150" class="formfield"/></td>
			</tr>
			
	<!--- Address cont. --->
		<tr>
			<td align="right">Address Line 2:</td>
			<td></td>
			<td><input type="text" name="Address2" value="#attributes.Address2#" class="formfield" size="37" maxlength="150"/></td>
			</tr>
			
	<!--- City --->
		<tr>
			<td align="right">City:</td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
			<td><input type="text" name="City" value="#attributes.City#" class="formfield" size="37" maxlength="150"/></td>
			</tr>
			
	<!--- State --->
		<tr>
			<td align="right">State/Province:</td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
			<td><select name="State" size="1" class="formfield" <cfif ShowCounties>onChange="objForm.County.populate(stcCounties[objForm.State.getValue()], null, null, stcBlank);"</cfif>>
			<option value="Unlisted">Unlisted/None</option>
   			<option value="Unlisted">___________________</option>
		<cfloop query="GetStates">
   			<option value="#Abb#" #doSelected(attributes.State,Abb)#>#Name# (#Abb#)</option>
		</cfloop></td>
			</tr>
			
 	<!--- state2 --->
			<tr>
			<td align="right" valign="baseline">Other State:</td>
			<td></td>
			<td><input type="text" name="state2" value="#attributes.state2#" class="formfield" size="37" maxlength="50"/>
			<span class="formtextsmall"><br/>Enter State here if not in list above.</span></td>
			</tr>
			
<cfif ShowCounties>
	<tr>
    	<td align="right">County: </td>
		<td <cfif get_User_Settings.RequireCounty>style="background-color: ###Request.GetColors.formreq#;"</cfif>></td>
    	<td><select name="County" class="formfield">
		<option value="">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; </option>
		<option value=""></option><option value=""></option><option value=""></option>
		<option value=""></option><option value=""></option></select></td></tr>
	<cfelse>
		<input type="hidden" name="County" value=""/>
	</cfif>

			
 	<!--- zip --->
		<tr>
			<td align="right">Zipcode:</td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
			<td><input type="text" name="Zip" value="#attributes.zip#" size="37" class="formfield" maxlength="50"/></td>
			</tr>
			
 	<!--- country --->
		<tr>
			<td align="right">Country:</td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
			<td>
			 <select name="Country" size="1" class="formfield">
			<option value="#Request.AppSettings.HomeCountry#">#ListGetAt(Request.AppSettings.HomeCountry, 2, "^")#</option>
			 <option value="#Request.AppSettings.HomeCountry#">___________________</option>
			<cfloop query="GetCountries">
			   <option value="#Abbrev#^#Name#" #doSelected(attributes.Country,"#Abbrev#^#Name#")#>#Name#</option>
			</cfloop>
			</select> 
			</td>
			</tr>
			
 	<!--- phone --->
		<tr>
			<td align="right">Phone:</td>
			<td></td>
			<td><input type="text" name="Phone" value="#attributes.Phone#" class="formfield" size="37" maxlength="50"/></td>
			</tr>
			
 	<!--- Phone2 --->
		<tr>
			<td align="right">Other Phone:</td>
			<td></td>
			<td><input type="text" name="Phone2" mvalue="#attributes.Phone2#" class="formfield" size="37" maxlength="50"/></td>
			</tr>
			
 	<!--- fax --->
		<tr>
			<td align="right">Fax:</td>
			<td></td>
			<td><input type="text" name="fax" value="#attributes.fax#" size="37" class="formfield" maxlength="50"/></td>
			</tr>
			
 	<!--- email --->
		<tr>
			<td align="right">Email:</td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
			<td><input type="text" name="Email" value="#attributes.Email#" class="formfield" size="37" maxlength="150"/></td>
			</tr>
			
	<!--- Residence --->
	<tr>
	    <td align="right">Residential: </td>
		<td style="background-color: ###Request.GetColors.formreq#;"></td>
   	 	 <td><input type="radio" name="Residence" value="1" #doChecked(attributes.Residence)# /> Yes
		 &nbsp;&nbsp;<input type="radio" name="Residence" value="0" #doChecked(attributes.Residence,0)# /> No
		</td>	

		<tr>
			<td colspan="2">&nbsp;</td>
			<td>
			<input type="submit" name="submit" value="#act_button#" class="formbutton"/> 
			<input type="button" value="Cancel" onclick="javascript:window.history.go(-1);" class="formbutton"/> 
			<cfif Customer is "edit"> <input type="submit" name="submit" value="Delete" class="formbutton"  onclick="return confirm('Are you sure you want to delete this customer?\nAll associate records and orders will be deleted.');"  />
</cfif>
			</td></tr>
			
	</form>	

<cfprocessingdirective suppresswhitespace="no">
<script type="text/javascript">
objForm = new qForm("editform");

objForm.required("FirstName,LastName,Address1,City,State,Zip,Residence");

objForm.Email.validateEmail();

<!--- Mask for US Zipcodes 
	objForm.Zip.validateZipCode(); ---->	
	objForm.Zip.validateLengthGT("4");

<cfif ShowCounties>
	<cfif get_User_Settings.RequireCounty>
		requireCounties();	
	</cfif>
	<cfif len(attributes.State)>
	setDefault("State", "#attributes.State#");
	setDefault("County", "#attributes.County#");
	</cfif>
</cfif>

qFormAPI.errorColor = "###Request.GetColors.formreq#";
</script>
</cfprocessingdirective>
</cfoutput>
</cfmodule>
