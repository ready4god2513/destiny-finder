
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This tag converts all "international" letters to their ASCII code equivalent
	  for database storage and correct HTML display.  Also included are some common
	  symbols and currency marks. --->
	  
<CFSET String = Attributes.String>

<!--- Begin Int'l Character Test Area --->

<CFIF Find('À',String) is not 0><CFSET String = Replace(String,'À','&Agrave;','ALL')></CFIF>
<CFIF Find('Á',String) is not 0><CFSET String = Replace(String,'Á','&Aacute;','ALL')></CFIF>
<CFIF Find('Â',String) is not 0><CFSET String = Replace(String,'Â','&Acirc;','ALL')></CFIF>
<CFIF Find('Ã',String) is not 0><CFSET String = Replace(String,'Ã','&Atilde;','ALL')></CFIF>
<CFIF Find('Ä',String) is not 0><CFSET String = Replace(String,'Ä','&Auml;','ALL')></CFIF>
<CFIF Find('Å',String) is not 0><CFSET String = Replace(String,'Å','&Aring;','ALL')></CFIF>
<CFIF Find('Æ',String) is not 0><CFSET String = Replace(String,'Æ','&AElig;','ALL')></CFIF>
<CFIF Find('Ç',String) is not 0><CFSET String = Replace(String,'Ç','&Ccedil;','ALL')></CFIF>
<CFIF Find('È',String) is not 0><CFSET String = Replace(String,'È','&Egrave;','ALL')></CFIF>
<CFIF Find('É',String) is not 0><CFSET String = Replace(String,'É','&Eacute;','ALL')></CFIF>
<CFIF Find('Ê',String) is not 0><CFSET String = Replace(String,'Ê','&Ecirc;','ALL')></CFIF>
<CFIF Find('Ë',String) is not 0><CFSET String = Replace(String,'Ë','&Euml;','ALL')></CFIF>
<CFIF Find('Ì',String) is not 0><CFSET String = Replace(String,'Ì','&Igrave;','ALL')></CFIF>
<CFIF Find('Í',String) is not 0><CFSET String = Replace(String,'Í','&Iacute;','ALL')></CFIF>
<CFIF Find('Î',String) is not 0><CFSET String = Replace(String,'Î','&Icirc;','ALL')></CFIF>
<CFIF Find('Ï',String) is not 0><CFSET String = Replace(String,'Ï','&Iuml;','ALL')></CFIF>
<CFIF Find('Ñ',String) is not 0><CFSET String = Replace(String,'Ñ','&Ntilde;','ALL')></CFIF>
<CFIF Find('Ò',String) is not 0><CFSET String = Replace(String,'Ò','&Ograve;','ALL')></CFIF>
<CFIF Find('Ó',String) is not 0><CFSET String = Replace(String,'Ó','&Oacute;','ALL')></CFIF>
<CFIF Find('Ô',String) is not 0><CFSET String = Replace(String,'Ô','&Ocirc;','ALL')></CFIF>
<CFIF Find('Õ',String) is not 0><CFSET String = Replace(String,'Õ','&Otilde;','ALL')></CFIF>
<CFIF Find('Ö',String) is not 0><CFSET String = Replace(String,'Ö','&Ouml;','ALL')></CFIF>
<CFIF Find('Ø',String) is not 0><CFSET String = Replace(String,'Ø','&Oslash;','ALL')></CFIF>
<CFIF Find('Ù',String) is not 0><CFSET String = Replace(String,'Ù','&Ugrave;','ALL')></CFIF>
<CFIF Find('Ú',String) is not 0><CFSET String = Replace(String,'Ú','&Uacute;','ALL')></CFIF>
<CFIF Find('Û',String) is not 0><CFSET String = Replace(String,'Û','&Ucirc;','ALL')></CFIF>
<CFIF Find('Ü',String) is not 0><CFSET String = Replace(String,'Ü','&Uuml;','ALL')></CFIF>
<CFIF Find('ß',String) is not 0><CFSET String = Replace(String,'ß','&szlig;','ALL')></CFIF>
<CFIF Find('à',String) is not 0><CFSET String = Replace(String,'à','&agrave;','ALL')></CFIF>
<CFIF Find('á',String) is not 0><CFSET String = Replace(String,'á','&aacute;','ALL')></CFIF>
<CFIF Find('â',String) is not 0><CFSET String = Replace(String,'â','&acirc;','ALL')></CFIF>
<CFIF Find('ã',String) is not 0><CFSET String = Replace(String,'ã','&atilde;','ALL')></CFIF>
<CFIF Find('ä',String) is not 0><CFSET String = Replace(String,'ä','&auml;','ALL')></CFIF>
<CFIF Find('å',String) is not 0><CFSET String = Replace(String,'å','&aring;','ALL')></CFIF>
<CFIF Find('æ',String) is not 0><CFSET String = Replace(String,'æ','&aelig;','ALL')></CFIF>
<CFIF Find('ç',String) is not 0><CFSET String = Replace(String,'ç','&ccedil;','ALL')></CFIF>
<CFIF Find('è',String) is not 0><CFSET String = Replace(String,'è','&egrave;','ALL')></CFIF>
<CFIF Find('é',String) is not 0><CFSET String = Replace(String,'é','&eacute;','ALL')></CFIF>
<CFIF Find('ê',String) is not 0><CFSET String = Replace(String,'ê','&ecirc;','ALL')></CFIF>
<CFIF Find('ë',String) is not 0><CFSET String = Replace(String,'ë','&euml;','ALL')></CFIF>
<CFIF Find('ì',String) is not 0><CFSET String = Replace(String,'ì','&igrave;','ALL')></CFIF>
<CFIF Find('í',String) is not 0><CFSET String = Replace(String,'í','&iacute;','ALL')></CFIF>
<CFIF Find('î',String) is not 0><CFSET String = Replace(String,'î','&icirc;','ALL')></CFIF>
<CFIF Find('ñ',String) is not 0><CFSET String = Replace(String,'ñ','&ntilde;','ALL')></CFIF>
<CFIF Find('ò',String) is not 0><CFSET String = Replace(String,'ò','&ograve;','ALL')></CFIF>
<CFIF Find('ó',String) is not 0><CFSET String = Replace(String,'ó','&oacute;','ALL')></CFIF>
<CFIF Find('ô',String) is not 0><CFSET String = Replace(String,'ô','&ocirc;','ALL')></CFIF>
<CFIF Find('õ',String) is not 0><CFSET String = Replace(String,'õ','&otilde;','ALL')></CFIF>
<CFIF Find('ö',String) is not 0><CFSET String = Replace(String,'ö','&ouml;','ALL')></CFIF>
<CFIF Find('÷',String) is not 0><CFSET String = Replace(String,'÷','&divide;','ALL')></CFIF>
<CFIF Find('ø',String) is not 0><CFSET String = Replace(String,'ø','&oslash;','ALL')></CFIF>
<CFIF Find('ù',String) is not 0><CFSET String = Replace(String,'ù','&ugrave;','ALL')></CFIF>
<CFIF Find('ú',String) is not 0><CFSET String = Replace(String,'ú','&uacute;','ALL')></CFIF>
<CFIF Find('û',String) is not 0><CFSET String = Replace(String,'û','&ucirc;','ALL')></CFIF>
<CFIF Find('ü',String) is not 0><CFSET String = Replace(String,'ü','&uuml;','ALL')></CFIF>
<CFIF Find('ÿ',String) is not 0><CFSET String = Replace(String,'ÿ','&yuml;','ALL')></CFIF>
<!--- Inverted exclamation mark (Spanish) --->
<CFIF Find('¡',String) is not 0><CFSET String = Replace(String,'¡','&iexcl;','ALL')></CFIF>
<!--- Pound currency sign (U.K.) --->
<CFIF Find('£',String) is not 0><CFSET String = Replace(String,'£','&pound;','ALL')></CFIF>
<!--- Generic/Universal currency symbol --->
<CFIF Find('¤',String) is not 0><CFSET String = Replace(String,'¤','&curren;','ALL')></CFIF>
<!--- Yen currency symbol (Japan) --->
<CFIF Find('¥',String) is not 0><CFSET String = Replace(String,'¥','&yen;','ALL')></CFIF>
<!--- Feminine and Masculine ordinals (Spanish and Portuguese) --->
<CFIF Find('ª',String) is not 0><CFSET String = Replace(String,'ª','&ordf;','ALL')></CFIF>
<CFIF Find('º',String) is not 0><CFSET String = Replace(String,'º','&ordm;','ALL')></CFIF>
<!--- Copyright symbol --->
<CFIF Find('©',String) is not 0><CFSET String = Replace(String,'©','&copy;','ALL')></CFIF>
<!--- Degree symbol --->
<CFIF Find('°',String) is not 0><CFSET String = Replace(String,'°','&deg;','ALL')></CFIF>
<!--- Inverted question mark (Spanish) --->
<CFIF Find('¿',String) is not 0><CFSET String = Replace(String,'¿','&iquest;','ALL')></CFIF>
<!--- Blank template for future additions --->
<!--- <CFIF Find('',String) is not 0><CFSET String = Replace(String,'','&;','ALL')></CFIF> --->

<!--- End Int'l Character Test Area --->

<CFSET Caller.String = String>


