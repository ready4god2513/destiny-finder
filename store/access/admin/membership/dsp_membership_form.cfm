<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the form to create or edit a membership. Called by the fuseactions access.admin&membership=edit|add --->

<!--- Initialize the values for the form --->
<cfset fieldlist="Membership_ID,Order_ID,membership_Type,Product_ID,AccessKey_ID,Start,time_count,access_count,Expire,Valid,Date_ordered,Access_used,Suspend_Begin_Date,Next_Membership_ID,Recur,Recur_Product_ID">
<cfswitch expression="#membership#">
		
	<cfcase value="add">		
		<!--- Sets the form fields to blanks --->
		<cfloop list="#fieldlist#" index="counter">
			<cfset setvariable("attributes.#counter#", "")>
		</cfloop>
		<cfset action="#self#?fuseaction=access.admin&Membership=act&mode=i">
		<cfset attributes.membership_id = 0>
		<cfset attributes.uid = 0>
		<cfset attributes.Recur = 0>
		<cfset attributes.Date_ordered = "#createODBCDAte(now())#">
	    <cfset act_title="New Membership">	
	</cfcase>
			
	<cfcase value="edit">	
		<!--- Set the form fields to values retrieved from the record --->
		<cfloop list="#fieldlist#" index="counter">
			<cfset "attributes.#counter#" = evaluate("qry_get_membership." & counter)>
		</cfloop>
		
		<cfif NOT len(attributes.accesskey_ID)>
			<cfset attributes.accesskey_ID = 0>
		</cfif>
				
		<cfset action="#self#?fuseaction=access.admin&Membership=act&mode=u">
		<cfset attributes.uid = qry_get_Membership.user_id>
		<cfset act_title="Edit Membership">		
	</cfcase>

</cfswitch>

<cfinclude template="../accesskey/qry_get_accesskeys.cfm">


<cfquery name="Membership_prods" datasource="#Request.ds#" username="#Request.user#" password="#Request.pass#" >
	SELECT Product_ID, Name
	FROM #Request.DB_Prefix#Products
	WHERE Prod_Type = 'membership' 
	OR Prod_Type = 'download'
</cfquery>

<cfquery name="GetUser" datasource="#Request.ds#" username="#Request.user#" password="#Request.pass#" >
	SELECT Username
	FROM #Request.DB_Prefix#Users
	WHERE User_ID = #attributes.UID#
</cfquery>
		
		
<!--- Membership Suspend Query --->
<cfquery name="qry_get_prior" datasource="#Request.ds#"	username="#Request.user#"  password="#Request.pass#" >
	SELECT Membership_ID, Suspend_Begin_Date 
	FROM #Request.DB_Prefix#Memberships
	WHERE Next_Membership_ID = #attributes.membership_ID#
	AND Next_Membership_ID > 0
</cfquery>		

		
<cfmodule template="../../../customtags/format_admin_form.cfm"
	box_title="#act_title#"
	width="550"
	>
	
<cfoutput>
	<form name="editform" action="#action##request.token2#" method="post">
	<input type="hidden" name="fieldlist" value="#fieldlist#"/>				
			
<!--- Membership ID --->
			<tr>
			<td align="right">Membership ID:</td>
			<td><img src="#Request.AppSettings.defaultimages#/spacer.gif" alt="" height="1" width="4" /></td>
			<td>
			<input type="hidden" name="Membership_id" value="#attributes.Membership_id#"/>
			<cfif attributes.Membership_id gt 0>#attributes.Membership_id#<cfelse>New</cfif></td>
			</tr>

<cfif len(attributes.Order_id)>			
<!--- Order ID --->
			<tr>
			<td align="right">Order ID:</td>
			<td></td>
			<td><input type="hidden" name="Order_id" value="#attributes.Order_id#" class="formfield"/>
			#(attributes.Order_id+get_order_settings.BaseOrderNum)#
			</td>
			</tr>
<cfelse>
<input type="hidden" name="Order_id" value="" class="formfield"/>
</cfif>	

<cfif attributes.Membership_id is 0>		
 <!--- Date_ordered --->
			<tr valign="top">
			<td align="right">Created:</td>
			<td></td>
			<td>
			<input type="hidden" name="Date_ordered" value="#attributes.Date_ordered#" class="formfield"/>
			#Dateformat(attributes.Date_ordered, "mm/dd/yyyy")#
			</td>
			</tr>
</cfif>		
<!--- User ID --->
			<tr valign="top">
			<td align="right">User:</td>
			<td style="background-color: ###Request.GetColors.formreq#;" width="3">&nbsp;</td>
			<td><input type="text" name="UName" value="#GetUser.Username#" size="20" maxlength="50" class="formfield"/>
			</td>
			</tr>
			
<!--- Product ID --->
			<td align="right">Product ID:</td>
			<td></td>
			 <td>
			  <select name="product_ID" class="formfield"> 
			 <option value="" #doSelected(attributes.Membership_id,0)#>select</option>
			 <cfloop query="Membership_prods">
			 <option value="#product_id#" #doSelected(attributes.product_ID,Membership_prods.product_id)#>
			 #product_id#: #name#</option>
			 </cfloop>
			 </select>
			</td>
			</tr>
			
<!--- type --->
			<tr valign="top">
			<td align="right">Type:</td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
			 <td>
			<select name="membership_type"  class="formfield">
			<option value="promo" #doSelected(attributes.membership_type,'promo')#>promo</option>
			<option value="download" #doSelected(attributes.membership_type,'download')#>download</option>
			<option value="membership" #doSelected(attributes.membership_type,'membership')#>membership</option>
		</select> 
			</td>
			</tr>

<!--- AccessKey ID --->
			<tr valign="top">
			<td align="right">AccessKey(s):</td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
			 <td>
				<select name="accesskey_ID" class="formfield" s
					size="#iif(qry_get_accesskeys.RecordCount LT 5,qry_get_accesskeys.RecordCount + 1,5)#" multiple="multiple">
				<option value="0" #doSelected(ListFind(attributes.accesskey_ID, 0))#>None</option>
				<cfloop query="qry_get_accesskeys">
				<option value="#accesskey_ID#" #doSelected(ListFind(attributes.accesskey_ID, qry_get_accesskeys.accesskey_ID))#>#name#</option>
				</cfloop>
				</select>	
			</td>
			</tr>

<!--- Start --->
			<tr valign="top">
			<td align="right">Start:</td>
			<td></td>
			 <td><cfmodule template="../../../customtags/calendar_input.cfm" ID="calstart" formfield="start" formname="editform" value="#dateformat(attributes.start,"mm/dd/yyyy")#" size="15" browser="#browsername#" bversion="#browserversion#" /></td>
			</tr>
			
<!--- Expire --->
			<tr valign="top">
			<td align="right">Expire:</td>
			<td></td>
			 <td><cfmodule template="../../../customtags/calendar_input.cfm" ID="calend" formfield="expire" formname="editform" value="#dateformat(attributes.expire,"mm/dd/yyyy")#" size="15" browser="#browsername#" bversion="#browserversion#" /></td>
			</tr>
			
<!--- time_count --->
			<tr valign="top">
			<td align="right">Days:</td>
			<td></td>
			 <td>
			<input type="text" name="time_count" class="formfield" value="#attributes.time_count#"  size="5"/>
			</td>
			</tr>
			
<!--- access_count --->
			<tr valign="top">
			<td align="right">Accesses:</td>
			<td></td>
			 <td>
			 <input type="text" name="access_count" class="formfield" value="#attributes.access_count#" size="5"/>
			</td>
			</tr>		
				
<!--- Access_used --->
			<tr valign="top">
			<td align="right">Access Used:</td>
			<td></td>
			 <td>
			<input type="hidden" name="Access_used" value="#attributes.access_used#"/>#attributes.access_used#
			</td>
			</tr>
			
			
<!--- Recurring --->
			<tr>
			<td valign="baseline" align="right">Recurring:</td>
			<td></td>
			 <td><input type="radio" name="Recur" value="1" #doChecked(attributes.Recur)# onclick="javascript:editform.Recur_Product_ID.disabled=false;"
/>Yes  
			&nbsp;<input type="radio" name="Recur" value="0" #doChecked(attributes.Recur,0)# onclick="javascript:editform.Recur_Product_ID.options[0].selected=true;editform.Recur_Product_ID.disabled=true;"/> No </td>
			</tr>
			
			<tr>
				<td align="RIGHT" valign="top">Renew to Different Product:</td>
				<td></td>
			 	<td>
				<select name="Recur_Product_ID" size="1" <cfif attributes.Recur is 0>disabled="disabled"</cfif> class="formfield">
				<option value="0" #doSelected(attributes.Recur_Product_ID,'')#></option>
				<cfloop query="Membership_prods">
				<option value="#Product_ID#" #doSelected(attributes.Recur_Product_ID,Membership_prods.Product_ID)#>#name#</option>
				</cfloop>
				</select>
				<span class="formtextsmall"><br/>When membership expires, renew using this product.</span>
				</td>
			</tr>		
			</tr>		
			
			
<!--- Valid --->
			<tr valign="top">
			<td align="right">Valid:</td>
			<td></td>
			 <td>
			 <input type="radio" name="valid" value="1" #doChecked(attributes.valid)# /> Yes
			 <input type="radio" name="valid" value="0" #doChecked(attributes.valid,0)# /> No
			</td>
			</tr>
	
<!--- Membership Suspend Upgrade - start custom code --->
<cfif qry_get_prior.recordcount>

	<cfloop query="qry_get_prior">
		<tr>
			<td colspan="2" >&nbsp;</td>
			<td valign="bottom" class="formerror">
			<cfif len(qry_get_prior.suspend_begin_date)>
			This subscription is a continuation of<br/> <a href="#self#?fuseaction=access.admin&Membership=edit&Membership_ID=#qry_get_prior.membership_id##Request.Token2#">Membership #qry_get_prior.membership_id#</a> suspended on #dateformat(qry_get_prior.suspend_begin_date,"m/d/yy")#
			<cfelse>
			This subscription follows <a href="#self#?fuseaction=access.admin&Membership=edit&Membership_ID=#qry_get_prior.membership_id##Request.Token2#">Membership #qry_get_prior.membership_id#</a>
 			</cfif>
</td>
		</tr>
	
	</cfloop>

</cfif>
	<!--- Suspend feature - allows admin to stop a membership and restart it later
	If suspend_begin_date is blank, not suspended
		show begin & end date
	If begin not blank and next is blank
		show end date
	otherwise
		show Next Membership
	--->
	<cfif attributes.membership is "edit" and attributes.expire GT createODBCdate(Now())>
			<tr valign="top">
			<td align="right">Suspend Starting:</td>
			<td></td>
			 <td>
			 <cfif attributes.next_membership_id LTE 0>
			 <cfmodule template="../../../customtags/calendar_input.cfm" ID="suspendbegin" formfield="suspend_begin_date" formname="editform" value="#dateformat(attributes.suspend_begin_date,"mm/dd/yyyy")#" size="15" browser="#browsername#" bversion="#browserversion#" />
			<cfelse>
			#dateformat(attributes.suspend_begin_date, 'mm/dd/yyyy')#
			<input type="hidden" name="suspend_begin_date" value="#dateformat(attributes.suspend_begin_date, 'mm/dd/yyyy')#"/>
			</cfif>
			</td>
			</tr>
			
			<cfif attributes.next_membership_id LTE 0>
			<tr valign="top">
			<td align="right">Suspend Ending:</td>
			<td></td>
			 <td>	
			 <cfmodule template="../../../customtags/calendar_input.cfm" ID="suspendend" formfield="suspend_end_date" formname="editform" value="" size="15" browser="#browsername#" bversion="#browserversion#" /> 
			</td>
			</tr>
			<cfelse>
			<tr valign="top">
			<td align="right">Membership Continues:</td>
			<td></td>
			<td>	 
				<a href="#self#?fuseaction=access.admin&Membership=edit&Membership_ID=#attributes.Next_membership_ID#">Membership Number #attributes.Next_membership_ID#</a>
			</td>
			</tr>	
			</cfif>			
	<cfelse>
		<input type="hidden" name="suspend_begin_date" value=""/>
		<input type="hidden" name="Next_membership_ID" value=""/>
	</cfif>
<!--- end custom code --->

			<cfinclude template="../../../includes/form/put_space.cfm">

			<tr>
			<td colspan="2">&nbsp;</td>
			<td>
			<input type="submit" name="submit" value="<cfif membership is "add">Add Membership<cfelse>Update</cfif>" class="formbutton"/> 
<input type="button" value="Cancel" onclick="javascript:window.history.go(-1);" class="formbutton"/>
			<cfif membership is "edit">
				<input type="submit" name="submit" value="Delete" class="formbutton"  onclick="return confirm('Are you sure you want to delete this membership?');" />
			</cfif></td></tr>
			</form>	
	</cfoutput>

<cfprocessingdirective suppresswhitespace="no">
<script type="text/javascript">
objForm = new qForm("editform");

objForm.required("accesskey_ID,membership_type,UName");
objForm.accesskey_ID.description = "access key ID";
objForm.UName.description = "user";

objForm.time_count.validate= true;

objForm.start.validateDate();
objForm.expire.validateDate();
objForm.time_count.validateNumeric();

qFormAPI.errorColor = "<cfoutput>###Request.GetColors.formreq#</cfoutput>";
</script>
</cfprocessingdirective>

</cfmodule>
