
<cfinclude template="templates/admin_subpage_header.cfm">

<!--- SET REDUNDANT VARIABLES --->
<cfset VARIABLES.listing_page = "manage_misc_content.cfm">
<cfset VARIABLES.form_return_page = "misc_content_block.cfm">
<cfset VARIABLES.db_table_name = "MiscContent">

<!--- SET VARIABLES FOR DELETE FUNCTION --->
<cfset VARIABLES.table_primkey_name = "block_id">
<cfset VARIABLES.table_title_column = "block_title">


	
<cfif isdefined("form.submit") AND form.submit IS "Update this content block">
<cfset fieldslist = "block_id">

<!--- BLOCK 1 IS LEFT COLUMN CONTENT ON HOME PAGE --->

<cfswitch expression="#FORM.block_id#">
	<cfcase value="1">
		<cfset fieldslist = fieldslist & ",block_title,block_field1,block_field2">	
		<!--- 
		<cfif LEN(FORM.add_block_field1) GT 0>
			<cfset FORM.block_field1 = FORM.add_block_field1>
			<cfset fieldslist = fieldslist & ",block_field1">	
		</cfif>
		--->
	</cfcase>
	<cfcase value="2">
		<cfset fieldslist = fieldslist & ",block_title,block_field1,block_field2">	
	</cfcase>
	<cfcase value="3">
		<cfset fieldslist = fieldslist & ",block_content,block_title">		
	</cfcase>
	<cfcase value="4">
		<cfset fieldslist = fieldslist & ",block_content,block_title">		
	</cfcase>
	<cfcase value="5">
		<!--- 
		<cfif LEN(FORM.add_block_field1) GT 0>
			<cfset FORM.block_field1 = FORM.add_block_field1>
			<cfset fieldslist = fieldslist & ",block_field1">	
		</cfif>
		<cfif LEN(FORM.add_block_field2) GT 0>
			<cfset FORM.block_field2 = FORM.add_block_field2>
			<cfset fieldslist = fieldslist & ",block_field2">	
		</cfif>
		--->
		<cfset fieldslist = fieldslist & ",block_field1">	
	</cfcase>
	<cfcase value="6">
		<cfset fieldslist = fieldslist & ",block_content,block_field1,block_field2">		
	</cfcase>
</cfswitch>

<cfupdate datasource="#APPLICATION.DSN#" tablename="#VARIABLES.db_table_name#" dbtype="ODBC" formfields="#fieldslist#">
<cfset table_title_column_value = "#form[table_title_column]#">
<cflocation url="#VARIABLES.listing_page#?memo=updated&title=#VARIABLES.table_title_column_value#"> 
<cfabort>
</cfif>


<cfquery name="getblock" datasource="#APPLICATION.DSN#" dbtype="odbc">
SELECT * FROM MiscContent
WHERE block_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#url.block_id#">
</cfquery>
<!--- NEW_ENTRY IS USED TO NOTIFY FUNCTIONS WHETHER THIS IS A NEW PAGE ENTRY OR IF YOU'RE EDITING AN EXISTING ENTRY (E.G. THE IMAGE FIELD FUNCTION) --->
<cfset VARIABLES.new_entry = "no">

<cfparam name="getblock.block_title" default="">
<cfparam name="getblock.block_field1" default="">
<cfparam name="getblock.block_field2" default="">	
<cfparam name="getblock.block_field3" default="">	
<cfparam name="getblock.block_field4" default="">	
<cfparam name="getblock.block_field5" default="">	
<cfparam name="getblock.block_field6" default="">	
<cfparam name="getblock.block_field7" default="">	
<cfparam name="getblock.block_field8" default="">	
<cfparam name="getblock.block_field9" default="">	


<cfoutput>

<cfform action="#VARIABLES.form_return_page#" name="home_content_block_form" method="post" enctype="multipart/form-data">
<table border="0" cellpadding="0" cellspacing="2" id="admincontent" width="98%" align="center">
	<cfset bg1 = "##eeeeee">
	<cfset bg2 = "##ffffff">
	<cfset bg = "bg1">

<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>>
	  <td colspan="2"><cfoutput><a href="#VARIABLES.listing_page#"><strong>&laquo; Manage Misc Content</strong></a></cfoutput> </td>
	  </tr>
<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>>
	  <td width="22%"><strong>Title:</strong></td>
	  <td width="78%"><input type="text" name="block_title" value="#getblock.block_title#" class="form_element" /></td></tr>

<cfif getblock.block_id EQ 1 OR getblock.block_id EQ 2>

<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>>
	  <td><strong>Promo Block: </strong><br />
	   <em> [440 x 175]</em></td>
	  <td>
	  </td>
</tr>
<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>>
	  <td width="22%"><strong>Select Calendar Item:</strong></td>
	  <td width="78%">
	  	<cfquery name="qEvents" datasource="#APPLICATION.DSN#">
			SELECT     Calendar_Events.calevent_title,Calendar_Events.calevent_id,Event_Categories.event_cat_name,Cat_Event_Match.event_cat_id 
				FROM         Calendar_Events INNER JOIN
                      Cat_Event_Match ON Calendar_Events.calevent_id = Cat_Event_Match.calevent_id INNER JOIN
                      Event_Categories ON Cat_Event_Match.event_cat_id = Event_Categories.event_cat_id
                      WHERE Calendar_Events.calevent_active = 1
                      AND Calendar_Events.calevent_live_date <= #NOW()#
                      AND Calendar_Events.calevent_end_date >= #NOW()#
                      ORDER BY Cat_Event_Match.event_cat_id 
		</cfquery>
		<select name="block_field1" class="form_element">
			<option value="">-NONE-</option>
			<cfset VARIABLES.current_cat = "">
			<cfloop query="qEvents">
				<cfif qEvents.event_cat_id NEQ VARIABLES.current_cat>
					<cfif qEvents.currentrow NEQ 1>
						</optgroup>
					</cfif>
					<optgroup label="#qEvents.event_cat_name#">
					<cfset VARIABLES.current_cat = qEvents.event_cat_id>
				</cfif>
				<option value="#qEvents.calevent_id#" <cfif qEvents.calevent_id EQ getblock.block_field1>selected="selected"</cfif>>
					#qEvents.calevent_title#
				</option>
			</cfloop>
		</select>
	  </td></tr>
<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>>
 <td width="22%"><strong>- OR Enter Content</strong></td>
 <td>&nbsp;</td>
 </tr>
 <tr>
	  <td colspan="2">
	  
 	 <cfscript>
			// Calculate basepath for FCKeditor. It's in the folder right above _samples
		
			basePath = '/editor/';
			fckEditor = createObject("component", "#basePath#fckeditor");
			fckEditor.instanceName	= "block_field2";
			fckEditor.value			= '#getblock.block_field2#';
			fckEditor.basePath		= basePath;
			fckEditor.width			= "100%";
			fckEditor.height		= 250;
			fckeditor.ToolbarSet = "Default";
			fckEditor.create(); // create the editor.
		</cfscript>
	  	
	
</td>
</tr>

</cfif> 
<cfif getblock.block_id EQ 5>

<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>>
	  <td valign="top"><strong>YouTube Embed Code:</strong><br> </td>
	
	  <td valign="top">
		 <textarea name="block_field1" cols="40" rows="5">
		 	#getblock.block_field1#
		 </textarea>

	</td>
</tr>
<!---
<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>>
	  <td valign="top"><strong>Splash Image:</strong><br> 
	  <em>Dimensions<br/>[241 x 157]</em></td>
	
	  <td valign="top">
		 <cfif LEN(getblock.block_field2) GT 0>
		<em>Uploaded image: #getblock.block_field2#</em>
			
		<br>
		<br>
		Replace&nbsp; 
	  </cfif>
	  <script type="text/javascript">
	  function BrowseServer2()
	   {
		CKFinder.Popup( 'ckfinder/', null, null, SetFileField2 ) ;
	   }
	  
	  function SetFileField2( fileUrl )
	   {
		document.getElementById( 'add_block_field2' ).value = fileUrl ;
	   }
	 </script>
	 Image:<input type="text" id="add_block_field2" name="add_block_field2" size="30" /> <input type="button" value="Browse Server" onclick="BrowseServer2();" /><br/>
	</td>
</tr>
--->
</cfif>

<cfif getblock.block_id EQ 6>
<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>>
	  <td><strong>Item 1 Content:</strong></td>
	  <td>
	  </td>
</tr>
<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>>
	  <td colspan="2">
	  
 	 <cfscript>
			// Calculate basepath for FCKeditor. It's in the folder right above _samples
		
			basePath = '/editor/';
			fckEditor = createObject("component", "#basePath#fckeditor");
			fckEditor.instanceName	= "block_field1";
			fckEditor.value			= '#getblock.block_field1#';
			fckEditor.basePath		= basePath;
			fckEditor.width			= "100%";
			fckEditor.height		= 250;
			fckeditor.ToolbarSet = "Default";
			fckEditor.create(); // create the editor.
		</cfscript>
	  	
	
</td>
</tr>
<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>>
	  <td><strong>Item 2 Content:</strong></td>
	  <td>
	  </td>
</tr>
<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>>
	  <td colspan="2">
	  
 	 <cfscript>
			// Calculate basepath for FCKeditor. It's in the folder right above _samples
		
			basePath = '/editor/';
			fckEditor = createObject("component", "#basePath#fckeditor");
			fckEditor.instanceName	= "block_field2";
			fckEditor.value			= '#getblock.block_field2#';
			fckEditor.basePath		= basePath;
			fckEditor.width			= "100%";
			fckEditor.height		= 250;
			fckeditor.ToolbarSet = "Default";
			fckEditor.create(); // create the editor.
		</cfscript>
	  	
	
</td>
</tr>

</cfif>



<tr <cfif bg IS "bg1">bgcolor="#bg1#"<cfset bg = "bg2"><cfelse>bgcolor="#bg2#"<cfset bg = "bg1"></cfif>><td colspan="2"><input type="submit" name="submit" value="Update this content block" class="form_element"><input type="hidden" name="block_id" value="#getblock.block_id#"></td></tr>

</table>
</cfform>
</cfoutput>

<cfinclude template="templates/admin_subpage_footer.cfm">