<cfset obj_admin = CreateObject("component","admin.cfcs.admin")>

<cfinclude template="templates/admin_subpage_header.cfm">

<!--- SET REDUNDANT VARIABLES --->
<cfset VARIABLES.listing_page = "cal_event_listing.cfm">
<cfset VARIABLES.form_return_page = "cal_event.cfm">
<cfset VARIABLES.db_table_name = "Calendar_Events">

<!--- SET VARIABLES FOR DELETE FUNCTION --->
<cfset VARIABLES.table_primkey_name = "calevent_id">
<cfset VARIABLES.table_title_column = "calevent_title">

<cfset VARIABLES.form_fields = "CALEVENT_ACTIVE,
CALEVENT_CONTENT,
CALEVENT_END_DATE,
CALEVENT_START_DATE,
CALEVENT_LIVE_DATE,
CALEVENT_TITLE,
CALEVENT_SHORT_DESC,
CALEVENT_URL,
CALEVENT_TIME,
CALEVENT_BANNER,
CALEVENT_CAT,
CALEVENT_VIDEO,
CALEVENT_RECUR_DAY,
CALEVENT_DISPLAY_DATE">






<cfif isdefined("form.submit") AND form.submit IS "Create Event">

<cfif LEN(FORM.add_image) GT 0>
		<cfset FORM.calevent_image = FORM.add_image>
		<cfset VARIABLES.form_fields = VARIABLES.form_fields & ",calevent_image">
</cfif>

<cfif LEN(FORM.add_image_thumb) GT 0>
		<cfset FORM.calevent_image_thumb = FORM.add_image_thumb>
		<cfset VARIABLES.form_fields = VARIABLES.form_fields & ",calevent_image_thumb">
</cfif>

<cfif LEN(FORM.add_image_banner) GT 0>
		<cfset FORM.calevent_image_banner = FORM.add_image_banner>
		<cfset VARIABLES.form_fields = VARIABLES.form_fields & ",calevent_image_banner">
</cfif>

<cfif isDefined('FORM.add_video') AND LEN(FORM.add_video) GT 0>
		<cfset FORM.calevent_video = FORM.add_video>
		<cfset VARIABLES.form_fields = VARIABLES.form_fields & ",calevent_video">
</cfif>

		<cfset VARIABLES.form_fields = VARIABLES.form_fields & ",CALEVENT_CREATEDATE">
		
<cfinsert datasource="#APPLICATION.DSN#" tablename="Calendar_Events" dbtype="ODBC" formfields="#VARIABLES.form_fields#">
<cfquery name="GetMax" datasource="#APPLICATION.DSN#" maxrows="1">
		SELECT calevent_id
		FROM Calendar_Events
		ORDER BY calevent_id DESC 
	</cfquery>
	
	<cfparam name="FORM.calevent_id" default="#GetMax.calevent_id#">
				
	<cfset obj_admin.lookup_table_update(
	lookup_table="Cat_Event_Match",
	table_primkey_name="calevent_id",
	checkbox_name="calevent_cat",
	secondary_primkey_name="event_cat_id"
	)>
<cflocation url="cal_event_listing.cfm?memo=new&title=#form.calevent_title#">
<cfabort>
	
<cfelseif isdefined("form.submit") AND form.submit IS "Update this event">


<cfif isDefined('FORM.remove_image')>
		<cfset FORM.calevent_image = "">
</cfif>
<cfif LEN(FORM.add_image) GT 0>
		<cfset FORM.calevent_image = FORM.add_image>
</cfif>
<cfif isDefined('FORM.calevent_image')>
	<cfset VARIABLES.form_fields = VARIABLES.form_fields & ",calevent_image">
</cfif>

<cfif isDefined('FORM.remove_image_thumb')>
		<cfset FORM.calevent_image_thumb = "">
</cfif>
<cfif LEN(FORM.add_image_thumb) GT 0>
		<cfset FORM.calevent_image_thumb = FORM.add_image_thumb>
</cfif>
<cfif isDefined('FORM.calevent_image_thumb')>
	<cfset VARIABLES.form_fields = VARIABLES.form_fields & ",calevent_image_thumb">
</cfif>

<cfif isDefined('FORM.remove_image_banner')>
		<cfset FORM.calevent_image_banner = "">
</cfif>
<cfif LEN(FORM.add_image_banner) GT 0>
		<cfset FORM.calevent_image_banner = FORM.add_image_banner>
</cfif>
<cfif isDefined('FORM.calevent_image_banner')>
	<cfset VARIABLES.form_fields = VARIABLES.form_fields & ",calevent_image_banner">
</cfif>

<cfif isDefined('FORM.remove_video')>
		<cfset FORM.calevent_video = "">
</cfif>
<cfif isDefined('FORM.add_video') AND LEN(FORM.add_video) GT 0>
		<cfset FORM.calevent_video = FORM.add_video>
</cfif>


<!--- <cfset form.calevent_start_date = CreateODBCDATE(form.calevent_start_date)>
<cfset form.calevent_end_date = CreateODBCDATE(form.calevent_end_date)> --->

<cfset VARIABLES.form_fields = "calevent_id," & VARIABLES.form_fields>

<cfupdate datasource="#APPLICATION.DSN#" tablename="Calendar_Events" formfields="#VARIABLES.form_fields#">

<cfset obj_admin.lookup_table_update(
	lookup_table="Cat_Event_Match",
	table_primkey_name="calevent_id",
	checkbox_name="calevent_cat",
	secondary_primkey_name="event_cat_id"
	)>
	
<cflocation url="cal_event_listing.cfm?memo=updated&title=#form.calevent_title#"> 
<cfabort>

<cfelseif isdefined("form.submit") AND form.submit IS "Delete this event">
	<cfoutput>#delete_step1(page_return="#VARIABLES.form_return_page#",table_primkey_name="#VARIABLES.table_primkey_name#",table_title_column="#VARIABLES.table_title_column#",additional_form_fields="")#</cfoutput>
<cfabort>

<cfelseif isdefined("form.submit") AND form.submit IS "Yes, Confirm Deletion">
	<cfoutput>#delete_step2(dsn="#DSN#",page_return="",table_name="#VARIABLES.db_table_name#",table_primkey_name="#VARIABLES.table_primkey_name#",table_title_column="#VARIABLES.table_title_column#",additional_url_vars="")#</cfoutput>
<cflocation url="#VARIABLES.listing_page#?memo=deleted&title=#form.calevent_title#">
			
			
<cfelseif isdefined("form.submit") AND form.submit IS "Cancel">
<cfset table_primkey_value = "#form[table_primkey_name]#">
<cflocation url="#VARIABLES.form_return_page#?#VARIABLES.table_primkey_name#=#VARIABLES.table_primkey_value#">
<cfabort>
</cfif>



	<cfset bg1 = "##eeeeee">
	<cfset bg2 = "##ffffff">
	<cfset bg = "bg1">

<!--- query to get existing values --->
<cfif isdefined("url.calevent_id") AND url.calevent_id NEQ "new">
<cfquery name="getevent" datasource="#APPLICATION.DSN#" dbtype="odbc">
SELECT * FROM Calendar_Events
WHERE calevent_id = #url.calevent_id#
</cfquery>
<cfset VARIABLES.new_entry = "no">
<cfelse>
<cfset VARIABLES.new_entry = "yes">
</cfif>

<!--- set blank defaults for new entries --->
<cfparam name="getevent.CALEVENT_ID" default="0">
<cfparam name="getevent.CALEVENT_CONTENT" default="">
<cfparam name="getevent.CALEVENT_TITLE" default="">
<cfparam name="getevent.CALEVENT_END_DATE" default="#Now()#">
<cfparam name="getevent.CALEVENT_LIVE_DATE" default="#Now()#">

<cfparam name="getevent.CALEVENT_START_DATE" default="#Now()#">
<cfparam name="getevent.CALEVENT_RECUR_DAY" default="">
<cfparam name="getevent.CALEVENT_LOCATION" default="">
<cfparam name="getevent.CALEVENT_ACTIVE" default="0">
<cfparam name="getevent.CALEVENT_FEATURED" default="0">
<cfparam name="getevent.CALEVENT_SHORT_DESC" default="">
<cfparam name="getevent.CALEVENT_CREATEDATE" default="">
<cfparam name="getevent.CALEVENT_TYPES_ID" default="">
<cfparam name="getevent.CALEVENT_FNAME" default="">
<cfparam name="getevent.CALEVENT_LNAME" default="">
<cfparam name="getevent.CALEVENT_PHONE" default="">
<cfparam name="getevent.CALEVENT_EMAIL" default="">
<cfparam name="getevent.CALEVENT_IMAGE" default="">
<cfparam name="getevent.CALEVENT_IMAGE_THUMB" default="">
<cfparam name="getevent.CALEVENT_IMAGE_BANNER" default="">
<cfparam name="getevent.CALEVENT_VIDEO" default="">
<cfparam name="getevent.CALEVENT_TIME" default="">
<cfparam name="getevent.CALEVENT_URL" default="">
<cfparam name="getevent.CALEVENT_BANNER" default="">
<cfparam name="getevent.CALEVENT_SCROLL" default="">
<cfparam name="getevent.CALEVENT_DISPLAY_DATE" default="">

<cfoutput>

<table width="600" border="0" cellspacing="0" cellpadding="0" id="planner_details">
  <tr>
    <td style="padding: 5px 10px 5px 10px;">
	<cfform action="cal_event.cfm" method="post" enctype="multipart/form-data">

	
	
	<table border="0" cellpadding="3" cellspacing="0" style="width: 100%; border-collapse: collapse;">
					<tbody>
					<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>>
  <td colspan="2"><a href="cal_event_listing.cfm"><strong>&laquo; Calendar Event  Listing</strong></a> </td>
  </tr>
  <tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>>
						  <td><strong>Event Title: </strong></td>
						  <td><cfinput name="calevent_title" type="text" id="calevent_title" value="#getevent.calevent_title#" size="20" maxlength="50" required="yes" message="Event Title: Cannot Be Empty!" /></td>
					  </tr>
  <tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>>
    <td width="30%" valign="top"><strong>Event  Active : </strong></td>
    <td width="70%"> Yes <input type="radio" name="CALEVENT_ACTIVE" value="1" <cfif getevent.calevent_active EQ 1>checked</cfif> style="border:none;">&nbsp;No
        <input type="radio" name="CALEVENT_ACTIVE" value="0" <cfif getevent.calevent_active EQ 0>checked</cfif> style="border:none;"></td>
  </tr>
   <tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>>
						  <td valign="top"><strong>Event Category: </strong></td>
						  <td>
						  <cfmodule template="customtags/category_checkboxes.cfm" calevent_id="#getevent.calevent_id#">
						  <!--- 
						  <cfquery name="qEventCats" datasource="#APPLICATION.DSN#">
						  	SELECT event_cat_name,event_cat_id
							FROM Event_categories
							ORDER BY event_cat_name
						  </cfquery>
						  <select name="calevent_cat">
						  	<option value="">-Select-</option>
						  	<cfloop query="qEventCats">
								<option value="#qEventCats.event_cat_id#" <cfif getevent.calevent_cat EQ qEventCats.event_cat_id>selected="selected"</cfif>>#qEventCats.event_cat_name# {event_cat=#qEventCats.event_cat_id#}</option>
							</cfloop>
						  </select> --->
						  </td>
					  </tr>

						
						<cfif url.calevent_id NEQ "new">
						<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>>
						  <td><strong>Date Created:</strong></td>
						  <td><em>#DateFormat(getevent.calevent_createdate,'mm/dd/yyyy')#</em></td>
					  </tr>
					  </cfif>
				
						<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>>

							<td><strong>Event Start Date:</strong></td>
							<td valign="top">
								<script>DateInput('calevent_start_date', true, 'MM-DD-YYYY','#DateFormat(getevent.calevent_start_date,"mm-dd-yyyy")#')</script>
							</td>
						</tr>
						<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>>

							<td><strong>Event End Date:</strong></td>
							<td>
								<script>DateInput('calevent_end_date', true, 'MM-DD-YYYY','#DateFormat(getevent.calevent_end_date,"mm-dd-yyyy")#')</script>
							</td>
						</tr>
						<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>>
						  <td><strong>Event Live Date:</strong></td>
						  <td><script>DateInput('calevent_live_date', true, 'MM-DD-YYYY','#DateFormat(getevent.CALEVENT_LIVE_DATE,"mm-dd-yyyy")#')</script></td>
					  </tr>
					  <tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>>
    <td width="30%" valign="top"><strong>Display Date : </strong></td>
    <td width="70%"> Yes <input type="radio" name="CALEVENT_display_date" value="1" <cfif getevent.CALEVENT_display_date EQ 1>checked</cfif> style="border:none;">&nbsp;No
        <input type="radio" name="CALEVENT_display_date" value="0" <cfif getevent.CALEVENT_display_date EQ 0>checked</cfif> style="border:none;"></td>
  </tr>
						<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>>
						  <td><strong>Event Time: </strong></td>
						  <td><cfinput name="calevent_time" type="text" id="calevent_time" value="#getevent.calevent_time#" size="20"  /></td>
					  </tr>
						 <tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>>
						  <td valign="top"><strong>Recurring Days: </strong>
						  <br>
						  <em>[For events that recur on specific days throughout the event time span]</em></td>
						  <td>
						  	<cfset VARIABLES.days = "Sunday,Monday,Tuesday,Wednesday,Thursday,Friday,Saturday">
						  	<cfloop list="#VARIABLES.days#" index="day">
								<input type="checkbox" name="calevent_recur_day" value="#day#" <cfif ListFind(getevent.CALEVENT_RECUR_DAY,day)>checked="checked"</cfif>> #day# <br/>
							</cfloop>
						  </td>
					  </tr>
						<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>>

							<td valign="top"><strong>Small Banner :<br>
					      </strong><em>[Displays on event details page: 253x174]</em> </td>
							<td valign="top">
								<cfif LEN(getevent.calevent_image) GT 0>
									<em>Uploaded Image: #getevent.calevent_image#</em><br />
									<input type="checkbox" name="remove_image" value="1"> Remove Image
									<br>Replace Image: 
								</cfif>
								<script type="text/javascript">
								  function BrowseServerA()
								   {
									CKFinder.Popup( 'ckfinder/', null, null, SetFileFieldA ) ;
								   }
								  
								  function SetFileFieldA( fileUrl )
								   {
									document.getElementById( 'add_image' ).value = fileUrl ;
								   }
								 </script>

								<input type="text" id="add_image" name="add_image" size="30" /> <input type="button" value="Browse Server" onclick="BrowseServerA();" />
								<input type="hidden" name="calevent_image" value="#getevent.calevent_image#">
							</td>
						</tr>
						<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>>

						  <td valign="top"><strong>Event Thumbnail Image:<br>
					      </strong><em>[Displays in right scroll area on home page.<br>
					      Dimensions: 90x72
					      ]</em> </td>
							<td valign="top">
								<cfif LEN(getevent.calevent_image_thumb) GT 0>
									<em>Uploaded Image: #getevent.calevent_image_thumb#</em><br />
									<input type="checkbox" name="remove_image_thumb" value="1"> Remove Image
									<br>Replace Image: 
								</cfif>
								<script type="text/javascript">
								  function BrowseServerThumb()
								   {
									CKFinder.Popup( 'ckfinder/', null, null, SetFileFieldThumb ) ;
								   }
								  
								  function SetFileFieldThumb( fileUrl )
								   {
									document.getElementById( 'add_image_thumb' ).value = fileUrl ;
								   }
								 </script>

								<input type="text" id="add_image_thumb" name="add_image_thumb" size="30" /> <input type="button" value="Browse Server" onclick="BrowseServerThumb();" />
								<input type="hidden" name="calevent_image_thumb" value="#getevent.calevent_image_thumb#">
							</td>
						</tr>
						<!--- <tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>>
						  <td valign="top"><strong>Scroll Active: </strong></td>
						  <td valign="top"> Yes <input type="radio" name="CALEVENT_scroll" value="1" <cfif getevent.calevent_scroll EQ 1>checked</cfif> style="border:none;">&nbsp;No
        <input type="radio" name="CALEVENT_scroll" value="0" <cfif getevent.calevent_scroll EQ 0>checked</cfif> style="border:none;"></td>
					  </tr> --->
						<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>>

						  <td valign="top"><strong>Big Banner:<br>
					      </strong><em>[Displays in the large banner area on home page.<br>
					      Dimensions: 583x236
					      ]</em> </td>
							<td valign="top">
								<cfif LEN(getevent.calevent_image_banner) GT 0>
									<em>Uploaded Image: #getevent.calevent_image_banner#</em><br />
									<input type="checkbox" name="remove_image_banner" value="1"> Remove Image
									<br>Replace Image: 
								</cfif>
								<script type="text/javascript">
								  function BrowseServerBanner()
								   {
									CKFinder.Popup( 'ckfinder/', null, null, SetFileFieldBanner ) ;
								   }
								  
								  function SetFileFieldBanner( fileUrl )
								   {
									document.getElementById( 'add_image_banner' ).value = fileUrl ;
								   }
								 </script>

								<input type="text" id="add_image_banner" name="add_image_banner" size="30" /> <input type="button" value="Browse Server" onclick="BrowseServerBanner();" />
								<input type="hidden" name="calevent_image_banner" value="#getevent.calevent_image_banner#">
							</td>
						</tr>
						<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>>
						  <td valign="top"><strong>Banner Active: </strong></td>
						  <td valign="top"> Yes <input type="radio" name="CALEVENT_BANNER" value="1" <cfif getevent.calevent_banner EQ 1>checked</cfif> style="border:none;">&nbsp;No
        <input type="radio" name="CALEVENT_banner" value="0" <cfif getevent.calevent_banner EQ 0>checked</cfif> style="border:none;"></td>
					  </tr>
						<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>>
						  <td valign="top"><strong>Short Description:<br>
						    </strong><em>[Used for rotating banner and .mobi site. <br>
						    Max 161 Characters]</em><strong><br>
					        </strong></td>
						  <td valign="top"><input type="text" name="calevent_short_desc" value="#getevent.calevent_short_desc#" size="50" maxlength="161"></td>
					  </tr>
						<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>>

							<td valign="top"><strong>Event Video:</strong><br />
							<em>[Youtube URL
					      ]</em><br>
					      </td>
							<td valign="top">
							<input type="text" name="calevent_video" value="#getevent.calevent_video#" size="50">
								<!--- <cfif LEN(getevent.calevent_video) GT 0>
									<em>Uploaded Video: #getevent.calevent_video#</em><br />
									<input type="checkbox" name="remove_video" value="1"> Remove Video
									<br>Replace Image: 
								</cfif>
								<script type="text/javascript">
								  function BrowseServerVideo()
								   {
									CKFinder.Popup( 'ckfinder/', null, null, SetFileFieldVideo) ;
								   }
								  
								  function SetFileFieldVideo( fileUrl )
								   {
									document.getElementById( 'add_video' ).value = fileUrl ;
								   }
								 </script>

								<input type="text" id="add_video" name="add_video" size="30" /> <input type="button" value="Browse Server" onclick="BrowseServerVideo();" />
								<input type="hidden" name="calevent_video" value="#getevent.calevent_video#"> --->
							</td>
						</tr>
						<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>>
						  <td valign="top"><strong>Tickets Full URL:<br>
					      </strong></td>
						  <td><input type="text" name="calevent_url" value="#getevent.calevent_url#" maxlength="161">
						    </td>
					  </tr>
						<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>>
							<td colspan="2">
								<strong>Details:</strong> </td>
						</tr>
						<tr>
							<td colspan="2">
	<cfscript>
	// Calculate basepath for FCKeditor. It's in the folder right above _samples

	basePath = '/editor/';
	fckEditor = createObject("component", "#basePath#fckeditor");
	fckEditor.instanceName	= "calevent_content";
	fckEditor.value			= '#getevent.calevent_content#';
	fckEditor.basePath		= basePath;
	fckEditor.width			= "99%";
	fckEditor.height		= 300;
	fckeditor.ToolbarSet = "Default";
	fckEditor.create(); // create the editor.
</cfscript>
							</td>
						</tr>

						<tr>
							<td colspan="2" style="text-align: left;">
								
								<cfif isDefined('url.calevent_id') AND url.calevent_id EQ "new"><input type="submit" name="submit" value="Create Event" /><input type="hidden" name="calevent_createdate" value="#CreateDate(Year(Now()), Month(Now()), Day(Now()))#"/><cfelse><input type="submit" name="submit" value="Update this event" />&nbsp;<input type="submit" name="submit" value="Delete this event" /><input type="hidden" name="calevent_id" value="#getevent.calevent_id#"/></cfif>
					      </td>
						</tr>
					</tbody>
		  </table>
		</cfform>
				
	  </td>
  </tr>
</table>
</cfoutput>

</body>
</html>