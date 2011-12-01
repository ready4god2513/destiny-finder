<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This page is used to run the javascript checks for the standard option form. Called from dsp_stdoption_form.cfm --->

<cfprocessingdirective suppresswhitespace="no">
<script type="text/javascript">
	function openWin( windowURL, windowName, windowFeatures ) { 
		return window.open( windowURL, windowName, windowFeatures ) ; 
	} 
	

	
function checkForm(thisform) {
        returnval=true;
        for (var j=0; j<(thisform.elements.length); j++)
                {
                indx = thisform.elements[j].name.indexOf('_required');
				indx2 = thisform.elements[j].name.indexOf('_float');
                if (indx != -1)
                        {
                        fieldname=thisform.elements[j].name.substring(0,indx);
                        if (thisform.elements[fieldname].value.length == 0)
                                {
                                alert(thisform.elements[j].value);
                                j = (thisform.elements.length);
                                returnval = false;
                                }
                        }
				else if (indx2 != -1) 
					{
					fieldname=thisform.elements[j].name.substring(0,indx2);
					var checkVal = parseFloat(thisform.elements[fieldname].value)
					if (isNaN(checkVal) && thisform.elements[fieldname].value.length != 0)
                           	{
                             alert(thisform.elements[j].value);
                          	 j = (thisform.elements.length);
                             returnval = false;
                            }
					}
						

                }
        return returnval;
        }

	
function CancelForm () {
	<cfoutput>location.href = "#self#?fuseaction=product.admin&stdoption=list&redirect=yes#Request.Token2#";</cfoutput>
	}
</script>
</cfprocessingdirective>


