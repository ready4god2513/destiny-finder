<cfinclude template="../Application.cfc" />

<!--- 
	We can override specific configuration if needed.  
	See http://www.bennadel.com/blog/2014-Extending-The-Application-cfc-ColdFusion-Framework-Component-With-CFInclude.htm 
--->

<cfif cgi.https EQ 'off'>
	<cfset vRedirectURL = '/auth/index.cfm?' & cgi.QUERY_STRING >
    <cflocation url="#vRedirectURL#" />
</cfif>

<!--- Application name, should be unique --->
<cfset this.name = "destinyfinder_user" />
	
<!--- Run before the request is processed --->
<cffunction name="_onRequestStart" returnType="boolean" output="false">
	<cfargument name="thePage" type="string" required="true">
	
	<cfset super.onRequestStart( arguments[ 1 ] ) />
	
	<cfset DSN="destinyfinder_cms">
	<cfset APPLICATION.DSN = "#DSN#">
	
	<cfreturn true>
</cffunction>

<!---
	Create a super scope to fake component extension. Any function
	that we override, we have to keep a reference to it in this super
	scope since we will have to overwrite the reference to it.
--->
<cfset super = {} />


<!---
	In order to get around having dupliate function declarations, we
	had to name any sub-functions (that override root functions) to
	start with an "_". Now, we need to point the
 
	Loop over this component and point any method that starts with
	"_" to the target method name (who's reference should now be
in super).
--->
<cfloop item="key" collection="#variables#">
 
	<!--- Chectk for a "local" method. --->
	<cfif reFind( "^_", key )>
 
		<!--- Copy oritinal reference into the fake super scope. --->
		<cfset super[ listFirst( key, "_" ) ] = variables[ listFirst( key, "_" ) ] />
 
		<!--- Now, move the "_" method in the main CFC scopes. --->
		<cfset this[ listFirst( key, "_" ) ] = this[ key ] />
		<cfset variables[ listFirst( key, "_" ) ] = variables[ key ] />
 
	</cfif>
 
</cfloop>