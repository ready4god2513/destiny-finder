
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Performs actions on standard addons: add, edit and delete. Asks for confirmation for deletions. Called by product.admin&stdaddon=act --->

<!--- Check user's access level --->
<cfmodule template="../../../access/secure.cfm"	keyname="product" requiredPermission="1">

<!--- if not full product admin, and is not adding an option, make sure they have access to this option --->
<cfif NOT ispermitted AND mode IS NOT "i">
	<cfmodule template="../../../access/useraccess.cfm" ID="#attributes.Std_ID#" type="stdaddon">
	<cfset editaddon = useraccess>
<cfelse>
	<cfset editaddon = "yes">
</cfif>

<cfif editaddon>
	
	<!--- Set price and weight --->
	<cfscript>
	Price = attributes.Std_Price;
	Price = iif(isNumeric(Price), trim(Price), 0);
	
	Weight = attributes.Std_Weight;
	Weight = iif(isNumeric(Weight), trim(Weight), 0);	
	</cfscript>	
	
	<cfswitch expression="#mode#">
	
		<cfcase value="i">
			
			<cfquery name="Insertaddon" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
			INSERT INTO #Request.DB_Prefix#StdAddons
			(Std_Name, Std_Prompt, Std_Desc, Std_Type, Std_Price, Std_Weight, Std_Display, Std_ProdMult, Std_Required, User_ID)
			VALUES(	'#Trim(attributes.Std_Name)#', 
			'#Trim(attributes.Std_Prompt)#', 
			<cfif len(Trim(attributes.Std_Desc))>'#Trim(attributes.Std_Desc)#',<cfelse>NULL,</cfif>
			'#Trim(attributes.Std_Type)#', 
			#Price#, 
			#Weight#,
			#attributes.Std_Display#,
			#attributes.Std_ProdMult#, 
			#attributes.StdRequired#,
			<cfif ispermitted>0<cfelse>#Session.User_ID#</cfif>)
			 </cfquery>	
				
			</cfcase>
				
			<cfcase value="u">
				<cfif submit is not "Delete">
					
					<cfquery name="UpdateOption" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
					UPDATE #Request.DB_Prefix#StdAddons
					SET 
					Std_Name = '#Trim(attributes.Std_Name)#',
					Std_Prompt = '#Trim(attributes.Std_Prompt)#',
					Std_Desc = <cfif len(Trim(attributes.Std_Desc))>'#Trim(attributes.Std_Desc)#',<cfelse>NULL,</cfif>
					Std_Type = '#Trim(attributes.Std_Type)#',
					Std_Price = #Price#,
					Std_Weight = #Weight#,
					Std_Display = #attributes.Std_Display#,
					Std_ProdMult = #attributes.Std_ProdMult#,
					Std_Required = #attributes.StdRequired#
					WHERE Std_ID = #attributes.Std_ID#
					</cfquery>
	
				</cfif>
			
			</cfcase>
	
		</cfswitch>	
		
	
		
		<cfmodule template="../../../customtags/format_admin_form.cfm"
			box_title="Standard Addon"
			width="400"
			required_fields="0"
			>
			
				<tr><td align="center" class="formtitle">
			<br/>
	
			<cfif submit is "Delete">
			 
			 	Are you sure you want to delete this addon? 
				This will delete it from all products as well as from the Addon Manager.
				<p>	
				
				<table>
					<tr>
						<cfoutput>
						<td>
						<form action="#self#?fuseaction=product.admin&Stdaddon=delete#request.token2#" method="post">
						<input type="hidden" name="std_id" value="#attributes.std_id#"/>
						<input class="formbutton" type="submit" value="Delete addon">
						</form>		
						</td>
								
						<td>
						<form action="#self#?fuseaction=product.admin&Stdaddons=list#request.token2#" method="post">		
						<input class="formbutton" type="submit" value="Cancel"/>
						</form>
						</td>
						</cfoutput>
					</tr>
				</table>	
		
			<cfelse>
			
				Addon <cfif mode is "i">Added<cfelse>Updated</cfif>
				<p>	
				
				<table><cfoutput>
					<tr>						
						<td>
						<form action="#self#?fuseaction=product.admin&Stdaddon=list#request.token2#" method="post">
						<input class="formbutton" type="submit" value="Back to List"/>
						</form>		
						</td>
						
					<cfif isdefined("attributes.product_id")>									
						<td>
						<form action="#self#?fuseaction=product.admin&do=addons&product_id=#attributes.product_id#<cfif isdefined("attributes.cid") and attributes.cid is not "">&cid=#attributes.cid#</cfif>#request.token2#" method="post">	
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
					
<!--- user did not have access --->
<cfelse>
	<cfset attributes.message = "You do not have access to edit this standard addon.">
	<cfset attributes.XFA_success = "fuseaction=product.admin&stdaddon=list">
	<cfinclude template="../../../includes/admin_confirmation.cfm">

</cfif>
			
