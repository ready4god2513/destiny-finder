<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the gallery images and provides the form to add new images, using the ImageUpload tag. Called by product.admin&do=images --->


<cfparam name="attributes.cid" default="0">

<cfset act_title="Update Product - #qry_get_product.name#">

<!------------->
<cfparam name="attributes.message" default="">
<cfparam name="attributes.gallery" default="">
<cfparam name="attributes.caption" default="">
<cfparam name="attributes.priority" default="">
<cfset dirBase = GetDirectoryFromPath(ExpandPath("*.*"))>

		
<!---Set Subdirectory for images according to product's User ID --->
<cfif qry_get_product.User_ID IS NOT 0>
	<cfset subdir = "User#qry_get_product.User_ID#/">
<cfelse>
	<cfset subdir = ''>
</cfif>

<cfquery name="qry_get_images" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	 SELECT Product_Image_ID, Image_File, Gallery
	 FROM #Request.DB_Prefix#Product_Images
	 WHERE Product_ID = #attributes.product_ID#
	 ORDER BY Gallery DESC, Priority
</cfquery>

<cfquery name="ImageSize" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	 SELECT SUM(File_Size) AS total
	 FROM #Request.DB_Prefix#Product_Images
	 WHERE Product_ID = #attributes.product_ID#
</cfquery>


<cfmodule template="../../../customtags/format_output_admin.cfm"
	box_title="#act_title#"
	Width="700"
	menutabs="yes">
	
	<cfinclude template="dsp_menu.cfm">
	
	<cfoutput>
	<cfif len(trim(attributes.Message))>
		<p align="center"><span class="formerror"><b>#attributes.Message#</b></span></p>
	</cfif>

<table border="0" cellpadding="0" cellspacing="4" class="formtext" align="center" width="100%"
style="color:###Request.GetColors.InputTText#"></cfoutput>

     <tr>
        <th align="left">Upload additional product photos here. Only GIF, JPEG and PNG images are accepted.<br/>
		 </th>
        </tr>
		 <td align="middle">

<cfif imagesize.total is not ""> 
	<!----- This status code was used for photo limits 
	<cfoutput>Current status: <b>#qry_get_images.recordcount#</b> files
		using <b>#decimalFormat(evaluate(imagesize.total/100000))#MB</b></cfoutput>
	---->	
<cfmodule template="../../../customtags/putline.cfm" linetype="thin" linecolor="#Request.GetColors.InputHBgcolor#"/>
	</cfif>	
	
		  </td>
        </tr>
	 <tr>
        <td align="center"><div align="left" class="formtitle">Add a New Image:</div>

		
		<cfif qry_get_images.recordcount is 0>
		<div align="left" class="formtext">Use this form to upload images. Use the browse button to select a file on your local computer then click the upload button to send the image to our server.<br/><br/></div>
		</cfif>
		
		<!--- To place limits on number of photos or total size, uncomment here 
		<cfif qry_get_images.recordcount lte "24" and imagesize.total lte "10000000">
		---->
		
		<!--- New Image Upload --->
		<cf_ImageUpload
		    TheFormAction=			"#self#?fuseaction=product.admin&do=images&product_id=#attributes.product_id#&cid=#attributes.cid#"
			TheTableName=			"#Request.DB_Prefix#Product_Images"					
			TheTableType=			"Foreign"							
			TheKeyColumnName=		"Product_Image_ID"
			TheFileColumnName=		"Image_File"
			TheRecordID=			"0"
			PathToImageDir=			"#dirbase##Request.AppSettings.defaultimages#\#subdir#products\"
			PathToTempDir=			"#Request.TempPath#"
			URLToImageDir=			"#Request.AppSettings.defaultimages#/#subdir#products/"
			Referrer=				"#self#?fuseaction=product.admin&do=images&product_id=#attributes.product_id#&cid=#attributes.cid#"
			WebReadyCheck=			"Yes"
			size_sm=				"65"
			size_med=				""
			size_lg=				""
			size_max=				"640"
			defaultimage=			""
			product_id=				"#attributes.product_id#"
			gallery=				"#attributes.gallery#"
			caption=				"#attributes.caption#"
			priority=				"#iif(isNumeric(attributes.priority), attributes.priority, DE(''))#"
			imagenumber=			"#qry_get_images.recordcount#"
			>
		
		<!--- photo limits code 	
        <cfelse>
			<p>You have exceeded your file limits.</p>
		</cfif>
		--->
		
<cfmodule template="../../../customtags/putline.cfm" linetype="thin" linecolor="#Request.GetColors.InputHBgcolor#"/>
		</td>
    </tr>

	
	<cfoutput query="qry_get_images" group="gallery">
	  	<tr>
      	  <td><span class="formtitle">#Gallery# Images:</span><cfif gallery is "private"><br/>
		  <span class="formtextsmall">These images will be passcode protected. </span></cfif>
			</td>
    	</tr>
	<cfoutput>
    <tr>
		<td align="center">	
		<!--- Image Update Functions --->
		<cf_ImageUpload
		    TheFormAction=			"#self#?fuseaction=product.admin&do=images&product_id=#attributes.product_id#&cid=#attributes.cid#"
			TheTableName=			"#Request.DB_Prefix#Product_Images"					
			TheTableType=			"Foreign"							
			TheKeyColumnName=		"Product_Image_ID"
			TheFileColumnName=		"Image_File"
			TheRecordID=			"#qry_get_images.Product_Image_ID#"
			PathToImageDir=			"#dirbase##Request.AppSettings.defaultimages#\#subdir#products\"
			PathToTempDir=			"#Request.TempPath#"
			URLToImageDir=			"#Request.AppSettings.defaultimages#/#subdir#products/"
			Referrer=				"#self#?fuseaction=product.admin&do=images&product_id=#attributes.product_id#&cid=#attributes.cid#"
			WebReadyCheck=			"Yes"
			size_sm=				"50"
			size_med=				"110"
			size_lg=				"230"
			size_max=				"500"
			defaultimage=			""
			product_id=				"#attributes.product_id#"
			gallery=				"#attributes.gallery#"
			caption=				"#attributes.caption#"
			priority=				"#iif(isNumeric(attributes.priority), attributes.priority, DE(''))#"
			>
        </td>
    </tr>
	</cfoutput>
	</cfoutput>
	
	
<cfoutput>
	<tr>
		<td align="center">
<cfif qry_get_images.recordcount is not 0>

<cfmodule template="../../../customtags/putline.cfm" linetype="thin" linecolor="#Request.GetColors.InputHBgcolor#"/>
</cfif>		<br/>
		<form action="#self#?fuseaction=product.admin&do=list#request.token2#" method="post">	
		<input type="hidden" name="cid" value="#iif(len(attributes.cid),attributes.cid,0)#"/>
		<input type="hidden" name="act" value="choose"/>
		<input type="submit" name="DONE" value="Back to Product List" class="formbutton"/><br/><br/>
		</td></form>
    </tr>
	</cfoutput>
</table>

</cfmodule>
