
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the form for editing a user account. Called by user.admin&user=add|edit|unlock --->

<!--- Initialize the values for the form --->
<cfset fieldlist="username,email,group_id,customer_id,emailIsBad,EmailLock,Subscribe,Shipto,Affiliate_ID,Birthdate,CardisValid,CardType,NameOnCard,CardNumber,CardExpire,CardZip,CurrentBalance,lastLogin,created,AdminNotes,Disable,LoginsTotal,LoginsDay,FailedLogins">

<cfswitch expression="#attributes.user#">
	<cfcase value="add">
		<cfloop list="#fieldlist#" index="counter">
			<cfset setvariable("attributes.#counter#", "")>
		</cfloop>

	    <cfset attributes.uid = "">
		<cfset attributes.group_id = 0>
		<cfset attributes.customer_id = 0>
		<cfset attributes.affiliate_id = 0>
		
		<!--- Radio button defaults --->
		<cfset attributes.CardisValid = 0>
		
		<cfset action="#self#?fuseaction=users.admin&user=act&mode=i">
	    <cfset act_title="Add User">				
	</cfcase>
			
	<cfcase value="edit">
		<!--- Set the form fields to values retrieved from the record --->				
		<cfloop list="#fieldlist#" index="counter">
			<cfset "attributes.#counter#" = evaluate("qry_get_user." & counter)>
		</cfloop>
				
		<cfset attributes.uid = qry_get_user.user_id>
		
		<cfset attributes.affiliate_id = iif(len(qry_get_user.Affiliate_ID), qry_get_user.Affiliate_ID, 0)>
		
		<cfset action="#self#?fuseaction=users.admin&user=act&mode=u">
		<cfset act_title="Update User">
		
		<cfquery name="qry_get_Customers" datasource="#Request.ds#"	username="#Request.user#"  password="#Request.pass#" >
		SELECT * FROM #Request.DB_Prefix#Customers
		WHERE User_ID = #attributes.uid#
		</cfquery>
				
	</cfcase>
</cfswitch>

<!--- initialize card expire date --->
<cfif NOT isDate(attributes.CardExpire)>
	<cfset attributes.CardExpire = Now()>
</cfif>

<cfinclude template="../../../shopping/qry_get_order_settings.cfm">
<cfinclude template="../../../queries/qry_getpicklists.cfm">
<cfinclude template="../group/qry_get_all_groups.cfm">
<cfset group_picklist = "">
	<cfloop query="qry_get_all_groups">
		<cfset group_picklist = ListAppend(group_picklist, "#name#|#group_id#")>
	</cfloop>

<cfmodule template="../../../customtags/format_admin_form.cfm"
	box_title="#act_title#"
	width="550"
	>
	
	<!--- Table --->
<cfoutput>
	<form name="editform"  action="#action##request.token2#" method="post" >
	<input type="hidden" name="fieldlist" value="#fieldlist#"/>
	<input type="hidden" name="uid" value="#attributes.uid#"/>
	<input type="hidden" name="XFA_success" value="#URLDecode(attributes.XFA_success)#"/>
	
	 <!--- User ID --->
			<tr>
				<td align="right">User ID:</td>
				<td width="4"></td>
		 		<td>#attributes.uid#</td>
			</tr>
		
<!--- Username --->
			<tr>
				<td align="right">Username:</td>
				<td style="background-color: ###Request.GetColors.formreq#;" width="3">&nbsp;</td>
		 		<td><input type="text" name="username" value="#attributes.username#" size="30" maxlength="100" class="formfield"/></td>
			</tr>
			
 <!--- Password --->
			<tr>
				<td align="right">New Password:</td>
				<td style="background-color: ###Request.GetColors.formreq#;"></td>
		 		<td><input type="text" name="Password" value="" size="30" maxlength="100" class="formfield"/>
				<cfif attributes.user is "edit" AND NOT (Request.DemoMode AND attributes.uid IS 1)>
				[ <a class="formtextsmall" href="#self#?fuseaction=users.admin&user=resetpw&uid=#attributes.uid#&email=#attributes.email#">Send New Password</a> ]</cfif>
				</td>
			</tr>
			
 <!--- Email --->
			<tr>
				<td align="right">Email:</td>
				<td style="background-color: ###Request.GetColors.formreq#;"></td>
				<td><input type="text" name="email" value="#attributes.email#" size="30" maxlength="100" class="formfield"/> 
				<cfif attributes.user is "edit">[ <a  class="formtextsmall" href="#self#?fuseaction=users.admin&email=write&UID=#attributes.uid#&XFA_success=#URLEncodedFormat(cgi.query_string)#">Send Mail</a> ]</cfif>
				</td>
			</tr>

<cfif attributes.user is "edit">	
 <!--- Bad Email --->
			<tr>
				<td align="right">Bad Email:</td>
				<td></td>
		 		<td>
				<input type="radio" name="emailIsBad" value="0" #doChecked(attributes.emailIsBad,0)# />Email OK
				<input type="radio" name="emailIsBad" value="1" #doChecked(attributes.emailIsBad)# />Email is BAD</td>
			</tr>
			
 <!--- Email Lock --->
			<tr>
				<td align="right">Email Lock:</td>
				<td></td>
		 		<td>#attributes.EmailLock#
					<input name="EmailLock" type="hidden" value="#attributes.EmailLock#"/>
					<cfif len(attributes.emailLock) AND attributes.emaillock is not "verified">
					[ <a  class="formtextsmall" href="#self#?fuseaction=users.admin&user=unlock&uid=#attributes.uid#&XFA_success=#URLEncodedFormat(attributes.XFA_success)##Request.Token2#">unlock</a> ]

					[ <a  class="formtextsmall" href="#self#?fuseaction=users.admin&email=write&uid=#attributes.uid#&MailText_ID=emaillock&XFA_success=#URLEncodedFormat(cgi.query_string)#">send code</a> ]
					</cfif></td>
			</tr>
</cfif>
			
 <!--- Subscribe --->
			<tr>
				<td align="right">Subscribe:</td>
				<td style="background-color: ###Request.GetColors.formreq#;"></td>
		 		<td>
				<input type="radio" name="Subscribe" value="0" #doChecked(attributes.Subscribe,0)# />No
				<input type="radio" name="Subscribe" value="1" #doChecked(attributes.Subscribe)# />Yes</td>
			</tr>	

		 <!--- Group_ID --->
			<tr>
				<td align="right">Group:</td>
				<td></td>
			 		<td>
				<select name="group_id" size="1" class="formfield">
				<option value="0">unassigned</option>
				<cfloop query="qry_get_all_groups">
				<option value="#qry_get_all_groups.group_id#"
					#doSelected(attributes.group_id,qry_get_all_groups.group_id)#>#qry_get_all_groups.name#</option>
				</cfloop>
				</select>
				</td>
			</tr>
			
<cfif attributes.uid is "">
	<input type="hidden" name="customer_id" value="0"/>
	<input type="hidden" name="Shipto" value="0"/>
<cfelse>
 <!--- Customer ID --->
			<tr>
				<td align="right">Customer ID:</td>
				<td></td>
		 		<td>
				<select name="customer_id" class="formfield">
					<option value="0">none</option>
					<cfloop query="qry_get_customers">
					<option value="#qry_get_customers.customer_id#"
						#doSelected(attributes.customer_id,qry_get_customers.customer_id)#>
						#qry_get_customers.customer_id#: #qry_get_customers.address1#</option>
					</cfloop>
				</select>
				</td>
			</tr>
			
 <!--- Ship To --->
			<tr>
				<td align="right">Ship To:</td>
				<td></td>
		 		<td><select name="Shipto" class="formfield">
					<option value="0">none</option>
					<cfloop query="qry_get_customers">
					<option value="#qry_get_customers.customer_id#"
						#doSelected(attributes.Shipto,qry_get_customers.customer_id)#>
						#qry_get_customers.customer_id#: #qry_get_customers.address1#</option>
					</cfloop>
				</select></td>
			</tr>
</cfif>
		

 <!--- Birthdate --->
<cfif get_User_Settings.UseBirthdate> 
			<tr>
				<td align="right">Birth Date:</td>
				<td></td>
		 		<td><cfmodule template="../../../customtags/calendar_input.cfm" ID="calbirth" formfield="Birthdate" formname="editform" value="#dateformat(attributes.Birthdate,"mm/dd/yyyy")#" size="15" browser="#browsername#" bversion="#browserversion#" /></td>
			</tr>		
<cfelse>
	<input type="hidden" name="Birthdate" value="#attributes.Birthdate#"/>
</cfif>

<!--- Card info if used	 --->
<cfif get_User_Settings.UseCCard AND get_Order_Settings.CCProcess IS "Shift4OTN">

	<tr><td colspan="3"><cfmodule template="../../../customtags/putline.cfm" linetype="thin" linecolor="#Request.GetColors.InputHBgcolor#" /></td></tr>
			
 <!--- Is Active --->	
			<tr>
				<td align="right">Card Is Valid:</td>
				<td></td>		
				<td>
				<input type="radio" name="CardisValid" value="0" #doChecked(attributes.CardisValid,0)# />Card Not Approved
				<input type="radio" name="CardisValid" value="1" #doChecked(attributes.CardisValid)# />Card Approved</td>
			</tr>
			
 <!--- CardType --->	
			<tr>
				<td align="right">Card Type:</td>
				<td></td>
		 		<td><input type="text" name="CardType" value="#attributes.CardType#" size="20" maxlength="40" class="formfield"/></td>
			</tr>

 <!--- NameOnCard --->		
			<tr>
				<td align="right">Card Name:</td>
				<td></td>
		 		<td><input type="text" name="NameOnCard"  value="#attributes.NameOnCard#" size="20" maxlength="80" class="formfield"/></td>
			</tr>

 <!--- CardNumber --->
			<tr>
				<td align="right">Card Number:</td>
				<td></td>
		 		<td><input type="text" name="CardNumber" value="#attributes.CardNumber#" size="20" maxlength="30" class="formfield"/></td>
			</tr>
			
 <!--- CardExpire --->	
			<tr>
				<td align="right">Card Expire:</td>
				<td></td>
		 		<td>
				<select name="Month" size="1" class="formfield">
					<cfloop index="i" from="1" to="12">
					<option value="#iif(i GTE 10, i,NumberFormat(i, '09'))#" #doSelected(Month(attributes.CardExpire),i)#>#MonthAsString(i)#</option>
					</cfloop>
				</select>
				<select name="Year" size="1" class="formfield">
					<cfloop index="i" from="#Year(Now())#" to="#Evaluate(Year(Now()) + 8)#">
					<option value="#Right(i,2)#" #doSelected(Year(attributes.CardExpire),i)#>#i#</option>
					</cfloop>
				</select>
				</td>
			</tr>

 <!--- CardZip --->	
			<tr>
				<td align="right">Card Zip:</td>
				<td></td>
		 		<td><input type="text" name="CardZip" value="#attributes.CardZip#"  size="20" maxlength="20" class="formfield"/></td>
			</tr>			
		
 <!--- CurrentBalance --->	
			<tr>
				<td align="right">Current Balance:</td>
				<td></td>
		 		<td><input type="text" name="CurrentBalance" value="#attributes.CurrentBalance#"  size="20" maxlength="30" class="formfield"/></td>
			</tr>			
			
 <!--- Authorize Card --->	
 	<cfif len(attributes.cardtype) and len(attributes.cardnumber)>
			<tr>
				<td align="right">Authorize Card:</td>
				<td></td>
		 		<td><a href="#self#?fuseaction=users.admin&user=authorize&UID=#attributes.UID##request.token2#">Process Test Transaction Now</a></td>
			</tr>		
	</cfif>
<cfelse>
	<input type="hidden" name="CardisValid" value="#attributes.CardisValid#"/>
	<input type="hidden" name="CardType" value="#attributes.CardType#"/>
	<input type="hidden" name="NameOnCard" value="#attributes.NameOnCard#"/>
	<input type="hidden" name="CardNumber" value="#attributes.CardNumber#"/>
	<input type="hidden" name="CardExpire" value="#attributes.CardExpire#"/>
	<input type="hidden" name="CardZip" value="#attributes.CardZip#"/>
	<input type="hidden" name="CurrentBalance" value="#attributes.CurrentBalance#"/>
</cfif>			
			
<tr><td colspan="3">
<cfmodule template="../../../customtags/putline.cfm" linetype="thin" linecolor="#Request.GetColors.InputHBgcolor#" /></td></tr>
			
 <!--- Disable --->
			<tr>
				<td align="right">Disable:</td>
				<td></td>
		 		<td>
				<input type="radio" name="Disable" value="0" #doChecked(attributes.Disable,0)# />No
				<input type="radio" name="Disable" value="1" #doChecked(attributes.Disable)# />Yes</td>
			</tr>	

		
 	<!--- Notes --->
	
			<tr>
				<td align="right" valign="top">Admin Notes:</td>
				<td colspan="2"></td>
			</tr>	
			<tr>
				<td align="right" valign="top" colspan="3">
				<cfset config = StructNew()>
				<cfset config.LinkBrowser = "false">
				<cfset config.FlashBrowser = "false">			
				<cfmodule 
					template="../../../customtags/fckeditor/fckeditor.cfm" 
					instanceName="AdminNotes"
					height="150" 						
					toolbarSet="Basic" 
					config="#config#"
					Value="#attributes.AdminNotes#"
					/>
			</td>
			</tr>				

<input type="hidden" name="Affiliate_ID" value="#attributes.Affiliate_ID#"/>

 <cfif attributes.user is "edit">	
 
  <tr><td colspan="3"><cfmodule template="../../../customtags/putline.cfm" linetype="thin" linecolor="#Request.GetColors.InputHBgcolor#" /></td></tr>
 
 <!--- Affiliate_ID --->
			<tr>
				<td align="right">Affiliate ID:</td>
				<td></td>
		 		<td><cfif qry_get_user.affcode is not "">#qry_get_user.affcode# at #(qry_get_user.affpercent * 100)#%<cfelse>not an affiliate</cfif> &nbsp; 
			<cfif len(attributes.uid)><a href="#self#?fuseaction=users.admin&user=affiliate&uid=#attributes.uid##Request.Token2#">Edit</a></cfif></td>
			</tr>
  
 <!--- lastLogin --->
			<tr>
				<td align="right">Last Login:</td>
				<td></td>
		 		<td><cfmodule template="../../../customtags/calendar_input.cfm" ID="callogin" formfield="lastLogin" formname="editform" value="#dateformat(attributes.lastLogin,"mm/dd/yyyy")#" size="15" browser="#browsername#" bversion="#browserversion#" /></td>
			</tr>
			
 <!--- Login Statistics --->
 			<tr>
				<td align="right">Login Statistics:</td>
				<td></td>
		 		<td>#attributes.LoginsTotal# total logins total; #Attributes.LoginsDay# on last login day with #Attributes.FailedLogins# failure(s)</td>
			</tr>
			
<!--- Login Counts --->
<tr>
			<td align="right">Reset Last Day:</td>
				<td></td>
		 		<td><input type="radio" name="ResetCounts" value="0" checked="checked" />No
				<input type="radio" name="ResetCounts" value="1"/>Yes</td>
			</tr>
			
 <!--- created --->
 			<tr>
				<td align="right">Created:</td>
				<td></td>
		 		<td>#dateformat(attributes.created,'mm/dd/yyyy')#</td>
			</tr>
			
 <!--- Permissions 
 			<tr>
				<td align="right">Permissions:</td>
				<td></td>
		 		<td><cfoutput>#qry_get_user.Permissions#</cfoutput></td>
			</tr>
	--->		
						
</cfif>			
		<cfinclude template="../../../includes/form/put_space.cfm">
			<tr>
			<td colspan="2">&nbsp;</td>
			<td>
			<!--- Make sure this is not the admin user and in demo mode --->
			<cfif Request.DemoMode AND attributes.uid IS 1>
			<input type="button" value="Submit" onclick="javascript:alert('The admin user cannot be modified while in demo mode.');" class="formbutton"/>
			<cfelse>
			<input type="submit" name="Submit" value="#act_title#" class="formbutton"/>
			</cfif>
			<input type="button" value="Cancel" onclick="javascript:window.history.go(-1);" class="formbutton"/> 	
			<cfif USER is "edit" and attributes.uid is not "1">
			<input type="submit" name="submit" value="Delete" class="formbutton"  onclick="return confirm('Are you sure you want to delete this user?\nThis will delete all associated records.');" />
			</cfif>
			</td></tr>
	</form>	
	
</cfoutput>

</cfmodule>

<cfprocessingdirective suppresswhitespace="no">
<script type="text/javascript">
<!--//
// initialize the qForm object
objForm = new qForm("editform");

// make these fields required
objForm.required("username,email,Subscribe,Disable,CardisValid");
<cfif attributes.user IS "add">
objForm.required("Password");
<cfelse>
objForm.required("emailIsBad");
</cfif>


<cfif attributes.user is "edit">
objForm.lastLogin.description = "last log in";
</cfif>

objForm.email.validateEmail();

<cfif get_User_Settings.UseBirthdate> 
objForm.Birthdate.validateDate();
objForm.Birthdate.description = "birth date";
</cfif>

<cfif get_User_Settings.UseCCard>
objForm.CurrentBalance.validateNumeric();
</cfif>

<cfif attributes.user is "edit">
objForm.lastLogin.validateDate();
</cfif>

qFormAPI.errorColor = "<cfoutput>###Request.GetColors.formreq#</cfoutput>";
//-->
</script>
</cfprocessingdirective>
