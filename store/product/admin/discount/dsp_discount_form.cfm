
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the form to add or edit a discount. Called by product.admin&discount=add|edit --->

<cfinclude template="../../../access/admin/accesskey/qry_get_accesskeys.cfm">

<!--- Initialize the values for the form --->
<cfset fieldlist="Discount_ID,Type1,Type2,Type3,Type4,Type5,Coup_Code,OneTime,AccessKey,name,display,startdate,EndDate,Amount,MinOrder,MaxOrder">	
		
<cfswitch expression="#discount#">
			
	<cfcase value="add">
		<cfloop list="#fieldlist#" index="counter">
			<cfset setvariable("attributes.#counter#", "")>
		</cfloop>
		<cfset attributes.Discount_ID = 0>
		<!--- radio button defaults --->
		<cfset attributes.Type1 = 1>
		<cfset attributes.Type3 = 0>
		<cfset attributes.Type4 = 0>
		<cfset attributes.Type5 = 0>
		<cfset attributes.OneTime = 0>
		
		<cfset action="#self#?fuseaction=product.admin&discount=act&mode=i">
	    <cfset act_title="Add Discount">
		<cfset act_button="Add">

	</cfcase>
					
	<cfcase value="edit">
		<!--- Set the form fields to values retrieved from the record --->
		<cfloop list="#fieldlist#" index="counter">
			<cfset "attributes.#counter#" = evaluate("qry_get_discount." & counter)>
		</cfloop>
				
		<cfset action="#self#?fuseaction=product.admin&discount=act&mode=u">
		<cfset act_title="Update Discount">
		<cfset act_button="Update">	
	</cfcase>
</cfswitch>
	
		
<cfif attributes.MaxOrder IS 999999999>
	<cfset attributes.MaxOrder = "">
</cfif>

<cfhtmlhead text="
	<script language=""JavaScript"">
		function CancelForm () {
		location.href = ""#self#?fuseaction=product.admin&discount=list&redirect=yes#request.token2#"";
		}
	</script>
	
	<script type='text/javascript' src='includes/openwin.js'></script>
">

				
<cfmodule template="../../../customtags/format_output_admin.cfm"
	box_title="#act_title#"
	width="550"
	menutabs="#iif(attributes.discount is "edit", DE("yes"), DE("no"))#">
	
	<cfif attributes.discount is "edit">
		<cfinclude template="dsp_menu.cfm">
	</cfif> 
	
<cfoutput>
	<!--- Table --->
	<table border="0" cellpadding="0" cellspacing="4" width="100%" class="formtext"
	style="color:###Request.GetColors.InputTText#">
	<form name="editform" action="#action##request.token2#" method="post">
	<input type="hidden" name="Discount_ID" value="#attributes.Discount_ID#"/>

	<!--- Discount ID --->
		<tr>
			<td align="RIGHT">Discount ID:</td>
			<td></td>
		 	<td><cfif discount is "add">NEW<cfelse>#attributes.discount_id#</cfif>
			</td></tr>
			
 	<!--- Type --->
		<tr>
			<td align="RIGHT" valign="top">Type of Discount:</td>
			<td style="background-color: ###Request.GetColors.formreq#;" width="3">&nbsp;</td>
		 	<td>
			<input type="radio" name="Type1" value="1" #doChecked(attributes.Type1, 1)# /> 
			Single-item discount<br/>
			<span class="formtextsmall" style="margin-left: 25px;">(purchase certain amount of one item for discount)<br/></span>
			<input type="radio" name="Type1" value="2" #doChecked(attributes.Type1, 2)# /> 
			Multi-item discount<br/>
			<span class="formtextsmall" style="margin-left: 25px;">(purchase items within a grouping for discount)</span>
			</td></tr>				
		
	<!--- Level --->
		<tr>
			<td align="RIGHT" valign="top">Discount Level:</td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
		 	<td>

<cfif attributes.discount is "add">
	<input type="radio" name="Type3" value="0" checked="checked" /> Product <span class="formtextsmall">(applies only to selected products)<br/></span>
	<input type="radio" name="Type3" value="1"/> Category <span class="formtextsmall">(applies to selected categories)<br/></span>
	<input type="radio" name="Type3" value="3"/> Storewide <span class="formtextsmall">(applies to all products in the store)<br/></span>
	<input type="radio" name="Type3" value="4"/> Order <span class="formtextsmall">(applies to the order total)</span>
<cfelse>
	<cfif attributes.Type3 IS 0>
		<b>This is a Product Discount</b>
	<cfelseif attributes.Type3 IS 1>
		<b>This is a Category Discount</b>
	<cfelseif attributes.Type3 IS 3>
		<b>This is a Storewide Discount</b>
	<cfelse>
		<b>This is a Total Order Discount</b>
	</cfif>
</cfif>			
			</td></tr>			
			
 	<!--- Level --->
		<tr>
			<td align="RIGHT" valign="top">User Level:</td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
		 	<td>
			<input type="radio" name="Type5" value="0" #doChecked(attributes.Type5, 0)# />
			 Available to all users<br/>
			<input type="radio" name="Type5" value="1" #doChecked(attributes.Type5)# />
			 Available to selected user groups only
			</td></tr>
						
 	<!--- name --->
		<tr>
			<td align="RIGHT">Name:</td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
		 	<td>
			<input type="text" name="Name" value="#attributes.name#" size="40" maxlength="255" class="formfield"/>
			</td></tr>			
		

	<!--- Display --->
		<tr>
			<td align="RIGHT">Display to users:</td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
		 	<td>
			<input type="text" name="Display" value="#attributes.Display#" size="40" maxlength="255" class="formfield"/>
			</td></tr>			
		
	<!--- Coupon Code --->
		<tr>
			<td align="RIGHT" valign="top">Coupon Code:</td>
			<td></td>
		 	<td>
			<input type="text" name="Coup_Code" value="#attributes.Coup_Code#" size="20" maxlength="50" class="formfield"/>
			<br/><span class="formtextsmall">Customer must enter this code to receive the discount.</span>
			</td></tr>	
			
 	<!--- One Time --->
		<tr>
			<td align="RIGHT" valign="top">One Time Only?</td>
			<td ></td>
		 	<td>
			<input type="radio" name="OneTime" value="1" #doChecked(attributes.OneTime)# /> Yes &nbsp;&nbsp;
			<input type="radio" name="OneTime" value="0" #doChecked(attributes.OneTime,0)# /> No
			<br/><span class="formtextsmall">Use with coupon, and user login required to checkout.</span>
			</td></tr>
			
 <!--- AccessKey --->
			<tr>
				<td align="RIGHT" valign="top">AccessKey:</td>
				<td></td>
				<td>
			 	<select name="AccessKey" class="formfield">
				<option value="0" #doSelected(attributes.accesskey,'')#>all</option>
				<cfloop query="qry_get_accesskeys">
				<option value="#accesskey_ID#" #doSelected(attributes.accesskey,qry_get_accesskeys.accesskey_ID)#>#name#</option>
				</cfloop>
	 			</select>
				<br/><span class="formtextsmall">User must have this access key to receive the discount.</span>
			</td>
			</tr>				
							
	<!--- start --->
			<tr>
				<td align="RIGHT">Start?</td>
				<td></td>
				<td><cfmodule template="../../../customtags/calendar_input.cfm" ID="calstart" formfield="StartDate" formname="editform" value="#dateformat(attributes.StartDate,"mm/dd/yyyy")#" size="15" browser="#browsername#" bversion="#browserversion#" /></td>
			</tr>
						
 	<!--- expire --->
			<tr>
				<td align="RIGHT">Expire?</td>
				<td></td>
				<td><cfmodule template="../../../customtags/calendar_input.cfm" ID="calend" formfield="EndDate" formname="editform" value="#dateformat(attributes.EndDate,"mm/dd/yyyy")#" size="15" browser="#browsername#" bversion="#browserversion#" /></td>
			</tr>
						
	 <!--- Amount --->
		<tr>
			<td align="RIGHT">Discount Amount:</td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
		 	<td>
<cfif attributes.Type2 IS 1>
	<input type="text" name="Amount1" value="#NumberFormat(attributes.Amount, '0.00')#" size="5" class="formfield"/>
<cfelse>
	<input type="text" name="Amount1" value="" size="5" class="formfield"/>
</cfif>

 #Request.AppSettings.MoneyUnit# Off &nbsp; <b>OR</b> &nbsp; 

<cfif attributes.Type2 IS 2> 
	<input type="text" name="Amount2" value="#(attributes.Amount*100)#" size="4" class="formfield"/>
<cfelse>
	<input type="text" name="Amount2" value="" size="4" class="formfield"/>
</cfif> Percent Off
			</td></tr>			
			
	<!--- range --->
		<tr>
			<td align="RIGHT" valign="top">Discount Range:</td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
		 	<td>
			<input type="radio" name="Type4" value="0" #doChecked(attributes.Type4, 0)# />
			 Based on number of items <br/>
			<input type="radio" name="Type4" value="1" #doChecked(attributes.Type4, 1)# />
			 Based on amount spent
			</td></tr>		
			
 	<!--- Minimum --->
		<tr>
			<td align="RIGHT">Minimum:</td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
		 	<td>
				<input type="text" name="MinOrder" value="#attributes.MinOrder#" size="5" maxlength="10"  class="formfield"/>
			</td></tr>
			
 	<!--- Maximum --->
		<tr>
			<td align="RIGHT">Maximum:</td>
			<td></td>
		 	<td>
				<input type="text" name="MaxOrder" value="#attributes.MaxOrder#" size="5" maxlength="10"  class="formfield"/>
				<span class="formtextsmall"><i>(Leave blank if no max)</i></span> 
			</td></tr>
			
		<cfinclude template="../../../includes/form/put_space.cfm">
		
		<tr>
			<td colspan="2">&nbsp;</td>
			<td>
			<input type="hidden" name="Check" value="Yes"/>
			<input type="submit" name="submit" value="#act_button#" class="formbutton"/> 
			<input type="button" value="Cancel" onclick="CancelForm();" class="formbutton"/>
		<cfif discount is "edit">
			<input type="submit" name="submit" value="Delete" class="formbutton" onclick="return confirm('Are you sure you want to delete this discount?');" />
		</cfif>
			</td></tr></table>
	</form>	

<cfprocessingdirective suppresswhitespace="no">
<script type="text/javascript">
objForm = new qForm("editform");

objForm.required("Name,Display,MinOrder,OneTime");

objForm.StartDate.validateDate();
objForm.EndDate.validateDate();
objForm.Amount2.validateRange('0','100');
objForm.Amount1.validateNumeric();
objForm.Amount2.validateNumeric();
objForm.MinOrder.validateNumeric();
objForm.MaxOrder.validateNumeric();

objForm.Amount1.description = "discount amount";
objForm.Amount2.description = "discount amount";
objForm.MinOrder.description = "minimum amount";
objForm.MaxOrder.description = "maximum amount";

qFormAPI.errorColor = "###Request.GetColors.formreq#";
</script>
</cfprocessingdirective>

</cfoutput>
</cfmodule>
	
