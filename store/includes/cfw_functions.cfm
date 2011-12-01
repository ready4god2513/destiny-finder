
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This page is used to call global functions used for CFWebstore pages. Include into your layout files --->

<!--- Function for formatting strings to safe filenames --->

<cfscript> 
// this function replaces illegal characters in product/category/feature/pages names for creating SES links
function SESFile(str){ 	
	var strip = LCase(Replace(str,' ','-', "ALL"));
	strip= ReReplace(strip,"[^\w\d-]+","","ALL");
	strip = strip & '.cfm';
	return strip;
} 

// used to sanitize text strings to use in queries
function sanitize(str) {
	var strip= ReReplace(str,"[^\w\d\s-]+","","ALL");
	return strip;
}

/**
 * Creates the RegEx to test a string for possible SQL injection.
 * 
 * @return Returns string. 
 * @author Luis Melo (luism@grouptraveltech.com)
 * @original author Gabriel Read
 * @version 1, July 25, 2008
 * @version 2, July 28, 2008
 * @version 3, August 20, 2008
 */ 
function checkSQLInject() {
	var insSql = 'insert|delete|select|update|create|alter|drop|truncate|grant|revoke|declare|' & 
				 'exec|backup|restore|sp_|xp_|set|execute|dbcc|deny|union|Cast|Char|Varchar|nChar|nVarchar';
 
	 // Build the regex 
	 var regEx = '((or)+[[:space:]]*\(*''?[[:print:]]+''?' &
		  		 '([[:space:]]*[\+\-\/\*][[:space:]]*''?' &
		  		 '[[:print:]]+''?)*\)*[[:space:]]*' &
		  		 '(([=><!]{1,2}|(like))[[:space:]]*\(*''?' &
		  		 '[[:print:]]+''?([[:space:]]*[\+\-\/\*]' &
		 		 '[[:space:]]*''?[[:print:]]+''?)*\)*)|((in)' &
		 		 '[[:space:]]*\(+[[:space:]]*''?[[:print:]]+''?' &
		 		 '(\,[[:space:]]*''?[[:print:]]+''?)*\)+)|' &
		 		 '((between)[[:space:]]*\(*[[:space:]]*''?' &
		 		 '[[:print:]]+''?(\,[[:space:]]*''?[[:print:]]+''?)' &
		 		 '*\)*(and)[[:space:]]+\(*[[:space:]]*''?[[:print:]]+''?' &
		 		 '(\,[[:space:]]*''?[[:print:]]+''?)*\)*)|((;)([^a-z>]*)' &
		 		 '(#insSql#)([^a-z]+|$))|(union[^a-z]+(all|select))|(\/\*)|(--$))';
		  
	return regEx;
}

function loadPattern() {
/**
 * Build the java pattern matcher
 * 
 * @return Returns object. 
 * @author Gabriel Read from CF-Talk (gabe@evolution7.com)
 * @version 1, July 28, 2008
 * @version 2, August 15, 2008
 */ 
	// Build the java pattern matcher 
	
	var reMatcher = '';
	var blacklist = checkSQLInject();
	var rePattern = createObject('java', 'java.util.regex.Pattern'); 
	rePattern = rePattern.compile(blackList); 	
	return rePattern;
}

/**
 * This function checks the URL, form, and cookie scopes, and selected CGI variables for SQL Injection
 * Updated to also check for XSS attacks
 * 
 * @return Returns boolean. 
 * @author Mary Jo Sminkey
 * @version 1, July 25, 2008
 * @version 2, July 28, 2008
 * @version 3, August 15, 2008
 * @version 4, August 20, 2008
 * @version 5, July 5, 2009
 */ 
function checkforattack() {
	
	var hackattempt = 'no';
	var testvar = '';
	var reMatcher = '';
	var CGIvars = 'script_name,remote_addr,query_string,path_info,http_referer,http_user_agent,server_name';
	var Tokens = 'CFID,CFTOKEN';
	var i = 1;
	
	//Make sure the Matcher is available in Application Scope
	if (NOT StructKeyExists(Application, 'regExChecker')) {
		Application.regExChecker = loadPattern();
	}
	
	//load matcher
	reMatcher = Application.regExChecker.matcher('');
	
	//Check URL scope for SQL Injection and XSS attacks
	for (testvar in URL) {
		if (reMatcher.reset(lcase(URL[testvar])).find()) {
			hackattempt="yes";
			}
		else if (ReFind("\<[[:space:]]?script",lcase(URL[testvar]))) {
			hackattempt="yes";
			}
		else if (ListFindNoCase(Tokens,testvar) AND sanitize(URL[testvar]) NEQ URL[testvar]) {
			hackattempt="yes";
			}
	}
		
	//check form scope
	for (testvar in FORM) {
		if (testvar IS NOT "fieldnames" AND reMatcher.reset(lcase(FORM[testvar])).find()) {
			hackattempt="yes";
		}
		else if (testvar IS NOT "fieldnames" AND ReFind("\<[[:space:]]?script",lcase(FORM[testvar]))) {
			hackattempt="yes";
			}
	}
	
	//Check cookie scope
	for (testvar in COOKIE) {
		if (reMatcher.reset(lcase(COOKIE[testvar])).find()) {
			hackattempt="yes";
		}
		else if (ReFind("\<[[:space:]]?script",lcase(COOKIE[testvar]))) {
			hackattempt="yes";
			}
		else if (ListFindNoCase(Tokens,testvar) AND sanitize(COOKIE[testvar]) NEQ COOKIE[testvar]) {
			hackattempt="yes";
			}
	}
	
	//Check CGI scope 
	for (i=1; i LTE ListLen(CGIvars); i=i+1) {
		testvar = ListGetAt(CGIvars, i);
		if (StructKeyExists(CGI, testvar) AND reMatcher.reset(lcase(CGI[testvar])).find()) {
			hackattempt="yes";
		}
		else if (StructKeyExists(CGI, testvar) AND ReFind("\<[[:space:]]?script",lcase(CGI[testvar]))) {
			hackattempt="yes";
			}
	}

	return hackattempt;
}

// this function determines the type of browser being used, to detect search engine crawlers
function getBrowserType(user_agent){ 
	
	var BrowserType = StructNew();
	
	BrowserType.browserName="Unknown"; 
	BrowserType.browserVersion="0"; 
	
	if (Len(user_agent)) { 

		if (FindNoCase("spider", user_agent)
		or FindNoCase("crawl", user_agent)
		or ReFindNoCase("bot\b", user_agent)
		or ReFindNoCase("\brss", user_agent)
		or FindNoCase("seek", user_agent)
		or FindNoCase("feed", user_agent)
		or FindNoCase("news", user_agent)
		or FindNoCase("blog", user_agent)
		or FindNoCase("reader", user_agent)
		or FindNoCase("syndication", user_agent)
		or FindNoCase("zyborg", user_agent)
		or FindNoCase("emonitor", user_agent)
		or FindNoCase("jeeves", user_agent)
		or FindNoCase("gulliver", user_agent)
		or FindNoCase("search", user_agent)
		or FindNoCase("vista", user_agent)
		or FindNoCase("yahoo", user_agent)
		or FindNoCase("widow", user_agent)
		or FindNoCase("wiki", user_agent)
		or FindNoCase("slurp", user_agent)
		or FindNoCase("netattache", user_agent)
		or FindNoCase("crescent", user_agent)
		or FindNoCase("check", user_agent)
		or FindNoCase("heritrix", user_agent)
		or FindNoCase("locator", user_agent)
		or FindNoCase("scooter", user_agent)
		or FindNoCase("archive", user_agent)
		or FindNoCase("Crescent", user_agent)
		or FindNoCase("webtrends", user_agent)) {
		 BrowserType.browserName="spider"; 
		}
		
	  else if (FindNoCase("LWP::Simple", user_agent)  	
		or FindNoCase("libwww-perl", user_agent)) {
	  	BrowserType.browserName="hack attempt"; 
		}
		
	  else if (Find("MSIE",user_agent)) {
	    BrowserType.browserName="MSIE"; 
		BrowserType.browserVersion=Val(RemoveChars(user_agent,1,Find("MSIE",user_agent)+4)); 
	  } 
	  
	  else if (Find("Firefox",user_agent)) {
	    BrowserType.browserName="Firefox"; 
		BrowserType.browserVersion=Val(RemoveChars(user_agent,1,Find("Firefox/",user_agent)));
	  } 
	  
	  else if (Find("Mozilla",user_agent)) {
	
	      if (not Find("compatible",user_agent)) {
	        BrowserType.browserName="Netscape"; 
			BrowserType.browserVersion=Val(RemoveChars(user_agent,1,Find("/",user_agent))); 
	      } 
	      else { 
	        BrowserType.browserName="compatible"; 
	      } 
		 }
	   else if (Find("ColdFusion",user_agent)) {
	      BrowserType.browserName="ColdFusion"; 
	    } 

  } 
  
  return BrowserType;
	
}

// this function replaces ambersands in a string with the ascii equivalent
function XHTMLFormat(str){ 	
	var formattedstr = Replace(str, "&", "&amp;", "ALL");
	return formattedstr;
} 

// used to make the text string that will output the javascript mouseover functions in link
function doMouseover(str){ 	
	//replace any double-quotes
	var strip = Replace(str, '"', '', 'ALL');
	strip = JSStringFormat(strip);
	returnstring = 'onmouseover="dmim(''' & strip & '''); return document.returnValue;" ';
	returnstring = returnstring & 'onmouseout="dmim(''''); return document.returnValue;"';
	return returnstring;
} 

// used to output XHTML-safe selectboxes
function doSelected(fieldToCheck) {
	var returnstring = '';
	var theCheck = 0;
	//if there is a second argument, use that for the value to compare
	if(arrayLen(arguments) GT 1) {
		theCheck = arguments[2];
		if (fieldToCheck IS theCheck) 
			returnstring = 'selected="selected"';
		}
	//if no second argument, we are checking to see if this value is not 0
	else if (fieldToCheck IS NOT theCheck) {
		returnstring = 'selected="selected"';	
		}
		
	return returnstring;	
}

// used to output XHTML-safe checkboxes
function doChecked(fieldToCheck) {
	var returnstring = '';
	var theCheck = 0;
	//if there is a second argument, use that for the value to compare
	if(arrayLen(arguments) GT 1) {
		theCheck = arguments[2];
		if (fieldToCheck IS theCheck) 
			returnstring = 'checked="checked"';
		}
	//if no second argument, we are checking to see if this value is not 0
	else if (fieldToCheck IS NOT theCheck) {
		returnstring = 'checked="checked"';	
		}
	
	return returnstring;	
}


function doAdmin() {
	var returnstring = 'class="menu_admin" ';
	//if admin links open new window, create the link
	if (Request.AppSettings.admin_new_window) {
		returnstring = returnstring & 'target="admin"'; }
	
	return returnstring;
}

// used to convert the database values for the various Priority fields 
function doPriority(valueToCheck) {
	var returnstring = '';
	var theCheck = 9999;
	//if there is a second argument, use that as the default value to return
	if(arrayLen(arguments) GT 1)
		returnstring = arguments[2];
	//if there is a third argument, use that for the value to compare
	if(arrayLen(arguments) GT 2)
		theCheck = arguments[3];
	if (len(valueToCheck) AND valueToCheck IS NOT theCheck) 
		returnstring = valueToCheck;
	
	return returnstring;	
}

/**
 * Makes a row of a query into a structure.
 * 
 * @param query 	 The query to work with. 
 * @param row 	 Row number to check. Defaults to row 1. 
 * @return Returns a structure. 
 * @author Nathan Dintenfass (nathan@changemedia.com) 
 * @version 1, December 11, 2001 
 */
function queryRowToStruct(query){
	//by default, do this to the first row of the query
	var row = 1;
	//a var for looping
	var ii = 1;
	//the cols to loop over
	var cols = listToArray(query.columnList);
	//the struct to return
	var stReturn = structnew();
	//if there is a second argument, use that for the row number
	if(arrayLen(arguments) GT 1)
		row = arguments[2];
	//loop over the cols and build the struct from the query row
	for(ii = 1; ii lte arraylen(cols); ii = ii + 1){
		stReturn[cols[ii]] = query[cols[ii]][row];
	}		
	//return the struct
	return stReturn;
}

/**
 * Tests passed value to see if it is a valid e-mail address (supports subdomain nesting and new top-level domains).
 * Update by David Kearns to support '
 * SBrown@xacting.com pointing out regex still wasn't accepting ' correctly.
 * More TLDs
 * Version 4 by P Farrel, supports limits on u/h
 * 
 * @param str 	 The string to check. (Required)
 * @return Returns a boolean. 
 * @author Jeff Guillaume (SBrown@xacting.comjeff@kazoomis.com) 
 * @version 4, December 30, 2005 
 */
function isEmail(str) {
    return (REFindNoCase("^['_a-z0-9-]+(\.['_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*\.(([a-z]{2,3})|(aero|coop|info|museum|name|jobs|travel))$",
arguments.str) AND len(listGetAt(arguments.str, 1, "@")) LTE 64 AND
len(listGetAt(arguments.str, 2, "@")) LTE 255) IS 1;
}

</cfscript>


