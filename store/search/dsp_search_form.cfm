<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the form for the site search, this page is used as the default file for the 'search form' page template --->

<cfparam name="attributes.string" default="please enter a search term...">

<cfoutput>
<blockquote>
<form name="searchform" action="#self#?fuseaction=page.searchresults#request.token2#" method="post" class="margins">
<input type="text" name="string" value="#HTMLEditFormat(attributes.string)#"size="30" maxlength="100" class="formfield" onfocus="searchform.string.value = '';" />
<input type="submit" value="search" class="formbutton"/><br/><br/>
<cfif request.appsettings.UseVerity>
You can use AND and OR to specify whether to <br/>
find any or all of the search words.<br/><br/>

Or use * for a wildcard search (e.g. prod*)
<cfelse>
<input type="radio" name="all_words" value="1" checked="checked" />Match all words
&nbsp;&nbsp;&nbsp;
<input type="radio" name="all_words" value="0" />Match any words
</cfif> 
</form>
</blockquote>
</cfoutput>
