
<!---
NAME:         	cf_validate_email
FILE:	        validate_email.cfm
VERSION:	  	1.0
CREATED:	 	12/17/1999
LAST MODIFIED:	12/17/1999

DESCRIPTION:  	This is a custom CFML tag that takes an email address passed
				as a variable and determines if it is syntactically valid
				using regular expression.

				It returns 1 for a valid email address, and 0 otherwise.

INPUT:			email (required)

OUTPUT:			ok

EXAMPLE			<cf_validate_email email="franky@kuentos.guam.net">
				<cfif ok>
					The email address seems to be OK!
				<cfelse>
					The email address is not OK!
				</cfif>
--->

<cfif ThisTag.ExecutionMode is 'start'>
	<cfparam name="attributes.email">
	<cfif attributes.email is not "" and not REFindNoCase("^[a-z0-9_%\.-]+@([a-z0-9_\-]+\.)+[a-z]+(,[a-z0-9_\%\.-]+@([a-z0-9_-]+\.)+[a-z]+)*$", attributes.email)>
		<cfset caller.ok = 0>
	<cfelse>
		<cfset caller.ok = 1>
	</cfif>
</cfif>



