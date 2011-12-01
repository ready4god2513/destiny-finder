<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This page calls the qforms libraries to use for form validations. Includes some custom validations for integers and floats.  --->
<cfprocessingdirective suppresswhitespace="No">
<cfoutput>

<script type="text/javascript" src="includes/qforms/compressed/qforms.js"></script>

<script type="text/javascript">
	<!--//
	// set the path to the qForms directory
	qFormAPI.setLibraryPath("includes/qforms/compressed/");
	// this loads all the default libraries
	qFormAPI.include("*");
	// load the "Bits" add-on library
	qFormAPI.include("bits");

	
//Test float fields to make sure they are proper floats (allows negative numbers)
function __IsNumericfloat()
{
// For foreign currencies, change the decimal to a comma on the next line:
var ValidChars = "01213456789.-";
var IsNumber = true;
var Char ;
var sText = this.value;
var numDecimals = 0;

for (i = 0; i < sText.length && IsNumber == true; i++)
{
Char = sText.charAt(i);
if (ValidChars.indexOf(Char) == -1)
{
IsNumber = false;
}
//Checks for minus sign
if (Char == '-' && i > 0)
{
IsNumber = false;
}
//Checks to make sure there is only 1 decimal point in the number
// For foreign currencies, change the decimal to a comma on the next line:
if (Char == '.')
{
numDecimals = numDecimals + 1;
}
}

if (numDecimals > 1 || IsNumber == false)
{
this.error = "The field " +
this.description + " does not contain a valid number";
}
}

_addValidator("IsNumericfloat",__IsNumericfloat);

function __QuantityMult(num) {
 // Check to make sure a product quantity being ordered is a multiple of a specfic value
 if( this.value % num != 0) {
  // error message
  this.error = "The " + this.description + " field must";
  this.error += " be a multiple of " + num;
 }
}
  
_addValidator("isQuantityMult", __QuantityMult);
//-->
</script>
	
</cfoutput>

</cfprocessingdirective>