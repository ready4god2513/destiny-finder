<!---
NAME: CF_Query2Excel

AUTHOR: Ali Taleb

DATE: 3 March 2000

DESCRIPTION:
Cold Fusion custom tag to dump the result of an SQL select query
to a downloadable Microsoft Excel spreadsheet which can have alternating row colors.

USAGE EXAMPLE (1):
<CF_Query2Excel Query="GetEmployees">

USAGE EXAMPLE (2):
<CF_Query2Excel Query="GetEmployees" 
                Headers="Firt Name, Last Name, Date of Birth"
                AlternatColor = "ff0000">

USAGE EXAMPLE (3):
<CF_Query2Excel Query="GetEmployees" 
                AlternatColor = "green">
                
Where 'GetEmployees' is the query name.


ATTRIBUTES:
Query          - (Required) Name of query to be converted to Excel.
Headers        - (Optional) Comma delimited list of coloumn header names. Defaults to all
                 query fields.
Message        - (Optional) Prompt link message to download the Excel File. Defaults to
                 'Download Results to Excel'.
AlternateColor - (Optional) The rows can have alternating colours, white and a second colour
                 defined by this attribute. Default is 'White'.
FileName 	   - Filename to export, defaults to customers.xls
             
IMPORTANT:     - As this tag invokes a download dialogue window (and hence not allow the actual page 
                 calling it to be displayed), It is best to place it in a .cfm page containing just 
                 the query followed by the tag, and then linking to that page with an HTML link.
             
               - The 'AlternateColor' Attribute MUST NOT begin with the number symbol '#', otherwise
                 an error will be generated. There is no means of rectifying this in ColdFusion 4.01.
                 as the problem is giving the custom tag attribute variable a value preceeding
                 with '#', rather than just deleting the symbol which is an easy thing to do.
                 As an example, For red you can type: AlternateColor = "red" or AlternateColor = "ff0000"
                 but NOT AlternateColor = "#ff0000".                      
--->

	<cfparam name="Attributes.FileName" default="customers.xls">

    <cfif Not IsDefined("Attributes.Query")>
      <cfoutput><div align="center"><b>Error! 'Query' attribute is required in your custom tag.</b></div></cfoutput>
      <cfabort>
    </cfif>
    
    <cfset QueryName = "Caller." & Attributes.Query>
    <cfset NumRows = Evaluate(QueryName & ".RecordCount")>
    <cfset TheColumnList = Evaluate(QueryName & ".ColumnList")>
    
    <cfparam name="Attributes.Headers" default=#Evaluate(QueryName & ".ColumnList")#>
    
    <cfif ListLen(TheColumnList) gt ListLen(Attributes.Headers)>
      <cfoutput><div align="center"><b>Error! There are more query fields than the items in the 'Headers' list.</cfoutput>
      <cfabort>
    <cfelseif  ListLen(Attributes.Headers) gt ListLen(TheColumnList)>
      <cfoutput><div align="center"><b>Error! There are more values in the 'Headers' list than the fields returned by the query.</cfoutput>
      <cfabort> 
    </cfif>
   
    
    <cfparam name="Attributes.AlternateColor" default="ffffff">     
    <cfparam name="Attributes.Type" default="application/ms-excel"> 
    
    
    
    <cfset Counter = 1>

    <cfloop query="#QueryName#">

    <cfset TheValueList = "">
    
        <cfloop list="#TheColumnList#" index="TheValue">
          <cfset TheValue = Trim(TheValue)>
          
          <cfset TheValue = Evaluate(QueryName & "." & TheValue)>
          <cfset TheValue = Replace(TheValue, ",", "¦¦", "All")>
          
          <cfset TheValueList = ListAppend(TheValueList,TheValue)>
          
          <cfset SetVariable("ValueList#Counter#", "#TheValueList#")>
        </cfloop>     
       
    <cfset Counter = Counter + 1>
       
    </cfloop>
    
        <cfset AlternateColor = Attributes.AlternateColor>       

		<cfheader name="Content-Disposition" value="attachment; filename=#attributes.filename#">
        <cfcontent type="#Attributes.Type#">
    
        <cfset CharWidth = 10>
        
        <table border="1">
        		<tr bgcolor="#C0C0C0">
              <cfloop list="#Attributes.Headers#" index="TheColTitle"> 
        				<cfset TheString = "#TheColTitle#">
        			  <cfset TheLength = Len(#TheString#) * #charwidth#>
        			  
                <cfoutput>
                  <th width="#TheLength#"><b>#TheString#</b></th>
                </cfoutput>
              
              </cfloop>
        		</tr>
        
              <cfset ColorList = "ffffff,#AlternateColor#">
         
         <cfloop from="1" to="#NumRows#" index="n">
         
              <cfif ColorList is "ffffff,#AlternateColor#">
                <cfset ColorList = "#AlternateColor#,ffffff">
              <cfelse>
                <cfset ColorList = "ffffff,#AlternateColor#">
              </cfif> 
         
              <cfloop list="#ColorList#" index="c">
                <cfset CurrentColor = #ListGetAt(c,1)#>
              </cfloop>  
             
              <cfset SetVariable("CurrentList", Evaluate("ValueList#n#"))>
              
              <cfset CurrentList = Replace(CurrentList, ",,", ",&nbsp;,", "All")>
              <cfset CurrentList = Replace(CurrentList, ",,", ",&nbsp;,", "All")>
              
              <cfoutput>
                <tr bgcolor="#CurrentColor#">
              </cfoutput>
              
              <cfloop list="#CurrentList#" index="TheColValue">    
        
        				<cfset TheString = "#TheColValue#">
        			    <cfset TheLength = Len(#TheString#) * #charwidth#>
                  
                  <cfif Len(TheColValue) is 0>
                  <cfset TheString = "&nbsp;">
                  </cfif>
        				  
                  <cfset TheString = Replace(TheString, "¦¦", ",", "All")>
                  
                  <cfoutput>
                  <td width="#TheLength#">#TheString#</td>
                  </cfoutput>
                  
                </cfloop> 
           			</tr>
        	</cfloop> 
        </table>