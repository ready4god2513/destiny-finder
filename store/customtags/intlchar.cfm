
<!--- CFWebstore�, version 6.43 --->

<!--- CFWebstore� is �Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This tag converts all "international" letters to their ASCII code equivalent
	  for database storage and correct HTML display.  Also included are some common
	  symbols and currency marks. --->
	  
<CFSET String = Attributes.String>

<!--- Begin Int'l Character Test Area --->

<CFIF Find('�',String) is not 0><CFSET String = Replace(String,'�','&Agrave;','ALL')></CFIF>
<CFIF Find('�',String) is not 0><CFSET String = Replace(String,'�','&Aacute;','ALL')></CFIF>
<CFIF Find('�',String) is not 0><CFSET String = Replace(String,'�','&Acirc;','ALL')></CFIF>
<CFIF Find('�',String) is not 0><CFSET String = Replace(String,'�','&Atilde;','ALL')></CFIF>
<CFIF Find('�',String) is not 0><CFSET String = Replace(String,'�','&Auml;','ALL')></CFIF>
<CFIF Find('�',String) is not 0><CFSET String = Replace(String,'�','&Aring;','ALL')></CFIF>
<CFIF Find('�',String) is not 0><CFSET String = Replace(String,'�','&AElig;','ALL')></CFIF>
<CFIF Find('�',String) is not 0><CFSET String = Replace(String,'�','&Ccedil;','ALL')></CFIF>
<CFIF Find('�',String) is not 0><CFSET String = Replace(String,'�','&Egrave;','ALL')></CFIF>
<CFIF Find('�',String) is not 0><CFSET String = Replace(String,'�','&Eacute;','ALL')></CFIF>
<CFIF Find('�',String) is not 0><CFSET String = Replace(String,'�','&Ecirc;','ALL')></CFIF>
<CFIF Find('�',String) is not 0><CFSET String = Replace(String,'�','&Euml;','ALL')></CFIF>
<CFIF Find('�',String) is not 0><CFSET String = Replace(String,'�','&Igrave;','ALL')></CFIF>
<CFIF Find('�',String) is not 0><CFSET String = Replace(String,'�','&Iacute;','ALL')></CFIF>
<CFIF Find('�',String) is not 0><CFSET String = Replace(String,'�','&Icirc;','ALL')></CFIF>
<CFIF Find('�',String) is not 0><CFSET String = Replace(String,'�','&Iuml;','ALL')></CFIF>
<CFIF Find('�',String) is not 0><CFSET String = Replace(String,'�','&Ntilde;','ALL')></CFIF>
<CFIF Find('�',String) is not 0><CFSET String = Replace(String,'�','&Ograve;','ALL')></CFIF>
<CFIF Find('�',String) is not 0><CFSET String = Replace(String,'�','&Oacute;','ALL')></CFIF>
<CFIF Find('�',String) is not 0><CFSET String = Replace(String,'�','&Ocirc;','ALL')></CFIF>
<CFIF Find('�',String) is not 0><CFSET String = Replace(String,'�','&Otilde;','ALL')></CFIF>
<CFIF Find('�',String) is not 0><CFSET String = Replace(String,'�','&Ouml;','ALL')></CFIF>
<CFIF Find('�',String) is not 0><CFSET String = Replace(String,'�','&Oslash;','ALL')></CFIF>
<CFIF Find('�',String) is not 0><CFSET String = Replace(String,'�','&Ugrave;','ALL')></CFIF>
<CFIF Find('�',String) is not 0><CFSET String = Replace(String,'�','&Uacute;','ALL')></CFIF>
<CFIF Find('�',String) is not 0><CFSET String = Replace(String,'�','&Ucirc;','ALL')></CFIF>
<CFIF Find('�',String) is not 0><CFSET String = Replace(String,'�','&Uuml;','ALL')></CFIF>
<CFIF Find('�',String) is not 0><CFSET String = Replace(String,'�','&szlig;','ALL')></CFIF>
<CFIF Find('�',String) is not 0><CFSET String = Replace(String,'�','&agrave;','ALL')></CFIF>
<CFIF Find('�',String) is not 0><CFSET String = Replace(String,'�','&aacute;','ALL')></CFIF>
<CFIF Find('�',String) is not 0><CFSET String = Replace(String,'�','&acirc;','ALL')></CFIF>
<CFIF Find('�',String) is not 0><CFSET String = Replace(String,'�','&atilde;','ALL')></CFIF>
<CFIF Find('�',String) is not 0><CFSET String = Replace(String,'�','&auml;','ALL')></CFIF>
<CFIF Find('�',String) is not 0><CFSET String = Replace(String,'�','&aring;','ALL')></CFIF>
<CFIF Find('�',String) is not 0><CFSET String = Replace(String,'�','&aelig;','ALL')></CFIF>
<CFIF Find('�',String) is not 0><CFSET String = Replace(String,'�','&ccedil;','ALL')></CFIF>
<CFIF Find('�',String) is not 0><CFSET String = Replace(String,'�','&egrave;','ALL')></CFIF>
<CFIF Find('�',String) is not 0><CFSET String = Replace(String,'�','&eacute;','ALL')></CFIF>
<CFIF Find('�',String) is not 0><CFSET String = Replace(String,'�','&ecirc;','ALL')></CFIF>
<CFIF Find('�',String) is not 0><CFSET String = Replace(String,'�','&euml;','ALL')></CFIF>
<CFIF Find('�',String) is not 0><CFSET String = Replace(String,'�','&igrave;','ALL')></CFIF>
<CFIF Find('�',String) is not 0><CFSET String = Replace(String,'�','&iacute;','ALL')></CFIF>
<CFIF Find('�',String) is not 0><CFSET String = Replace(String,'�','&icirc;','ALL')></CFIF>
<CFIF Find('�',String) is not 0><CFSET String = Replace(String,'�','&ntilde;','ALL')></CFIF>
<CFIF Find('�',String) is not 0><CFSET String = Replace(String,'�','&ograve;','ALL')></CFIF>
<CFIF Find('�',String) is not 0><CFSET String = Replace(String,'�','&oacute;','ALL')></CFIF>
<CFIF Find('�',String) is not 0><CFSET String = Replace(String,'�','&ocirc;','ALL')></CFIF>
<CFIF Find('�',String) is not 0><CFSET String = Replace(String,'�','&otilde;','ALL')></CFIF>
<CFIF Find('�',String) is not 0><CFSET String = Replace(String,'�','&ouml;','ALL')></CFIF>
<CFIF Find('�',String) is not 0><CFSET String = Replace(String,'�','&divide;','ALL')></CFIF>
<CFIF Find('�',String) is not 0><CFSET String = Replace(String,'�','&oslash;','ALL')></CFIF>
<CFIF Find('�',String) is not 0><CFSET String = Replace(String,'�','&ugrave;','ALL')></CFIF>
<CFIF Find('�',String) is not 0><CFSET String = Replace(String,'�','&uacute;','ALL')></CFIF>
<CFIF Find('�',String) is not 0><CFSET String = Replace(String,'�','&ucirc;','ALL')></CFIF>
<CFIF Find('�',String) is not 0><CFSET String = Replace(String,'�','&uuml;','ALL')></CFIF>
<CFIF Find('�',String) is not 0><CFSET String = Replace(String,'�','&yuml;','ALL')></CFIF>
<!--- Inverted exclamation mark (Spanish) --->
<CFIF Find('�',String) is not 0><CFSET String = Replace(String,'�','&iexcl;','ALL')></CFIF>
<!--- Pound currency sign (U.K.) --->
<CFIF Find('�',String) is not 0><CFSET String = Replace(String,'�','&pound;','ALL')></CFIF>
<!--- Generic/Universal currency symbol --->
<CFIF Find('�',String) is not 0><CFSET String = Replace(String,'�','&curren;','ALL')></CFIF>
<!--- Yen currency symbol (Japan) --->
<CFIF Find('�',String) is not 0><CFSET String = Replace(String,'�','&yen;','ALL')></CFIF>
<!--- Feminine and Masculine ordinals (Spanish and Portuguese) --->
<CFIF Find('�',String) is not 0><CFSET String = Replace(String,'�','&ordf;','ALL')></CFIF>
<CFIF Find('�',String) is not 0><CFSET String = Replace(String,'�','&ordm;','ALL')></CFIF>
<!--- Copyright symbol --->
<CFIF Find('�',String) is not 0><CFSET String = Replace(String,'�','&copy;','ALL')></CFIF>
<!--- Degree symbol --->
<CFIF Find('�',String) is not 0><CFSET String = Replace(String,'�','&deg;','ALL')></CFIF>
<!--- Inverted question mark (Spanish) --->
<CFIF Find('�',String) is not 0><CFSET String = Replace(String,'�','&iquest;','ALL')></CFIF>
<!--- Blank template for future additions --->
<!--- <CFIF Find('',String) is not 0><CFSET String = Replace(String,'','&;','ALL')></CFIF> --->

<!--- End Int'l Character Test Area --->

<CFSET Caller.String = String>


