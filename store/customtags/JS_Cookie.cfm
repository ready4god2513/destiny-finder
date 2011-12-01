<!--- 
	cf_cookie
	written by bdope
	
	Tag Usage:
	<cf_cookie name="NameOfCookie" value="ValueOfCookie" expires="NOW|NEVER" location="http://www.wherever.com">
	
	Attributes:
	NAME (required)		: sets the name of the cookie.
	VALUE (optional)	: sets the value of the cookie. defaults to blank.
	EXPIRES (optional)	: sets cookie to expire if value is to "NOW", expires in a year if value is set to "NEVER".
	LOCATION (optional)	: sets the url to relocate to after cookie is set.
 --->

<cfparam name="cgi.http_host" default="">
<cfparam name="attributes.name" default="">
<cfparam name="attributes.value" default="">
<cfparam name="attributes.expires" default="">
<cfparam name="attributes.location" default="">
<cfparam name="attributes.domain" default=".#ListRest(cgi.http_host,'.')#">

<cfif not len(trim(attributes.name))>
	<b>Please enter a name attribute for the cookie.</b><cfexit>
</cfif>

<cfoutput>
<cfprocessingdirective suppresswhitespace="no">
<script type="text/javascript">
	function fixDate(date) {
	  var base=new Date(0);
	  var skew=base.getTime();
	  if(skew>0)
	    date.setTime(date.getTime()-skew);
	}
	<cfif attributes.expires is "NOW">
		var ThreeDays=3 * 24 * 60 * 60 * 1000;
		var expirdate=new Date();
		expirdate.setTime (expirdate.getTime()-ThreeDays);
	<cfelseif attributes.expires is "NEVER">
		/* create an instance of the Date object */
		var expirdate=new Date();
		/* fix the bug in Navigator 2.0, Macintosh */
		fixDate(expirdate);
		/* cookie expires in one year (actually, 365 days)
			 365 days in a year
			 24 hours in a day
			 60 minutes in an hour
			 60 seconds in a minute
			 1000 milliseconds in a second */
		expirdate.setTime(expirdate.getTime() + 365 * 24 * 60 * 60 * 1000);
	</cfif>
	
	document.cookie="#attributes.name#=#attributes.value#;path=/;domain=#attributes.domain#;"<cfif len(trim(attributes.expires))>+"expires=" + expirdate.toGMTString();</cfif>
	<cfif len(trim(attributes.location))>"#trim(attributes.location)#";</cfif>
</script>
</cfprocessingdirective>
</cfoutput>
