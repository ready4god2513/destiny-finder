<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Outputs the features search form. Used by dsp_results.cfm --->

<cfparam name="attributes.search_string" default="">
<cfparam name="attributes.title" default="">
<cfparam name="attributes.all_words" default="1">

<cfoutput>
<form action="#XHTMLFormat('#self#?fuseaction=feature.search#request.token2#')#" method="post" name="catsearchform">

<cfmodule template="../customtags/format_input_form.cfm"
box_title="Feature Search"
required_Fields="0"
>
	<tbody> 
	<tr align="left"> 
         <td align="right" valign="top">title, author</td>
		 <td><img src="#Request.AppSettings.defaultimages#/spacer.gif" alt="" width="1" height="1" /></td>
          <td valign="bottom"><input name="title" size="35" class="formfield"  value="#HTMLEditFormat(attributes.title)#"/>
</td>
    </tr>
	<tr align="left"> 
         <td align="right" valign="top">words in text</td>
		 <td><img src="#Request.AppSettings.defaultimages#/spacer.gif" alt="" width="1" height="1" /></td>
          <td valign="bottom"><input name="search_string" size="35" class="formfield"  value="#HTMLEditFormat(attributes.search_string)#"/><br/>
<input type="radio" name="all_words" value="1" #doChecked(attributes.all_words)# />Match all words
	&nbsp;&nbsp;&nbsp;
<input type="radio" name="all_words" value="0" #doChecked(attributes.all_words,0)# />Match any words
</td>
    </tr>
	
	<tr align="left">
		<td colspan="2">&nbsp;</td>
		<td>
 	 	<input type="submit" name="Feature_searchsubmit" value="search" class="formbutton"/>
		</td>
	</tr>
	
	</tbody>
</cfmodule>
</form>

</cfoutput>