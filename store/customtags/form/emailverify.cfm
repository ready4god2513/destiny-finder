<!--- ================================================================================= --->
<!---                      																															--->
<!--- NAME:                    																													--->
<!---  CF_EmailVerify                 																									--->
<!---                      																															--->
<!---                      																															--->
<!--- PURPOSE:                      																										--->
<!---  To determine if an Email Address is properly formatted by checking:  			 			--->
<!---                      																															--->
<!---  - For at least 6 characters in the email (a@a.co)        												--->
<!---  - The User portion of the email to have at least 1 character     								--->
<!---  - The Domain portion of the email to contain at least 2 parts     								--->
<!---  - The Last Domain Element of the email to contain between 2 and 5 characters 		--->
<!---  - For only 1 @ symbol and must be within the email address      									--->
<!---  - For at least 1 period and must be within the email address     								--->
<!---  - CompuServe users that forget to replace the comma with a period   				 			--->
<!---  - For No Spaces within the email address          																--->
<!---  - All non-AlphaNumeric characters within the email address      									--->
<!---                      																															--->
<!---                      																															--->
<!--- ATTRIBUTES:                   																										--->
<!---  Email  (required)               																									--->
<!---                     																															--->
<!---                      																															--->
<!--- NOTES:                   																													--->
<!---  This Tag creates a variable called #emailerror#         													--->
<!---                      																															--->
<!---   0 = No Errors Found in the Email Address         																--->
<!---   1 = Yes Errors Found in the Email Address         															--->
<!---                      																															--->
<!--- *** A value of '1' WILL GENERATE a SECOND VARIABLE called #err_msg#   *** 				--->
<!---                      																															--->
<!---    This contains the error message in regards to the email address   							--->
<!---                      																															--->
<!---                      																															--->
<!--- USAGE:                    																												--->
<!---    <CF_EmailVerify Email="value">           																			--->
<!---                      																															--->
<!---    The value can be another variable such as #emailaddr# for example.  						--->
<!---                      																															--->
<!---    Place the <CF_EmailVerify> tag in your Action web page.  Then on the 		 			--->
<!---    next line in the page test for the value of #emailerror# and if it   					--->
<!---    equals 1, you can stop processing and display the error message   							--->
<!---    regarding the incorrect email address.  Or check for the existence of		   		--->
<!---   the #err_msg#.  Or pass the message back to your form so the user has 					--->
<!---    the ability to correct it.             																				--->
<!---                      																															--->
<!---                      																															--->
<!--- AUTHOR:                    																												--->
<!---  Steven Semrau (ssemrau@home.com)            																			--->
<!---                      																															--->
<!---                      																															--->
<!--- DATE:                     																												--->
<!---  22nd of October 1999               																							--->
<!---                      																															--->
<!---                      																															--->
<!--- MODIFICATION LOG:                 																								--->
<!--- 	DATE    	AUTHOR    		NOTES           																				--->
<!--- 	====   		======    		===================================================			--->
<!--- 	10/27/99  Steven Semrau	Tag was posted on Allaire web site for Freeware use			--->
<!---   06/28/00	M. Sean Neal	Changed Cfexit method from default(abort template) to   --->
<!---                      			exit template																						--->
<!---                      																															--->
<!--- ================================================================================= --->

<!--- ================================================================================= --->
<!--- Checking for and setting required attribute           														--->
<!---                       																														--->
<!--- ATTRIBUTES.email  must contain a value (email address) to continue.				   			--->
<!--- ================================================================================= --->

<cfif IsDefined("attributes.email") IS "FALSE">
	<cfabort showerror = "The EmailVerify Custom Tag has halted, the EMAIL attribute is required!">
<cfelse>
	<cfset email = attributes.email>
</cfif>
<!--- ================================================================================= --->
<!--- Initialize Error Flag Variable to 0 (False)... no errors found.     							--->
<!--- ================================================================================= --->
<cfset caller.emailerror = "0">
<!--- ================================================================================= --->
<!--- Check to ensure the total length of the email address is atleast 7 characters.	 	--->
<!--- ================================================================================= --->
<cfif Len(email) LT 6>
	<cfset caller.err_msg = "The e-mail address is shorter than the smallest possible valid e-mail address of 6 characters.">
	<cfset caller.emailerror = "1">
	<cfexit method="exittemplate">
</cfif>
<!--- ================================================================================= --->
<!--- tev is a local (smaller) var name for testing --- TEV (Test Email Verify)   			--->
<!--- ================================================================================= --->
<cfset tev = Trim(attributes.email)>
<!--- ================================================================================= --->
<!--- tevUsr is the portion of the email address before the @ symbol (User)    					--->
<!--- tevDom is the portion of the email address after the @ symbol (Domain)   					--->
<!--- ================================================================================= --->
<cfset tevUsr = ListFirst(tev,"@")>
<cfset tevDom = ListLast(tev,"@")>
<!--- ================================================================================= --->
<!--- At least 1 character must be present in the User portion.       									--->
<!--- ================================================================================= --->
<cfif Len(tevUsr) lt 1>
	<cfset caller.err_msg = "The user portion of the e-mail address was not valid.">
	<cfset caller.emailerror = "1">
	<cfexit method="exittemplate">
</cfif>

<!--- ================================================================================= --->
<!--- At least 2 sections must be present in the Domain name.        										--->
<!--- ================================================================================= --->
<cfif ListLen(tevDom,".") lt 2>
	<cfset caller.err_msg = "The server portion of the e-mail address was not valid, there must be at least 2 parts to the domain (i.e.. gsa.gov)">
	<cfset caller.emailerror = "1">
	<cfexit method="exittemplate">
</cfif>
<!--- ================================================================================= --->
<!--- Test for the length of the last part of the domain.  Between 2 and 5 characters.  --->
<!--- ================================================================================= --->
<cfif Len(ListLast(tevDom,".")) GT 5 OR Len(ListLast(tevDom,".")) LT 2>
	<cfset caller.err_msg = "The server portion of the e-mail address was not valid; Most end with .com">
	<cfset caller.emailerror = "1">
	<cfexit method="exittemplate">
</cfif>
<!--- ================================================================================= --->
<!--- Test for all non-AlphaNumeric characters.           															--->
<!--- ================================================================================= --->
<cfif findnocase('@',email) is 0>
	<cfset caller.err_msg = "No @ sign detected.  An @ sign is part of every e-mail address.">
	<cfset caller.emailerror = "1">
	<cfexit method="exittemplate">
</cfif>
<cfif right(email,1) is "@">
	<cfset caller.err_msg = "An @ sign cannot be the last character of the e-mail address.">
	<cfset caller.emailerror = "1">
	<cfexit method="exittemplate">
</cfif>
<cfif left(email,1) is "@">
	<cfset caller.err_msg = "An @ sign cannot be the first character of the e-mail address.">
	<cfset caller.emailerror = "1">
	<cfexit method="exittemplate">
</cfif>
<cfif findnocase('@',email,(findnocase('@',email) + 1))>
	<cfset caller.err_msg = "A valid e-mail address contains only one @ sign.">
	<cfset caller.emailerror = "1">
	<cfexit method="exittemplate">
</cfif>
<cfif findnocase('.',email) is 0>
	<cfset caller.err_msg = "No period detected.  An e-mail address contains at least one period.">
	<cfset caller.emailerror = "1">
	<cfexit method="exittemplate">
</cfif>
<cfif right(email,1) is ".">
	<cfset caller.err_msg = "The last character of the e-mail address cannot be a period.">
	<cfset caller.emailerror = "1">
	<cfexit method="exittemplate">
</cfif>
<cfif left(email,1) is ".">
	<cfset caller.err_msg = "The first character of the e-mail address cannot be a period.">
	<cfset caller.emailerror = "1">
	<cfexit method="exittemplate">
</cfif>
<cfif findnocase(',',email)>
	<cfset caller.err_msg = "A valid e-mail address cannot contain a comma.  If you have a CompuServe account, substitute a period for the comma in your CompuServe ID, like so: 12345.6789@compuserve.com">
	<cfset caller.emailerror = "1">
	<cfexit method="exittemplate">
</cfif>
<cfif findnocase(' ',email)>
	<cfset caller.err_msg = "You cannot have a space in an e-mail address.">
	<cfset caller.emailerror = "1">
	<cfexit method="exittemplate">
</cfif>
<cfif findnocase('~',email)>
	<cfset caller.err_msg = "You cannot have a tilde ( ~ ) in an e-mail address.">
	<cfset caller.emailerror = "1">
	<cfexit method="exittemplate">
</cfif>
<cfif findnocase('`',email)>
	<cfset caller.err_msg = "You cannot have a reverse quote ( ` ) in an e-mail address.">
	<cfset caller.emailerror = "1">
	<cfexit method="exittemplate">
</cfif>
<cfif findnocase('!',email)>
	<cfset caller.err_msg = "You cannot have an exclamation point ( ! ) in an e-mail address.">
	<cfset caller.emailerror = "1">
	<cfexit method="exittemplate">
</cfif>
<cfif findnocase(chr(35),email)>
	<cfset caller.err_msg = "You cannot have a ( Hash / Pound symbol ) in an e-mail address.">
	<cfset caller.emailerror = "1">
	<cfexit method="exittemplate">
</cfif>
<cfif findnocase('$',email)>
	<cfset caller.err_msg = "'You cannot have a dollar sign ( $ ) in an e-mail address.">
	<cfset caller.emailerror = "1">
	<cfexit method="exittemplate">
</cfif>
<cfif findnocase('%',email)>
	<cfset caller.err_msg = "You cannot have a percent sign ( % ) in an e-mail address.">
	<cfset caller.emailerror = "1">
	<cfexit method="exittemplate">
</cfif>
<cfif findnocase('^',email)>
	<cfset caller.err_msg = "You cannot have a carrot sign ( ^ ) in an e-mail address.">
	<cfset caller.emailerror = "1">
	<cfexit method="exittemplate">
</cfif>
<cfif findnocase(chr(38),email)>
	<cfset caller.err_msg = "You cannot have an ampersand ( AND symbol ) in an e-mail address.">
	<cfset caller.emailerror = "1">
	<cfexit method="exittemplate">
</cfif>
<cfif findnocase('*',email)>
	<cfset caller.err_msg = "You cannot have an asterisk ( * ) in an e-mail address.">
	<cfset caller.emailerror = "1">
	<cfexit method="exittemplate">
</cfif>
<cfif findnocase('(',email)>
	<cfset caller.err_msg = "You cannot have an open parenthesis sign in an e-mail address.">
	<cfset caller.emailerror = "1">
	<cfexit method="exittemplate">
</cfif>
<cfif findnocase(')',email)>
	<cfset caller.err_msg = "You cannot have a close parenthesis sign in an e-mail address.">
	<cfset caller.emailerror = "1">
	<cfexit method="exittemplate">
</cfif>
<cfif findnocase(chr(43),email)>
	<cfset caller.err_msg = "You cannot have a ( plus sign ) in an e-mail address.">
	<cfset caller.emailerror = "1">
	<cfexit method="exittemplate">
</cfif>
<cfif findnocase(chr(61),email)>
	<cfset caller.err_msg = "You cannot have an ( equal sign ) in an e-mail address.">
	<cfset caller.emailerror = "1">
	<cfexit method="exittemplate">
</cfif>
<cfif findnocase('{',email)>
	<cfset caller.err_msg = "You cannot have a evaluation open bracket ( { ) in an e-mail address.">
	<cfset caller.emailerror = "1">
	<cfexit method="exittemplate">
</cfif>
<cfif findnocase('[',email)>
	<cfset caller.err_msg = "You cannot have a square open bracket ( [ ) in an e-mail address.">
	<cfset caller.emailerror = "1">
	<cfexit method="exittemplate">
</cfif>
<cfif findnocase('}',email)>
	<cfset caller.err_msg = "You cannot have a evaluation close bracket ( } ) in an e-mail address.">
	<cfset caller.emailerror = "1">
	<cfexit method="exittemplate">
</cfif>
<cfif findnocase(']',email)>
	<cfset caller.err_msg = "You cannot have a square close bracket ( ] ) in an e-mail address.">
	<cfset caller.emailerror = "1">
	<cfexit method="exittemplate">
</cfif>
<cfif findnocase(chr(124),email)>
	<cfset caller.err_msg = "You cannot have a ( PIPE symbol ) in an e-mail address.">
	<cfset caller.emailerror = "1">
	<cfexit method="exittemplate">
</cfif>
<cfif findnocase('\',email)>
	<cfset caller.err_msg = "You cannot have a backslash ( \ ) in an e-mail address.">
	<cfset caller.emailerror = "1">
	<cfexit method="exittemplate">
</cfif>
<cfif findnocase(':',email)>
	<cfset caller.err_msg = "You cannot have a colon ( : ) in an e-mail address.">
	<cfset caller.emailerror = "1">
	<cfexit method="exittemplate">
</cfif>
<cfif findnocase(';',email)>
	<cfset caller.err_msg = "You cannot have a semicolon ( ; ) in an e-mail address.">
	<cfset caller.emailerror = "1">
	<cfexit method="exittemplate">
</cfif>
<cfif findnocase(chr(34),email)>
	<cfset caller.err_msg = "You cannot have a ( double quote ) in an e-mail address.">
	<cfset caller.emailerror = "1">
	<cfexit method="exittemplate">
</cfif>
<cfif findnocase(chr(39),email)>
	<cfset caller.err_msg = "You cannot have an ( Apostrophe ) in an e-mail address.">
	<cfset caller.emailerror = "1">
	<cfexit method="exittemplate">
</cfif>
<cfif findnocase(chr(60),email)>
	<cfset caller.err_msg = "You cannot have a ( Less Then symbol ) in an e-mail address.">
	<cfset caller.emailerror = "1">
	<cfexit method="exittemplate">
</cfif>
<cfif findnocase(chr(62),email)>
	<cfset caller.err_msg = "You cannot have a ( Greater Then sign ) in an e-mail address.">
	<cfset caller.emailerror = "1">
	<cfexit method="exittemplate">
</cfif>
<cfif findnocase('?',email)>
	<cfset caller.err_msg = "You cannot have a question mark ( ? ) in an e-mail address.">
	<cfset caller.emailerror = "1">
	<cfexit method="exittemplate">
</cfif>
<cfif findnocase('/',email)>
	<cfset caller.err_msg = "You cannot have a forwardslash ( / ) in an e-mail address.">
	<cfset caller.emailerror = "1">
	<cfexit method="exittemplate">
</cfif>
<!--- ================================================================================= --->
<!--- END OF ERROR CHECKING FOR VALID CHARACTERS WITHIN THE PROVIDED EMAIL ADDRESS 		 	--->
<!--- ================================================================================= --->