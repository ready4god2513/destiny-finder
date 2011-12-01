
function addtable()
{	
	var frm = document.getElementById('fieldform');
	var table = document.createElement('table');
	table.setAttribute('id', 'customfields');
	table.setAttribute('width', '100%');
	frm.appendChild(table);
	var tbody = document.createElement('tbody');
	table.appendChild(tbody);
	
	var tr = document.createElement('tr');
	tbody.appendChild(tr);
	
	//add the header row
	var th = document.createElement('th');
	th.appendChild(document.createTextNode('Field Name'));
	th.setAttribute('valign', 'bottom');
	th.setAttribute('align', 'left');
	th.setAttribute('class', 'formtext');
	tr.appendChild(th);
	
	th = document.createElement('th');
	th.appendChild(document.createTextNode('Google Code'));
	th.setAttribute('valign', 'bottom');	
	th.setAttribute('align', 'left');
	th.setAttribute('class', 'formtext');
	tr.appendChild(th);
	
	th = document.createElement('th');
	th.appendChild(document.createTextNode('Display'));
	th.setAttribute('valign', 'bottom');
	th.setAttribute('align', 'center');
	th.setAttribute('class', 'formtext');
	tr.appendChild(th);
	
	th = document.createElement('th');	
	th.setAttribute('align', 'center');
	th.appendChild(document.createTextNode('Send to'));
	th.appendChild(document.createElement('br'));
	th.appendChild(document.createTextNode('Google'));
	th.setAttribute('class', 'formtext');
	tr.appendChild(th);
	
	th = document.createElement('th');
	th.appendChild(document.createTextNode('Remove'));
	th.setAttribute('valign', 'bottom');
	th.setAttribute('align', 'center');
	th.setAttribute('class', 'formtext');
	tr.appendChild(th);
	// end header row
	
	//add form buttons
	tr = document.createElement('tr');
	tbody.appendChild(tr);
	
	var td = document.createElement('td');
	td.colSpan=5;
	td.setAttribute('align', 'center');
	td.appendChild(document.createElement('br'));
	
	//submit button
	var button = document.createElement('input');
	button.setAttribute('type', 'submit');
	button.setAttribute('class', 'formbutton');
	button.setAttribute('value', 'Update');
	
	td.appendChild(button);
	td.appendChild(document.createTextNode('  '));
	
	//cancel button
	button = document.createElement('input');
	button.setAttribute('type', 'button');
	button.setAttribute('class', 'formbutton');
	button.setAttribute('value', 'Cancel');
	 //if NN6 then OK to use the standard setAttribute
   if ((!document.all)&&(document.getElementById)){
       button.setAttribute("onClick","CancelForm()");
   }    
   //workaround for IE 5.x
   if ((document.all)&&(document.getElementById)){
       button["onclick"]=new Function("CancelForm()");
   }

   	td.appendChild(button);	
	td.appendChild(document.createTextNode('  '));
	
	//add new rows button
	button = document.createElement('input');
	button.setAttribute('type', 'button');
	button.setAttribute('class', 'formbutton');
	button.setAttribute('value', 'Add Another Field');
	 //if NN6 then OK to use the standard setAttribute
   if ((!document.all)&&(document.getElementById)){
       button.setAttribute("onClick","addRowToTable()");
   }    
   //workaround for IE 5.x
   if ((document.all)&&(document.getElementById)){
       button["onclick"]=new Function("addRowToTable()");
   }

   	td.appendChild(button);
	tr.appendChild(td);
}


function CancelForm() 
{
	window.history.go(-1);
}

function addRowToTable() 
{
	var tbl = document.getElementById('customfields');
	var frm = document.getElementById('fieldform');
	var lastRow = tbl.rows.length;
	// if there's no header row in the table, then iteration = lastRow + 1
	var rownum = lastRow - 1;
	
	//add the row
	createRow(tbl, frm, rownum, 0, '', '', 0, 0, 0);
}

function createRow (tbl, frm, rownum, id, txtName, txtGoogle, ckDisplay, ckGoogle) 
{
	var row = tbl.insertRow(rownum);
 
 	// hidden field
	var hidden = document.createElement('input');
	hidden.setAttribute('type', 'hidden');
	hidden.setAttribute('name', 'Custom_ID' + rownum);
	hidden.setAttribute('id', 'Custom_ID' + rownum);
	hidden.setAttribute('value', id);
 
	frm.appendChild(hidden);
	
	// name field
	var cellname = row.insertCell(0);	
	var box = document.createElement('input');
	box.setAttribute('type', 'text');
	box.setAttribute('class', 'formfield');
	box.setAttribute('name', 'Custom_Name' + rownum);
	box.setAttribute('id', 'Custom_Name' + rownum);
	box.setAttribute('size', '30');
	box.setAttribute('maxlength', '50');
	box.setAttribute('value', txtName);
 
	cellname.appendChild(box);
	
	// google code field
	var cellcode = row.insertCell(1);	
	var code = document.createElement('input');
	code.setAttribute('type', 'text');
	code.setAttribute('class', 'formfield');
	code.setAttribute('name', 'Google_Code' + rownum);
	code.setAttribute('id', 'Google_Code' + rownum);
	code.setAttribute('size', '20');
	code.setAttribute('maxlength', '50');
	code.setAttribute('value', txtGoogle);
 
	cellcode.appendChild(code);
	
	// Display field
	var celldisplay = row.insertCell(2);
	celldisplay.align='center';
	var checkdisplay = document.createElement('input');
	checkdisplay.setAttribute('type', 'checkbox');
	checkdisplay.setAttribute('name', 'Custom_Display' + rownum);
	checkdisplay.setAttribute('id', 'Custom_Display' + rownum);	
	checkdisplay.setAttribute('value','1');
	
	celldisplay.appendChild(checkdisplay);	
	if (ckDisplay != 0) {
		checkdisplay.setAttribute("checked","checked");
	}
	
	// Send to Google field
	var cellgoogle = row.insertCell(3);
	cellgoogle.align='center';
	var checkgoogle = document.createElement('input');
	checkgoogle.setAttribute('type', 'checkbox');
	checkgoogle.setAttribute('name', 'Google_Use' + rownum);
	checkgoogle.setAttribute('id', 'Google_Use' + rownum);	
	checkgoogle.setAttribute('value','1');
	
	cellgoogle.appendChild(checkgoogle);
	if (ckGoogle != 0) {
		checkgoogle.setAttribute("checked","checked");
	}
	 
	// Delete field
	var celldelete = row.insertCell(4);
	celldelete.align='center';
	var checkdelete = document.createElement('input');
	checkdelete.setAttribute('type', 'checkbox');
	checkdelete.setAttribute('name', 'Remove' + rownum);
	checkdelete.setAttribute('id', 'Remove' + rownum);	
	checkdelete.setAttribute('value','1');
	
	celldelete.appendChild(checkdelete);	
	
	//update the counter field
	frm.TotalFields.value = rownum;
	
}
