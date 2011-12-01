<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays form to select users to send an email to. Called from users.admin&email=select. --->

<cfinclude template="../group/qry_get_all_groups.cfm">

<cfmodule template="../../../customtags/format_output_admin.cfm"
	box_title="Send Email"
	Width="575"
	menutabs="yes">
		
	<cfinclude template="dsp_menu.cfm">

<cfoutput>		
	<!--- Table --->

	<table border="0" cellpadding="0" cellspacing="4" width="100%"  class="formtext" style="color:###Request.GetColors.InputTText#">
	
	<form name="editform" action="#self#?fuseaction=users.admin&email=write#request.token2#" method="post" >

		<tr>
			<td align="right" class="formtitle"><br/>Select Emails&nbsp;</td>
			<td colspan="2"><br/><cfmodule template="../../../customtags/putline.cfm" linetype="thin" linecolor="#Request.GetColors.InputHBgcolor#"/></td>
		</tr>		
		
<!------ verified ------>
		<tr>
			<td align="right" width="33%">Email Verified</td>
			<td width="4">&nbsp;</td>
			<td>
			<select name="verified" class="formfield">
			<option value="">all</option>
			<option value="0" #doSelected(attributes.verified,0)#>no</option>
			<option value="1" #doSelected(attributes.verified,1)#>yes</option>
			</select>
			</td>
		</tr>
		
<!------ subscribe ----->
		<tr>
			<td align="right">Subscribed</td>
			<td width="4"></td>
			<td>
			<select name="subscribe" class="formfield">
			<option value="">all</option>
			<option value="0" #doSelected(attributes.subscribe,0)#>no</option>
			<option value="1" #doSelected(attributes.subscribe,1)#>yes</option>
			</select>
			</td>
		</tr>
		
		<tr>
			<td align="right" class="formtitle"><br/>Select Users&nbsp;</td>
			<td colspan="2"><br/><cfmodule template="../../../customtags/putline.cfm" linetype="thin" linecolor="#Request.GetColors.InputHBgcolor#"/></td>
		</tr>		
		
<!------ User name ----------->
		<tr>
			<td align="right">Username</td>
			<td width="4"></td>
			<td>
			<input type="text" name="un" size="23" maxlength="50" class="formfield" value="<cfoutput>#attributes.un#</cfoutput>"/>
			</td>
		</tr>
		
		
		
<!------ GID ----------->
		<tr>
			<td align="right">In Group</td>
			<td width="4"></td>
			<td>
			<select name="gid" size="1" class="formfield">
				<option value="">all</option>
				<option value="0">unassigned</option>
				<cfloop query="qry_get_all_groups">
					<option value="#group_id#" #doSelected(attributes.gid,group_id)#>#name#</option>
				</cfloop>
				</select>
			</td>
		</tr>
		

<!------ affiliate ----->
		<tr>
			<td align="right">Is an Affiliate</td>
			<td width="4"></td>
			<td>
			<select name="affiliate" class="formfield">
			<option value="">all</option>
			<option value="0" #doSelected(attributes.affiliate,0)#>no</option>
			<option value="1" #doSelected(attributes.affiliate,1)#>yes</option>
			</select>
			</td>
		</tr>


<!------ account ------->
		<tr>
			<td align="right">Has Account</td>
			<td width="4"></td>
			<td>
			<select name="acct" class="formfield">
			<option value="">all</option>
			<option value="0" #doSelected(attributes.acct,0)#>no</option>
			<option value="1" #doSelected(attributes.acct,1)#>yes</option>
			</select>
			</td>
		</tr>
		
<!------ lastLogin ----->
		<tr>
			<td align="right">Last Login</td>
			<td width="4"></td>
			<td>
			<select name="lastLogin_is" size="1" class="formfield">
			<option value="after" #doSelected(attributes.lastLogin_is,"after")#>after</option>	 
		 	<option value="before" #doSelected(attributes.lastLogin_is,"before")#>before</option>
		 	<option value="on" #doSelected(attributes.lastLogin_is,"on")#>on</option>
		 	</select>
							
			<cfmodule template="../../../customtags/calendar_input.cfm" ID="callogin" formfield="lastLogin" formname="editform" value="#dateformat(attributes.lastLogin,"mm/dd/yyyy")#" size="15" browser="#browsername#" bversion="#browserversion#" /></td>
		</tr>
		

<!------ lastLogin_is --->

<!------ created ------->
		<tr>
			<td align="right">User Created</td>
			<td width="4"></td>
			<td>
			<select name="created_is" size="1" class="formfield">
			<option value="after" #doSelected(attributes.created_is,"after")#>after</option>	 
		 	<option value="before" #doSelected(attributes.created_is,"before")#>before</option>
		 	<option value="on" #doSelected(attributes.created_is,"on")#>on</option>
		 	</select>
			
			<cfmodule template="../../../customtags/calendar_input.cfm" ID="calcreated" formfield="created" formname="editform" value="#dateformat(attributes.created,"mm/dd/yyyy")#" size="15" browser="#browsername#" bversion="#browserversion#" />

			</td>
		</tr>
		
<!------ Members ---->
		<tr>
			<td align="right" valign="baseline">Member</td>
			<td width="4"></td>
			<td><input type="checkbox" name="member" value="1" class="formfield" #doChecked(attributes.member)# />
			Users with a current membership

<!---   <br/><span class="formtextsmall">(Member selection can NOT be used with Order options below.)</span> --->
			</td>
		</tr>
				
<!------ ORDER TITLE---->
		<tr>
			<td align="right" class="formtitle"><br/>Select by Order&nbsp;</td>
			<td colspan="2"><br/><cfmodule template="../../../customtags/putline.cfm" linetype="thin" linecolor="#Request.GetColors.InputHBgcolor#"/></td>
		</tr>	
		
<!------ product_ID ---->
		<tr>
			<td align="right">Product ID</td>
			<td width="4"></td>
			<td><input type="text" name="product_id" size="8" maxlength="25" class="formfield" value="#attributes.product_id#"/></td>
		</tr>
		
<!------ SKU ----------->
		<tr>
			<td align="right">Product SKU</td>
			<td width="4"></td>
			<td><input type="text" name="sku" size="8" maxlength="25" class="formfield" value="#attributes.sku#"/></td>
		</tr>
		
<!------ dateOrdered --->
		<tr>
			<td align="right">Date Ordered</td>
			<td width="4"></td>
			<td>
			<select name="dateOrdered_is" size="1" class="formfield">
			<option value="after" #doSelected(attributes.dateOrdered_is,"after")#>after</option>	 
		 	<option value="before" #doSelected(attributes.dateOrdered_is,"before")#>before</option>
		 	<option value="on" #doSelected(attributes.dateOrdered_is,"on")#>on</option>
		 	</select>
			
			<cfmodule template="../../../customtags/calendar_input.cfm" ID="calordered" formfield="dateOrdered" formname="editform" value="#dateformat(attributes.dateOrdered,"mm/dd/yyyy")#" size="15" browser="#browsername#" bversion="#browserversion#" />


			</td>
		</tr>
		
		
<!------ dateFilled ---->
		<tr>
			<td align="right">Date Filled</td>
			<td width="4"></td>
			<td>
			<select name="dateFilled_is" size="1" class="formfield">
			<option value="after" #doSelected(attributes.dateFilled_is,"after")#>after</option>	 
		 	<option value="before" #doSelected(attributes.dateFilled_is,"before")#>before</option>
		 	<option value="on" #doSelected(attributes.dateFilled_is,"on")#>on</option>
		 	</select>
				<cfmodule template="../../../customtags/calendar_input.cfm" ID="calfilled" formfield="dateFilled" formname="editform" value="#dateformat(attributes.dateFilled,"mm/dd/yyyy")#" size="15" browser="#browsername#" bversion="#browserversion#" />

			</td>
		</tr>
		
		<tr>
			<td colspan="2">&nbsp;</td>
			<td><br/>
			<input type="submit" name="submit" value="Continue" class="formbutton"> <input type="reset" name="reset" value="Reset" class="formbutton"/> 
			<input type="button" value="Cancel" onclick="javascript:window.location.href='#self#?fuseaction=home.admin&inframes=yes#request.token2#';" class="formbutton"/>
			</td></tr>
			<cfinclude template="../../../includes/form/put_requiredfields.cfm">	
			</form>	
</cfoutput>
	</table>
	
</cfmodule>


