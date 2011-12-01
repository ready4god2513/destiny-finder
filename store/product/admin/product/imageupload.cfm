<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This tag provides the form for uploading product gallery images. If no thumbnail image is entered, it attempts to use the ImageCFC component to create a thumbnail. Called from dsp_images_form.cfm --->

<!--- ----------------------------------------------------------------------------------
	ERROR CHECKING: The first thing we do is to check that the tag is correctly implented:
	We build a message telling the developer which one is missing, then exit the tag.
------------------------------------------------------------------------------------ --->

<cfinclude template="../../../includes/cfw_functions.cfm">

<!--- These values are optional, so lets make sure they are defined. --->
	<cfparam name="DefaultImage" default="">
	<cfparam name="Attributes.WebReadyCheck" default="Yes">

<!--- Build implementation error messages: List of required attributes. --->
	<cfset ReqAttList="TheFormAction,TheTableName,TheTableType,TheKeyColumnName,TheFileColumnName,TheRecordID,PathToImageDir,PathToTempDir,URLToImageDir,Referrer">

<!--- Initialize the error list value --->
	<cfset ReqAttErrList="">

<!--- [Err 1] Loop though the list, initializing the error message --->
	<cfloop index="index" list="#ReqAttList#" delimiters=",">
	
		<cfset TempAtt="Attributes.#index#">
		<cfset AttributeError="#IIF(IsDefined('#TempAtt#'), DE(''), DE('#index#'))#">
		
		<cfif Len(AttributeError)>
			<cfset ReqAttErrList="#ListAppend(ReqAttErrList, AttributeError)#">
		</cfif>

<!--- [Err 1] End if --->
	</cfloop>

<!--- [Err 2] Output an error message if any, and exit tag. --->	
	<cfif Len(ReqAttErrList)>
		<cfoutput>
		<div style="formerror">
			<strong>There is an error with the implementation of</strong><br/>
			&nbsp;&nbsp;&nbsp;#GetCurrentTemplatePath()#<br/><br/>
		
			<strong>The following attributes seem to be missing from the tag definition in the document</strong><br/>
			&nbsp;&nbsp;&nbsp;#GetBaseTemplatePath()#
		
			<ol style="color:Red;">
				<cfloop index="index" list="#ReqAttErrList#">
				<li>#index#</li>
				</cfloop>
			</ol>
			Please see the comments at the top of the cf_ImageUpload tag for detailed usage instructions. (You may also want to compare the spelling of the attribute name with the correct one displayed in the above list.).
		</div>
		</cfoutput>
		<cfexit>

<!--- [Err 2] End if --->
	</cfif>

<!--- Now set the Attribute scoped variables to locals, so that our code appears a little neater to the eye. --->
	<cfset TheFormAction=	 Attributes.TheFormAction>
	<cfset TheTableName=	 Attributes.TheTableName>
	<cfset TheTableType=	 Attributes.TheTableType>
	<cfset TheKeyColumnName= Attributes.TheKeyColumnName>
	<cfset TheFileColumnName= Attributes.TheFileColumnName>
	<cfset TheRecordID=		 Attributes.TheRecordID>
	<cfset PathToImageDir=	 Attributes.PathToImageDir>
	<cfset PathToTempDir=	 Attributes.PathToTempDir>
	<cfset URLToImageDir=	 Attributes.URLToImageDir>
	<cfset Referrer=		 Attributes.Referrer>
	<cfset DefaultImage=	 Attributes.defaultImage>
	<cfset WebReadyCheck=	 Attributes.WebReadyCheck>
	<cfset size_sm=			 Attributes.size_sm>
	<cfset size_med=		 Attributes.size_med>
	<cfset size_lg=			 Attributes.size_lg>
	<cfset size_max=		 Attributes.size_max>
	
	<!---  Make sure file path is correct for the server --->
	<cfset PathToImageDir = ReReplace(PathToImageDir, "[\\\/]", Request.slash, "ALL")>
	<cfset PathToTempDir = ReReplace(PathToTempDir, "[\\\/]", Request.slash, "ALL")>

<!--- ----------------------------------------------------------------------------------
	UPLOAD (HTML FORM)
	As the tag is invoked, it will display a table with a form and an image/text.
	A query looks for an image that is associated with a record,
	if present, it is displayed. If not, and a default image is defined,
	the default image is displayed. If neither is the case, text is displayed.
------------------------------------------------------------------------------------ --->

<!--- Query the database to see if we have an image to display. --->
	<cfquery name="GetRecordImages" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
		SELECT #TheFileColumnName#, Gallery, Caption, Priority
		FROM #TheTableName#
		WHERE #TheKeyColumnName#=#TheRecordID#
		AND Product_ID = #attributes.Product_ID#
		</cfquery>

<!--- Construct the image name so that we may refer to it as a variable. --->
	<cfset TheImage="#Evaluate('GetRecordImages.'&TheFileColumnName)#">
	
	<!--- Check for subdirectory --->
	<cfif ListLen(TheImage,"/") GT 1>
		<!--- Separate out the subdirectory and the image name --->
		<cfset subdir = ListDeleteAt(TheImage, ListLen(TheImage, "/"), "/") & "/">
		<cfset TheImage = ListLast(TheImage,"/")>
	<cfelse>
		<cfset subdir = "">
	</cfif>

	<!--- Add any subdirectory to the full image path, make sure slashes correct for the server type --->
	<cfset FullImagePath = PathToImageDir & ReReplace(subdir, "[\\\/]", Request.slash, "ALL")>

<!--- [2] Form layout table --->
	<cfoutput><table class="formtext" style="color: ###request.getcolors.InputTText#;"></cfoutput>
		<tr>

		<!--- [3] UPLOAD FORM: Start the form --->
				<cfoutput>
				<form action="#TheFormAction##request.token2#" name="UploadForm_#TheRecordID#" method="post" enctype="multipart/form-data" >
				<input type="hidden" name="#TheKeyColumnName#" value="#TheRecordID#"/>
				<input type="hidden" name="TheTableName" value="#TheTableName#"/>
				<input type="hidden" name="PathToImageDir" value="#PathToImageDir#"/>
				<input type="hidden" name="URLToImageDir" value="#URLToImageDir#"/>
				<input type="hidden" name="Referrer" value="#Referrer#"/>
				<input type="hidden" name="size_sm" value="#size_sm#"/>
				</cfoutput>

		<!--- UPLOAD FORM: Do we display an image, the default, or some text? --->
		<cfif FileExists('#FullImagePath#sm_#TheImage#')>
			<td>
			<cfoutput><a href="#URLToImageDir##subdir##TheImage#" target="image"></cfoutput>
			<cfmodule template="../../../customtags/putimage.cfm" filename="sm_#TheImage#" hspace="3" vspace="2" imgbase="#URLToImageDir##subdir#" filealt="#TheImage#"></a>
			</td>
		<cfelseif FileExists('#FullImagePath##TheImage#')>
			<td>	
			<cfmodule template="../../../customtags/putimage.cfm" filename="#TheImage#" hspace="3" vspace="2" imgbase="#URLToImageDir##subdir#" filealt="#TheImage#">
			</td>
		<cfelseif FileExists('#FullImagePath##defaultImage#')>
			<td>
			<cfmodule template="../../../customtags/putimage.cfm" filename="#defaultImage#" hspace="3" vspace="2" imgbase="#URLToImageDir##subdir#" filealt="#TheImage#">
			</td>
		<cfelse>
			<td>
			<cfoutput><img src="images/spacer.gif" alt="" width="56" height="1" /></cfoutput>
			</td>
		</cfif>
			
			
		<!--- UPLOAD FORM: Upload buttons --->
			<td style="width:330px;" valign="top">	
			<cfif not len(TheImage)>
				<cfoutput>
				<span class="formtextsmall">Select the full size image file:<br/></span>
				<input type="File" name="Photo_#TheRecordID#" class="formfield" size="30"/><br/>
				<span class="formtextsmall">Save to this subdirectory under #Request.AppSettings.DefaultImages#/products:<br/></span>
				<input type="text" name="subdir" value="" class="formfield" size="30" maxlength="100"><br/><br/>
				<cfif len(size_sm)>
				<span class="formtextsmall">OPTIONAL: A #size_sm#px thumbnail image will be automatically created, or you wish to upload your own thumbail image please select a small image file:
				<br/></span>
				<input type="File" name="Photo_SM_#TheRecordID#" class="formfield" size="30"/>	<br/>
				</cfif>
				
Gallery: <input type="radio" name="gallery" value="Public" checked="checked" />public 
		<input type="radio" name="gallery" value="Private" />private<br/>

Priority: <input type="text" name="Priority" value="0" size="4" class="formfield"> <span class="formtextsmall">(1 is highest, 0 is none)</span><br/>
<input type="text" name="caption" value="enter photo caption..." class="formfield" size="30" maxlength="100" onfocus="UploadForm_#TheRecordID#.caption.value = '';" />
			<input type="submit" name="UploadImageButton_#TheRecordID#" class="formbutton" value="Upload" style="width:50px;"
 onclick="if(UploadForm_#TheRecordID#.caption.value=='enter photo caption...'){UploadForm_#TheRecordID#.caption.value = '';} return; LimitAttach(this.form, this.form.Photo_#TheRecordID#.value)" />
				</cfoutput>
		
		<!--- EDIT FORM: Update & Delete buttons --->
			<cfelse>
				<cfoutput>
Gallery: <input type="radio" name="gallery" value="Public" #doChecked(GetRecordImages.gallery,'Public')#  />public  
		<input type="radio" name="gallery" value="Private" #doChecked(GetRecordImages.gallery,'Private')# />private<br/>

Priority: <input type="text" name="Priority" value="#doPriority(GetRecordImages.Priority,0)#" size="4" class="formfield"/> 
<span class="formtextsmall">(1 is highest, 0 is none)</span><br/>
		<input type="text" name="caption" value="#GetRecordImages.caption#" class="formfield" size=30 maxlength="100"/> 
		<input type="submit" name="EditImageButton_#TheRecordID#" value="Update" class="formbutton"/>		
		<input type="submit" name="DeleteImageButton_#TheRecordID#" value="Delete" class="formbutton"/>		

				</cfoutput>
			</cfif>
			</td>

		<!--- [3] UPLOAD FORM: End the form --->
			</form>
		</tr>

<!--- [2] End Form layout table--->
	</table>


	
<!--- ----------------------------------------------------------------------------------
	UPLOAD THE IMAGE

	If the user has clicked on the 'Delete' button, we check the database
	for an existing entry. If one exists, we check the hard drive to see if
	a file with the same name (but not the default) exists then remove it.
	We then delete the database entry.

	If the user has clicked the 'Upload' button we go though the same routine,
	then proceed to upload the image. Small, medium and large versions of the image are
	are created IF the size attributes are not zero. Once on the server, we rename it with
	the records's ID and the original file extension. We then update the database
	with the file name, and refresh the page.
------------------------------------------------------------------------------------ --->


<!--- [4] Process if the user has clicked either the 'upload' or the 'delete' button --->
	<cfif isdefined("Form.UploadImageButton_#TheRecordID#") or isdefined("Form.DeleteImageButton_#TheRecordID#")>

	<!--- Determine what we will run, based on the user's choice of buttons. --->
		<cfif isdefined("Form.UploadImageButton_#TheRecordID#")>
			<cfset DoSomeWork="UploadImage">
		<cfelseif isdefined("Form.DeleteImageButton_#TheRecordID#")>
			<cfset DoSomeWork="DeleteImage">
		</cfif>
		
		<!--- [5] Check to see if there is there is a record to edit --->
		<cfif GetRecordImages.RecordCount GTE 1>
			

			<!--- [7] If there is an entry in the database, and it's not an entry for the default image. --->
			<cfif "#PathToImageDir##TheImage#" NEQ "#PathToImageDir##defaultImage#">
				
				<!--- Add any subdirectory to the full image path, make sure slashes correct for the server type --->
				<cfset FullImagePath = PathToImageDir & ReReplace(subdir, "[\\\/]", Request.slash, "ALL")>

				<!--- Now we check for the existence of the file prior to deleting it. --->
				<cfif FileExists('#FullImagePath##TheImage#')>
					<cffile action="DELETE" File="#FullImagePath##TheImage#">
				</cfif>
				
				<cfif FileExists('#FullImagePath#sm_#TheImage#')>
					<cffile action="DELETE" File="#FullImagePath#sm_#TheImage#">
				</cfif>
					
				<cfif FileExists('#FullImagePath#med_#TheImage#')>
					<cffile action="DELETE" File="#FullImagePath#med_#TheImage#">
				</cfif>
					
				<cfif FileExists('#FullImagePath#lg_#TheImage#')>
					<cffile action="DELETE" File="#FullImagePath#lg_#TheImage#">
				</cfif>
							
			<!--- [7] End if --->
			</cfif>

			
			<!--- [10] The file is gone, remove its reference from local table.--->
				<cfif TheTableType EQ "Local">

					<cfquery name="DeleteImages" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
						UPDATE #TheTableName# SET
						#TheFileColumnName#=''
						WHERE #TheKeyColumnName#=#TheRecordID#
						</cfquery>

			<!--- [10] Else if: Delete from foreign table --->
				<cfelseif TheTableType EQ "Foreign">

					<cfquery name="DeleteImages" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
						DELETE FROM #TheTableName#
						WHERE #TheKeyColumnName#=#TheRecordID#
						</cfquery>

			<!--- [10] End if --->
				</cfif>

	<!--- [5] End if record check --->
		</cfif>


		
	<!--- [8] The user has clicked 'UploadFileButton', process the new file. --->
		<cfif DoSomeWork EQ "UploadImage">
			
			<!--- Check if a subdirectory was entered --->			
			<cfset attributes.subdir = Trim(form.subdir)>
			<cfif len(attributes.subdir)>
				<cfset PathToImageDir = PathToImageDir & ReReplace(attributes.subdir, "[\\\/]", Request.slash, "ALL")>
			</cfif>
		
			<!--- If directory does not exist yet, create it --->
			<cfif NOT DirectoryExists("#PathToImageDir#")>
				<cfdirectory action="CREATE" directory="#PathToImageDir#">
			</cfif>
			
			<!--- Check if we are uploading to a temp directory --->
			<cfif len(PathToTempDir)>
				<cfset UploadDir = PathToTempDir>
			<cfelse>
				<cfset UploadDir = PathToImageDir>
			</cfif>
		
			<!--- [9] Upload the image file and set its location to a variable --->
			<cfif WebReadyCheck EQ "Yes">
				<cftry>
					<cffile action="UPLOAD"
						filefield="Photo_#trim(TheRecordID)#"
						destination="#UploadDir#"
						nameconflict="MAKEUNIQUE"
						attributes="Normal"
						accept="image/gif,image/jpeg,image/pjpeg,image/png"
						mode="777">
					<cfcatch>
						<div style="formerror">
						<h1>Error!</h1>
						<p>The image was NOT uploaded. Only images ending in '<strong>.gif</strong>' or '<strong>.jpg</strong>' can be reliably used on the web.</p>
						<p>Please convert your image before uploading it.<br/>(Simply changing the file extension won't help. The image file itself must be converted. Recommendation: GIF or JPEG in RGB mode at 72 DPI. If this is mysterious to you, please email us.)</p>
						</div>
						<cfexit>
					</cfcatch>
				</cftry>

		<!--- [9] Else --->
			<cfelse>
				<cffile action="UPLOAD"
					filefield="Photo_#trim(TheRecordID)#"
					destination="#UploadDir#"
					nameconflict="OVERWRITE"
					attributes="Normal"
					accept="image/gif,image/jpeg,image/pjpeg,image/png"
					mode="777">

		<!--- [9] End if --->
			</cfif>
			
			<!--- [8a] Verify that the image uploaded has a valid image extension. If so, and a temp directory used, move it to the image directory --->
			<cfif ListFindNoCase("gif,jpg,jpeg,png,bmp",File.ServerFileExt)>
				
				<!--- If temp directory used, move the file --->
				<cfif len(PathToTempDir)>
					<cffile action="move" source="#UploadDir##request.slash##File.ServerFile#" destination="#PathToImageDir##request.slash##File.ServerFile#">
				</cfif>
				
				<!---===================== Database Entry ======================--->		
				<!--- Build the name of the image file: Subdirectory + Filename + Record ID + file extension (image_241.jpg) --->	
					
				<cfif len(attributes.subdir)>
					<!--- Set slashes to forward slash only --->
					<cfset attributes.subdir = Replace(attributes.subdir, "\", "/", "ALL")>
					<!--- Make sure there is a trailing slash --->
					<cfif Right(attributes.subdir,1) IS NOT "/">
						<cfset attributes.subdir = attributes.subdir & "/">
					</cfif>
				</cfif>
					
				<!--- [11] Update the file column for the record with the just-constructed image file name. --->
					<cfif TheTableType EQ 'Local'>
					
						<cfset Photo="#attributes.subdir##Trim(TheRecordID)#_#TheFileColumnName#.#Trim(File.ServerFileExt)#">
						
						<cfquery name="AddImageToRecord" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
							UPDATE #TheTableName# SET
							#TheFileColumnName#='#Photo#'
							WHERE #TheKeyColumnName#=#TheRecordID#
							</cfquery>
		
						<cfset New_name = "#Trim(TheRecordID)#_#TheFileColumnName#">
		
				<!--- [11] Else if --->
					<cfelseif TheTableType EQ 'Foreign'>
						
						<cfif NOT isNumeric(attributes.Priority) OR attributes.Priority IS 0>
							<cfset attributes.Priority = 9999>
						</cfif>
		
						<cftransaction isolation="SERIALIZABLE">
						
							<!--- get record id --->
						    <cfquery name="New_ID" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
								SELECT MAX(#TheKeyColumnName#) AS maxid 
								FROM #TheTableName#
							</cfquery>
								
							<!----------->	
							<cfif New_ID.maxid gt 0>
								<cfset Key_Number = new_id.maxid + 1>
							<cfelse>
								<cfset Key_Number = 1>
							</cfif>
					
							<cfset New_name = "#ListGetAt(Trim(File.ServerFile), 1, ".")#_#Key_Number#">
							
							<cfset Photo = "#attributes.subdir##New_name#.#Trim(File.ServerFileExt)#">
			
							<!--- Insert a new record into the image table --->
							<cfquery name="AddImageToRecord" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
								INSERT INTO #TheTableName#
								(#TheFileColumnName#, #TheKeyColumnName#, Product_ID, Gallery, Caption, Priority, File_Size)
								VALUES 
								('#Photo#', #Key_Number#, #attributes.product_id#, '#attributes.gallery#', 
								'#attributes.caption#', #attributes.priority#, #File.filesize#)
								</cfquery>
			
						</cftransaction>
						
				<!--- [11] End if--->
					</cfif>		
					
					
				<!---============ RENAME  =================================---->	
				<!--- Build the server source name for the file we've just uploaded --->
					<cfset SourceFile="#PathToImageDir##request.slash##Trim(File.ServerFile)#">
		
				<!--- Build the new name and path for the file we've just uploaded. --->
					<cfset DestinationFile="#PathToImageDir##request.slash##new_name#.#Trim(File.ServerFileExt)#">
					
				<!--- Rename the uploaded image file (now on the server) to the parent record's ID --->
					<cffile
						Action="Rename"
						Source="#SourceFile#"
						Destination="#DestinationFile#"
						attributes="Normal"
						mode="777">
						
		
		
				<!---============ THUMBNAIL =================================-----
				If a thumbnail image file has been submitted, upload the image and rename to "sm_imagefile.ext".
				If no image file, auto-create small, medium and large version of the image using the cfx_image
				tag which must be installed on the server.
				---->	
		
				<cfif len(evaluate("form.Photo_SM_" & TheRecordID))>
				
					<!--- [11] Upload the image file and set its location to a variable --->
					<cfif WebReadyCheck EQ "Yes">
						<cftry>
							<cffile action="UPLOAD"
								filefield="Photo_SM_#trim(TheRecordID)#"
								destination="#UploadDir#"
								nameconflict="MAKEUNIQUE"
								attributes="Normal"
								accept="image/gif,image/jpeg,image/pjpeg,image/png"
								mode="777">
							<cfcatch>
								<div style="formerror">
								<h1>Error!</h1>
								<p>The small image was NOT uploaded. Only images ending in '<strong>.gif</strong>' or '<strong>.jpg</strong>' can be reliably used on the web.</p>
								<p>Please convert your image before uploading it.<br/>(Simply changing the file extension won't help. The image file itself must be converted. Recommendation: GIF or JPEG in RGB mode at 72 DPI. If this is mysterious to you, please email us.)</p>
								</div>
								<cfexit>
							</cfcatch>
						</cftry>
		
				<!--- [9] Else --->
					<cfelse>
						<cffile action="UPLOAD"
							filefield="Photo_SM_#trim(TheRecordID)#"
							destination="#UploadDir#"
							nameconflict="OVERWRITE"
							attributes="Normal"
							accept="image/gif,image/jpeg,image/pjpeg,image/png"
							mode="777">
		
				<!--- [9] End if --->
					</cfif>
					
					<!--- [11a] Verify that the image uploaded has a valid image extension. If so, and a temp directory used, move it to the image directory --->
					<cfif ListFindNoCase("gif,jpg,jpeg,png,bmp",File.ServerFileExt)>
					
						<!--- If temp directory used, move the file --->
						<cfif len(PathToTempDir)>
							<cffile action="move" source="#UploadDir##request.slash##File.ServerFile#" destination="#PathToImageDir##request.slash##File.ServerFile#">
						</cfif>
				
						<!--- Build the server source name for the file we've just uploaded --->
							<cfset SourceFile="#PathToImageDir##request.slash##Trim(File.ServerFile)#">
				
						<!--- Build the new name and path for the file we've just uploaded. --->
							<cfset DestinationFile="#PathToImageDir##request.slash#sm_#new_name#.#Trim(File.ServerFileExt)#">
							
						<!--- Rename the uploaded image file (now on the server) to the parent record's ID --->
							<cffile
								Action="Rename"
								Source="#SourceFile#"
								Destination="#DestinationFile#"
								attributes="Normal"
								mode="777">
								
						
						
						<!--- [11a] End if - Check file extension for thumbnail file --->
						<cfelse>
						<cffile action="DELETE" File="#UploadDir##request.slash##File.ServerFile#">	
						<div style="formerror">
						<h1>Error!</h1>
						<p>The thumbnail image was NOT uploaded. A valid image extension was not found.</p>
						<p>Please convert your image before uploading it.<br/>(Simply changing the file extension won't help. The image file itself must be converted. Recommendation: GIF or JPEG in RGB mode at 72 DPI. If this is mysterious to you, please email us.)</p>
						</div>
						<cfexit>
					</cfif>
								
								
					<cfelse><!--- Auto-create thumbails ---->
					
							
						<!--- Create thumbnail image if thumbsize is not blank ----->
						<cfif len(form.size_sm) and form.size_sm gt 0>
						
							<cftry>
							
								<!--- 	<cfx_image action="iml"
								file="#DestinationFile#"
								commands="
								resize #form.size_sm#
								write #Trim(File.ServerDirectory)##request.slash#sm_#new_name#.#Trim(File.ServerFileExt)#							
								">  --->
								<cfscript>
								imageCFC = CreateObject("component", "#Request.CFCMapping#.tags.imageCFC.image");
								newImage = '#PathToImageDir##request.slash#sm_#new_name#.#File.ServerFileExt#';
								imageCFC.resize('', DestinationFile, newImage, form.size_sm, 0);
								</cfscript>		
							<cfcatch>
								<div style="formerror">
								<h1>Error!</h1>
								<p>The small image was NOT uploaded. Your server may not allow use of CFC objects.</p>
								</div>
								<cfexit>
							</cfcatch>
							</cftry>
											
						</cfif>		
							
						<!--- Create thumbnail image if size_med is not blank ----->
						<cfif len(size_med)>			
						
							<cftry>
								
								<!--- <cfx_image action="iml"
								file="#DestinationFile#"
								commands="
									resize #size_med#
									write #Trim(File.ServerDirectory)##request.slash#med_#new_name#.#Trim(File.ServerFileExt)#							
								"> --->
								<cfscript>
								imageCFC = CreateObject("component", "#Request.CFCMapping#.tags.imageCFC.image");
								newImage = '#PathToImageDir##request.slash#med_#new_name#.#File.ServerFileExt#';
								imageCFC.resize('', DestinationFile, newImage, size_med, 0);
								</cfscript>	
							<cfcatch>
								<div style="formerror">
								<h1>Error!</h1>
								<p>The medium image was NOT uploaded. Your server may not allow use of CFC objects.</p>
								</div>
								<cfexit>
							</cfcatch>
							</cftry>
							
						</cfif>		
					
					
						<!--- Create large image if size_lg is not blank ----->
						<cfif len(size_lg)>			
							
							<cftry>
								<!--- <cfx_image action="iml"
								file="#DestinationFile#"
								commands="
								resize #size_lg#
								write #Trim(File.ServerDirectory)##request.slash#lg_#new_name#.#Trim(File.ServerFileExt)#							
								">  --->
								<cfscript>
								imageCFC = CreateObject("component", "#Request.CFCMapping#.tags.imageCFC.image");
								newImage = '#PathToImageDir##request.slash#lg_#new_name#.#File.ServerFileExt#';
								imageCFC.resize('', DestinationFile, newImage, size_lg, 0);
								</cfscript>	
							<cfcatch>
								<div style="formerror">
								<h1>Error!</h1>
								<p>The large image was NOT uploaded. Your server may not allow use of CFC objects.</p>
								</div>
								<cfexit>
							</cfcatch>
							</cftry>
						
						</cfif>		
					    
						<!--- Resize Image if too large: USES maximum width ----->
						<cfif len(size_max)>				
							<cftry>					
								<!--- <cfx_image action="iml"
								file="#DestinationFile#"
								commands="
								resizeif #size_max#,-1,#size_max#
								write #Trim(File.ServerDirectory)##request.slash##new_name#.#Trim(File.ServerFileExt)#
								">	 --->	
								<cfscript>
								imageCFC = CreateObject("component", "#Request.CFCMapping#.tags.imageCFC.image");					
								newImage = '#PathToImageDir##request.slash##new_name#.#File.ServerFileExt#';
								imgInfo = imageCFC.getImageInfo("", newImage);
								//check if width or height are over the the maximum
								if (imgInfo.height GT size_max OR imgInfo.width GT size_max) {
									imageCFC.resize('', DestinationFile, newImage, size_max, size_max, 'true');
									}
								</cfscript>
							<cfcatch>
								<div style="formerror">
								<h1>Error!</h1>
								<p>The fullsize image was NOT uploaded. Your server may not allow use of CFC objects.</p>
								</div>
								<cfexit>
							</cfcatch>
							</cftry>
							
						</cfif>		
						
					</cfif>
					
			<!--- [8a] End if - Check file extension for primary file --->
			<cfelse>
			<cffile action="DELETE" File="#UploadDir##request.slash##File.ServerFile#">	
			<div style="formerror">
			<h1>Error!</h1>
			<p>The image was NOT uploaded. A valid image extension was not found.</p>
			<p>Please convert your image before uploading it.<br/>(Simply changing the file extension won't help. The image file itself must be converted. Recommendation: GIF or JPEG in RGB mode at 72 DPI. If this is mysterious to you, please email us.)</p>
			</div>
			<cfexit>
		</cfif>
		
			
	<!--- [8] End if - Upload file --->
	</cfif>

	<!--- Redirect the user to the referring document. --->
	<cfheader statusCode="302" statusText="Document Moved">
	<cfheader name="location" value="#Referrer#">
	
	<!--- NOt upload or delete... IF EDIT RECORD ---->
	<cfelseif isdefined("Form.EditImageButton_#TheRecordID#")>
	
		<cfif NOT isNumeric(attributes.Priority) OR attributes.Priority IS 0>
			<cfset attributes.Priority = 9999>
		</cfif>
	
		<cfquery name="AddImageToRecord" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
		UPDATE #TheTableName# SET
		Caption = <cfif len(attributes.caption)>'#Trim(attributes.caption)#',<cfelse>NULL,</cfif>
		Gallery = '#attributes.gallery#',
		Priority = '#attributes.priority#'
		WHERE #TheKeyColumnName#=#TheRecordID#
		AND Product_ID = #attributes.Product_ID#
		</cfquery>

		<!--- Redirect the user to the referring document. --->
		<cfheader statusCode="302" statusText="Document Moved">
		<cfheader name="location" value="#Referrer#">

<!--- [4] UPLOAD ACTION: End if --->
	</cfif>


<!--- // End of document // --->