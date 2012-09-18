<cfset obj_queries = CreateObject('component','cfcs.queries')>
<cfset pageTitle = "The Destiny Finder Store">
<cfparam name="URL.gateway" default="6">
<cfparam name="VARIABLES.page" default="">
<cfparam name="VARIABLES.gateway_id" default="">

<!--- THIS MODULE FINDS THE FIRST PAGE TO CALL FROM A GATEWAY --->
<cfmodule template="/templates/initial_page_call.cfm"
	gateway="#URL.gateway#"
>
<cfparam name="URL.page" default="#VARIABLES.page#">

<!--- RETRIEVE THE PAGE CONTENT --->
<cfset qContent = obj_queries.get_content(page='#URL.page#')>

<cfmodule template="../templates/site_wrapper.cfm"
	page_name="#pageTitle#"
	gateway_id="#URL.gateway#"
	header_image="#qContent.content_header_img#"
	html_title="#pageTitle#"
	meta_desc="">
	
	<div class="row">
		<div class="span11">
			<section id="main" class="no-filter">
				<h2>Destiny Finder Workshop</h2>
				<h5>
				    Saturday September 22, 2012<br />
                    At the PLF Revive facilities<br />
                    13th Street &amp; Avenue E:<br />
                    Treasure Island, San Francisco<br />
                    Times: 10:00am - 4:00pm Cost: $25<br />
				</h5>
				<p>See below for a special discount offer.</p>
				<p>
				    <strong>Destiny Finder</strong> will lead you on a journey of 
				    discovery to help you 
				    identify your spiritual gifts and equip you with the necessary 
				    tools to find and fulfill your God-given destiny. 
				    In this workshop you will receive:
				</p>
				<ul>
				    <li>Practical tools for pursuing your personal destiny</li>
				    <li>Prophetic ministry from a team from Bethel Church</li>
				    <li>Skills to coach others in the Destiny Finder process</li>
				</ul>
				<p>
				    This workshop is part of a set of powerful tools 
				    including the Destiny Finder Book and 
				    <a href="http://destinyfinder.com">destinyfinder.com</a>. The website provides 
				    a Free Destiny Survey, The Destiny Profiler, personal coaching, 
				    and additional resources to help you continue 
				    to thrive in your journey. 
				</p>
				<p>
				    Registration is at the door on a first come basis. 
				    If you want to let us know you are coming, please click on the 
				    CONTACT button on the menu bar and fill in the information. 
				    Hope to see you this Saturday!
				</p>
				<h3>Special Offer!</h3>
				<p>
				    The cost is $25.00 at the door but if you take the Destiny 
				    Profiler Surveys online and bring in your printed report you will
				    receive a $10 discount. Taking the Profiler first will not 
				    only save you money but will help you maximize the benefit of 
				    this workshop. We recommend everyone bring their own lunch. 
				</p>
				<p>
				    For more information, email us at <a href="mailto:info@destinyfinder.com">info@destinyfinder.com</a><br />
				    Take the Profiler Surveys at <a href="http://destinyfinder.com">destinyfinder.com</a>
				</p>
			</section>
		</div>

		<cfinclude template="../templates/sidebar.cfm" />
	</div>
</cfmodule>