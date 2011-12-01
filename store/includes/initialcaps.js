
<!--
	/* changes form field string to init caps
	   add to each form field: onBlur="javascript:changeCase(this.form.fieldname)" */
	function changeCase(frmObj) {
	var index;
	var tmpStr;
	var tmpChar;
	var preString;
	var postString;
	var strlen;
	tmpStr = frmObj.value.toLowerCase();
	strLen = tmpStr.length;
	if (strLen > 0)  {
		for (index = 0; index < strLen; index++)  {
			if (index == 0)  {
				tmpChar = tmpStr.substring(0,1).toUpperCase();
				postString = tmpStr.substring(1,strLen);
				tmpStr = tmpChar + postString;
				}
			else {
				tmpChar = tmpStr.substring(index, index+1);
				tmpChar2 = tmpStr.substring(index-1, index+1);
				if ((tmpChar == " " || tmpChar == "-" || tmpChar2 == "Mc" || tmpChar2 == "O'" || tmpChar2 == "P." || tmpChar2 == "PO") && index < (strLen-1))  {
					tmpChar = tmpStr.substring(index+1, index+2).toUpperCase();
					preString = tmpStr.substring(0, index+1);
					postString = tmpStr.substring(index+2,strLen);
					tmpStr = preString + tmpChar + postString;
       				}
	   			}
   			}		
		}
	frmObj.value = tmpStr;
	}	
//-->
