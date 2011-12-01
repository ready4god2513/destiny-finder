<cfsetting enablecfoutputonly="true">
<!--- Ensure this file gets compiled using iso-8859-1 charset --->
<cfprocessingdirective pageencoding="iso-8859-1">
<!--- 
/**
* ColdFusion custom tag: "hieritem"
  Must be contained inside "hiermenu" or "hierbar".
  Each instance of this tag creates an item inside the menu.
  The tag requires ColdFusion Server 6.1 or more. 
* Copyright © 2004 Massimocorner.com 
* @author       Massimo Foti (massimo@massimocorner.com)
* @version      1.0, 2004-10-12
* @param        label         Optional. Text for the menu item. Default to "Sub Menu"
* @param        href          Optional. The href attribute of the <a> tag. Default to "javascript:;"
* @param        class         Optional. The class attribute of the <li> tag. Default to none
* @param        id            Optional. The id attribute of the <li> tag. Default to none
* @param        title         Optional. The title attribute of the <a> tag. Default to none
* @param        target        Optional. The target attribute of the <a> tag. Default to none
 */
--->
<cfif thisTag.executionMode IS "start">
	
	<!--- Be sure the tag is properly nested --->
	<cftry>
		<!--- First we look for the hiermenu tag --->
		<cfset ancestorTag=GetBaseTagData("cf_hiermenu")>
		<cfcatch type="any">
			<cftry>
				<!--- Hiermenu is missing, try hierbar instead --->
				<cfset ancestorTag=GetBaseTagData("cf_hierbar")>
				<cfcatch type="any">
					<cfthrow message="Tag hieritem must be contained inside hiermenu or hierbar tags" type="hieritem">
				</cfcatch>
			</cftry>			
		</cfcatch>
	</cftry>
	
	<cfparam name="attributes.label" type="string" default="Sub Menu">
	<cfparam name="attributes.href" type="string" default="javascript:;">
	<cfparam name="attributes.class" type="string" default="">
	<cfparam name="attributes.id" type="string" default="">
	<cfparam name="attributes.title" type="string" default="">
	<cfparam name="attributes.target" type="string" default="">

	<cfscript>
	classStr = "";
	idStr = "";
	titleStr = "";
	targetStr = "";
	if(attributes.class NEQ ""){
		classStr = ' class="#attributes.class#"';
	}
	if(attributes.id NEQ ""){
		idStr = ' id="#attributes.id#"';
	}
	if(attributes.title NEQ ""){
		titleStr = ' title="#attributes.title#"';
	}
	// If we have no target attribute, check the one from the ancestor tag
	if(attributes.target EQ ""){
		attributes.target = ancestorTag.attributes.target;
	}
	if(attributes.target NEQ ""){
		targetStr = ' target="#attributes.target#"';
	}
	</cfscript>
	
<cfoutput>
			<li#classStr##idStr#><a href="#attributes.href#"#titleStr##targetStr#>#attributes.label#</a></li></cfoutput>
</cfif>
<cfsetting enablecfoutputonly="no">