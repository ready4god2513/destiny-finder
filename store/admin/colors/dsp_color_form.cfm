
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the form to add and edit color palettes. Called by home.admin&colors=add|edit --->
 
<!--- Initialize the values for the form --->
<cfset fieldlist="color_id,palette_name,Bgcolor,Bgimage,MainTitle,MainText,MainLink,MainVLink,BoxHBgcolor,BoxHText,BoxTBgcolor,BoxTText,InputHBgcolor,InputHText,InputTBgcolor,InputTText,OutputHBgcolor,OutputHText,OutputTBgcolor,OutputTText,OutputTAltcolor,linecolor,hotImage,saleImage,newImage,mainlineImage,minorLineImage,formreq,formreqOB,layoutfile,PassParam">	

<cfswitch expression="#colors#">

	<cfcase value="add">
		<cfif isdefined("attributes.color_id")>
			<!--- copy a palette --->
			<cfinclude template="qry_get_color.cfm"> 
			<cfloop list="#fieldlist#" index="counter">
				<cfset "attributes.#counter#" = evaluate("qry_get_color." & counter)>
			</cfloop>
			<cfset act_title="Copy Palette">	
		<cfelse>
			<!--- Set the form fields to current color palette --->
			<cfloop list="#fieldlist#" index="counter">
				<cfset "attributes.#counter#" = evaluate("request.getcolors." & counter)>
			</cfloop>
			 <cfset act_title="New Palette">	
			 <cfset attributes.mainlineimage = "HR">
			 <cfset attributes.minorlineimage = "HR">
		</cfif>
		
		<cfset action="#self#?fuseaction=home.admin&colors=act&mode=i">
		<cfset attributes.color_id ="0">	
	</cfcase>
			
	<cfcase value="edit">
		<cfloop list="#fieldlist#" index="counter">
			<cfset "attributes.#counter#" = evaluate("qry_get_color." & counter)>
		</cfloop>

		
		<cfset action="#self#?fuseaction=home.admin&colors=act&mode=u">
		<cfset act_title="Update Palette">
	</cfcase>

</cfswitch>

<style type="text/css">
div.colorswatch {
display: inline;
width: 30px;
height: 15px;
font-size: 0.7pc; 
border: gray; 
border-style: solid; 
border-width: 1px; }
</style>

<cfinclude template="../../includes/imagepreview.js">

<cfprocessingdirective suppresswhitespace="no">
<script type="text/javascript">
	function colortool() {
		newWindow = openWin( 'colortool.cfm', 'colortool', 'width=800,height=480,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=0,resizable=1' ); 
	newWindow.focus();
	}	
</script>
</cfprocessingdirective>

<cfscript>
function putswatch(fieldname) {
	writeoutput('<div class="colorswatch" id="');
	writeoutput(fieldname & '_swatch" style="background-color:');
	writeoutput('##' & attributes[fieldname] & '" align="left">');
	writeoutput('&nbsp; &nbsp; &nbsp; &nbsp;</div>');
}
</cfscript>


<cfmodule template="../../customtags/format_admin_form.cfm"
	box_title="#act_title#"
	width="700"
	required_fields="0"
	>
<tr><td colspan="3">


<cfoutput>
<form name="editform" action="#action##request.token2#" method="post">
<input type="hidden" name="color_id" value="#attributes.color_id#"/>
<table width="100%" border="0" bgcolor="###attributes.InputTBgcolor#" style="color:###attributes.InputTText#;" class="FormText">

<!---- MAIN SETTINGS --->
	<tr>
		<td colspan="3" >
		Palette Name: <input type="text" name="palette_name" value="#attributes.palette_name#" size="40" maxlength="75" class="formfield"/>
		</td>
		<td align="right"><input class="formbutton" type="button" value="HTML Color Tool" onclick="colortool()"/> </td>
	</tr>
</table>	

	
<!--- Table that uses the background color --->	
<table width="100%" border="0" bgcolor="#attributes.BGColor#" style="color:###attributes.MainText#;">
  
  <tr><td colspan="4"><div class="formtitle" style="margin-top:5px">Colors</div>	
<cfmodule template="../../customtags/putline.cfm" linetype="thin" linecolor="#Request.GetColors.InputHBgcolor#"/>
  </td></tr>

  <tr> 
    <td valign="middle" class="formtext" width="75" nowrap="nowrap"><font color="#attributes.MainTitle#">Titles</font></td>
    <td valign="top" width="125" nowrap="nowrap">
	<input type="text" name="MainTitle" value="#attributes.MainTitle#" size="7" maxlength="10" class="formfield" id="MainTitle"/> 
	#putswatch('MainTitle')#

	  </td>
    <td valign="middle" class="formtext" width="75"><font color="#attributes.MainText#">Text</font></td>
    <td width="75%">
	<input type="text" name="MainText" value="#attributes.MainText#" size="7" maxlength="10" class="formfield" id="MainText"/>
	#putswatch('MainText')#
    </td>
  </tr>
  <tr> 
    <td valign="middle" class="formtext"><font color="#attributes.MainLink#">Links</font></td>
    <td valign="top">   
    <input type="text" name="MainLink" value="#attributes.MainLink#" size="7" maxlength="10" class="formfield" id="MainLink"/>
	#putswatch('MainLink')#
    </td>
    <td valign="middle" class="formtext"><font color="#attributes.MainVLink#">Visited Links</font></td>
    <td>
    <input type="text" name="MainVLink" value="#attributes.MainVLink#" size="7" maxlength="10" class="formfield" id="MainVLink"/>
	#putswatch('MainVLink')#
    </td>
  </tr>
  <tr> 
    <td valign="middle" class="formtext">Line Color</td>
    <td valign="top">
	<input type="text" name="linecolor" value="#attributes.linecolor#" size="7" maxlength="10" class="formfield" id="linecolor"/>
	#putswatch('linecolor')#
    </td>
	 <td valign="middle" class="formtext"><nobr>Background Color</nobr></td>
    <td valign="top">
    <input type="text" name="Bgcolor" value="#attributes.Bgcolor#" size="7" maxlength="10" class="formfield" id="Bgcolor"/>
	#putswatch('Bgcolor')#
    </td>
  </tr>
  
  <tr><td colspan="4">  <div class="formtitle" style="margin-top:5px">Layout</div>
  <cfmodule template="../../customtags/putline.cfm" linetype="thin" linecolor="#Request.GetColors.InputHBgcolor#"/>
  </td></tr>
  
  <tr> 
  	<td valign="middle" class="formtext">Layout file</td>
  	<td  valign="top">
		<input type="text" name="layoutfile" size="15" maxlength="100" value="#attributes.layoutfile#" class="formfield"/>
	</td>
  
  	<td valign="middle" class="formtext">Parameters</td>
  	<td  valign="top"><input type="text" name="passparam" size="30" maxlength="100" value="#attributes.passparam#" class="formfield"/></td>
 
  </tr>
  
  <tr>
    <td valign="middle" class="formtext"><nobr>Background Image</nobr></td>
    <td  valign="top"> 
        <input type="text" name="Bgimage" size="15" maxlength="100" value="#attributes.Bgimage#" class="formfield"/>
       <a href="JavaScript: newWindow = openWin('#self#?fuseaction=home.admin&select=image&fieldname=Bgimage&fieldvalue=#attributes.Bgimage#', 'images', 'width=520,height=290,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=0,resizable=1'); newWindow.focus();" class="formtextsmall">Image&nbsp;Manager</a><br/>
      </td>
	  
	  <td valign="middle" class="formtext">&nbsp;</td>
   	  <td  valign="top">&nbsp;</td>	  
  </tr>
    <tr> 
    <td colspan="4">
	<div class="formtitle"  style="margin-top:5px">Images</div>
	<cfmodule template="../../customtags/putline.cfm" linetype="thick" /></td>
  </tr>
  
    <tr> 
    <td valign="middle" class="formtext">Main Line
	
	</td>
    <td  valign="top">  
      <input type="text" name="mainlineimage" size="15" maxlength="100" value="#attributes.mainlineimage#" class="formfield"/> 
	 <br/><span class="formtextsmall">'HR' or
      <a href="JavaScript: newWindow = openWin('#self#?fuseaction=home.admin&select=image&fieldname=mainlineimage', 'images', 'width=520,height=290,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=0,resizable=1'); newWindow.focus();" class="formtextsmall">Image Manager</a><br/></span></td>

    <td valign="middle" class="formtext">Minor Line</td>
    <td  valign="top">  
      <input type="text" name="minorlineimage" size="15" maxlength="100" value="#attributes.minorlineimage#" class="formfield"/>
		<br/><span class="formtextsmall">'HR' or
      <a href="JavaScript: newWindow = openWin('#self#?fuseaction=home.admin&select=image&fieldname=minorlineimage', 'images', 'width=520,height=290,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=0,resizable=1'); newWindow.focus();" class="formtextsmall">Image Manager</a><br/></span></td>
  </tr>
    <tr> 
    <td colspan="4"><cfmodule template="../../customtags/putline.cfm" linetype="thin"/></td>
  </tr>
  
      <tr> 
    <td valign="middle" class="formtext" nowrap="nowrap">'New'&nbsp;Image</td>
    <td valign="top"> 
        <input type="text" name="Newimage" size="15" maxlength="100" value="#attributes.Newimage#" class="formfield"/>
       <a href="JavaScript: newWindow = openWin('#self#?fuseaction=home.admin&select=image&fieldname=Newimage&fieldvalue=#attributes.Newimage#', 'images', 'width=520,height=290,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=0,resizable=1'); newWindow.focus();" class="formtextsmall">Image&nbsp;Manager</a><br/>
      </td>
    <td valign="middle" class="formtext">'Sale'&nbsp;Image</td>
    <td  valign="top"> 
        <input type="text" name="Saleimage" size="15" maxlength="100" value="#attributes.saleimage#" class="formfield"/>
       <a href="JavaScript: newWindow = openWin('#self#?fuseaction=home.admin&select=image&fieldname=Saleimage&fieldvalue=#attributes.Saleimage#', 'images', 'width=520,height=290,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=0,resizable=1'); newWindow.focus();" class="formtextsmall">Image&nbsp;Manager</a><br/>
      </td>
  </tr>
  
  <tr>
     <td valign="middle" class="formtext"><nobr>'Hot' Image</nobr></td>
     <td  valign="top" colspan = 3> 
        <input type="text" name="hotImage" size="15" maxlength="100" value="#attributes.hotImage#" class="formfield"/><br/>
       <a href="JavaScript: newWindow = openWin('#self#?fuseaction=home.admin&select=image&fieldname=hotImage&fieldvalue=#attributes.hotImage#', 'images', 'width=520,height=290,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=0,resizable=1'); newWindow.focus();" class="formtextsmall">Image&nbsp;Manager</a><br/>
  </tr>
</table>
<br/>

<!---- ORDER BOX --->

<cfmodule template="../../customtags/format_box.cfm"
box_title="Order Box, Highlight Box"
border="1"
float="center"
>
<table width="100%">		
  <tr> 
    <td valign="middle" class="formtext" width="125" nowrap="nowrap"><font color="###attributes.BoxTText#">Header Bkgd</font></td>
    <td valign="top" width="125" nowrap="nowrap"> 
	<input type="text" name="BoxHBgcolor" value="#attributes.BoxHBgcolor#" size="7" maxlength="10" class="formfield" id="BoxHBgcolor"/>
	#putswatch('BoxHBgcolor')#
	
    </td>
    <td valign="middle" class="formtext" width="75" nowrap="nowrap"><font color="###attributes.BoxTText#">Header Text</font></td>
    <td> 
	<input type="text" name="BoxHText" value="#attributes.BoxHText#" size="7" maxlength="10" class="formfield" id="BoxHText"/>
	#putswatch('BoxHText')#
    </td>
  </tr>
  <tr> 
    <td valign="middle" class="formtext" nowrap="nowrap"><font color="###attributes.BoxTText#">Table Bkgd</font></td>
    <td valign="top">
	<input type="text" name="BoxTBgcolor" value="#attributes.BoxTBgcolor#" size="7" maxlength="10" class="formfield" id="BoxTBgcolor"/>
	#putswatch('BoxTBgcolor')#
    </td>
    <td valign="middle" class="formtext"><font color="###attributes.BoxTText#">Table Text</font></td>
    <td>
	<input type="text" name="BoxTText" value="#attributes.BoxTText#" size="7" maxlength="10" class="formfield" id="BoxTText"/>
	#putswatch('BoxTText')#
    </td>
  </tr>
   <tr> 
    <td valign="middle" class="formtext" nowrap="nowrap"><font color="###attributes.BoxTText#">Required Field</font></td>
    <td>
	<input type="text" name="formreqOB" value="#attributes.formreqOB#" size="7" maxlength="10" class="formfield"  style="background-color: ###Request.GetColors.formreqOB#;" id="formreqOB"/>
	#putswatch('formreqOB')#
    </td>
    <td></td>
    <td></td>
  </tr>
</table>
</cfmodule>
<br/>

<!---- INPUT FORM --->
<cfmodule template="../../customtags/format_input_form.cfm"
	Box_title="Input Form"
	align="center"
	required_fields="0"
	border="1"
	>
  <tr align="left"> 
    <td valign="middle" class="formtext" width="125" nowrap="nowrap"><font color="###attributes.InputTText#">Header Bkgd</font></td>
    <td width="125" nowrap="nowrap"> 
	<input type="text" name="InputHBgcolor" value="#attributes.InputHBgcolor#" size="7" maxlength="10" class="formfield" id="InputHBgcolor"/>
	#putswatch('InputHBgcolor')#
    </td>
    <td valign="middle" class="formtext" width="75" nowrap="nowrap"><font color="###attributes.InputTText#">Header Text</font></td>
    <td> 
	<input type="text" name="InputHText" value="#attributes.InputHText#" size="7" maxlength="10" class="formfield" id="InputHText"/>
	#putswatch('InputHText')#
    </td>
  </tr>
  <tr align="left"> 
    <td valign="middle" class="formtext" nowrap="nowrap"><font color="###attributes.InputTText#">Table Background</font></td>
    <td> 
	<input type="text" name="InputTBgcolor" value="#attributes.InputTBgcolor#" size="7" maxlength="10" class="formfield" id="InputTBgcolor"/>
	#putswatch('InputTBgcolor')#
    </td>
    <td valign="middle" class="formtext" nowrap="nowrap"><font color="###attributes.InputTText#">Table Text</font></td>
    <td> 
	<input type="text" name="InputTText" value="#attributes.InputTText#" size="7" maxlength="10" class="formfield" id="InputTText"/>
	#putswatch('InputTText')#
    </td>
  </tr>
  
 <tr align="left"> 
    <td valign="middle" class="formtext" nowrap="nowrap"><font color="###attributes.InputTText#">Required Field</font></td>
    <td>
	<input type="text" name="FormReq" value="#attributes.FormReq#" size="7" maxlength="10" class="formfield" style="background-color: ###Request.GetColors.formreq#;" id="FormReq"/>
	#putswatch('FormReq')#
    </td>
    <td></td>
    <td></td>
  </tr>

</cfmodule>
<br/>


<!---- OUTPUT TABLE --->
<table width="100%" border="0" cellspacing="5" cellpadding="0" bgcolor="###attributes.OutputTBgcolor#">	
	<tr>
		<th colspan="4" bgcolor="###attributes.OutputHBgcolor#" class="FormTitle">
		<font color="###attributes.OutputHText#">Shopping Cart / Output Box</font>
		</th>
	</tr>

  <tr> 
    <td valign="middle" class="formtext" width="125" nowrap="nowrap"><font color="###attributes.OutputTText#">Header Bkgd</font></td>
    <td width="125" nowrap="nowrap"> 
	<input type="text" name="OutputHBgcolor" value="#attributes.OutputHBgcolor#" size="7" maxlength="10" class="formfield" id="OutputHBgcolor"/>
	#putswatch('OutputHBgcolor')#
    </td>
    <td valign="middle" class="formtext" width="75" nowrap="nowrap"><font color="###attributes.OutputTText#">Header Text</font></td>
    <td> 
	<input type="text" name="OutputHText" value="#attributes.OutputHText#" size="7" maxlength="10" class="formfield" id="OutputHText"/>
	#putswatch('OutputHText')#
    </td>
  </tr>
  <tr>
    <td valign="middle" class="formtext" nowrap="nowrap"><font color="###attributes.OutputTText#">Table Background</font></td>
    <td>
	<input type="text" name="OutputTBgcolor" value="#attributes.OutputTBgcolor#" size="7" maxlength="10" class="formfield" id="OutputTBgcolor"/>
	#putswatch('OutputTBgcolor')#
    </td>
    <td valign="middle" class="formtext" nowrap="nowrap"><font color="###attributes.OutputTText#">Table Text</font></td>
    <td>
	<input type="text" name="OutputTText" value="#attributes.OutputTText#" size="7" maxlength="10" class="formfield" id="OutputTText"/>
	#putswatch('OutputTText')#
    </td>
  </tr>
  <tr> 
    <td valign="middle" class="formtext" nowrap="nowrap" bgcolor="###attributes.OutputTAltcolor#"><font color="###attributes.OutputTText#">Table Alt Bkgd</font></td>
    <td> 
	<input type="text" name="OutputTAltcolor" value="#attributes.OutputTAltcolor#" size="7" maxlength="10" class="formfield" id="OutputTAltcolor"/>
	#putswatch('OutputTAltcolor')#
    </td>
	
 <td></td>
    <td></td>
  </tr>
</table>

<table width="100%">
  <tr>
		<td colspan="4" align="center"><br/>
		<input class="formbutton" type="submit" name="submit" value="Save Changes"/> <input type="button" value="Cancel" onclick="javascript:window.history.go(-1);" class="formbutton"/> <cfif attributes.colors is "edit" and attributes.color_id gt 1><input type="submit" name="submit" value="Delete" class="formbutton" onclick="return confirm('Are you sure you want to delete this color palette?');"/></cfif>
		</td>
	</tr>

</form>
</cfoutput>
</table>

</td></tr>
</cfmodule>
<br/><br/>&nbsp;<br/>

<!--- <script type="text/javascript">
colorinit();
</script> --->
