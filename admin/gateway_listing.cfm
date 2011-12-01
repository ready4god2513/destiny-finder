<cfinclude template="checksession_sub.cfm">
<!--- QUERY FOR LISTING --->
<cfquery name="getgateways" datasource="#APPLICATION.DSN#" dbtype="odbc">
	SELECT gateway_id, gateway_name,gateway_sortorder FROM Gateway_Pages
	WHERE Gateway_parent_id = 0
	ORDER BY gateway_sortorder ASC
	
</cfquery>

<cfif isDefined('form.submit') AND form.submit EQ "Update Sort Order">
	<!--- SORTABLE CODE --->
	<!--- <cfset VARIABLES.page_id_array = ListToArray('#form.page_id_list#')> --->
	<cfset VARIABLES.divorder = Replace('#FORM.divOrder#','sortContainer[]=','','ALL')>
	<cfset VARIABLES.divorder = Replace('#VARIABLES.divorder#','&',',','All')>
	<cfset VARIABLES.div_order_array = ListToArray('#VARIABLES.divOrder#')>
	
	<cfset VARIABLES.sort_id_array = ArrayNew(1)>
	<cfset VARIABLES.div_marker = 0>
	
		<cfloop from="1" to="#ListLen(sort_id_list)#" index="i">
			<cfset VARIABLES.sort_id_array[i] = StructNew()>
			<cfset VARIABLES.sort_id_array[i].sort_id = ListGetAt(FORM.sort_id_list,i)>
			<cfset VARIABLES.sort_id_array[i].div_id =  VARIABLES.div_marker>
			<cfset VARIABLES.div_marker = VARIABLES.div_marker + 1>
		</cfloop>
	
	 FOR DEBUGGING 
	Sort ID ARRAY:<br />
	<cfdump var="#VARIABLES.sort_id_array#">
	Div Order ARRAY:<br />
	<cfdump var="#VARIABLES.div_order_array#">
	<!--- --->
	
		<cfloop from="1" to="#ArrayLen(VARIABLES.sort_id_array)#" index="x">
			<cfoutput>
				UPDATE gateway_pages set gateway_sortorder= #x# WHERE gateway_id = 
				<cfloop from="1" to="#ArrayLen(VARIABLES.sort_id_array)#" index="y">
					<cfif VARIABLES.div_order_array[x] EQ VARIABLES.sort_id_array[y].div_id>
						#VARIABLES.sort_id_array[y].sort_id#
					</cfif> 
					<br/>
				</cfloop>
			</cfoutput>
			
			<cfquery name="update_sortorder" datasource="#APPLICATION.DSN#">
			UPDATE gateway_pages set gateway_sortorder= #x# WHERE gateway_id = 
			<cfloop from="1" to="#ArrayLen(VARIABLES.sort_id_array)#" index="y">
				<cfif VARIABLES.div_order_array[x] EQ VARIABLES.sort_id_array[y].div_id>
					#VARIABLES.sort_id_array[y].sort_id#
				</cfif> 
			</cfloop>
			
		</cfquery>
		
		
		</cfloop>
		<cflocation url="gateway_listing.cfm" addtoken="no">
	</cfif>

<cfinclude template="functions/admin_functions.cfm">

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Gateway Pages</title>
	<link rel="stylesheet" href="css/style.css" type="text/css" />
	<link rel="stylesheet" href="css/mocha.css" type="text/css" />
	<script src="scripts/prototype.js" type="text/javascript"></script>
	<script src="scripts/scriptaculous.js" type="text/javascript"></script>
	<script language="JavaScript" type="text/javascript"><!--
	function populateHiddenVars() {
		document.getElementById('divOrder').value = Sortable.serialize('sortContainer');
		return true;
				}
				//-->
	</script>
</head>

<body>
<div style="width:500px;margin-right:auto;margin-left:auto;margin-top:5px;">
	<div id="table_headings">
		<div style="float:left; margin-top:4px;">Gateway Pages&nbsp;&nbsp;<a href="gateway.cfm?gateway_id=new"><img src="images/action_add.gif" />Add New Gateway</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="content_listing.cfm">List All Pages</a></div> 
		<div style="clear:both;"></div>
	</div>
<cfoutput>
	<form action="gateway_listing.cfm" method="post" onSubmit="populateHiddenVars();" enctype="multipart/form-data">
		<cfset VARIABLES.divcount = 0>
		<cfset VARIABLES.sortids = "">
</cfoutput>
		<div id="sortContainer">	
	<cfoutput query="getgateways">
	
		
<div id="div_#VARIABLES.divcount#" style="cursor:move;border:1px solid ##D8D8D8; margin-bottom:2px;padding:2px;">

			<!--- FOR EVERY COLUMN SET EACH STYLE ELEMENT NEEDS TO ADDRESS THE APPROPRIATE WIDTH AS ASSIGNED ABOVE, THIS IS DONE BY SETTING THE LISTGETAT # TO IT'S RESPECTIVE COLUMN PLACEHOLDER, 1 IS FOR THE FIRST COLUMN, 2 IS FOR THE SECOND, AND SO ON. --->
			<div id="name_column" style="width:225px">
				<a href="gateway.cfm?gateway_id=#getgateways.gateway_id#"><img src="images/edit.gif" />&nbsp;
				#getgateways.gateway_name# </a>&nbsp;
			</div>
			<div id="column" style="width:100px;">
				<a href="content_listing.cfm?gateway=#getgateways.gateway_id#">[Menu Listing]</a> 
			</div>
			<div id="column">
				<a href="content.cfm?content_pageid=new&gateway=#getgateways.gateway_id#" style="font-size:10px;color: ##737373;"><img src="/admin/images/action_add.gif" /> Add New Page</a>
			</div>
			<div style="clear:both;"></div>
		</div>
		<cfset VARIABLES.divcount = VARIABLES.divcount + 1>
		<cfset VARIABLES.sortids = ListAppend(VARIABLES.sortids,getgateways.gateway_id)>
	</cfoutput>	
		</div>
	<cfoutput>

		<input type="hidden" name="sort_id_list" value="#VARIABLES.sortids#"/>
		<input type="hidden" name="divOrder" id="divOrder" >
		</cfoutput>
		<div align="right" style="margin-right:30px;padding-top:8px;"><input type="submit" name="submit" value="Update Sort Order"></div>
	</form>
	
	<script type="text/javascript">
		// <![CDATA[
						
			Sortable.create('sortContainer',{tag:'div'});
								
							// ]]>
	</script>
<div style="clear:both;"></div>
</div>
</body>
</html>
