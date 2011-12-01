<cfsilent>
<!---		-- StringSearch.cfm, Custom Tag, Generates SQL for a wildcard search
**** 		-- Aug.20. 2001
****	    -- Dan Moore, dan@moores.org 
****		-- If you improve this please let me know
****	
**** 	Purpose: Create SQL so you search for multiple words in an order different 
**** 		from what the user entered.  Option exists to require all words match 
**** 		or any.
****	--  You must pass in the name of the column you want to match to
****	--	Supports use of single quotes, other operators not yet supported
**** 	--	Not all of the SQL is generated, just part of the WHERE clause.
**** 	--	Double Quotes are replaced with spaces
**** 
**** 	Example:
**** 	<cf_StringSearch	
****		sql_col_ref="upper(p.description||p.program_name)"	--DB Column to match on, (try concatenating them)
**** 		search_string=#ucase(form.search)#					--String to parse
**** 		all_words="true">									--use 'AND' or 'OR'
**** 
**** 	<cfoutput><pre>PreservesingleQuotes(#SQL_Output#)</pre></cfoutput>
****	---> 
<cfparam name="attributes.sql_col_ref" default="">	<!--- required --->
<cfparam name="attributes.search_string" default="">
<cfparam name="attributes.all_words" default="false" type="boolean">
<cfset caller.SQL_Output =""><!--- Output --->

<cfif not len(Trim(attributes.sql_col_ref))>
	<cfthrow message="Error calling custom tag. The parameter sql_col_ref must have a value."
			 detail="This is a custom error thrown from the custom tag StringSearch.cfm"
			 errorcode="1">
</cfif>



<cfscript>
	caller.SQL_Output="(" & Chr(10);
	if (attributes.all_words){
		vAndOr=' and ';
	}else{
		vAndOr=' or ';
	}
	aClauses=ArrayNew(2);
	//vOneQuote="""";
	vOneQuote="'";
	vOneDubQuote="""";
	vSearchString=attributes.search_string;

	//vSearchString=REPLACE(vSearchString, "'"	, " ",  "all");//Single Quote
	vSearchString=Replace(vSearchString, vOneDubQuote	, " ",  "all");//Single Quote

	vSearchString=Replace(vSearchString, Chr(10), " ",  "all");//line return 
	vSearchString=Replace(vSearchString, Chr(13), " ",  "all");//carriage return 
	vPosition=1;
	vStart=1;
	vContinueParsing=true;
	vMaxLoop=0;
	
	
	vStartLoc=FIND(vOneQuote, vSearchString, vStart);
	vEndLoc=FIND(vOneQuote, vSearchString, vStartLoc+1);
	
	//WRITEOUTPUT("vSearchString: " & vSearchString & "<br/>");

	while ((vContinueParsing) AND (vMaxLoop LT 10)){
		vMaxLoop=IncrementValue(vMaxLoop);
		if ((vStartLoc GT 0) AND (vEndLoc GT 0)){
			if (vStart LT vStartLoc){
				//**** This part of string is NOT in Quotes but there is at least one more quoted part ****
				aClauses[vPosition][1]=Mid(vSearchString,  vStart, vStartLoc-vStart);
				aClauses[vPosition][2]='NoQuotes';
				//WRITEOUTPUT(vPosition & "A:" & aClauses[vPosition][1] & "||" & vStart & "||" & vStartLoc-1&"<br/>");
				vPosition=IncrementValue(vPosition);
			}
			//**** This part of string IS in Quotes
			aClauses[vPosition][1]=Mid(vSearchString,  vStartLoc, vEndLoc-vStartLoc);
			aClauses[vPosition][1]=Replace(aClauses[vPosition][1], vOneQuote,"" , "all");
			//WRITEOUTPUT(vPosition & "B:" & aClauses[vPosition][1] & "<br/>");
			aClauses[vPosition][2]='YesQuotes';
			vPosition=IncrementValue(vPosition);
			//**** Done- Prepare for next iteration of while loop ****
			if (vEndLoc GTE Len(vSearchString)){
				vContinueParsing=false;
			}else{
				vStart=vEndLoc+1;
				vStart=vEndLoc+1;
				vStartLoc=Find(vOneQuote, vSearchString, vStart);
				if (vStartLoc EQ 0){
					vEndLoc=0;
				}else{
					vEndLoc=FIND(vOneQuote, vSearchString, vStartLoc+1);
				}
				//writeoutput(vStart & "||" & vStartLoc & "||" & vEndLoc & "<br/>");	
			}
		}else{
			//**** none or just one quote in [or left in] the remaining search string, ignore the quote [if there is one] because we don't know what to do with it ****
			aClauses[vPosition][1]=Mid(vSearchString, vStart, LEN(vSearchString)-vStart+1);  
			aClauses[vPosition][1]=Replace(aClauses[vPosition][1], vOneQuote, " " , "all");
			//WRITEOUTPUT(vPosition & "C:" & aClauses[vPosition][1] & "<br/>");
			aClauses[vPosition][2]='NoQuotes';
			vPosition=IncrementValue(vPosition);
			vContinueParsing=false;
		}
	}
	//writeoutput("ArrayLen: " & ARRAYLEN(aClauses) & "<br/>");
	//writeoutput("vMaxLoop: " & vMaxLoop & "<br/>");
	//**** Output the results and we are done ****
	
	vFirstTime=true;
	for(X=1; X LTE ArrayLen(aClauses); X=IncrementValue(X)){
		//WRITEOUTPUT(X & ":" &aClauses[X][1] & "<br/>");
		if (len(Trim(aClauses[X][1]))){
			//CALLER.SQL_Output=CALLER.SQL_Output & "vFirstTime: " & vFirstTime &  Chr(10);
			if (NOT vFirstTime){
				caller.SQL_Output=caller.SQL_Output & vAndOr &  Chr(10);
			}else{
				vFirstTime=false;
			}
			if (aClauses[X][2] EQ 'YesQuotes'){
				caller.SQL_Output=caller.SQL_Output & attributes.sql_col_ref & " like '%" & aClauses[X][1] & "%' " &  Chr(10);
			}else{
				//**** Divide this segment of the string up by spaces, CF ignores empty spaces ****
				aTemp=ListToArray(aClauses[X][1]," ");
				for(Y=1; Y LTE ArrayLen(aTemp); Y=IncrementValue(Y)){
					caller.SQL_Output=caller.SQL_Output & attributes.sql_col_ref & " like '%" & aTemp[Y] & "%' " &  Chr(10);
					if (Y NEQ ArrayLen(aTemp)){
						caller.SQL_Output=caller.SQL_Output & vAndOr &  Chr(10);
					}
				}
			}
		}
	}
	caller.SQL_Output=caller.SQL_Output & ")" & Chr(10);
</CFSCRIPT>




<!---
**** Wayne Division, Dresser Industries
**** CHANGE CONTROL
**** 08-16-01  DFM	New- 
**** 
**** --->

</cfsilent>