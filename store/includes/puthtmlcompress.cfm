
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This page outputs the HTMLCompressFormat function, to use in removing whitespace on the layout pages. --->

<cfscript>
/**
 * Replaces a huge amount of unnecessary whitespace from your HTML code.
 * 
 * @param sInput 	 HTML you wish to compress. (Required)
 * @return Returns a string. 
 * @author Jordan Clark (JordanClark@Telus.net) 
 * @version 1, November 19, 2002 
 */
function HtmlCompressFormat(sInput)
{
   var level = 2;
   if( arrayLen( arguments ) GTE 2 AND isNumeric(arguments[2]))
   {
      level = arguments[2];
   }
   // just take off the useless stuff
   sInput = trim(sInput);
   switch(level)
   {
      case "3":
      {
         //   extra compression can screw up a few little pieces of HTML, doh         
         sInput = reReplace( sInput, "[[:space:]]{2,}", " ", "all" );
         sInput = replace( sInput, "> <", "><", "all" );
         sInput = reReplace( sInput, "<!--[^>]+>", "", "all" );
         break;
      }
      case "2":
      {
         sInput = reReplace( sInput, "[[:space:]]{2,}", chr( 13 ), "all" );
         break;
      }
      case "1":
      {
         // only compresses after a line break
         sInput = reReplace( sInput, "(" & chr( 10 ) & "|" & chr( 13 ) & ")+[[:space:]]{2,}", chr( 13 ), "all" );
         break;
      }
   }
   return sInput;
}
</cfscript>



