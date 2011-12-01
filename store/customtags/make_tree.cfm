<!---  Feature Reviews Upgrade - 
This tag will take a query that is in a LEGAL parent/child relationship and sort it. The entire query will be sorted and an additional field called "maketreesortlevel" will be added to specify the level of a particular item. 
Attributes:
	Query (Required, Query) - The query to be sorted
	Result (required, string) - The variable name which will contain the sorted query
	Unique (optional, string, defaults to messagecounter) - The unique identifier of a query item. In older terms, the ItemID
	Parent (optional, string, defaults to ParentID) - The id of the parent for an item. MUST reference a legal parent. 0 is considered a root item. In older terms, the ParentItemID.

Author:	Michael Dinowitz

Usage:
  <cfquery datasource="foo" name="GetStuff">     
	SELECT           
		bar.ID AS ItemID,          
		bar.ParentID AS ParentItemID,          
		bar.blah     
		FROM bar
  </cfquery>

  <cf_make_tree     
	Query="#GetStuff#"     
	Result="GetStuff"     
	Unique="ItemID"     
	Parent="ParentItemID">

 --->
<cfparam name="Attributes.Query" type="Query">
<cfparam name="Attributes.Result" type="String">
<cfparam name="Attributes.Unique" type="String" default="MessageCounter">
<cfparam name="Attributes.Parent" type="String" default="ParentID">

<cfscript>
	// Convert Query to List. All work is done on this 'worklist' which is assigned to the request structure as well.
	Items = evaluate('ValueList(Attributes.Query.'&Attributes.Unique&')');
	Parents=Evaluate('ValueList(Attributes.Query.'&Attributes.Parent&')');

	// these next two lines correct a decimal issue that affects only some versions of MS Access      		
    Items=Replace(Items,".0","","all");    
    Parents=Replace(Parents,".0","","all"); 
	
	// Set Local Query
	Local = QueryNew(Attributes.Query.ColumnList&',maketreesortlevel');

	Current=0;
	Path=0;

	// Loop over Query list and order in a tree
	for(index=1;index LTE Attributes.Query.RecordCount;index=index+1)
	{
		
		//Adds a new row
		QueryAddRow(Local);

		//Sets the new row to the value for the list
		Position = ListFind(Parents, Current);
		//If the current ID has no children, drop down the path and try again
		while (NOT Position)
		{
			Path=ListRest(Path);
			Current=ListFirst(Path);
			Position = ListFind(Parents, Current);
		}
		for(i=1;i LTE listlen(Attributes.Query.Columnlist);i=i+1)
		{
			Column=listgetat(Attributes.Query.Columnlist, i);
			QuerySetCell(Local, Column, Evaluate('Attributes.Query.'&Column&'[Position]'));
		}
		QuerySetCell(Local, 'maketreesortlevel', ListLen(path));
		Current = ListGetAt(Items, Position);
		Parents=ListSetAt(Parents, Position, '-');
		Path=ListPrepend(Path, Current);
	}
	SetVariable('Caller.'&Attributes.Result, Local);
</CFSCRIPT>
