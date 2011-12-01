
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Processes the second form page for standard options. Called by product.admin&option=act2 --->

<cfparam name="attributes.cid" default="">

<!--- Get option info --->
<cfquery name="qry_get_Option"   datasource="#Request.ds#"	 username="#Request.user#"  password="#Request.pass#" >
SELECT PO.Display, SO.Std_Display
FROM #Request.DB_Prefix#Product_Options PO 
INNER JOIN #Request.DB_Prefix#StdOptions SO ON PO.Std_ID = SO.Std_ID
WHERE PO.Option_ID =  #attributes.Option_ID#
</cfquery>

<!--- Check if this option used for inventory tracking --->
<cfset TotalStock = 0>

<cfloop index="i" from="1" to="#attributes.num#">
	<cfscript>
		//Check if SKUs entered and allowed for this option
		if (NOT isDefined("attributes.OtherSKUs"))
			SKU = attributes['SKU' & i];
		else 
			SKU = '';
		
		//process number in stock, add to running total
		InStock = attributes['NumInStock' & i];
		NumInStock = iif(isNumeric(InStock), trim(InStock), 0);
		TotalStock = TotalStock + NumInStock;
		
		Display = iif(isDefined("attributes.Display#i#"),1,0);
		
		Choice_ID = iif(isDefined("attributes.Choice_ID#i#"),Evaluate(De("attributes.Choice_ID#i#")),0);

	</cfscript>
	
	<!--- Check if there is any information entered for this option choice --->
	<cfif len(SKU) OR isNumeric(InStock) OR Display IS 0>
	
		<!--- Check if there is a record for this option choice --->
		<cfquery name="CheckChoice" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
		SELECT Choice_ID FROM #Request.DB_Prefix#ProdOpt_Choices
		WHERE Option_ID = #attributes.option_ID#
		AND Choice_ID = #Choice_ID#
		</cfquery>
		
		<cfif CheckChoice.RecordCount>
			<cfquery name="UpdOptChoice" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
				UPDATE #Request.DB_Prefix#ProdOpt_Choices
				SET SKU = '#Trim(SKU)#',
				NumInStock = #NumInStock#,
				Display = #Display#
				WHERE Option_ID = #attributes.option_ID#
				AND Choice_ID = #Choice_ID#
			</cfquery>
		
		<cfelse>
			<cfquery name="UpdOptChoice" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
				INSERT INTO #Request.DB_Prefix#ProdOpt_Choices
				(Option_ID, Choice_ID, SKU, NumInStock, Display)
				VALUES (
				#attributes.option_id#, #Choice_ID#, '#Trim(SKU)#', #NumInStock#, #Display# )
			</cfquery>
		
		</cfif>
		
	<cfelse>
		<cfquery name="UpdOptChoice" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
		DELETE FROM #Request.DB_Prefix#ProdOpt_Choices
		WHERE Option_ID = #attributes.option_id#
		AND Choice_ID = #Choice_ID#
		</cfquery>
	
	</cfif>
	
</cfloop>
	
<!--- Check if inventory was entered or required. If yes, update the product option and product --->
<cfif (TotalStock IS NOT 0 AND NOT isDefined("attributes.OtherInv")) OR isDefined("attributes.TrackInv")>
	<cfquery name="UpdateOption" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
		UPDATE #Request.DB_Prefix#Product_Options
		SET TrackInv = 1,
		Required = 1
		WHERE Option_ID = #attributes.Option_ID#
	</cfquery>
	
	<cfquery name="UpdateProduct" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	UPDATE #Request.DB_Prefix#Products
	SET OptQuant = #attributes.option_ID#, 
	NuminStock = #TotalStock#
	WHERE Product_ID = #attributes.Product_ID#
	</cfquery>
	
<cfelse>
	<!--- Check if this option was using quantities previously --->
	<cfquery name="UpdateProduct" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	UPDATE #Request.DB_Prefix#Products
	SET OptQuant = 0
	WHERE Product_ID = #attributes.Product_ID#
	AND OptQuant = #attributes.option_ID#
	</cfquery>	
	
	<cfquery name="UpdateOption" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
		UPDATE #Request.DB_Prefix#Product_Options
		SET TrackInv = 0
		WHERE Option_ID = #attributes.Option_ID#
	</cfquery>	

</cfif>
	

<cfmodule template="../../../../customtags/format_admin_form.cfm"
	box_title="Product Options"
	width="400"
	required_fields = "0"
	>
		
	<tr><td align="center" class="formtitle">
		<br/>
		Option Updated	
		<br/><br/>
		<cfoutput>				
		<form action="#self#?fuseaction=Product.admin&do=options&product_id=#attributes.product_id#<cfif len(attributes.cid)>&cid=#attributes.cid#</cfif>#request.token2#" method="post">
			<input class="formbutton" type="submit" value="Back to Options"/>
		</form>	
		</cfoutput>
	</td></tr>
			
</cfmodule> 


