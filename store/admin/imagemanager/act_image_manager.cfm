
<!--- This is an Image Manager used to view, upload and select images on admin forms throughout the site. The selected image is placed in the calling form field.
 
Usage in forms for IMAGES: 

<a href="JavaScript: newWindow = openWin('#self#?fuseaction=home.admin&select=image&fieldname=Sm_Title&fieldvalue=#attributes.Sm_Title#', 'images', 'width=520,height=290,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=0,resizable=1'); newWindow.focus()" class="formtextsmall">Image Manager</a>

Usage for DOWNLOAD FILES: 

<a href="JavaScript: newWindow = openWin('#self#?fuseaction=home.admin&select=image&type=Download&fieldname=content_url&fieldvalue=#attributes.content_url#', 'images', 'width=520,height=290,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=0,resizable=1'); newWindow.focus()" class="formtextsmall">File Manager</a>

Note: 
	"&formname=editform" is optional, it defaults to "editform" 
	"&dirname=/products" is optional. NOTE: the directory must begin with a /. For images it defaults to the image root set in the admin settings, for downloads it defaults to the download directory. The directory in fieldvalue takes precidence.
	"&type=download" can be used to manage the downloads directory.
--->

<!--- Set top directory depending on TYPE: images or downloads ---->
<cfparam name="attributes.type" default="Image">

<!--- Used to prevent deletes on satellite connections --->
<cfparam name="attributes.dotheDelete" default="no">

<!--- If user ID passed in, restrict to that directory --->
<cfparam name="attributes.user" default="">
<cfif len(attributes.user) AND attributes.user is NOT 0>
	<cfparam name="attributes.topdir" default="#request.appsettings.defaultimages#/User#attributes.User#">
<cfelse>
	<cfparam name="attributes.topdir" default="#request.appsettings.defaultimages#">
</cfif>

<!--- If store in demo mode, only allow images --->
<cfif Request.DemoMode>
	<cfset attributes.type = "image">
</cfif>

<!--- If using FCKEditor file upload, change to file directory --->
<cfif attributes.type IS "file">
	<cfset attributes.topdir = Replace(attributes.topdir, request.appsettings.defaultimages, "files")>
</cfif>

<!--- Process variables passed in query string: ----->
<cfparam name="attributes.fieldvalue" default="">

<cfscript>
	if (len(attributes.fieldvalue)) {
		if (listlen(attributes.fieldvalue,'/') gt 1) {
			attributes.filename = listlast(attributes.fieldvalue,'/');
			attributes.dirname = "/" & Replace(attributes.fieldvalue,'/'&attributes.filename,'');
			}
		else {
			attributes.filename = attributes.fieldvalue;
			attributes.dirname = '';
			}
		attributes.do = 'viewimage';
	
	}
</cfscript>

<cfparam name="attributes.fieldname" default="">
<cfparam name="attributes.fieldname2" default="">
<cfparam name="attributes.formname" default="editform">
<cfparam name="attributes.dirname" default="">

<cfparam name="attributes.do" default="">

<cfscript>
	//URLDecode the dirname
	attributes.dirname = URLDecode(attributes.dirname);
	
	//Set current web address
	SiteAddress = Request.StoreURL;
	ImagePath = attributes.topdir;
	ImageUrl= ImagePath & attributes.dirname;
	
	//Set URL for running the image manager functions
	actionURL = "#request.self#?fuseaction=home.admin&select=image&fieldname=#attributes.fieldname#";
	actionURL = actionURL & "&fieldname2=#attributes.fieldname2#&formname=#attributes.formname#&user=#attributes.user#";
	
	if (len(attributes.topdir))
		actionURL = actionURL & "&topdir=" & URLEncodedFormat(attributes.topdir);
	
	if (attributes.type neq 'image')
		actionURL = actionURL & "&type=" & attributes.type;
		
		
	//Point to images directory
	TopDirectory = GetDirectoryFromPath(ExpandPath("*.*"));
	theDirectory = TopDirectory & ImagePath & attributes.dirname;
	
	//set the acceptable mime and file types
	if (attributes.type IS "Image") {
		mimetypes = "image/gif, image/jpeg, image/pjpeg, image/png";
		showfiletypes = "jpg,jpeg,gif,png,pdf";
		}
	else if (attributes.type IS "PDF") {
		mimetypes = "application/pdf";
		showfiletypes = "pdf";
		}
	else if (attributes.type IS "flash") {
		mimetypes = "application/x-shockwave-flash";
		showfiletypes = "swf";
		}
	else if (attributes.type IS "file") {
		mimetypes = "image/gif, image/jpeg, image/pjpeg, image/png, application/msword, application/pdf, application/powerpoint, application/x-excel, application/zip, text/plain";
		showfiletypes = "jpg,jpeg,gif,png,pdf,doc,mov,ppt,zip,txt,xls";
		}
	else {
	//Point to downloads directory
	//check for user-level access only and upload to that user's directory only
		if (len(attributes.user) AND attributes.user is NOT 0)
			theDirectory = Request.DownloadPath & Request.Slash & 'User' & attributes.user & attributes.dirname;
		else
			theDirectory = Request.DownloadPath & attributes.dirname;
			
		mimetypes = Request.MimeTypes;
		showfiletypes = Request.AllowExtensions;
		}
	
	
	if (Right(theDirectory, 1) IS NOT Request.Slash)
		theDirectory =  theDirectory & Request.Slash;
	
	// Make sure file path is correct for the server<br>
	theDirectory = ReReplace(theDirectory, "[\\\/]", Request.slash, "ALL");
</cfscript>

<!--- Display either entire Manager window or just directory listing iframe --->
<cfparam name="attributes.dirlist" default="0">

<!--- Entire Manager ---->
<cfif attributes.dirlist neq 1>

	<!--- Do some processing if necessary... --->
		
	<!--- Create New Directory --->
	<cfif parameterexists(newfolder)>
		<cftry>
			<cfdirectory action="CREATE" directory="#theDirectory##request.slash##foldername#">
			<cfset attributes.do="">
		<cfcatch type="Any">
			<cfset attributes.do="newfolder">
			<cfset message = "There was a problem creating the new folder. Make sure that CFDIRECTORY is enabled on your server and that you have entered a valid folder name.">
		</cfcatch>
		</cftry>
	</cfif>
	
	<!--- Delete a file --->
	<cfif attributes.do is "delimage" AND attributes.dotheDelete is "yes">
		<cftry>
			<cfif FileExists('#theDirectory##request.slash##attributes.fn#')>
				<cffile action="DELETE" File="#theDirectory##request.slash##attributes.fn#">
			</cfif>
			<cfset attributes.do="">
		<cfcatch type="Any">
			<cfset attributes.do="">
			<cfset message = "There was a problem deleting this file. Make sure that CFFILE is enabled on your server and that you have the proper permissions.">
		</cfcatch>
		</cftry>
	</cfif>
	
	<!--- Upload the file --->
	<cfif parameterexists(newimage)>
		<cfset attributes.do="viewimage">
		<cftry>
			<!--- Check if there is a temp upload directory set --->
			<cfif len(Request.TempPath)>
				<cfset UploadDir = Request.TempPath>
			<cfelse>
				<cfset UploadDir = theDirectory>
			</cfif>
			
			<cffile action="UPLOAD" filefield="FileName" destination="#UploadDir#" nameconflict="OVERWRITE" accept="#mimetypes#">
			<cfset attributes.filename = File.ServerFile>
			
			<!--- Check that the file extension is in the allowed list before continuing. --->
			<cfif ListFindNoCase(showfiletypes,File.ServerFileExt)>
			
				<!--- If temp directory used, move the file --->
				<cfif len(Request.TempPath)>
					<cffile action="move" source="#UploadDir##request.slash##File.ServerFile#" destination="#theDirectory##request.slash##File.ServerFile#">
				</cfif>
				
				<!--- Thumbnail and resize of images ----->
				<cfif attributes.type is "image">	
					<cfset photo = "#SpanExcluding(File.ServerFile,'.')#">
					<cfset photo_ext = "#File.ServerFileExt#">
					
					<!--- If image is a gif, save to png --->
					<cfif CompareNoCase(photo_ext, "gif") IS 0>
						<cfset photo_ext = "png">
					</cfif>
	
					<!--- Create Thumbmail Image if desired ----->
					<cfif len(attributes.thumbnail)>
					
						<cftry>
					
						<cfscript>
						imageCFC = CreateObject("component", "#Request.CFCMapping#.tags.imageCFC.image");
						currImage = '#theDirectory##request.slash##File.ServerFile#';
						newImage = '#theDirectory##request.slash##photo#_#attributes.thumbnail#.#photo_ext#';
						imageCFC.resize('', currImage, newImage, attributes.thumbnail, 0);
						</cfscript>
										
						<!--- Version for CF8
						<cfimage action="read" source="#theDirectory##request.slash##File.ServerFile#" name="objImage">
						<cfset ImageResize(objImage, attributes.thumbnail, "")>
						<cfset ImageWrite(objImage, "#theDirectory##request.slash##photo#_#attributes.thumbnail#.#photo_ext#")>
						 --->
						
						<cfcatch type="Any">
							<cfthrow type="CFCError">
						</cfcatch>
						</cftry>
						
					</cfif>
					
					<!--- Resize image if requested --->
					<cfif len(attributes.resizeW) OR len(attributes.resizeH)>
					
						<!--- Comment these out if using the alternate CF 8 code! --->
						<cfif NOT len(attributes.resizeW)>
							<cfset attributes.resizeW = 0>
						</cfif>
						<cfif NOT len(attributes.resizeH)>
							<cfset attributes.resizeH = 0>
						</cfif>
						
						<cftry>
						<cfscript>
						imageCFC = CreateObject("component", "#Request.CFCMapping#.tags.imageCFC.image");
						currImage = '#theDirectory##request.slash##File.ServerFile#';
						newImage = '#theDirectory##request.slash##photo#_#attributes.resizeW#.#photo_ext#';
						imageCFC.resize('', currImage, newImage, attributes.resizeW, attributes.resizeH, 'true');
						</cfscript>
						
						<!--- Version for CF8 (be sure to comment out lines 195-200 above as well)
						<cfimage action="read" source="#theDirectory##request.slash##File.ServerFile#" name="objImage">
						<cfset ImageResize(objImage, attributes.resizeW, attributes.resizeH)>
						<cfset ImageWrite(objImage, "#theDirectory##request.slash##photo#_#attributes.resizeW#.#photo_ext#")>
						 --->
						 
						<cfcatch type="Any">
							<cfthrow type="CFCError">
						</cfcatch>
						</cftry>
							
						<!--- Remove original image  --->
						<cfif NOT isdefined("attributes.leavefile")>
							<cfif FileExists('#theDirectory##request.slash##photo#.#photo_ext#')>
								<cffile action="DELETE" File="#theDirectory##request.slash##photo#.#photo_ext#">
							</cfif>
						
							<cfset attributes.filename = replace(File.ServerFile,'.#photo_ext#','_#attributes.resizeW#.#photo_ext#')>
						</cfif>
										
					</cfif>
				
				</cfif><!--- image file check --->
				
			<!--- File extension not allowed --->
			<cfelse>
				<cfset message = "There was a problem with your upload. Make sure that you are uploading an appropriate file type.">
				<cffile action="DELETE" File="#UploadDir##request.slash##File.ServerFile#">		
				<cfset attributes.do = "error">
			</cfif>
	
		
		<cfcatch type="CFCError">
			<cfset message = "There was a problem with resizing your images. <br>Make sure that your server allows CFC object instantiation.<br>If you are running on ColdFusion 8 you may need to edit the image function to use the alternate cfimage tags.">
			<cfset attributes.do = "error">
		</cfcatch>
		<cfcatch type="Any">
			<cfset message = "There was a problem with your upload. Make sure that CFFILE is enabled on your server and that you are uploading an appropriate file type.">
			<cfset attributes.do = "error">
		</cfcatch>
		</cftry>

	</cfif>

<cfheader name="Expires" value="#Now()#">
		

	<cfoutput>
	<cfprocessingdirective suppresswhitespace="no">
	<script type="text/javascript">
	function updatefieldname(image){
	<cfif attributes.fieldname is "fckeditor">
		fullimage = '#Request.StorePath##attributes.topdir#/' + image ;
		window.opener.SetUrl( fullimage ) ;
	<cfelse>	
		window.opener.document.#attributes.formname#.#attributes.fieldname#.value=image;
		//window.opener.parent.AdminContent.document.#attributes.formname#.#attributes.fieldname#.value=image;
	</cfif>
		window.close();
	     }
		 
	function SizeWindow() { 
       window.resizeTo(530, 345); 
       self.focus(); 
		}	
	</script>
</cfprocessingdirective>
	</cfoutput>



	
	<cfset onload="SizeWindow();">	
	
<cfoutput>
<table width="100%" border="0" cellspacing="0" cellpadding="2" class="formtext" style="border: 1px solid ###Request.GetColors.InputHBgcolor#;">
	<tr bgcolor="###Request.GetColors.InputHBgcolor#">
		<th align="left" class="boxtitle" colspan="2">
			<font color="###Request.GetColors.InputHText#">#attributes.type# Manager &nbsp;&nbsp;&nbsp;&nbsp;<img src="#request.appsettings.defaultimages#/icons/openfolder.gif" alt="Open Folder" border="0" align="bottom" /><span style="font-size:12px">#attributes.dirname#<cfif isdefined("attributes.filename")>/#attributes.filename#</cfif></span></font>
		</th>
	</tr>
	<tr >
		<td width="150" rowspan="3" valign="top">
		<iframe src="#actionURL#&dirlist=1&dirname=#URLEncodedFormat(attributes.dirname)##Request.AddToken#" frameborder="0" width="150" height="250"></iframe>
		</td>
		<td align="right" height="20"><a href="#actionURL#&do=newfolder&dirname=#attributes.dirname#" #doMouseover('Create New Folder')#><img src="#request.appsettings.defaultimages#/icons/trimfolder.gif" alt="" border="0" align="bottom" /> <strong>New Folder</strong></a> &nbsp; <a href="#actionURL#&do=newimage&dirname=#attributes.dirname#" #doMouseover('Upload New #attributes.type#')#><img src="#request.appsettings.defaultimages#/icons/trimimage.gif" alt="" border="0" /> <strong>New #attributes.type#</strong></a> &nbsp;</td>
	</tr>

	<tr>
    	<td align="center"  height="200">
		<cfif isdefined('message')><div class="formerror">#message#</div></cfif>
		
<!--- Error, leave blank --->
	<cfif attributes.do is "error">
	

<!--- Welcome message ---->		
	<cfelseif attributes.do is "">
	
		<div align="center" >Choose a file from the directory<br/> or upload a new <cfif attributes.type is "image">image<cfelse>file</cfif>.<br/><br/><br/></div>

<!--- New Image ---->		
	<cfelseif attributes.do is "newimage">
	
	<table width="80%" border="0" align="center" ><tr><td>
	<form action="#ActionURL#&newimage=1&dirname=#attributes.dirname#" method="post" enctype="multipart/form-data">
	<b>Select <cfif attributes.type is "image">Image<cfelse>File</cfif> to Upload:</b><br/> <input type="file" name="FileName" size="35" class="formfield"/>
	</td></tr>
		
	<cfif attributes.type is "image">	
	<tr><td class="formtextsmall"><br/><strong>ADDITIONAL OPTIONS:</strong></td></tr>
	
	<tr><td class="formtext">	
	Create a thumbnail 
	<input type="text" name="thumbnail" size="4" maxlength="4" value="" class="formfield"/> pixels wide
	</td></tr>
	<tr><td class="formtext">	
	Resize image to 
	<input type="text" name="resizeW" size="4" maxlength="4" class="formfield" value=""/> wide by <input type="text" name="resizeH" size="4" maxlength="4" class="formfield" value=""/> high
	</td></tr>
	<tr><td class="formtextsmall">	
	Entering only one dimension will resize image to scale.
	<br/>Note: Only jpeg and png files can be resized (gifs will be saved as pngs if resized)
	<br/>Check to leave original file on server after resize: <input type="checkbox" name="leavefile" value="1"/></td></tr>	

	</cfif>
	
	<tr><td>	
	<input type="submit" value="Upload" class="formbutton"/>
	</form><br/><br/>
	</td></tr></table>	
	
		</td>
	</tr>
	
<!--- New Folder ---->			
	<cfelseif attributes.do is "newfolder">
	
	<table width="80%" border="0"  align="center"><tr><td>
	<form action="#ActionURL#&do=newfolder&dirname=#attributes.dirname#" method="post">
	<b>Folder Name:</b><br/> <input type="text" class="formfield" size="30" name="foldername"/>
	<br/><br/>
	<input class="formbutton" type="submit" name="newfolder" value="Create Folder"/>
	</form><br/><br/>
	</td></tr></table>	
	
			</td>
	</tr>
	
<!--- View Image ---->	
	<cfelseif attributes.do is "viewimage">
	
		<cfif attributes.type is "image">
			<iframe src="#imageurl#/#attributes.filename#" width="350" height="200" frameborder="0"></iframe>

		<cfelse>
			<!--- Display file information ---->
			<cfdirectory action="LIST" directory="#theDirectory#" name="getfile" filter="#attributes.filename#">
			<table width="80%" border="0" cellspacing="2" class="formtext">
			<cfloop query="getfile">
			<tr><td align="right" width="35%">Name: &nbsp;</td>
				<td width="65%"><strong>#getfile.name#</strong></td></tr>
			<tr><td align="right">Size: &nbsp;</td><td>#getfile.size#</td></tr>
			<tr><td align="right">Type: &nbsp;</td><td>#getfile.type#</td></tr>
			<tr><td align="right">Last Modified: &nbsp;</td><td>#dateformat(getfile.datelastmodified, 'dd/mm/yy')#</td></tr>
			</cfloop>
			</table>
		</cfif>	
		</td>
	</tr>
    <tr> 
   	  <td height="20"> 
	
	 <table width="98%" border="0"  cellspacing="0" cellpadding="2" align="center" class="formtext">
        <tr> 
          <td><b>#attributes.type#:</b> #attributes.filename# &nbsp;&nbsp; 
		  	<a href="#actionURL#&do=delimage&dotheDelete=yes&dirname=#attributes.dirname#&fn=#attributes.filename#" #doMouseover('Delete This #attributes.type#')# onclick="return confirm('Are you sure you want to delete this file?');">
		  	<img src="#request.appsettings.defaultimages#/icons/delete.gif" alt="" border="0" align="bottom" /><strong>Delete</strong></a>
		  </td> 
          <td align="right" width="40"><button onclick="javascript:updatefieldname('<cfif len(attributes.dirname)>#Replace(attributes.dirname, "/", "", "ONE")#/</cfif>#attributes.filename#');" class="formbutton">Select #attributes.type#</button></td>
        </tr>
	</cfif>
	
      </table>
	</td>
  </tr> 
</table>
</cfoutput>


<!--- iframe directory listing ----->
<cfelse>

	<cfif NOT DirectoryExists("#theDirectory#")>
	
		<!--- try to create the directory --->
		<cftry>
			<cfdirectory action="CREATE" directory="#theDirectory#">
		<cfcatch type="Any">
			<div class="formerror">Directory does not exist and could not be created. Please check the site settings to make sure they are pointing to a valid directory.</div>
		</cfcatch>
		</cftry>		
		
	<cfelse>
	
	<cfscript>
		objFile = CreateObject("java", "java.io.File").init("#theDirectory#");
		listFiles = objFile.listFiles();
		fileArray = ArrayNew(1);
		dirArray = ArrayNew(1);
		for (x=1; x lte ArrayLen(listFiles); x=x+1) {
			if (listFiles[x].isDirectory())
				ArrayAppend(dirArray, listFiles[x].getName());
			else if (listFiles[x].isFile())
				ArrayAppend(fileArray, listFiles[x].getName());
		}
	
		numfiles = ArrayLen(fileArray);
		numdirs = ArrayLen(dirArray);
	</cfscript>
	
<!--- 	Old CFDirectory Method --->
<!--- On CF7 and higher, add "listinfo="name" to the cfdirectory tag for much faster results --->
<!---
	
	<cfdirectory action="LIST" directory="#theDirectory#" name="FileList" sort="type DESC, name ASC, size DESC">
	
		<!--- get subdirectories --->
		<cfquery dbtype="query" name="getSubDirs">
		SELECT * FROM FileList
		WHERE Type = 'Dir'
		</cfquery>
		
		<cfset numdirs = getSubDirs.Recordcount>
		
		<!--- get files --->
		<cfquery dbtype="query" name="getImages">
		SELECT * FROM FileList
		WHERE Type = 'File'
		</cfquery>
		
		<cfset numfiles = getImages.Recordcount> --->

	
	<cfoutput>
	<!--- Up one level --->
	<cfif Len(attributes.dirname)>
		<cfset dirup=REReplace(attributes.dirname, "(.*)/.*","\1", "ALL")>		
		<a href="#ActionURL#&dirname=#dirup#" target="_parent" style="font-size:11px; font-family: Arial, Helvetica, sans-serif;" #doMouseover('Change Directory')#><img src="#request.appsettings.defaultimages#/icons/upfolder.gif" border="0" alt="" align="middle" width="18" height="15" /> [ Up One Level ]</a><br/>
	</cfif>
	
	<!--- Sub Directories --->					
	<cfloop index="i" from="1" to="#numdirs#">
		<cfset Name = dirArray[i]>
		<!--- <cfset Name = getSubDirs.Name[i]> --->
		<a href="#ActionURL#&dirname=#attributes.dirname#%2F#URLEncodedFormat(name)#" target="_parent" style="font-size:11px; font-family: Arial, Helvetica, sans-serif;" #doMouseover('Click to Open')#><img src="#request.appsettings.defaultimages#/icons/folder.gif" alt="Open Folder" border="0" align="middle" width="18" height="15" />#name#</a><br/>
	</cfloop> 
									
	<!--- List the Files ---->
	<cfloop index="i" from="1" to="#numfiles#">
		<cfset Name = fileArray[i]>
		<!--- <cfset Name = getImages.Name[i]> --->
		<cfif showfiletypes IS "ALL" OR ListFindNoCase(showfiletypes, GetToken(Name,2,"."))>
		 <a href="javascript:parent.document.location='#ActionURL#&dirname=#attributes.dirname#&filename=#URLEncodedFormat(name)#&do=viewimage';" target="_parent" style=" font-size:11px; font-family: Arial, Helvetica, sans-serif;" #doMouseover('Click to View')#>#name#</a><br/>
		</cfif>
		</cfloop>	
	
	</cfoutput>
	</cfif>
	
</div>
</cfif>

