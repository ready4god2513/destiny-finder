
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the form for adding or editing a Gift Registry. Called by shopping.admin&giftregistry=add|edit --->

<!--- Initialize the values for the form --->
<cfset fieldlist="Registrant,OtherName,GiftRegistry_Type,Event_Date,Event_Name,Event_Descr,Private,Order_Notification,Live,City,State,Expire,Created">	
		
<cfswitch expression="#giftregistry#">
			
	<cfcase value="add">
		<cfloop list="#fieldlist#" index="counter">
			<cfset temp = setvariable("attributes.#counter#", "")>
		</cfloop>
		<cfset attributes.GiftRegistry_ID = 0>	
		<!--- Radio button defaults --->
		<cfset attributes.Private = 0>	
		<cfset attributes.Order_Notification = 0>
		
		<cfset action="#request.self#?fuseaction=shopping.admin&giftregistry=act&mode=i">
		<cfset variables.UID = 0>
		<cfset attributes.created = now()>
		
	    <cfset act_title="New Gift Registry">
		<cfset act_button="Add Registry">	
	</cfcase>
					
	<cfcase value="edit">
				
		<cfinclude template="qry_get_registry.cfm"> 
		<!--- Set the form fields to values retrieved from the record --->
		<cfloop list="#fieldlist#" index="counter">
			<cfset "attributes.#counter#" = evaluate("qry_get_giftregistry." & counter)>
		</cfloop>
				
		<cfset variables.UID = qry_get_giftregistry.user_ID>
								
		<cfset action="#request.self#?fuseaction=shopping.admin&giftregistry=act&mode=u">
		<cfset act_title="Update Gift Registry">
		<cfset act_button="Update Registry">	
				
	</cfcase>
</cfswitch>

<cfinclude template="../../../queries/qry_getstates.cfm">
<cfinclude template="../../../queries/qry_getpicklists.cfm">

<cfquery name="GetUser" datasource="#Request.ds#" username="#Request.user#" password="#Request.pass#" >
	SELECT Username
	FROM #Request.DB_Prefix#Users
	WHERE User_ID = #variables.UID#
</cfquery>

<cfinclude template="../../../includes/charCount.js">

<cfhtmlhead text="<script type='text/javascript' src='includes/initialcaps.js'></script>">

<cfmodule template="../../../customtags/format_output_admin.cfm"
	box_title="#act_title#"
	Width="650"
	menutabs="yes">
	
	<cfinclude template="dsp_menu_tab.cfm">
	
<cfoutput>
	<table border="0" cellpadding="0" cellspacing="4" width="100%" class="formtext" style="color:###Request.GetColors.InputTText#">

	
	<!--- Table --->
	<form name="editform" action="#action##request.token2#" method="post" >
		<input type="hidden" name="GiftRegistry_ID" value="#attributes.GiftRegistry_ID#"/>
		
		
	 <!--- User_ID --->
	 	<tr>
			<td align="RIGHT">User:</td>
			<td style="background-color: ###Request.GetColors.formreq#;" width="3">&nbsp;</td>
			<td><input type="text" name="UName" value="#GetUser.Username#" size="20" maxlength="50" class="formfield"/>
			</td>
		</tr>		
		
		
	<!--- Type --->
	<tr> 
   		<td align="right" width="26%">Event Type:</td>
        <td style="background-color: ###Request.GetColors.formreq#;">&nbsp;</td>
		<td>
			<select name="GiftRegistry_Type" size="1" class="formfield">
			<option value="" #doSelected(attributes.GiftRegistry_Type,'')#></option>
			<cfmodule template="../../../customtags/form/dropdown.cfm"
			mode="valuelist"
			valuelist="#qry_getpicklists.GiftRegistry_Type#"
			selected="#attributes.GiftRegistry_Type#"
			/>
	 		</select>
		</td>
    </tr>	


 <!--- Event_Name --->
		<tr>
			<td align="RIGHT">Event Name:</td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
		 	<td><input type="text" name="Event_Name" value="#HTMLEditFormat(attributes.Event_Name)#" size="50" class="formfield"/>
			</td>
			</tr>			
			
 <!--- Event_Date --->
		<tr>
			<td align="RIGHT">Event Date:</td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
		 	<td>
			<cfmodule template="../../../customtags/calendar_input.cfm" ID="calevent" formfield="Event_Date" formname="editform" value="#dateformat(attributes.Event_Date,"mm/dd/yyyy")#" size="15" browser="#browsername#" bversion="#browserversion#" /></td>
			</td>
			</tr>

 <!--- City --->
	<tr>
    	<td align="right">Event City: </td>
		<td style="background-color: ###Request.GetColors.formreq#;"></td>
    	<td><input type="text" size="36" name="City" value="#attributes.City#" class="formfield" maxlength="150" onblur="javascript:changeCase(this.form.City)"/></td></tr>

 <!--- State --->
	<tr>
		<td align="right" valign="baseline">State: </td>	
		<td style="background-color: ###Request.GetColors.formreq#;"></td>
	    <td><select name="State" size="1" class="formfield">
			<option value="Unlisted">None</option>
   			<option value="Unlisted">___________________</option>
		<cfloop query="GetStates">
   			<option value="#Abb#" #doSelected(attributes.State,GetStates.Abb)#>#Name# (#Abb#)</option>
		</cfloop></select>
		</td></tr>
			
			
			
  <!--- Registrant --->
	<tr>
  		<td align="RIGHT" valign="baseline">Registrant:</td>
		<td></td>
		<td align="left"><input type="text" name="Registrant" value="#attributes.Registrant#" size="50" maxlength="100"  class="formfield"/></td>
	</tr>
			
			
  <!--- OtherName --->
	<tr>
  		<td align="RIGHT" valign="baseline">Other Name:</td>
		<td></td>
		<td align="left"><input type="text" name="OtherName" value="#attributes.OtherName#" size="50" maxlength="100"  class="formfield"/></td>
	</tr>
						
  <!--- Description --->
	<tr>
  		<td align="RIGHT" valign="top">Message:</td>
		<td></td>
		<td align="left"><textarea cols="35" rows="3" name="Event_Descr" onkeyup="CheckFieldLength(Event_Descr, 'charcount', 'remaining', 255);" onkeydown="CheckFieldLength(Event_Descr, 'charcount', 'remaining', 255);" onmouseout="CheckFieldLength(Event_Descr, 'charcount', 'remaining', 255);">#attributes.Event_Descr#</textarea>
		<br/><span class="formtextsmall">This message will greet people viewing the registry.</span><br/>
		<small><span id="charcount">#len(attributes.Event_Descr)#</span> characters entered.   |   
		<span id="remaining">#255-len(attributes.Event_Descr)#</span> characters remaining.</small><br/>
		</td>
	</tr>					
				
 <!--- display --->
			<tr>
				<td align="RIGHT"  valign="top">Private Registry:</td>
				<td></td>
			 	<td><input type="radio" name="Private" value="1" #doChecked(attributes.Private)# /> Yes 
				&nbsp;&nbsp;<input type="radio" name="Private" value="0" #doChecked(attributes.Private,0)# /> No<br/>
				<span class="formtextsmall">Private registries do not appear when users search the registry database. The only way for people to access the registry will be by clicking on a link that the registry owner can send them at any time using the 'Notify' feature.</span>
				</td>
			</tr>	

 <!--- Order_Notification --->
			<tr>
				<td align="RIGHT" valign="top">Order Notification:</td>
				<td></td>
			 	<td><input type="radio" name="Order_Notification" value="1" #doChecked(attributes.Order_Notification)# /> Yes  
				&nbsp;&nbsp;<input type="radio" name="Order_Notification" value="0" #doChecked(attributes.Order_Notification,0)# /> No<br/>
				<span class="formtextsmall">Notifies the registry owner when items from the list are purchased</span>
				</td>
			</tr>	
	
	
 <!--- Live --->
			<tr>
				<td align="RIGHT" valign="top">Expire Registry:</td>
				<td></td>
			 	<td>
				
				<cfif len(attributes.expire)>
					<cfset expire_days = dateDiff('d',attributes.event_date,attributes.expire)>
				<cfelse>
					<cfset expire_days = 365>
				</cfif>			
				
				<input type="radio" name="expire_days" value="7" #doChecked(expire_days,7)# /> 1 week after event<br/>
<input type="radio" name="expire_days" value="30" #doChecked(expire_days,30)# /> 1 month after the  event<br/>
<input type="radio" name="expire_days" value="90" #doChecked(expire_days,90)# /> 3 months after the event<br/>
<input type="radio" name="expire_days" value="180" #doChecked(expire_days,180)# /> 6 months after the event<br/>
<input type="radio" name="expire_days" value="365" #doChecked(expire_days,365)# /> 1 year after the event
				</td>
			</tr>		
	
	
 <!--- Live --->
			<tr>
				<td align="RIGHT">Active:</td>
				<td></td>
			 	<td><input type="radio" name="Live" value="1" #doChecked(attributes.Live)# /> Yes  
				&nbsp;&nbsp;<input type="radio" name="Live" value="0" #doChecked(attributes.Live,0)# /> No
				</td>
			</tr>	
		
 <!--- created --->
			<tr>
				<td align="RIGHT">Created:</td>
				<td></td>
			 	<td>#dateformat(attributes.created,"mm/dd/yyyy")#</td>
			</tr>			
			
		<tr>
			<td colspan="2">&nbsp;</td>
			<td><br/>
			<input type="submit" name="submit" value="#act_button#" class="formbutton"/>
			
			<cfif attributes.giftregistry IS "add">
			<input type="button" value="Cancel" onclick="javascript:window.history.go(-1);" class="formbutton"/> 	
			</cfif>
			
			<cfif attributes.giftregistry is "edit">
				<input type="submit" name="submit" value="Delete" class="formbutton"  onclick="return confirm('Are you sure you want to delete this registry?');"/>
			</cfif>
			</td>
		</tr>
		</form>	


	<cfif attributes.giftregistry IS NOT "add">
<form action="#request.self#?fuseaction=shopping.admin&giftregistry=list#request.token2#" method="post">
	<tr>
		<td align="center" colspan="3">
<cfmodule template="../../../customtags/putline.cfm" linetype="thin" linecolor="#Request.GetColors.InputHBgcolor#" width="98%" /><br/>
		<input type="submit" name="DONE" value="Back to Registry List" class="formbutton"/><br/><br/>
		</td>
    </tr>
    </form>
	</cfif>
		
		
		</table>
	
<cfprocessingdirective suppresswhitespace="no">
<script type="text/javascript">
objForm = new qForm("editform");

objForm.required("UName,Event_Name,Event_Date,City,State,Private,Order_Notification,Live");

objForm.Event_Date.validateDate();
objForm.UName.description = "User";

qFormAPI.errorColor = "###Request.GetColors.formreq#";

</script>			
</cfprocessingdirective>		

		
</cfoutput>
	
</cfmodule>
	

