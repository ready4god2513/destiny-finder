
<!--- 

Modified by Daniel Chicayban - daniel@chicayban.com.br - 3/31/2001
Would be cool if we can do reverse.

Thank you, Charles Arehart, for this great job.
Let me try to help.

Syntax: <cf_textareaformat input="inputval" [output="outputval"] [reverse="true"]>

--->

<!--- 
Custom tag: CF_TEXTAREAFORMAT
By: Charles Arehart, SysteManage, carehart@systemanage.com
Created: 2/7/99

Updated: 2/15/99 (Doc update 7/26/00)

Purpose: 

See the textareaformat_help.cfm file that was included with in the download of this custom tag for an HTML representation of these notes, or visit  http:\\www.systemanage.com\cff\textareaformat_help.cfm.

CF_TEXTAREARFORMAT is an enhancement over the features offered by the CF paragraphformat function. Both can be used when you want to display to a user the data that has been entered into a TEXTAREA form field. 

TEXTAREA form fields are very useful, since they allow multiple lines of data to be entered. They also can be deceptive. A user can press the "enter" key to create new lines, or press enter twice to create blank lines. Spaces can also to be entered, if needed. And if the user copies text from another source, even tabs can be used within a textarea field (if the user tries to simply press the tab key, however, the cursor just jumps to the next input field). 

That's all wonderful, until you try to show that input to the user in a subsequent page. Have you evered try to display such textarea data, such as for their review on the form's action page. Or, more likely, have you stored that data in a database and then tried to display it again later to the user, perhaps in a report? 

The problem is that, when you display the field within a CFOUTPUT or CFOUTPUT QUERY loop for example, the user's input is not accurately rendered. All those wondeful carriage returns, spaces, and tabs are lost! Well, they're not lost. But they'll be ignored by the browser, since browsers just naturally ignore those things.

What we need, instead, is to convert all those things into the HTML that will be properly interpeted by the browser. We want single enter key presses (stored in the field as carriage returns) to be converted to <br/> tags, and double enter key presses (stored in the field as 2 carriage returns) to be convereted to <p> tags. We also want to convert multiple consecutive spaces to be converted to the &NBSP (non-breaking space) character and any tabs to be converted to 8 non-breaking spaces..

But do you want to do that conversion? Searching for each such "bad" character and change it to the proper HTML version? Why bother. There is another solution: CF_TEXTAREAFORMAT!

---------------------------------------------------------

When to Use The Solution

Note that we don't need to do the conversion before storing the data in a database. It's perfectly ok to store the TEXTAREA field data directly in a database. The carriage returns, spaces, and tabs will be stored just fine. It's only when you later display it to a browser that the problem arises. We just need to convert it whenever we want to display the data, whether on the form's action page or later in a query report.

Sometimes, you don't even notice this problem because as long as the user hasn't used blank lines, spaces, or tabs, the TEXTAREA field is accurately rendered on output. But that doesn't mean someone won't do it someday. It's just too easy, and using blanks, spaces, and tabs can be very useful for making the input more well-organized. 

The bottom line is that you NEED to put a solution in place, so that when the data is displayed back to the user, it's rendered accurately. 

---------------------------------------------------------

An Inelegant Solution

One solution is to always display the data in a TEXTAREA format field again, but that's usually not appropriate if your intending only to show it to them for output, since the user would be given the impression that they could change the data. 

Of course, if the user is going to be offered the opportunity to edit the data, this is indeed the solution, and you don't want to use any of the solutions below. 

---------------------------------------------------------

Allaire's semi-solution

Allaire saw the need to solve this problem, and they offered the PARAGRAPHFORMAT funtion. It's job was to do almost just what we want. Unfortunately, it only does half the job! It converts 
converts double carriage returns to a <p> tag, but it does not convert a single carriage return to a <br/>, nor does it convert multiple consecutive spaces to non-breaking spaces ("nbsp"), nor TAB characters into some fixed number of non-breaking spaces (since there's no "tab" characters support in HTML). As such, PARAGRAPHFORMAT does not present an accurate representation of what a user has typed into a form's TEXTAREA input field.

---------------------------------------------------------

The Best Solution: CF_TEXTAREAFORMAT

CF_TEXTAREAFORMAT, on the other hand, solves all four problems:

- converting single carriage returns (where the user pressed "enter" in the TEXTAREA field) into <br/> tags
- converting 2 carriage returns (where the user pressed "enter" twice) into <p> tags
- converting multiple consecutive spaces into &NBSP (non-breaking space) characters
- converting TAB characters into a fixed number of non-breaking spaces

All you need to do is pass the field to be formatted to the custom tag, and in return you'll receive a formatted string that you can then display to the user. Basically, you use it on a form action page when you intend to show the user's input to them for review, or you use it on any page that's displaying query data that includes data that came from a textarea field.

Note also that this tag cannot be called as a "function", as there is currently no support in CF for user-defined functions. See below for details on syntax and usage.

---------------------------------------------------------

FORMAT:

<CF_TEXTAREAFORMAT INPUT="#inputval#" [OUTPUT="outputvar"]>

(Note that the inputval MUST be enclosed in pound signs if it's referring to a coldfusion variable holding the textarea data to be formatted, whereas outputvar MUST NOT BE enclosed in pound signs, as it's the [optional] name of the variable in which you want the custom tag to place the converted output. If it's not specified, the variable "htmlformatted_string" will hold the converted string.)

CF_TEXTAREAFORMAT takes whatever field/variable you would like to format (which came from a TEXTAREA form field) and returns it, formatted for proper display in HTML, in a variable that you can then choose to output. You must output the returned, formatted variable yourself. That decision was made to make the tag more flexible. 

---------------------------------------------------------

VARIABLES:

INPUT - required, textarea field string to be formatted. Usually, this will come from a ColdFusion variable (such as a form. variable on an action page, or a query variable when used in a report). Again, if it's a variable, it must be enclosed in pound signs.

OUTPUT - optional, name of the variable to be created to hold the converted value. If none is specified, a variable named "htmlformatted_string" is created. 

DEFAULTS:

INPUT - null string. In no input variable is provided, a null result will be returned in the output variable.

OUTPUT - If no output variable is specified, a variable called "htmlformatted_string" is created to hold the converted string.

---------------------------------------------------------

USAGE EXAMPLE:

If you had a form prompting a user for a "Description" field as a <TEXTAREA> tag, you may want to display that input to them on the form's action page, perhaps for their approval on the form's action page. Or perhaps you will store the data in a database and then want to display it later in a report.

To cause that textarea field to be properly formatted, call this tag on the page where you intend to display the form field or query variable. Then use CFOUTPUT to refer to the variable created by CF_TEXTAREAFORMAT (either a variable you named, or the default variable it will create, called "htmlformatted_string"), which holds the converted string for proper html display.

Using on an Action Page

Assuming you had a form with a "description" TEXTAREA field, you would use the following in the form's ACTION page :
<CF_TEXTAREAFORMAT INPUT="#form.description#">
<CFOUTPUT>#htmlformatted_string#</CFOUTPUT>

Using in a Query Loop

If, instead, the "description" TEXTAREA field had been stored in a database, you might use the following code on the page where you intend to display that record. Let's assume the description is part of a record describing parts in a product database. The code might look like:

<CFQUERY DATASOURCE="test" NAME="GetParts">
	SELECT id, name, price, availability, description
</CFQUERY>

<TABLE>
<TR>
	<TH>Part ID</TH>
	<TH>Part Name</TH>
	<TH>Price</TH>
	<TH>Availability</TH>
</TR>

<CFOUTPUT QUERY= "get_parts">
	<TR>
		<TD>#Id#</TD>
		<TD>#Name#</TD>
		<TD>#Price#</TD>
		<TD>#Availability#</TD>
	</tr>
	<tr>
		<td>
		<hr/>
		<CF_TEXTAREAFORMAT INPUT="#description#">
		#htmlformatted_string#
		</td>
	</tr>
</CFOUTPUT>
</TABLE>


Of course, this example may be more complicated than your needs require. If you don't need the table formatting, you could do it more simply as:

<CFOUTPUT QUERY= "get_parts">
	PartId: #Id#<br/>
	Part Name: #Name#<br/>
	Price: #Price#<br/>
	Availability: #Availability#<br/>
	<CF_TEXTAREAFORMAT INPUT="#description#">
	<hr/>
	#htmlformatted_string#<br/>
	<p>
</CFOUTPUT>

Live Example

See the available live example at http://www/systtextareaformat_example.cfm for a working demonstration of displaying a textarea field and the difference between showing it with no formatting, formatting it with Allaire's paragraphformat function, and formatting with CF_TEXTAREAFORMAT.

---------------------------------------------------------
USAGE NOTES:

The choice to have this custom tag convert any 3 consecutive spaces into non-breaking spaces was made so that single and double spaces, common in writing, are not converted. And the conversion of tabs to 8 spaces is arbitrary. It reproduces an approximate spacing created by a tab. 

Note also:
Errors in Release 3.1 or Earlier

There is a minor problem that won't affect Release 4 users. When using the tag on a server running Release 3.1 or earlier, you cannot call the tag within a <CFOUTPUT>, such as was done in the "query loop" examples above. Sadly, you'll encounter an error. 

The error will say that the tag cannot be used in within a CFOUTPUT. This is not a limitation of my tag, nor is it caused by anything the tag is doing. It's simply because, prior to release 4, very few tags are allowed within a CFOUTPUT loop, including custom tags.

But there is a simple solution, that can be used in most cases.  Again, it's only needed prior to release 4 of CF.

Change the <CFOUTPUT QUERY=...> loop to <CFLOOP QUERY=....>, and put a pair of CFOUTPUT tags just inside the CFLOOP. Generally, this will not change the functionality of the template at all (unless you were using the GROUP attribute on CFOUTPUT, which is not supported in CFLOOP). 

Then, put a closing CFOUTPUT just before the call to this custom tag, and put an opening one just after it. Problem solved.


If you have any questions, please send them to carehart@systemanage.com.

(Or, you could use this to motivate an upgrade to Release 4! See my article on the upgrading to Release 4 in the February 1999 ColdFusion Developer Journal, as well as Richard Shulze's article in the January 1999 issue. You might also want to see my article on hidden gems in 4.01, in the February 2000 issue. If either of the links provided fail, visit the magazine's front page instead.) 
--->

<cfif isDefined("attributes.reverse") eq "true">

	<cfparam name="attributes.input" default="">
	<cfparam name="attributes.output" default="htmlformatted_string">
	<cfset temp = attributes.input>
	<cfset temp = replace(temp,"<p>",chr(13)&chr(10)&chr(13)&chr(10),"all")>
	<cfset temp = replace(temp,"<br/>",chr(13)&chr(10),"all")>
	<cfset temp = replace(temp,"&nbsp;&nbsp;&nbsp;",chr(32)&chr(32)&chr(32),"all")>
	<cfset temp = replace(temp,"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;",chr(9),"all")>
	
	<cfset x = setvariable("caller."&attributes.output,temp)>

<cfelse>
	
	<cfparam name="attributes.input" default="">
	<cfparam name="attributes.output" default="htmlformatted_string">
	<cfset temp = attributes.input>
	<cfset temp = replace(temp,chr(13)&chr(10)&chr(13)&chr(10),"<p>","all")>
	<cfset temp = replace(temp,chr(13)&chr(10),"<br/>","all")>
	<cfset temp = replace(temp,chr(32)&chr(32)&chr(32),"&nbsp;&nbsp;&nbsp;","all")>
	<cfset temp = replace(temp,chr(9),"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;","all")>
	
	<cfset x = setvariable("caller."&attributes.output,temp)>

</cfif>



