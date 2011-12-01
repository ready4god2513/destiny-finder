
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the form for adding or editing a Gift Registry. Called by shopping.giftregistry&manage=add|edit --->

<!--- Initialize the values for the form --->
<cfset fieldlist="Registrant,OtherName,GiftRegistry_Type,Event_Date,Event_Name,Event_Descr,Private,Order_Notification,Live,City,State,Expire">	
		
<cfswitch expression="#manage#">
			
	<cfcase value="add">
		<cfloop list="#fieldlist#" index="counter">
			<cfset temp = setvariable("attributes.#counter#", "")>
		</cfloop>
		<cfset attributes.GiftRegistry_ID = 0>	
		
		<!--- Radio button defaults --->
		<cfset attributes.Order_Notification = 0>
		
		<cfset action="#request.self#?fuseaction=shopping.giftregistry&manage=act&mode=i">

	    <cfset act_title="New Gift Registry">
		<cfset act_button="Add Registry">	
	</cfcase>
					
	<cfcase value="edit">
				
		<cfinclude template="../qry_get_giftregistry.cfm"> 
		<!--- Set the form fields to values retrieved from the record --->
		<cfloop list="#fieldlist#" index="counter">
			<cfset "attributes.#counter#" = evaluate("qry_get_giftregistry." & counter)>
		</cfloop>
				
		<cfset action="#request.self#?fuseaction=shopping.giftregistry&manage=act&mode=u">
		<cfset act_title="Update Gift Registry">
		<cfset act_button="Update Registry">	
				
	</cfcase>
</cfswitch>

<cfinclude template="../../../queries/qry_getstates.cfm">
<cfinclude template="../../../queries/qry_getpicklists.cfm">
<cfinclude template="../../../includes/charCount.js">

<cfhtmlhead text="<script type='text/javascript' src='includes/initialcaps.js'></script>">

<!--- Table --->
<cfoutput>
<form name="editform" action="#XHTMLFormat('#action##request.token2#')#" method="post" >
<input type="hidden" name="GiftRegistry_ID" value="#attributes.GiftRegistry_ID#"/>
	
<cfmodule template="../../../customtags/format_input_form.cfm"
	box_title="#act_title#"
	width="450"
	align="left"
	>
			
	<!--- Type --->
 	<tr align="left"> 
   		<td align="right" width="26%">Event Type:</td>
        <td style="background-color: ###Request.GetColors.formreq#;" width="3">&nbsp;</td>
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
		<tr align="left">
			<td align="right" nowrap="nowrap">Event Name:</td>
			<td style="background-color: ###Request.GetColors.formreq#;">&nbsp;</td>
		 	<td><input type="text" name="Event_Name" value="#HTMLEditFormat(attributes.Event_Name)#" size="50" class="formfield"/>
			</td>
			</tr>			
			
 <!--- Event_Date --->
		<tr align="left">
			<td align="right">Event Date:</td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
		 	<td>
			<cfmodule template="../../../customtags/calendar_input.cfm" ID="calevent" formfield="Event_Date" formname="editform" value="#dateformat(attributes.Event_Date,"mm/dd/yyyy")#" size="15" browser="#browsername#" bversion="#browserversion#" /></td>
			</tr>

 <!--- City --->
	<tr align="left">
    	<td align="right">Event City: </td>
		<td style="background-color: ###Request.GetColors.formreq#;"></td>
    	<td><input type="text" size="36" name="City" value="#attributes.City#" class="formfield" maxlength="150" onblur="javascript:changeCase(this.form.City)"/></td></tr>

 <!--- State --->
	<tr align="left">
		<td align="right" valign="baseline">State: </td>	
		<td style="background-color: ###Request.GetColors.formreq#;"></td>
	    <td><select name="State" size="1" class="formfield">
			<option value="Unlisted">none</option>
   			<option value="Unlisted">___________________</option>
		<cfloop query="GetStates">
   			<option value="#Abb#" #doSelected(attributes.State,Abb)#>#Name# (#Abb#)</option>
		</cfloop></select>
		</td></tr>			
			
			
  <!--- Registrant --->
	<tr align="left">
  		<td align="right" valign="baseline">Registrant:</td>
		<td style="background-color: ###Request.GetColors.formreq#;"></td>
		<td align="left"><input type="text" name="Registrant" value="#attributes.Registrant#" size="50" maxlength="100"  class="formfield"/>
<br/><span class="formtextsmall">Name of the person that is registering, used in searches.</span>
</td>
	</tr>
			
			
  <!--- OtherName --->
	<tr align="left">
  		<td align="right" valign="baseline">Co-Registrant:</td>
		<td></td>
		<td align="left"><input type="text" name="OtherName" value="#attributes.OtherName#" size="50" maxlength="100"  class="formfield"/>
<br/><span class="formtextsmall">If there is another person involved in the event (such as for a wedding registry), enter their name here.</span></td>
	</tr>
						
  <!--- Description --->
	<tr align="left">
  		<td align="right" valign="top">Message:</td>
		<td></td>
		<td align="left"><textarea cols="35" rows="3" name="Event_Descr" onkeyup="CheckFieldLength(Event_Descr, 'charcount', 'remaining', 255);" onkeydown="CheckFieldLength(Event_Descr, 'charcount', 'remaining', 255);" onmouseout="CheckFieldLength(Event_Descr, 'charcount', 'remaining', 255);">#attributes.Event_Descr#</textarea>
		<br/><span class="formtextsmall">This message will greet people viewing your registry.</span><br/>
		<small><span id="charcount">#len(attributes.Event_Descr)#</span> characters entered.   |   
		<span id="remaining">#255-len(attributes.Event_Descr)#</span> characters remaining.</small><br/>
		</td>
	</tr>					
				
 <!--- display --->
	<tr align="left">
		<td align="right" valign="top">Private Registry:</td>
		<td></td>
	 	<td><input type="radio" name="Private" value="1" #doChecked(attributes.Private)# /> Yes 
		&nbsp;&nbsp;<input type="radio" name="Private" value="0" #doChecked(attributes.Private,0)# /> No<br/>
		<span class="formtextsmall">Private registries do not appear when users search our registry database. The only way for people to access your registry will be by clicking on a link that yu can send them at any time using our 'Notify' feature.</span>
		</td>
	</tr>	

 <!--- Order_Notification --->
	<tr align="left">
		<td align="right" valign="top">Order Notification:</td>
		<td></td>
	 	<td><input type="radio" name="Order_Notification" value="1" #doChecked(attributes.Order_Notification)# /> Yes  
		&nbsp;&nbsp;<input type="radio" name="Order_Notification" value="0" #doChecked(attributes.Order_Notification,0)# /> No<br/>
		<span class="formtextsmall">Would you like to be notified when items from your list are purchased?</span>
		</td>
	</tr>	
	
	
 <!--- Live --->
	<tr align="left">
		<td align="right" valign="top">Expire Registry:</td>
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
		<tr align="left">
			<td align="right">Active:</td>
			<td></td>
		 	<td><input type="radio" name="Live" value="1" #doChecked(attributes.Live)# /> Yes  
			&nbsp;&nbsp;<input type="radio" name="Live" value="0" #doChecked(attributes.Live,0)# /> No
			</td>
		</tr>	
			
		<tr align="left">
			<td colspan="2">&nbsp;</td>
			<td><br/>
			<input type="submit" name="submit" value="#act_button#" class="formbutton"/>
			<input type="button" value="Cancel" onclick="javascript:window.history.go(-1);" class="formbutton"/> 	
			
			<cfif attributes.manage is "edit">
				<input type="submit" name="submit" value="Delete" class="formbutton"  onclick="return confirm('Are you sure you want to delete this registry?');"/>
			</cfif>
			</td>
		</tr>
	
</cfmodule>
	

</form>	
		
<cfprocessingdirective suppresswhitespace="no">
<script type="text/javascript">
<!--
objForm = new qForm("editform");

objForm.required("Event_Name,Event_Date,City,State,Registrant,Private,Order_Notification,Live");

objForm.Registrant.description = "Bride";

objForm.Event_Date.validateDate();

qFormAPI.errorColor = "###Request.GetColors.formreq#";
//-->
</script>			
</cfprocessingdirective>
		
</cfoutput>