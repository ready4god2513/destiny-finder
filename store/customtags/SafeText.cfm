
<!--- 
CF_SafeText

This tag is designed to strip out potential security problems from text that is generated on a web page.

Use this tag if you want to take out some HTML tags and javascript handlers, but leave much of the HTML tag set intact.

This includes stripping out potentially harmful tags (SCRIPT,OBJECT,APPLET,EMBED,FORM,LAYER,ILAYER,FRAME,IFRAME,FRAMESET,PARAM,META)

Also, it strips potentially harmful event handlers (onClick,onDblClick,onKeyDown,onKeyPress,onKeyUp,onMouseDown,onMouseOut,onMouseUp,onMouseOver,onBlur,onChange,onFocus,onSelect,javascript:)

It is very easy to change the list of tags and/or event handlers

The syntax is (all attributes are optional, * shows default):

<CF_SafeText [mode="escape* | delete"] [output ="yes* | no"] [name="foo"]>
Your text to process #andCFVariables#
</CF_SafeText>

By default, MODE is "escape", so offending tags will be replaced with their HTMLEditFormat() equivalent, thus rendering them on the page.  If you like, set mode="delete" to strip these tags out of the text

If NAME exists, the tag assumes you don't want to output and puts the GeneratedContent of the tag into a variable of that name

Comments are welcome at nathan@changemedia.com

Create Date: 2/2000
Author: Nathan Dintenfass/Ben Archibald
ChangeMedia, Inc.
http://www.changemedia.com
nathan@changemedia.com

This tag may be used freely provided the following copyright notice is maintained:

This code is provided as is.  ChangeMedia makes no warranty or guarantee.  Use of this code is at your own risk.

Copyright, 2000 ChangeMedia, Inc.

 --->

<!--- WHEN THE TAG ENDS, CLEAN THE GeneratedContent --->
<cfif ThisTag.ExecutionMode is "end">
	<!--- escape or delete? --->
	<cfparam name="attributes.mode" default="escape">
	<!--- If there is a name, assume attributes.output is "no" --->
	<cfif isDefined("attributes.name")>
		<cfparam name="attributes.output" default="no" type="boolean">
	</cfif>
	<!--- Are we going to output? By default, yes --->
	<cfparam name="attributes.output" default="yes" type="boolean">	
	<!--- Make an Easy variable for readability --->
	<cfset TheText = trim(ThisTag.GeneratedContent)>
	<!--- The Stuff we want to strip out --->
	<cfparam name="attributes.badtags" default="SCRIPT,OBJECT,APPLET,EMBED,FORM,LAYER,ILAYER,FRAME,IFRAME,FRAMESET,PARAM,META,CAST(,EXEC(">
	<cfparam name="attributes.badevents" default="onClick,onDblClick,onKeyDown,onKeyPress,onKeyUp,onMouseDown,onMouseOut,onMouseUp,onMouseOver,onBlur,onChange,onFocus,onSelect,javascript:">
 	<!--- The regular expression for a bad tag -- the extra [[:space:]] at the beginning is to account for browsers that are lax in their parsing --->
	<cfset StripperRE = "<[[:space:]]?/?[[:space:]]?(#ListChangeDelims(attributes.badtags,"|")#)[^>]*>">
	<!--- If mode is "escape", then go through the document replacing text --->
	<cfif attributes.mode is "escape">
		<!--- find the first open bracket --->
		<cfset obracket = Find("<", TheText)>	
		<!--- go through the text as long as there is an open bracket to be found --->
		<cfloop condition="#obracket#">
			<!--- FIND THE NEXT INSTANCE OF ONE OF THE BAD TAGS --->
			<cfset BadTag = REFindNoCase(StripperRE,TheText,obracket,1)>
			<!--- IF THERE IS A BAD TAG, REPLACE IT --->
			<cfif badtag.pos[1]>		
				<!--- replace the occurence with an escaped version if that is the mode, and do them all while we're at it --->
				<cfset TheText = Replace(TheText,Mid(TheText,badtag.pos[1],badtag.len[1]),HTMLEditFormat(Mid(TheText,badtag.pos[1],badtag.len[1])),"ALL")>
				<!--- start the search for the next open bracket after the length of what you replaced --->
				<cfset NextStart = badtag.pos[1] + badtag.len[1]>
			<!--- by default, start the next search for an open bracket at the character after this one --->
			<cfelse>
				<cfset NextStart = obracket + 1>
			</cfif>		
			<!--- find the next open bracket --->
			<cfset obracket = Find("<", TheText,NextStart)>
		</cfloop>	
	<!--- if the mode is anything other than "escape", just delete the offending tags --->
	<cfelse>
		<cfset TheText = REReplaceNoCase(TheText,StripperRE,"","ALL")>	
	</cfif>
	<!--- now take care of the bad event handlers by just stripping them right out --->
	<cfset TheText = REReplaceNoCase(TheText,(ListChangeDelims(attributes.badevents,"|")),"","ALL")>
	<!--- deal with smart quotes from MS Word --->
	<cfset TheText = REReplace(TheText,"(’|‘)", "'", "ALL")>
	<!--- IF OUTPUTTING, DO SO --->
	<cfif attributes.output>
		<cfset ThisTag.GeneratedContent = TheText>
	<!--- IF NOT OUTPUTTING, MAKE THE VARIABLE --->
	<cfelse>
		<cfparam name="attributes.name" default="SafeText">
		<cfset "caller.#attributes.name#" = TheText>
		<cfset ThisTag.GeneratedContent = "">
	</cfif>
</cfif>


