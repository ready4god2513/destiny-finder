<cfinclude template="templates/admin_subpage_header.cfm">

<!--- SET REDUNDANT VARIABLES --->
<cfset VARIABLES.listing_page = "articles_listing.cfm">
<cfset VARIABLES.form_return_page = "articles.cfm">
<cfset VARIABLES.db_table_name = "Articles">

<!--- SET VARIABLES FOR DELETE FUNCTION --->
<cfset VARIABLES.table_primkey_name = "articleid">
<cfset VARIABLES.table_title_column = "title">


<!--- Queries to update database if form has been submitted --->
<cfif isdefined("form.submit") AND form.submit IS "Add article">

<cfset FORM.shorttext = HTMLEditFormat(FORM.shorttext)>

<cfinsert datasource="#DSN#" tablename="Articles" dbtype="ODBC" formfields="title,shorttext, article_content, url, livedate, author">
<cflocation url="article_listing.cfm?memo=new&title=#form.title#">
<cfabort>
<cfelseif isdefined("form.submit") AND form.submit IS "Update article">
<cfset FORM.shorttext = HTMLEditFormat(FORM.shorttext)>

<cfupdate datasource="#DSN#" tablename="Articles" dbtype="ODBC" formfields="articleID,title,shorttext,article_content, url, livedate, author">
<cflocation url="article_listing.cfm?memo=updated&title=#form.title#">
<cfabort>


<cfelseif isdefined("form.submit") AND form.submit IS "Delete article">
	<cfoutput><div id="delete_warning">Are you sure you want to delete: #form.title# ?<Br /><br />
	<cfform action="articles.cfm" method="post" enctype="multipart/form-data">
	<input name="submit" type="submit" value="Yes, Confirm Deletion" />&nbsp;
	<input name="submit" type="submit" value="Cancel" />
	<input type="hidden" name="articleid" value="#form.articleid#" />
	<input type="hidden" name="title" value="#form.title#" />
	<!--- <input type="hidden" name="article_type" value="#form.article_type#" /> --->
	</cfform>
	</div></cfoutput>
<cfabort>

<cfelseif isdefined("form.submit") AND form.submit IS "Yes, Confirm Deletion">
		<cfquery name="deletearticle" datasource="#DSN#" dbtype="odbc">
		DELETE FROM Articles
		WHERE articleID = #form.articleID#
		</cfquery>
	<cflocation url="article_listing.cfm?memo=deleted&title=#form.title#">
	<cfabort>
<cfelseif isdefined("form.submit") AND form.submit IS "Cancel">
<cflocation url="articles.cfm?articleid=#form.articleid#">
<cfabort>
</cfif>


<!--- query to get existing values --->

<!--- NEW_ENTRY IS USED TO NOTIFY FUNCTIONS WHETHER THIS IS A NEW PAGE ENTRY OR IF YOU'RE EDITING AN EXISTING ENTRY (E.G. THE IMAGE FIELD FUNCTION) --->
<cfparam name="VARIABLES.new_entry" default="no">

<cfif isdefined("url.articleID") AND url.articleID NEQ "new">
<cfquery name="getarticle" datasource="#DSN#" dbtype="odbc">
SELECT * FROM Articles
WHERE articleID = #url.articleID#
</cfquery>

<cfset VARIABLES.new_entry = "no">
</cfif>

<!--- <cfquery name="gettypes" datasource="#DSN#">
SELECT * FROM tblArticle_Types
</cfquery> --->

<!--- set blank defaults for new entries --->
<cfparam name="getarticle.title" default="">
<cfparam name="getarticle.article_content" default="">
<cfparam name="getarticle.url" default="">
<cfparam name="getarticle.livedate" default="#NOW()#">
<cfparam name="getarticle.author" default="">
<cfparam name="getarticle.shorttext" default="">
<!--- <cfparam name="getarticle.article_type" default="#URL.article_type#"> --->


<cfoutput>
<cfform action="articles.cfm" method="post" enctype="multipart/form-data">
<cfif isdefined("url.articleID") AND #url.articleID# NEQ "new"><input type="hidden" name="articleID" value="#getarticle.articleID#"></cfif>
<table border="0" cellpadding="0" cellspacing="2" id="admincontent" width="98%" align="center">
	<cfset bg1 = "##eeeeee">
	<cfset bg2 = "##ffffff">
	<cfset bg = "bg1">
    <tr class="<cfif bg IS "bg1">row1<cfset bg = "bg2"><cfelse>row2<cfset bg = "bg1"></cfif>">
      <td colspan="2"><a href="article_listing.cfm"><strong>&laquo; News Listing</strong></a></td>
      </tr>
    <tr class="<cfif bg IS "bg1">row1<cfset bg = "bg2"><cfelse>row2<cfset bg = "bg1"></cfif>"><td><strong>Title:</strong></td><td><input name="title" type="text" size="25" maxlength="240" value="#getarticle.title#"></td></tr>
  <!---   <tr class="<cfif bg IS "bg1">row1<cfset bg = "bg2"><cfelse>row2<cfset bg = "bg1"></cfif>">
                    <td><strong>Article Type:</strong></td>
                    <td><select name="article_type" class="form_element">
						
                        <option value=""> - Select Article Type - </option>
                        <cfloop query="gettypes">
                          <option value="#gettypes.article_type_id#" <cfif getarticle.article_type EQ gettypes.article_type_id>SELECTED</cfif>>#gettypes.article_type_title#&nbsp;{id= #gettypes.article_type_id#}</option>
                        </cfloop>
                      </select></td>
                  </tr> --->
    <tr class="<cfif bg IS "bg1">row1<cfset bg = "bg2"><cfelse>row2<cfset bg = "bg1"></cfif>"><td><strong>Live Date:</strong></td><td><script>DateInput('LiveDate', true, 'YYYY-MM-DD','#DateFormat(getarticle.LiveDate,"yyyy/m/d")#')</script> </td></tr>
<tr class="<cfif bg IS "bg1">row1<cfset bg = "bg2"><cfelse>row2<cfset bg = "bg1"></cfif>"><td><strong>Author:</strong></td><td><input name="author" type="text" size="25" maxlength="200" value="#getarticle.author#"></td></tr>

<tr class="<cfif bg IS "bg1">row1<cfset bg = "bg2"><cfelse>row2<cfset bg = "bg1"></cfif>"><td><strong>Link url:</strong></td><td>http://<input name="url" type="text" size="25" maxlength="200" value="#getarticle.url#"></td></tr>
<tr class="<cfif bg IS "bg1">row1<cfset bg = "bg2"><cfelse>row2<cfset bg = "bg1"></cfif>"><td colspan="2">(Either fill in the content below, or fill in "Link url" if you are wanting to link to an outside web site for article.)</td></tr>
<tr class="<cfif bg IS "bg1">row1<cfset bg = "bg2"><cfelse>row2<cfset bg = "bg1"></cfif>"><td valign="top" colspan="2"><strong>Short Text:</strong></td></tr>
<tr class="<cfif bg IS "bg1">row1<cfset bg = "bg2"><cfelse>row2<cfset bg = "bg1"></cfif>"><td valign="top" colspan="2">
<textarea name="shorttext" cols="60" rows="5">#getarticle.shorttext#</textarea>

</td></tr>
<tr class="<cfif bg IS "bg1">row1<cfset bg = "bg2"><cfelse>row2<cfset bg = "bg1"></cfif>"><td valign="top" colspan="2"><strong>Full Text:</strong></td></tr>
<tr class="<cfif bg IS "bg1">row1<cfset bg = "bg2"><cfelse>row2<cfset bg = "bg1"></cfif>"><td valign="top" colspan="2">
<cfscript>
	// Calculate basepath for FCKeditor. It's in the folder right above _samples

	basePath = '/editor/';
	fckEditor = createObject("component", "#basePath#fckeditor");
	fckEditor.instanceName	= "article_content";
	fckEditor.value			= '#getarticle.article_content#';
	fckEditor.basePath		= basePath;
	fckEditor.width			= "100%";
	fckEditor.height		= 300;
	fckEditor.create(); // create the editor.
</cfscript>
</td></tr>
<tr class="<cfif bg IS "bg1">row1<cfset bg = "bg2"><cfelse>row2<cfset bg = "bg1"></cfif>"><td valign="top" colspan="2">
<cfif isdefined("url.articleID") AND #url.articleID# NEQ "new">
<input type="submit" name="submit" value="Update article"><input type="submit" name="submit" value="Delete article">
<cfelse>
<input type="submit" name="submit" value="Add article">
</cfif>
</td></tr>
</table>
</cfform>
</cfoutput>

<cfinclude template="templates/admin_subpage_footer.cfm">