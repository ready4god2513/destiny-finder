		<div id="bodyColumn">
      		<div class="section">
				<h2>mxAjax Usage</h2>
				<div class="section">
					<h3>Common Concepts</h3>
					<div class="section">
						<h4>Base URL</h4>
						<p>The <tt>baseUrl</tt>
property is required of every tag and is used by the tag to make a
request to the serverside. The responding resource (e.g., CFM, html
etc.) is responsible for returning the response in the appropriate
format (plain text, HTML, XML, JSON etc.)</p>
					</div>
					<div class="section">
						<h4>Parameters</h4>
						<div class="section">
							<h5>Overview</h5>
							<p>Each tag has a common <tt>parameters</tt> property, composed of name-value pairs that eventually get passed to the URL specified in the <tt>baseUrl</tt>
property. You may specify multiple name-value pairs by separating them
with commas. Within each pair, you can also indicate that you want a
certain form field value to be inserted at the time the request is made
by surrounding the value with curly brackets.</p>

<p>Let's look at an
example. Assume we want to pass two parameters on the URL, one
indicating the make of our automobile and another that is a plain text
constant. The value of the make parameter will be inserted at request
time. In this case, we assume the makeId form field contains a value of
"Honda".</p>
<div class="source"><pre>parameters="make={makeId},q=someConstantValue"</pre></div>
<p>...will be replaced at request time with...</p>
<div class="source"><pre>parameters="make=Honda,q=someConstantValue"</pre></div>
						</div>


						<div class="section"><h4>Post-functions and Error Functions</h4><p>If
you've wondered how to either chain AJAX tags together--by having one
execute after another has completed--then you'll like this. The <tt>postFunction</tt>
attribute allows you do just that. This attribute expects a JavaScript
function name to be passed. The AJAX JavaScript will execute the
function you define after it has finished its work.</p><p>In addition
to post-functions, you may also define functions to be executed when
the AJAX request could not be completed (e.g., invalid URL, server
exception). You simply enter the name of the user-defined JavaScript
function into the optional <tt>errorFunction</tt> tag attribute.</p></div>
				</div>


				<div class="section"><h3>mxAutocomplete</h3><p>The
autocomplete tag allows one to retrieve a list of probable values from
CF and display them in a
dropdown beneath an HTML text input field. The user may then use the
cursor and ENTER keys or the mouse to make a selection from that list
of labels, which is then populated into the text field. This tag
also allows for a second field to be populated with the value or ID of
the item in the dropdown.</p><div class="source"><pre>&lt;form&gt;
	State : &lt;input id="searchCharacter" name="searchCharacter" type="text" size="40" /&gt;
	&lt;input id="statecode" name="statecode" type="text" size="2" /&gt;
&lt;/form&gt;

new mxAjax.Autocomplete({
	indicator: "indicator",
	minimumCharacters: "1",
	target: "statecode",
	className: "autocomplete",
	paramArgs: new mxAjax.Param(url,{cffunction:"getStateList"}),
	parser: new mxAjax.CFQueryToJSKeyValueParser(),
	source: "searchCharacter"
});
  </pre></div><table class="bodyTable"><tbody><tr class="b"><td align="left"><b>Parameter</b></td><td align="left"><b>Description</b></td><td align="center"><b>Required</b></td></tr><tr class="a"><td align="left">var</td><td align="left">Name of the JavaScript object created</td><td align="center">no</td></tr><tr class="b"><td align="left">attachTo</td><td align="left">Name of the JavaScript object to which autocompleter will attach. You must define 'var' for this to work.</td><td align="center">no</td></tr><tr class="a"><td align="left">baseUrl</td><td align="left">URL
of CF code that processes search and returns list
of values used in autocomplete dropdown; expression language (EL) is
supported for this field</td><td align="center">yes</td></tr><tr class="b"><td align="left">source</td>
<td align="left">Text field where label of autocomplete selection will be populated; also the field in which the user types out the search string</td>
<td align="center">yes</td></tr><tr class="a"><td align="left">target</td>
<td align="left">Text field where value of autocomplete selection will be populated; you may set this to the same value as the source field</td>
<td align="center">yes</td></tr>
<tr class="b">
	<td align="left">parameters</td>
	<td align="left">A comma-separated list of parameters to pass to the server-side CFM page or CFC</td>
	<td align="center">yes</td>
</tr>
<tr class="a">
	<td align="left">className</td>
	<td align="left">CSS class name to apply to the popup autocomplete dropdown</td>
	<td align="center">yes</td></tr><tr class="b"><td align="left">indicator</td>
	<td align="left">ID of indicator region that will show during Ajax request call</td>
	<td align="center">no</td></tr><tr class="a"><td align="left">minimumCharacters</td>
	<td align="left">Minimum number of characters needed before autocomplete is executed</td>
	<td align="center">no</td></tr><tr class="b"><td align="left">appendSeparator</td>
	<td align="left">The separator to use for the target field when values are appended
[default=space]. If appendValue is not set or is set to "false", this
parameter has no effect.</td><td align="center">no</td></tr><tr class="a">
<td align="left">preFunction</td><td align="left">Function to execute before Ajax is begun</td>
<td align="center">no</td></tr><tr class="b"><td align="left">postFunction</td>
<td align="left">Function to execute after Ajax is finished, allowing for a chain of additional functions to execute</td>
<td align="center">no</td></tr><tr class="a"><td align="left">errorFunction</td>
<td align="left">Function to execute if there is a server exception (non-200 HTTP response)</td>
<td align="center">no</td></tr><tr class="b"><td align="left">parser</td>
<td align="left">The response parser to implement [default=CFArrayToJSKeyValueParser]</td><td align="center">no</td></tr></tbody></table></div>






<div class="section"><h3>mxPortlet</h3><p>The portlet tag simulates a <i>a href="http://www.jcp.org/en/jsr/detail?id=168"</i>JSR-168<i>/a</i>
style portlet by allowing you to define a portion of the page that
pulls content from another location using Ajax with or without a
periodic refresh.</p><p>This tag expects an HTML response instead of
XML and the AJAX function will not parse it as XML; it will simply
insert the content of the response as is.</p><div class="source"><pre>
new mxAjax.Portlet({
	executeOnLoad: true,
	paramArgs: new mxAjax.Param(url + '?htmlResponse=true',{param:"code=honda", cffunction:"getContent"}),
	imageClose: "../core/images/close.png",
	imageRefresh: "../core/images/refresh.png",
	title: "Demo Portlet",
	classNamePrefix: "portlet",
	imageMaximize: "../core/images/maximize.png",
	imageMinimize: "../core/images/minimize.png",
	source: "portlet_1",
	refreshPeriod: "5"
});
</pre></div><table class="bodyTable"><tbody><tr class="a"><td align="left"><b>Parameter</b></td><td align="left"><b>Description</b></td><td align="center"><b>Required</b></td></tr><tr class="b"><td align="left">var</td><td align="left">Name of the JavaScript object created</td><td align="center">no</td></tr><tr class="a"><td align="left">attachTo</td><td align="left">Name of the JavaScript object to which portlet will attach. You must define 'var' for this to work.</td><td align="center">no</td></tr><tr class="b"><td align="left">baseUrl</td><td align="left">URL of CF code that processes a simple command</td><td align="center">yes</td></tr><tr class="a"><td align="left">source</td><td align="left">ID of the portlet</td><td align="center">yes</td></tr><tr class="b"><td align="left">parameters</td><td align="left">A comma-separated list of parameters to pass to the CF code</td><td align="center">no</td></tr><tr class="a"><td align="left">classNamePrefix</td><td align="left">CSS class name prefix to use for the portlet's 'Box', 'Tools', 'Refresh', 'Size', 'Close', 'Title', and 'Content' elements</td><td align="center">yes</td></tr><tr class="b"><td align="left">title</td><td align="left">Title for portlet header</td><td align="center">yes</td></tr><tr class="a"><td align="left">imageClose</td><td align="left">Image used for the close icon</td><td align="center">no</td></tr><tr class="b"><td align="left">imageMaximize</td><td align="left">Image used for the maximize icon</td><td align="center">no</td></tr><tr class="a"><td align="left">imageMinimize</td><td align="left">Image used for the minimize icon</td><td align="center">no</td></tr><tr class="b"><td align="left">imageRefresh</td><td align="left">Image used for the refresh icon</td><td align="center">no</td></tr><tr class="a"><td align="left">refreshPeriod</td><td align="left">The
time (in seconds) the portlet waits before automatically refreshing its
content. If no period is specified, the portlet will not refresh itself
automatically, but must be commanded to do so by clicking the refresh
image/link (if one is defined). Lastly, the refresh will not occur
until after the first time the content is loaded, so if executeOnLoad
is set to false, the refresh will not begin until you manually refresh
the first time.</td><td align="center">no</td></tr><tr class="b"><td align="left">executeOnLoad</td><td align="left">Indicates whether the portlet's content should be retrieved when the page loads [default=true]</td><td align="center">no</td></tr><tr class="a"><td align="left">expireDays</td><td align="left">Number of days cookie should persist</td><td align="center">no</td></tr><tr class="b"><td align="left">expireHours</td><td align="left">Number of hours cookie should persist</td><td align="center">no</td></tr><tr class="a"><td align="left">expireMinutes</td><td align="left">Number of minutes cookie should persist</td><td align="center">no</td></tr><tr class="b"><td align="left">preFunction</td><td align="left">Function to execute before Ajax is begun</td><td align="center">no</td></tr><tr class="a"><td align="left">postFunction</td><td align="left">Function to execute after Ajax is finished, allowing for a chain of additional functions to execute</td><td align="center">no</td></tr><tr class="b"><td align="left">errorFunction</td><td align="left">Function to execute if there is a server exception (non-200 HTTP response)</td><td align="center">no</td></tr></tbody></table></div>




<div class="section"><h3>mxSelect</h3><p>The
select tag allows one to retrieve a list of values from a backend
servlet (or other server-side control) and display them in another HTML
select box.</p><div class="source"><pre>&lt;form&gt;
    &lt;table&gt;
	&lt;tr&gt;
		&lt;td&gt;
			Select a phone brand :
		&lt;/td&gt;
		&lt;td&gt;
			&lt;select id="brand" name="brand"&gt;
				&lt;option value="Nokia"&gt;Nokia&lt;/option&gt;
				&lt;option value="Motorolla"&gt;Motorolla&lt;/option&gt;
				&lt;option value="Samsung"&gt;Samsung&lt;/option&gt;
			&lt;/select&gt;
		&lt;/td&gt;
	&lt;/tr&gt;
	&lt;tr&gt;
		&lt;td align="right"&gt;
			Select a phone model :
		&lt;/td&gt;
		&lt;td&gt;
			&lt;select name="model" id="model" style="vertical-align:top;"&gt;&lt;/select&gt;
		&lt;/td&gt;
	&lt;/tr&gt;
    &lt;/table&gt;
&lt;/form&gt;

new mxAjax.Select({
	parser: new mxAjax.CFArrayToJSKeyValueParser(),
	executeOnLoad: true,
	target: "model", 
	paramArgs: new mxAjax.Param(url,{param:"brand={brand}", cffunction:"makelookup"}),
	source: "brand"
});

</pre></div><table class="bodyTable"><tbody><tr class="a"><td align="left"><b>Parameter</b></td><td align="left"><b>Description</b></td><td align="center"><b>Required</b></td></tr><tr class="b"><td align="left">var</td><td align="left">Name of the JavaScript object created</td><td align="center">no</td></tr><tr class="a"><td align="left">attachTo</td><td align="left">Name of the JavaScript object to which select will attach. You must define 'var' for this to work.</td><td align="center">no</td></tr><tr class="b"><td align="left">baseUrl</td><td align="left">URL of CF code that processes a simple command</td><td align="center">yes</td></tr><tr class="a"><td align="left">source</td><td align="left">The initial select field that will form the basis for the search via AJAX</td><td align="center">yes</td></tr><tr class="b"><td align="left">target</td><td align="left">Select field where value of AJAX search will be populated</td><td align="center">yes</td></tr><tr class="a"><td align="left">parameters</td><td align="left">A comma-separated list of parameters to pass to the CF code</td><td align="center">no</td></tr><tr class="b"><td align="left">eventType</td><td align="left">Specifies the event type to attach to the source field(s)</td><td align="center">no</td></tr><tr class="a"><td align="left">executeOnLoad</td><td align="left">Indicates
whether the target select/dropdown should be populated when the object
is initialized (this is essentially when the form loads) [default=false]</td><td align="center">no</td></tr><tr class="b"><td align="left">defaultOptions</td><td align="left">A comma-seperated list of values of options to be marked as selected by default if they exist in the new set of options</td><td align="center">no</td></tr><tr class="a"><td align="left">preFunction</td><td align="left">Function to execute before Ajax is begun</td><td align="center">no</td></tr><tr class="b"><td align="left">postFunction</td><td align="left">Function to execute after Ajax is finished, allowing for a chain of additional functions to execute</td><td align="center">no</td></tr><tr class="a"><td align="left">errorFunction</td><td align="left">Function to execute if there is a server exception (non-200 HTTP response)</td><td align="center">no</td></tr><tr class="b"><td align="left">parser</td><td align="left">The response parser to implement [default=CFArrayToJSKeyValueParser]</td><td align="center">no</td></tr></tbody></table></div>

<div class="section"><h3>mxTabPanel</h3><p>Provides a tabbed page view of content from different resources</p><div class="source"><pre>
&lt;div id="tabPanelWrapper"&gt;
	&lt;div id="tabPanel" class="tabPanel"&gt;
&lt;ul&gt;
 &lt;li&gt;&lt;a href="javascript://" onclick="executeAjaxTab(this, 'code=ford'); return false;" 
	class="ajaxCurrentTab"&gt;Ford&lt;/a&gt;&lt;/li&gt;
 &lt;li&gt;&lt;a href="javascript://" onclick="executeAjaxTab(this, 'code=honda'); return false;"&gt;Honda&lt;/a&gt;&lt;/li&gt;
 &lt;li&gt;&lt;a href="javascript://" onclick="executeAjaxTab(this, 'code=mazda'); return false;"&gt;Mazda&lt;/a&gt;&lt;/li&gt;
&lt;/ul&gt;
	&lt;/div&gt;
	&lt;div id="tabContent" class="tabContent"&gt;&lt;/div&gt;
	&lt;p&gt;Page loaded at: &lt;cfoutput&gt;#now()#&lt;/cfoutput&gt;&lt;/p&gt;
&lt;/div&gt;

function executeAjaxTab(elem, params) {
	var aj_tabPanel = new mxAjax.TabPanel({
	paramArgs: new mxAjax.Param(url + '?htmlResponse=true',{param:params, cffunction:"getContent"}),
	target: "tabContent",
	panelId: "tabPanel",
	source: elem,
	currentStyleClass: "ajaxCurrentTab"
	});
}

</pre></div>


<div class="section"><h4>mxTabPanel</h4><table class="bodyTable"><tbody><tr class="a"><td align="left"><b>Parameter</b></td><td align="left"><b>Description</b></td><td align="center"><b>Required</b></td></tr><tr class="b"><td align="left">var</td><td align="left">Name of the JavaScript object created</td><td align="center">no</td></tr><tr class="a"><td align="left">attachTo</td><td align="left">Name of the JavaScript object to which tabPanel will attach. You must define 'var' for this to work.</td>
<td align="center">no</td></tr><tr class="b">
<td align="left">panelStyleId</td><td align="left">ID of the tab panel</td>
<td align="center">yes</td></tr><tr class="a"><td align="left">contentStyleId</td>
<td align="left">ID of the tab panel content</td><td align="center">yes</td></tr>
<tr class="b"><td align="left">panelStyleClass</td><td align="left">CSS classname of the tab panel</td>
<td align="center">no</td></tr><tr class="a"><td align="left">contentStyleClass</td><td align="left">CSS classname of the tab panel content</td>
<td align="center">no</td></tr><tr class="b"><td align="left">currentStyleClass</td>
<td align="left">CSS classname to use for the active tab</td><td align="center">yes</td></tr>
<tr class="a"><td align="left">preFunction</td><td align="left">Function to execute before Ajax is begun</td>
<td align="center">no</td></tr><tr class="b"><td align="left">postFunction</td>
<td align="left">Function to execute after Ajax is finished, allowing for a chain of additional functions to execute</td>
<td align="center">no</td></tr><tr class="a"><td align="left">errorFunction</td>
<td align="left">Function to execute if there is a server exception (non-200 HTTP response)</td>
<td align="center">no</td></tr><tr class="b"><td align="left">parser</td>
<td align="left">The response parser to implement [default=CFArrayToJSKeyValueParser]</td>
<td align="center">no</td></tr></tbody></table></div>
<div class="section"><h4>mxTablePanel - Individual Tab</h4><table class="bodyTable"><tbody><tr class="a"><td align="left"><b>Parameter</b></td><td align="left"><b>Description</b></td><td align="center"><b>Required</b></td></tr><tr class="b"><td align="left">baseUrl</td><td align="left">The URL to use for the AJAX action, which will return content for this tab</td><td align="center">yes</td></tr><tr class="a"><td align="left">caption</td><td align="left">The caption for this tab</td><td align="center">yes</td></tr><tr class="b"><td align="left">defaultTab</td><td align="left">Indicates whether this tab is the initial one loaded [true</td><td align="center">false]</td></tr><tr class="a"><td align="left">parameters</td><td align="left">A comma-separated list of parameters to pass to the CF code</td><td align="center">no</td></tr></tbody></table></div></div>





<div class="section"><h3>mxUpdateField</h3>
<p>Builds the JavaScript required to update one or more form fields based on the value of another single field.</p><div class="source"><pre>
	
&lt;select id="brand" name="brand"&gt;
	&lt;option value="Nokia"&gt;Nokia&lt;/option&gt;
	&lt;option value="Motorolla"&gt;Motorolla&lt;/option&gt;
&lt;/select&gt;
Make : &lt;input id="make" name="make" type="text" size="30" /&gt;
Model : &lt;input id="model" name="model" type="text" size="30" /&gt;

new mxAjax.UpdateField({
	parser: new mxAjax.CFArrayToJSArray(),
	paramArgs: new mxAjax.Param(url,{param:"brand={brand}", cffunction:"makelookup"}),
	target: "make,model",
	source: "brand"
});
</pre></div>

<table class="bodyTable"><tbody><tr class="b"><td align="left"><b>Parameter</b></td><td align="left"><b>Description</b></td><td align="center"><b>Required</b></td></tr><tr class="a"><td align="left">var</td><td align="left">Name of the JavaScript object created</td><td align="center">no</td></tr><tr class="b"><td align="left">attachTo</td><td align="left">Name of the JavaScript object to which updateField will attach. You must define 'var' for this to work.</td><td align="center">no</td></tr><tr class="a"><td align="left">baseUrl</td><td align="left">URL of CF code that processes a simple command</td><td align="center">yes</td></tr><tr class="b"><td align="left">source</td><td align="left">The form field that will hold the parameter passed to the servlet</td><td align="center">yes</td></tr><tr class="a"><td align="left">target</td><td align="left">A comma-delimited list of form field IDs that will be populated with results</td><td align="center">yes</td></tr><tr class="b"><td align="left">action</td><td align="left">ID of form button or image tag that will fire the onclick event</td><td align="center">yes</td></tr><tr class="a"><td align="left">parameters</td><td align="left">A comma-separated list of parameters to pass to the CF code</td><td align="center">no</td></tr><tr class="b"><td align="left">eventType</td><td align="left">Specifies the event type to attach to the source field(s)</td><td align="center">no</td></tr><tr class="a"><td align="left">preFunction</td><td align="left">Function to execute before Ajax is begun</td><td align="center">no</td></tr><tr class="b"><td align="left">postFunction</td><td align="left">Function to execute after Ajax is finished, allowing for a chain of additional functions to execute</td><td align="center">no</td></tr><tr class="a"><td align="left">errorFunction</td><td align="left">Function to execute if there is a server exception (non-200 HTTP response)</td><td align="center">no</td></tr><tr class="b"><td align="left">parser</td><td align="left">The response parser to implement [default=CFArrayToJSKeyValueParser]</td><td align="center">no</td></tr></tbody></table></div></div>
      </div>
    </div>
	




<div class="section">
<h4>mxDomInclude</h4>
<p>
	mxDOMinclude is replacement for annoying popup windows : If JavaScript is available the linked file gets shown in a new layer - 
	if it is an image just as the image, if not inside an IFRAME. DOMinclude automatically positions the popup where the original link is 
	and adds a text prefix to the original link telling the user how to hide the layer again	
</p>
<div class="source"><pre>
function init() {
	new mxAjax.DomInclude( {source:"amazon"} ); 
	new mxAjax.DomInclude( {source:"photo"} ); 
	new mxAjax.DomInclude( {source:"content"} ); 
}
addOnLoadEvent(function() {init();});

Example 1 : &lt;a id="amazon" href="data/amberspyglass.html"&gt;Phillip Pullman: The Amber Spyglass&lt;/a&gt; 
&lt;br&gt;&lt;br&gt;
Example 2 : &lt;a id="photo" href="data/saywhat.jpg"&gt;Image&lt;/a&gt;
&lt;br&gt;&lt;br&gt;
Example 3 : &lt;a id="content" href="data/exampleTandC.html"&gt;Html Content&lt;/a&gt;
</pre></div>
<table class="bodyTable">
	<tbody>
		<tr class="a">
			<td align="left"><b>Parameter</b></td>
			<td align="left"><b>Description</b></td>
			<td align="center"><b>Required</b></td>
		</tr>
		<tr class="b">
			<td align="left">var</td>
			<td align="left">Name of the JavaScript object created</td>
			<td align="center">no</td>
		</tr>
		<tr class="a">
			<td align="left">id</td>
			<td align="left">ID of the link</td>
			<td align="center">no</td>
		</tr>
		<tr class="b">
			<td align="left">eventType</td>
			<td align="left">Specifies the event type to attach to the source field</td>
			<td align="center">no</td>
		</tr>
		<tr class="a">
			<td align="left">popupClass</td>
			<td align="left">css class of the popup</td>
			<td align="center">no</td>
		</tr>
		<tr class="b">
			<td align="left">openPopupLinkClass</td>
			<td align="left">css class of the link when the popup is open</td>
			<td align="center">no</td>
		</tr>
		<tr class="a">
			<td align="left">displayPrefix</td>
			<td align="left">text to add to the link when the popup is open : Default is "Hide""</td>
			<td align="center">no</td>
		</tr>
		<tr class="b">
			<td align="left">frameSize</td>
			<td align="left">dimensions of the popup : Default is [320,180] </td>
			<td align="center">no</td>
		</tr>
	</tbody>
</table>
</div>





    <div class="clear">
      <hr>
    </div>
    <div id="footer">
      <div class="xright">© 2005-2006 Darren L. Spurgeon
			<br/>Addition/Updates by : Arjun Kalura
			
      </div>
      <div class="clear">
        <hr>
      </div>
    </div>
