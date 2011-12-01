
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Performs actions on standard options: add, edit and delete. Asks for confirmation for deletions. Called by product.admin&stdoption=act --->

<!--- Check user's access level --->
<cfmodule template="../../../access/secure.cfm"	keyname="product" requiredPermission="1">

<!--- if not full product admin, and is not adding an option, make sure they have access to this option --->
<cfif NOT ispermitted AND mode IS NOT "i">
	<cfmodule template="../../../access/useraccess.cfm" ID="#attributes.Std_ID#" type="stdoption">
	<cfset editoption = useraccess>
<cfelse>
	<cfset editoption = "yes">
</cfif>

<cfif editoption>
	
	<!--- New code to make sure there is at least one selection in the option --->
	
	<cfif mode IS "u" AND attributes.submit is not "Delete" AND NOT len(attributes.ChoiceName1)>
		
		<cfmodule template="../../../customtags/format_admin_form.cfm"
			box_title="Standard Option"
			width="400"
			required_fields="0"
			>
			
				<tr><td align="center" class="formtitle">
			<br/>
			
		An option must have at least one selection!
		<p>	
		
		<table><cfoutput>
			<tr>
				<td>
				<form action="#self#?fuseaction=product.admin&StdOption=list#request.token2#" method="post">
				<input class="formbutton" type="submit" value="Back to List"/>
				</form>		
				</td>
				
			<cfif isdefined("attributes.product_id")>			
				<td>
				<form action="#self#?fuseaction=product.admin&do=options&product_id=#attributes.product_id#<cfif isdefined("attributes.cid") and attributes.cid is not "">&cid=#attributes.cid#</cfif>#request.token2#" method="post">	
				<input class="formbutton" type="submit" value="Back to Product"/>
				</form>
				</td>
			</cfif>	
			</tr>
			</cfoutput>
		</table>	
		</cfmodule>
	
	<cfelse>		
	
		
		<cfswitch expression="#mode#">
		
			<cfcase value="i">
				
				<cftransaction isolation="SERIALIZABLE">
				<cfquery name="InsertOption" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
				INSERT INTO #Request.DB_Prefix#StdOptions
				(Std_Name, Std_Prompt, Std_Desc, 
				Std_ShowPrice, Std_Display, Std_Required, User_ID)
				VALUES(	'#Trim(attributes.Std_Name)#', 
				'#Trim(attributes.Std_Prompt)#', 
				<cfif len(Trim(attributes.Std_Desc))>'#Trim(attributes.Std_Desc)#',<cfelse>NULL,</cfif>
				'#attributes.Std_ShowPrice#', 
				 #attributes.Std_Display#,
				 #attributes.Required#, <cfif ispermitted>0<cfelse>#Session.User_ID#</cfif>)
				 </cfquery>	
				 
				 <cfquery name="getID" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
				SELECT Max(Std_ID) AS newid FROM #Request.DB_Prefix#StdOptions
				</cfquery>
				 </cftransaction>
				 
				 <cfset attributes.Std_ID = getID.newid>
					
				</cfcase>
					
				<cfcase value="u">
					<cfif attributes.submit is not "Delete">
						
						<cfquery name="UpdateOption" datasource="#Request.DS#" 
						username="#Request.user#" password="#Request.pass#">
						UPDATE #Request.DB_Prefix#StdOptions
						SET 
						Std_Name = '#Trim(attributes.Std_Name)#',
						Std_Prompt = '#Trim(attributes.Std_Prompt)#',
						Std_Desc = <cfif len(Trim(attributes.Std_Desc))>'#Trim(attributes.Std_Desc)#',<cfelse>NULL,</cfif>
						Std_ShowPrice = '#attributes.Std_ShowPrice#',
						Std_Display = #attributes.Std_Display#,
						Std_Required = #attributes.Required#
						WHERE Std_ID = #attributes.Std_ID#
						</cfquery>		
						
					</cfif><!--- not delete --->
				
				</cfcase>
		
			</cfswitch>
			
			<cfif attributes.submit is not "Delete">
			<!--- Update the option choices --->
				<cfloop index="i" from="1" to="#attributes.num#">
					<cfscript>
						//Process the form fields 
						ChoiceName = attributes['ChoiceName' & i];
						Price = attributes['Price' & i];
						Price = iif(isNumeric(Price), trim(Price), 0);
						
						Weight = attributes['Weight' & i];
						Weight = iif(isNumeric(Weight), trim(Weight), 0);
						
						SortOrder = attributes['SortOrder' & i];
						SortOrder = iif(isNumeric(SortOrder), trim(SortOrder), 0);
						
						Display = iif(isDefined("attributes.Display#i#"),1,0);
						Delete = iif(isDefined("attributes.Delete#i#"),1,0);
						
						Choice_ID = iif(isDefined("attributes.Choice_ID#i#"),Evaluate(De("attributes.Choice_ID#i#")),0);

					</cfscript>
					
				<!--- Run delete functions if update --->
				<cfif mode IS "u" AND Delete>
				<!--- remove this standard option choice from the product choice lists --->
					<cfquery name="DeleteProdChoice" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
						DELETE FROM #Request.DB_Prefix#ProdOpt_Choices						
						WHERE Choice_ID = #Choice_ID#
						AND Option_ID IN (SELECT Option_ID FROM #Request.DB_Prefix#Product_Options PO
											WHERE Std_ID = #attributes.Std_ID#)
					</cfquery>
					
				<!--- remove this standard option choice --->
					<cfquery name="DeleteOptChoice" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
						DELETE FROM #Request.DB_Prefix#StdOpt_Choices
						WHERE Std_ID = #attributes.Std_ID#
						AND Choice_ID = #Choice_ID#
					</cfquery>
					
				<!--- If delete not checked, and there is a choice ID, run update --->
				<cfelseif NOT Delete AND Choice_ID IS NOT 0>
					<cfquery name="UpdOptChoice" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
						UPDATE #Request.DB_Prefix#StdOpt_Choices
						SET ChoiceName = '#Trim(ChoiceName)#',
						Price = #Price#,
						Weight = #Weight#,
						SortOrder = <cfif SortOrder IS NOT 0>#SortOrder#,<cfelse>9999,</cfif>
						Display = #Display#
						WHERE Std_ID = #attributes.Std_ID#
						AND Choice_ID = #Choice_ID#
					</cfquery>
					
				<!--- Otherwise, run insert --->
				<cfelseif NOT Delete AND len(Trim(ChoiceName))>
					<cftransaction isolation="SERIALIZABLE">
					<!--- If update, get new ID --->
					<cfif mode IS "u">
						<cfquery name="getNewID" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
						SELECT MAX(Choice_ID) + 1 AS newid FROM #Request.DB_Prefix#StdOpt_Choices
						WHERE Std_ID = #attributes.Std_ID#
						</cfquery>
						<cfset newID = iif(len(getNewID.newid),getNewID.newid,1)>
					<cfelse>
						<cfset newID = i>
					</cfif>
					
					<cfquery name="UpdOptChoice" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
						INSERT INTO #Request.DB_Prefix#StdOpt_Choices
						(Std_ID, Choice_ID, ChoiceName, Price, Weight, SortOrder, Display)
						VALUES (
						#attributes.Std_ID#, #newID#, '#Trim(ChoiceName)#', #Price#, #Weight#,
						<cfif SortOrder IS NOT 0>#SortOrder#,<cfelse>9999,</cfif> 
						#Display# )
					</cfquery>
				</cftransaction>
				</cfif>
				
				</cfloop>
				
			</cfif>
			
		
			
			<cfmodule template="../../../customtags/format_admin_form.cfm"
				box_title="Standard Option"
				width="400"
				required_fields="0"
				>
				
					<tr><td align="center" class="formtitle">
				<br/>
		
				<cfif attributes.submit is "Delete">
				 
				 	Are you sure you want to delete this option? 
					This will delete it from all products as well as from the Option Manager.
					<p>	
					
					<table>
						<tr>
							<cfoutput>
							<td>
							<form action="#self#?fuseaction=product.admin&StdOption=delete#request.token2#" method="post">
							<input type="hidden" name="std_id" value="#attributes.std_id#"/>
							<input class="formbutton" type="submit" value="Delete Option"/>
							</form>		
							</td>			
							<td>
							<form action="#self#?fuseaction=product.admin&StdOptions=list#request.token2#" method="post">	
							<input class="formbutton" type="submit" value="Cancel"/>
							</form>
							</td>
							</cfoutput>
						</tr>
					</table>	
			
				<cfelse>
				
					Option <cfif mode is "i">Added<cfelse>Updated</cfif>
					<p>	
					
					<table><cfoutput>
						<tr>
							<td>
							<form action="#self#?fuseaction=product.admin&StdOption=list#request.token2#" method="post">
							<input class="formbutton" type="submit" value="Back to List"/>
							</form>		
							</td>
							
						<cfif isdefined("attributes.product_id")>	
							<td>
							<form action="#self#?fuseaction=product.admin&do=options&product_id=#attributes.product_id#<cfif isdefined("attributes.cid") and attributes.cid is not "">&cid=#attributes.cid#</cfif>#request.token2#" method="post">			
							<input class="formbutton" type="submit" value="Back to Product"/>
							</form>
							</td>
						</cfif>	
						</tr>
						</cfoutput>
					</table>	
							
				</cfif>
				
			</td></tr>
				
		</cfmodule> 							
					
	</cfif>
	
<!--- user did not have access --->
<cfelse>
	<cfset attributes.message = "You do not have access to edit this standard option.">
	<cfset attributes.XFA_success = "fuseaction=product.admin&stdoption=list">
	<cfinclude template="../../../includes/admin_confirmation.cfm">

</cfif>
