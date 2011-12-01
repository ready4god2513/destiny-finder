
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the form to add or edit a promotion. Called by product.admin&promotion=add|edit --->

<cfinclude template="../../../access/admin/accesskey/qry_get_accesskeys.cfm">

<!--- Initialize the values for the form --->
<cfset fieldlist="Promotion_ID,Type1,Type2,Type3,Type4,Coup_Code,OneTime,AccessKey,name,display,startdate,EndDate,Amount,QualifyNum,DiscountNum,Multiply,Add_DiscProd">
		
<cfswitch expression="#promotion#">
			
	<cfcase value="add">
		<cfloop list="#fieldlist#" index="counter">
			<cfset setvariable("attributes.#counter#", "")>
		</cfloop>
		<cfset attributes.Promotion_ID = 0>
		<!--- radio button defaults --->
		<cfset attributes.Type1 = 1>
		<cfset attributes.Type4 = 0>
		<cfset attributes.OneTime = 0>
		<cfset attributes.Type3 = 0>
		<cfset attributes.Add_DiscProd = 0>
		
		<cfset action="#self#?fuseaction=product.admin&promotion=act&mode=i">
	    <cfset act_title="Add Promotion">
		<cfset act_button="Add">

	</cfcase>
					
	<cfcase value="edit">
		<!--- Set the form fields to values retrieved from the record --->
		<cfloop list="#fieldlist#" index="counter">
			<cfset "attributes.#counter#" = evaluate("qry_get_promotion." & counter)>
		</cfloop>
				
		<cfset action="#self#?fuseaction=product.admin&promotion=act&mode=u">
		<cfset act_title="Update Promotion">
		<cfset act_button="Update">	
	</cfcase>
</cfswitch>

<cfhtmlhead text="
	<script language=""JavaScript"">
		function CancelForm () {
		location.href = ""#self#?fuseaction=product.admin&promotion=list&redirect=yes#request.token2#"";
		}
	</script>
	<script type='text/javascript' src='includes/openwin.js'></script>
">

				
<cfmodule template="../../../customtags/format_output_admin.cfm"
	box_title="#act_title#"
	width="600"
	menutabs="#iif(attributes.promotion is "edit", DE("yes"), DE("no"))#">
	
	<cfif attributes.promotion is "edit">
		<cfinclude template="dsp_menu.cfm">
	</cfif> 
	
<cfoutput>
	<!--- Table --->
	<table border="0" cellpadding="0" cellspacing="4" width="100%" class="formtext"
	style="color:###Request.GetColors.InputTText#">
	<form name="editform" action="#action##request.token2#" method="post">
	<input type="hidden" name="Promotion_ID" value="#attributes.Promotion_ID#"/>

	<!--- Discount ID --->
		<tr>
			<td align="RIGHT">Promotion ID:</td>
			<td></td>
		 	<td><cfif promotion is "add">NEW<cfelse>#attributes.promotion_id#</cfif>
			</td></tr>
			
 	<!--- Type --->
		<tr>
			<td align="RIGHT" valign="top">Promotion Type:</td>
			<td style="background-color: ###Request.GetColors.formreq#;" width="3">&nbsp;</td>
		 	<td>
			<input type="radio" name="Type1" value="1" #doChecked(attributes.Type1,1)# /> 
			Single-item promotion<br/>
			<span class="formtextsmall" style="margin-left: 24px">(apply to each selected product individually, 
			discount on the same product)<br/></span>
			<input type="radio" name="Type1" value="2" #doChecked(attributes.Type1,2)# /> Cross-item promotion<br/>
			<span class="formtextsmall" style="margin-left: 24px">(apply to each selected product individually, 
			discount on a different product)<br/></span>
			<input type="radio" name="Type1" value="3" #doChecked(attributes.Type1,3)# /> 
			Multi-item promotion<br/><span class="formtextsmall" style="margin-left: 24px">(group all selected products 
			together to qualify, discount on a single selected product)<br/></span>
			<input type="radio" name="Type1" value="4" #doChecked(attributes.Type1,4)# /> 
			Order-based promotion<br/><span class="formtextsmall" style="margin-left: 24px">(Qualify based on the entire order total,
			discount on a single selected product)</span>
			</td></tr>				

			
 	<!--- Level --->
		<tr>
			<td align="RIGHT" valign="top">User Level:</td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
		 	<td>
			<input type="radio" name="Type4" value="0" #doChecked(attributes.Type4,0)# />
			 Available to all users<br/>
			<input type="radio" name="Type4" value="1" #doChecked(attributes.Type4)# />
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
			<br/><span class="formtextsmall">Customer must enter this code to receive the promotion.</span>
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
				<br/><span class="formtextsmall">User must have this access key to receive the promotion.</span>
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
			
	<!--- range --->
		<tr>
			<td align="RIGHT" valign="top">Qualify Based On:</td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
		 	<td>
			<input type="radio" name="Type3" value="0" #doChecked(attributes.Type3,0)# />
			 Number of items purchased<br/>
			<input type="radio" name="Type3" value="1" #doChecked(attributes.Type3,1)# />
			 Amount spent on items
			</td></tr>
			
 	<!--- Qualifying Amount --->
		<tr>
			<td align="RIGHT">Qualifying Amount:</td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
		 	<td>
				<input type="text" name="QualifyNum" value="#attributes.QualifyNum#" size="5" maxlength="10"  class="formfield"/>
			</td></tr>
			
 	<!--- Maximum --->
		<tr>
			<td align="RIGHT">Number of Items<br/>to Discount:</td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
		 	<td>
				<input type="text" name="DiscountNum" value="#attributes.DiscountNum#" size="5" maxlength="10"  class="formfield"/>
			</td></tr>			
						
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
			<input type="text" name="Amount2" value="#Evaluate(attributes.Amount*100)#" size="4" class="formfield"/>
		<cfelse>
			<input type="text" name="Amount2" value="" size="4" class="formfield"/>
		</cfif> Percent Off
		</td></tr>		

			
 	<!--- Multiply --->
		<tr>
			<td align="RIGHT" valign="top">Promotion Amounts<br/> can Multiply:</td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
		 	<td>
			<input type="radio" name="Multiply" value="1" #doChecked(attributes.Multiply)# /> Yes &nbsp;&nbsp;&nbsp;
			<input type="radio" name="Multiply" value="0" #doChecked(attributes.Multiply,0)# /> No<br/>
			<span class="formtextsmall">If turned on, each additional qualifying amount the customer<br/> 
			purchases will qualify them for an additional discounted item(s).</span>
			</td></tr>
			
	 	<!--- Add_DiscProd --->
		<tr>
			<td align="RIGHT" valign="top">Add the Discounted <br/>Product:</td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
		 	<td>
			<input type="radio" name="Add_DiscProd" value="1" #doChecked(attributes.Add_DiscProd)# /> Yes &nbsp;&nbsp;&nbsp;
			<input type="radio" name="Add_DiscProd" value="0" #doChecked(attributes.Add_DiscProd,0)# /> No<br/>
			<span class="formtextsmall">If turned on, this will automatically add the discounted product to the <br/>
			shopping cart if it is not already there. No options/addons are included. <br/>
			Best only for free product promotions.</span>
			</td></tr>
			
		<cfinclude template="../../../includes/form/put_space.cfm">
		
		<tr>
			<td colspan="2">&nbsp;</td>
			<td>
			<input type="hidden" name="Check" value="Yes"/>
			<input type="submit" name="submit" value="#act_button#" class="formbutton"/> 
			<input type="button" value="Cancel" onclick="CancelForm();" class="formbutton"/>
		<cfif promotion is "edit">
			<input type="submit" name="submit" value="Delete" class="formbutton" onclick="return confirm('Are you sure you want to delete this promotion?');" />
		</cfif>
			</td></tr></table>
	</form>	

<cfprocessingdirective suppresswhitespace="no">
<script type="text/javascript">
objForm = new qForm("editform");

objForm.required("Type1,Type4,Type3,Name,Display,QualifyNum,DiscountNum,Multiply,OneTime");

objForm.StartDate.validateDate();
objForm.EndDate.validateDate();
objForm.Amount2.validateRange('0','100');
objForm.Amount1.validateNumeric();
objForm.Amount2.validateNumeric();
objForm.QualifyNum.validateNumeric();
objForm.DiscountNum.validateNumeric();

objForm.Type1.description = "promotion type";
objForm.Type4.description = "user level";
objForm.Type3.description = "qualify based on";
objForm.Amount1.description = "discount amount";
objForm.Amount2.description = "discount amount";
objForm.QualifyNum.description = "qualifying amount";
objForm.DiscountNum.description = "number of items to discount";

qFormAPI.errorColor = "###Request.GetColors.formreq#";
</script>
</cfprocessingdirective>

</cfoutput>
</cfmodule>
	
