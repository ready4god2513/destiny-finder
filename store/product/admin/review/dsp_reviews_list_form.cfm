<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the List Edit form for reviews. This page is used to make common changes to multiple reviews at one time. Called by product.admin&review=listform --->

<cfparam name="attributes.displaycount" default="12">

<!--- Create the string with the filter parameters --->		
<cfset addedpath="&fuseaction=product.admin&review=#attributes.review#">
<cfset fieldlist = "uid,uname,search_string,product_ID,rating,recommend,approved,needsCheck,order,sortby,editorial,recent_days">

<cfloop list="#fieldlist#" index="counter">
	<cfif isdefined('attributes.' & counter) and len(evaluate('attributes.' & counter))>
		<cfset addedpath="#addedpath#&#counter#=" & evaluate('attributes.' & counter)>
	</cfif>
</cfloop>
		
<cfparam name="currentpage" default="1">

<cfinclude template="../../../queries/qry_getpicklists.cfm">				

<!--- Create the page through links, max records set by the display count --->		
<cfmodule template="../../../customtags/pagethru.cfm" 
	totalrecords="#qry_get_reviews.recordcount#" 
	currentpage="#currentpage#"
	templateurl="#self#"
	addedpath="#addedpath##request.token2#"
	displaycount="#attributes.displaycount#" 
	imagepath="#request.appsettings.defaultimages#/icons/" 
	imageheight="12" 
	imagewidth="12"
	hilightcolor="###request.getcolors.mainlink#" 
	>
	
<cfsetting enablecfoutputonly="no">		
		
<cfmodule template="../../../customtags/format_admin_form.cfm"
	box_title="Product Review Manager"
	width="600"
	required_fields="0"
	>

<cfoutput>		
	<tr>
		<td colspan="3">
			<a href="#self#?#replace(addedpath,"listform","list")#">List View</a></td>
		<td colspan="4"	align="right">#pt_pagethru#</td>
	</tr>

	<form action="#self#?fuseaction=product.admin&review=listform#request.token2#" method="post">
	
	<tr>
		<td><span class="formtextsmall"><br/></span>
		<input type="submit" value="Search" class="formbutton"/></td>
			
		<td><span class="formtextsmall">product ID<br/></span>
		<input type="text" name="product_ID" size="5" maxlength="8" class="formfield" value="#attributes.product_ID#"/>
		</td>	
			
		<td><span class="formtextsmall">title, comment search word<br/></span>
			<input type="text" name="search_string" size="25" maxlength="25" class="formfield" value="#HTMLEditFormat(attributes.search_string)#"/></td>	
				
		<td><span class="formtextsmall">order by<br/></span>
		<select name="sortby" size="1" class="formfield">
			<option value=""></option>
			<option value="newest" #doSelected(attributes.sortby,'newest')#>newest</option>
			<option value="oldest" #doSelected(attributes.sortby,'oldest')#>oldest</option>
			<option value="highest" #doSelected(attributes.sortby,'highest')#>best</option>
			<option value="lowest" #doSelected(attributes.sortby,'lowest')#>worst</option>
			<option value="mosthelp" #doSelected(attributes.sortby,'mosthelp')#>helpful</option>
			<option value="leasthelp" #doSelected(attributes.sortby,'leasthelp')#>not helpful</option>
		</select>
		</td>			

		<td><span class="formtextsmall">editorial<br/></span>
		<select name="editorial" size="1" class="formfield">
			<option value="">all</option>
			<cfmodule template="../../../customtags/form/dropdown.cfm"
			mode="valuelist"
			valuelist="#qry_getpicklists.Review_Editorial#"
			selected="#attributes.editorial#"
			/>
	 	</select>
			</td>		
			
		<td><span class="formtextsmall">display<br/></span>
		<select name="display_status" class="formfield">
			<option value="" #doSelected(attributes.display_status,'')#>all</option>
			<option value="check" #doSelected(attributes.display_status,'check')#>check</option>
			<option value="pending" #doSelected(attributes.display_status,'pending')#>pending</option>
			<option value="editor" #doSelected(attributes.display_status,'editor')#>editor</option>
			<option value="day" #doSelected(attributes.display_status,'day')#>day</option>
			<option value="week" #doSelected(attributes.display_status,'week')#>week</option>
			<option value="month" #doSelected(attributes.display_status,'month')#>month</option>
		</select></td>			
						
		<td><span class="formtextsmall"><br/></span>
		<a href="#self#?fuseaction=product.admin&review=listform#Request.Token2#">ALL</a><br/>
		</td></tr>
		</form>		
		
	<tr>
		<td colspan="7" style="BACKGROUND-COLOR: ###Request.GetColors.outputHBgcolor#;">
		<img src="#Request.AppSettings.defaultimages#/spacer.gif" alt="" height="1" width="1" /></td>
	</tr>
		

	<tr>
		<th>Edit</th>
		<th colspan="3" align="left">Review/Comment</th>
		<th>Editorial</th>
		<th colspan="2"></th>	
	</tr>	
	
<!--- Make list of review IDs to send to next page --->
<cfset reviewList = "">

<form name="editform" action="#self#?#replace(addedpath,"listform","actform")##request.token2#" method="post">

<cfif qry_get_reviews.recordcount gt 0>					
	<cfloop query="qry_get_reviews" startrow="#PT_StartRow#" endrow="#PT_EndRow#">
	<!--- Add review ID to the list --->
	<cfset reviewList = ListAppend(reviewList, Review_ID)>

		<tr>
			<td valign="top"><a href="#self#?fuseaction=product.admin&review=edit&Review_ID=#Review_ID##Request.Token2#">
			Edit #Review_ID#</a></td>
		
			<td  valign="top" colspan="3">
			<a href="#self#?fuseaction=product.reviews&do=display&Review_ID=#Review_ID##request.token2#" target="store"><strong>#LEFT(title, 50)#</strong></a><br/>
				
				<strong>re:</strong> <a href="#self#?fuseaction=product.display&product_ID=#product_ID##request.token2#" target="store">#LEFT(product_Name, 50)#</a><br/>

			<em>by <cfif Anonymous is 1>a member<cfelseif user_ID><a href="#self#?fuseaction=product.reviews&do=list&uid=#user_ID##request.token2#" target="store"><cfif len(anon_name)>#anon_name#<cfelse>#username#</cfif></a><cfelse>#anon_name#</cfif>
			<cfif len(Anon_Loc)>from #Anon_Loc#</cfif> on #dateformat(Posted,"mmm d, yyyy")#</em>
			<br/>#comment#
			
			</td>
			
		<td  valign="top" align="center">
		<select name="editorial#Review_ID#" size="1" class="formfield">
			<option value=""></option>
			<cfmodule template="../../../customtags/form/dropdown.cfm"
			mode="valuelist"
			valuelist="#qry_getpicklists.Review_Editorial#"
			selected="#editorial#"
			/>
	 	</select>
		</td>
		
		<td  valign="top" colspan="2">
			<input type="checkbox" name="Approved#Review_ID#" value="1" #doChecked(approved)# /> 
			<cfif approved>approved<cfelse><span style="color: orange;"><strong>approved</strong></span></cfif>

			<br/>
			<input type="checkbox" name="needscheck#Review_ID#" value="1" #doChecked(needscheck)# />  
			<cfif NOT needscheck>needs check<cfelse><span style="color: red;"><strong>needs check</strong></span></cfif>

		</td>
		</tr>	
		</cfloop>	
	
		<tr><td colspan="7" align="center">
		<div align="right" class="formtext">#pt_pagethru#</div>
	<input type="submit" name="Action" value="Save Changes" class="formbutton"/>
	<input type="hidden" name="reviewList" value="#reviewList#"/>
		</td></tr>
	</form>	

	<cfelse>	
		<td colspan="7">
		<br/>
		<span class="formerror">No records selected</span>
		</td>
	</cfif>
</cfoutput>

</cfmodule>
