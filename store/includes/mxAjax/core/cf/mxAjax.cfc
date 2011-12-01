<!----
 * http://www.indiankey.com/mxajax/
 *
 * @author Arjun Kalura (arjun.kalura@gmail.com)
 * @version 0.1, July 8th 2006
---->
<cfcomponent displayname="mxAjax">
	<cffunction name="init" access="remote" output="yes" returntype="void">
		<cftry>
			<cfscript>
				debug = false;
				dataPass = "";
				htmlResponse = false;
				if (isDefined("json")) {
					if (CGI.REQUEST_METHOD eq "POST") {
						dataPass = FORM.mxAjaxParam;
					} else if (CGI.REQUEST_METHOD eq "GET") {
						dataPass = URL.mxAjaxParam;
					}
				}
			</cfscript>
	
			
			<cfif (isDefined("json"))>
				<cfset mxAjaxRequest = jsondecode(dataPass)>
			<cfelse>
				<!--- non json request --->
				<cfset mxAjaxRequest = convertToJsonRequest()>
			</cfif>
			<cfif StructKeyExists(mxAjaxRequest, "calls") EQ true>
				<!---  multiple function call --->
				<cfset mxAjaxResponse = StructNew()>
				<cfset mxAjaxResponse.calls = ArrayNew(1)>
				<cfloop from="1" to="#ArrayLen(mxAjaxRequest.calls)#" index="rctr">
					<cfset functionName = StructKeyList(mxAjaxRequest.calls[rctr])>
					<cfif isStruct(mxAjaxRequest.calls[rctr][functionName])>
						<cfset functionParametersPassed = StructKeyList( mxAjaxRequest.calls[rctr][functionName])>
					<cfelse>
						<cfset functionParametersPassed = "">
					</cfif>
					
					<cfset _functionParameters = getMetaData(variables[functionName]).parameters>
					<cfset _functionArguments = StructNew()>
					<cfloop from="1" to="#ArrayLen(_functionParameters)#" index="fctr">
						<cfif ListFindNoCase(functionParametersPassed, _functionParameters[fctr].NAME ) GT 0>
							<cfset StructInsert(_functionArguments, _functionParameters[fctr].NAME, mxAjaxRequest.calls[rctr][functionName][_functionParameters[fctr].NAME])>
						</cfif>
					</cfloop>
					<cfinvoke method="#functionName#" returnvariable="result" argumentcollection="#_functionArguments#" />	
					<cfset callResponse = StructNew()>
					<cfset callResponse.functionName = functionName>
					<cfset callResponse.data = result>
					<cfset ArrayAppend(mxAjaxResponse.calls, callResponse)>
				</cfloop>
			<cfelse>
				<!--- single function call --->
				<cfloop collection="#mxAjaxRequest#" item="item">
					<cfif isStruct( mxAjaxRequest[item] )>
						<cfset functionName = item>
					</cfif>
					<cfif lcase(item) EQ "htmlresponse">
						<cfset htmlresponse = mxAjaxRequest[item]>
					</cfif>
				</cfloop>
				<cfif isStruct(mxAjaxRequest[functionName])>
					<cfset functionParametersPassed = StructKeyList( mxAjaxRequest[functionName])>
				<cfelse>
					<cfset functionParametersPassed = "">
				</cfif>
				
				<cfset _functionParameters = getMetaData(variables[functionName]).parameters>
				<cfset _functionArguments = StructNew()>
				<cfloop from="1" to="#ArrayLen(_functionParameters)#" index="fctr">
					<cfif ListFindNoCase(functionParametersPassed, _functionParameters[fctr].NAME ) GT 0>
						<cfset StructInsert(_functionArguments, _functionParameters[fctr].NAME, mxAjaxRequest[functionName][_functionParameters[fctr].NAME])>
					</cfif>
				</cfloop>
				<cfinvoke method="#functionName#" returnvariable="result" argumentcollection="#_functionArguments#" />	
				<cfset mxAjaxResponse = result>
			</cfif>
			
			<cfoutput><br><br>htmlResponse = #htmlResponse#<br><br><br></cfoutput>
			<cfif htmlResponse EQ false>
				<cfset output = jsonencode(mxAjaxResponse)>
			<cfelse>
				<cfset output = mxAjaxResponse>
			</cfif>
			
			<cfdump var="#output#">
			<cfdump var="#mxAjaxResponse#">


			<cfif debug eq false><cfcontent reset="Yes"></cfif><cfoutput>#output#</cfoutput><cfabort>
			<cfcatch type="any">
				<cfrethrow>
			</cfcatch>
		</cftry>
	</cffunction>
	
	<cffunction name="convertToJsonRequest">
		<cfscript>
			if (CGI.REQUEST_METHOD eq "POST") {
				dataPass = FORM;
				if (StructCount(dataPass) EQ 0)
				{
					//if ajax call was made directly using prototype lib. ie. using this syntax new Ajax.Updater('image', 'http://domain/demo.cfc?method=init&function=modelImage&model=10&htmlResponse=true')
					//prototype uses the http post, but we are interested in url data.
					dataPass = URL;
				}
			} else if (CGI.REQUEST_METHOD eq "GET") {
				dataPass = URL;
			}
		</cfscript>
		<cfoutput>CGI.REQUEST_METHOD = #CGI.REQUEST_METHOD#<br></cfoutput>
		<cfdump var="#url#">
		<cfif isDefined("dataPass.function")>
			<cfset retData = StructNew()>
			<cfset functionName = dataPass.function>
			<cfset StructDelete(dataPass, "function")>
			<cfset StructInsert(retData, functionName, dataPass)>
			<cfif isDefined("dataPass.htmlresponse")>
				<cfset StructInsert(retData, "htmlresponse", dataPass.htmlresponse)>
			<cfelse>
				<cfset StructInsert(retData, "htmlresponse", false)>
			</cfif>
			<cfreturn retData>
		<cfelse>
			<cfthrow message="required parameter missing">
		</cfif>
	</cffunction>

	<!----
	 * Serialize native ColdFusion objects (simple values, arrays, structures, queries) into JSON format
	 * http://json.org/
	 *
	 * @param object Native data to be serialized
	 * @return Returns string with serialized data.
	 * @author Jehiah Czebotar (jehiah@gmail.com)
	 * @version 1.4, Janauary 10th 2006
	 ---->
	<cffunction name="jsonencode">
		<cfargument name="arg" type="any">
		<cfscript>
			var i=0;
			var o="";
			var u="";
			var v="";
			var z="";
			var r="";
			if (isarray(arg))
			{
				o="";
				for (i=1;i lte arraylen(arg);i=i+1){
					try{
						v = jsonencode(arg[i]);
						if (o neq ""){
							o = o & ',';
						}
						o = o & v;
					}
					catch(Any ex){
						o=o;
					}
				}
				return '['& o &']';
			}
			if (isstruct(arg))
			{
				o = '';
				if (structisempty(arg)){
					return "{}";
				}
				z = StructKeyArray(arg);
				for (i=1;i lte arrayLen(z);i=i+1){
					try{
					v = jsonencode(structfind(arg,z[i]));
					}catch(Any err){WriteOutput("caught an error when trying to evaluate z[i] where i="& i &" it evals to "  & z[i] );}
					if (o neq ""){
						o = o & ",";
					}
					o = o & '"'& lcase(z[i]) & '":' & v;
				} 
				return '{' & o & '}';
			}
			if (isobject(arg)){
				return "unknown-obj";
			}
			if (issimplevalue(arg) and isnumeric(arg)){
				return ToString(arg);
			}
			if (issimplevalue(arg)){
				return '"' & JSStringFormat(ToString(arg)) & '"';
			}
			if (IsQuery(arg)){
				o = o & '"RECORDCOUNT":' & arg.recordcount;
				o = o & ',"COLUMNLIST":'&jsonencode(arg.columnlist);
				// do the data [].column
				o = o & ',"DATA":{';
				// loop through the columns
				for (i=1;i lte listlen(arg.columnlist);i=i+1){
					v = '';
					// loop throw the records
					for (z=1;z lte arg.recordcount;z=z+1){
						if (v neq ""){
							v =v  & ",";
						}
						// encode this cell
						v = v & jsonencode(evaluate("arg." & listgetat(arg.columnlist,i) & "["& z & "]"));
					}
					// put this column in the output
					if (i neq 1){
						o = o & ",";
					}
					o = o & '"' & listgetat(arg.columnlist,i) & '":[' & v & ']';
				}
				// close our data section
				o = o & '}';
				// put the query struct in the output
				return '{' & o & '}';
			}
			return "unknown";
		</cfscript>
	</cffunction>
	
	<!---
	/**
	 * DeSerialize JSON data into ColdFusion native objects (simple value, array, structure, query)
	 * http://json.org/
	 * 
	 * @param text 	 Serialized text to convert to objets. (Required)
	 * @return Returns object. 
	 * @author Jehiah Czebotar (jehiah@gmail.com)
	 * @version 1.3, December 16th 2005
	 */
	 --->
	<cffunction name="jsondecode">
		<cfargument name="arg" type="string">
		<cfscript>
			var z=1;//where to start slicing
			var s=0;//stack of tokens passed
			var i=0;// for counter
			var k="";//temp key
			var t="";//temp string
			var split=0;//position of split :
			var o = StructNew();
			var v = arraynew(1);
			var inq=0; // used when checking for ',' to see if we are in a quoted string or not.
		
			arg = trim(arg);
			
			if (not IsNumeric(arg) and arg is "true")
				return true;
			else if (arg is "false") 
				return false;
		
			switch("#LCase(arg)#"){
				case '""':
				case "''":
					return "";
				case 'null':
					return "null";
				
				default:
				//numeric
				if (IsNumeric(arg)){
					//numeric
					return LSParseNumber(arg);
				}else if (arg is "true"){
					return true;
				}else if (ReFind('^".+"$',arg,0) is 1 or ReFind("^'.+'$",arg,0) is 1){
					//string
					return replace(mid(arg,2,len(arg)-2),'\"','"',"All");
				}else if (ReFind("^\[.*\]$",arg,0) is 1){
					//array
					// get rid of delims
					arg = mid(arg,2,len(arg)-2);
					// for each one
					
					for (i=1;i lte len(arg)+1;i=i+1){
						if (mid(arg,i,1) is '"'){
							if (inq is 1){
								inq=0;
							}
							else {
								inq =1;
							}
								
						}
						else if (mid(arg,i,1) is "\" and inq is 1){
							i= i+1;//skip the escaped character
						}
						else if ((mid(arg,i,1) is "," and  s is 0 and inq is 0) or i is len(arg)+1){
							// we found a comma, or the end
		// the commented code here would possibly deal with empty array elements					
		//					if (i-z gt 0)
								arrayappend(v,jsondecode(mid(arg,z,i-z)));
		//					else
		//						arrayappend(v,"");
		
							z=i+1;//move the start forward
						} else if ("{[" contains mid(arg,i,1) and inq is 0){
							s=s+1;//track if we are moving into a subexpression
						} else if ("}]" contains mid(arg,i,1) and inq is 0){
							s=s-1;//track if we are moving out of a subexpression
						}
					}	
					
					return v;
				}else if (ReFind("^\{.*\}$",arg,0) is 1){
					if (not arg contains ":")
						///AK
						/////////////return "arg contains no : " & arg;
						return "";
					//struct
					// get rid of delims
					arg = mid(arg,2,len(arg)-2);
					
		
					
					for (i=1;i lte len(arg)+1;i=i+1){
		//				WriteOutput("checking struct character "&i&"->" & mid(arg,i,1)&"<br>");
						if (mid(arg,i,1) is '"'){
							if (inq is 1){
								inq=0;
							}
							else {
								inq =1;
							}
						}
						else if (mid(arg,i,1) is "\" and inq is 1){
							i= i+1;//skip the escaped character
						}
						else if ((mid(arg,i,1) is "," and s is 0 and inq is 0) or i is len(arg)+1){
							// we found a comma, or the end
							
		// the commented code here would possibly deal with empty array elements					
		//					if (i-z gt 0)
								// split on :
								t = mid(arg,z,i-z);
								split=find(":",t);
								if (split is 0){
									return t;
									//return": not found in ->" & t & " with z="&z &" and split="&split&" and i ="&i & " and k="&mid(t,1,split) &" when second half is ->" &mid(t,split+1,len(t)-split);
								}else{
									k=trim(mid(t,1,split-1));
									// if the key is quoted, remove the stinkin quotes
									if (mid(k,1,1) is "'" or mid(k,1,1) is '"')
										k=mid(k,2,len(k)-2);
										
									r=mid(t,split+1,len(t)-split);
									StructInsert(o,k,jsondecode(r));
								}
								//arrayappend(v,jsondecode(mid(arg,z,i-z)));
		//					else
		//						arrayappend(v,"");
		
							z=i+1;//move the start forward
						} else if ("{[" contains mid(arg,i,1) and inq is 0){
							s=s+1;//track if we are moving into a subexpression
						} else if ("}]" contains mid(arg,i,1) and inq is 0){
							s=s-1;//track if we are moving out of a subexpression
						}
					}	
					return o;
				}
				else{
					//? - if this happens, just go home ;-)
					return "unknown:"&arg;
				}
				
			}
			return "unknown2:"&arg;
		</cfscript>
	</cffunction>
</cfcomponent>