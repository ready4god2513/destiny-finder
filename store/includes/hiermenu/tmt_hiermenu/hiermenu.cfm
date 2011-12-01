<cfsetting enablecfoutputonly="true">
<!--- Ensure this file gets compiled using iso-8859-1 charset --->
<cfprocessingdirective pageencoding="iso-8859-1">
<!--- 
/**
* ColdFusion custom tag: "hiermenu"
  Must be contained inside "hierbar" and can contains "hieritem" tags.
  Each instance of this tag creates an entry inside the menu.
  The tag requires ColdFusion Server 6.1 or more. 
* Copyright © 2004 Massimocorner.com 
* @author       Massimo Foti (massimo@massimocorner.com)
* @version      1.0, 2004-10-12
* @param        label         Optional. Text for the menu entry. Default to "Main Menu"
* @param        href          Optional. The href attribute of the <a> tag. Default to "javascript:;"
* @param        class         Optional. The class attribute of the <li> tag. Default to "tmtHiermenu"
* @param        id            Optional. The id attribute of the <li> tag. Default to none
* @param        title         Optional. The title attribute of the <a> tag. Default to none
* @param        target        Optional. The target attribute of the <a> tag. 
  This attribute also affects all the child menu items, unless child tags overwrite it. 
  If you want to specify a target attribute for the whole menu you may consider using a base tag like: <base target="myTarget" />. 
  Default to none
 */
--->
<cfif thisTag.executionMode IS "start">

	<!--- Be sure the tag is properly nested --->
	<cftry>
		<cfset ancestorTag=GetBaseTagData("cf_hierbar")>
		<cfcatch type="any">
			<cfthrow message="Tag hiermenu must be contained inside hierbar tag" type="hiermenu">
		</cfcatch>
	</cftry>

	<cfparam name="attributes.label" type="string" default="Main Menu">
	<cfparam name="attributes.href" type="string" default="javascript:;">
	<cfparam name="attributes.class" type="string" default="tmtHiermenu">
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
	<li#classStr##idStr#><a href="#attributes.href#" onmouseover="tmt_showHiermenu(this)" onmouseout="tmt_hideHiermenu(this)"#titleStr##targetStr#>#attributes.label#</a>
		<ul>#thisTag.generatedContent#</cfoutput>
</cfif>
<cfif thisTag.executionMode IS "end">
	<cfoutput>
		</ul>
	</li></cfoutput>
</cfif>
<cfsetting enablecfoutputonly="no">