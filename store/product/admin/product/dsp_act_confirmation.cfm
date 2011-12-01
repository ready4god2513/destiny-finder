<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays a confirmation message after adding or editing a product. Provides links to other product sections. Called by act_product.cfm and act_product_price.cfm --->

<cfmodule template="../../../customtags/format_admin_form.cfm"
	box_title="Products"
	width="400"
	required_fields="0"
	>
	
	<tr><td align="center" class="formtitle">
		<br/>
		Product
		<cfif frm_submit is "Delete">
			Deleted
			<cfelse>				
				<cfif mode is "i">Added<cfelse>Updated</cfif>
			</cfif><p>	
		<cfoutput>
				
		<cfif frm_submit is not "Delete">
		<table>
			<tr>
				<form action="#self#?fuseaction=Product.admin&product_id=#attributes.product_id#&do=edit<cfif attributes.cid is not "">&cid=#attributes.cid#</cfif>#request.token2#" method="post">
				<td>
				<input class="formbutton" type="submit" value="Edit Display"/>
				</form>	
				</td>
				
				<form action="#self#?fuseaction=Product.admin&do=price&product_id=#attributes.product_id#<cfif attributes.cid is not "">&cid=#attributes.cid#</cfif>#request.token2#" method="post">
				<td>
				<input class="formbutton" type="submit" value="Edit Prices"/>
				</form>	
				</td>
				
				<form action="#self#?fuseaction=Product.admin&do=info&product_id=#attributes.product_id#<cfif attributes.cid is not "">&cid=#attributes.cid#</cfif>#request.token2#" method="post">
				<td>
				<input class="formbutton" type="submit" value="Edit Info"/>
				</form>	
				</td>
		
				<form action="#self#?fuseaction=Product.admin&do=options&product_id=#attributes.product_id#<cfif attributes.cid is not "">&cid=#attributes.cid#</cfif>#request.token2#" method="post">
				<td>
				<input class="formbutton" type="submit" value="Edit Options"/>
				</form>	
				</td>	
				
				<form action="#self#?fuseaction=Product.admin&do=addons&product_id=#attributes.product_id#<cfif attributes.cid is not "">&cid=#attributes.cid#</cfif>#request.token2#" method="post">
				<td>
				<input class="formbutton" type="submit" value="Edit Addons"/>
				</form>	
				</td>	
		
				<form action="#self#?fuseaction=Product.admin&do=images&product_id=#attributes.product_id#<cfif attributes.cid is not "">&cid=#attributes.cid#</cfif>#request.token2#" method="post">
				<td>
				<input class="formbutton" type="submit" value="Edit Images"/>
				</form>	
				</td>
			</tr>
		</table>
		</cfif>
		
	<table>
		<tr>
		<td>
		<form action="#self#?fuseaction=Product.admin&do=list<cfif attributes.cid is not "">&cid=#attributes.cid#</cfif>#request.token2#" method="post">
			<input class="formbutton" type="submit" value="Back to Product List"/>
		</form>	
		</td>	
		
		<cfif frm_submit is not "Delete">
		<td>
		<form action="#self#?fuseaction=Product.display&product_id=#attributes.product_id##request.token2#" target="store" method="post">
			<input class="formbutton" type="submit" value="View Product"/>
		</form>	
		</td>	
		</cfif>
	</tr>
	</table>
		</cfoutput>
	</td></tr>
			
	</cfmodule> 
