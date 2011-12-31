<cfset objAssessments = CreateObject("component","cfcs.assessment")>
<cfparam name="URL.assessment_id" default="1">
<cfparam name="ATTRIBUTES.assessment_id" default="#val(URL.assessment_id)#">
<cfparam name="URL.qcount" default="1">
<cfset qItems = objAssessments.retrieve_assessment_items(assessment_id="#ATTRIBUTES.assessment_id#")>
<cfset qAssessments = objAssessments.retrieve_assessments(assessment_id="#ATTRIBUTES.assessment_id#")>
<!---<cfset qGift_Type = objAssessments.retrieve_gift_type(assessment_id="#ATTRIBUTES.assessment_id#")>--->

<cfoutput query="qItems" startrow="#val(URL.qcount)#" maxrows="1">

<cfparam name="URL.sort_id" default="#qItems.item_type_id#">
<cfparam name="URL.type_id" default="#qItems.item_type#">
<cfparam name="URL.item_result" default="">
<cfparam name="URL.user_id" default="#Request.user_id#">
<cfparam name="URL.invite" default="">
<cfparam name="URL.assessment_id" default="">
<cfparam name="URL.page" default="">
<cfparam name="URL.qcount" default="">
<cfparam name="ATTRIBUTES.sort_id" default="#URL.sort_id#">
<cfparam name="ATTRIBUTES.type_id" default="#URL.type_id#">
<cfparam name="ATTRIBUTES.gift_type_id" default="#qAssessments.gift_type_id#">
<cfparam name="ATTRIBUTES.item_result" default="#URL.item_result#">
<cfparam name="ATTRIBUTES.user_id" default="#URL.user_id#">
<cfparam name="ATTRIBUTES.invite" default="#URL.invite#">
<cfparam name="ATTRIBUTES.assessment_id" default="#URL.assessment_id#">
<cfparam name="ATTRIBUTES.page" default="#URL.page#">
<cfparam name="ATTRIBUTES.qcount" default="#URL.qcount#">


<cfset qResults = objAssessments.retrieve_result(user_id="#HTMLEditFormat(val(ATTRIBUTES.user_id))#",assessment_id="#HTMLEditFormat(val(ATTRIBUTES.assessment_id))#",invite_uid="#HTMLEditFormat(ATTRIBUTES.invite)#")>
	<cfif qResults.recordcount>
		<cfset VARIABLES.result_set = DeserializeJSON(qResults.result_set)>
	<cfelse>
		<cfset VARIABLES.result_set = ArrayNew(1)>
	</cfif>
    
    <!--- BEGIN debugging --->
   <!--- <cfdump var="#qResults#">
    <cfabort>--->
    <!--- END debugging --->
    
<cfif isNumeric(ATTRIBUTES.sort_id)> 
	<cfset qSort = objAssessments.retrieve_sort(sort_id="#ATTRIBUTES.sort_id#")>
	<cfset VARIABLES.sort_words = DeSerializeJSON(qSort.sort_words)>
	<cfset CreateObject("java","java.util.Collections").Shuffle(VARIABLES.sort_words)>
	<cfset VARIABLES.sort_id_list = "">
	
	
	<cfif ListLen(ATTRIBUTES.item_result) GT 0>
		<cfloop from="1" to="#ListLen(ATTRIBUTES.item_result)#" index="i">
			<cfset VARIABLES.sort_words[i][1] = ListGetAt(ATTRIBUTES.item_result,i)>
			
		</cfloop>
	</cfif>
			
		<div id="sort#HTMLEditFormat(val(ATTRIBUTES.sort_id))#_result" class="sort_result">
		
		</div>
		<cfif ListLen(ATTRIBUTES.item_result) GT 0>
			<input type="button" class="retake#HTMLEditFormat(val(ATTRIBUTES.sort_id))#" value="Retake"/>
		</cfif>
		<div class="sort#HTMLEditFormat(val(ATTRIBUTES.sort_id))#_wrapper" style="background-color:white;" <cfif ListLen(ATTRIBUTES.item_result) GT 0>style="display:none;"</cfif>>
        <cfif qcount EQ 1><div style="float:left;margin:0px 40px 20px 0px;">
            <strong>Instructions:</strong><br />
            Rank the statements that complete the sentence by dragging the one that is most true about you to the top, and arranging the rest in order with the least true at the bottom. It’s easiest to do this by ranking the first two statements, then rank the third statement with the first two, and so on. </div><!---<cfelseif qcount EQ qItems.recordcount><div style="float:left;margin:20px 30px 0px 60px;">Once you finish, you’ll receive your results instantly in a report onscreen that you can view and print. It will also be stored so that you can access it at any time later.</div>---></cfif>
        <div class="sort_name">#HTMLEditFormat(qSort.sort_name)#</div>
        <br />
		<form action="/site_modules/assessment/act_word_sort.cfm" method="post" id="sort_form_#HTMLEditFormat(val(ATTRIBUTES.sort_id))#">
			
             <!--- MANAGE CONVERSION OF SORTABLE CLICK AND DRAG QUESTIONS TO SIMPLE RADIO BUTTON FUNCTIONALITY AS NEEDED--->
        	<cfparam name="REQUEST.radio_convert" default="0">
			<cfif Find("mobile",LCase(CGI.ALL_HTTP)) GT 0 OR ATTRIBUTES.assessment_id EQ 4>
            	<cfset REQUEST.radio_convert = 1>
        	</cfif>
            <cfif REQUEST.radio_convert NEQ 1>
			<ul id="sortable#HTMLEditFormat(val(ATTRIBUTES.sort_id))#" class="sortable" >
				<cfloop from="1" to="#ArrayLen(VARIABLES.sort_words)#" index="i">
					<li class="ui-state-default" id="item_#VARIABLES.sort_words[i][1]#">#VARIABLES.sort_words[i][2]#</li>
					<cfset VARIABLES.sort_id_list = ListAppend(VARIABLES.sort_id_list,VARIABLES.sort_words[i][1])>
				</cfloop>			
			</ul>
            <cfelseif REQUEST.radio_convert EQ 1>
              <cfloop from="1" to="#ArrayLen(VARIABLES.sort_words)#" index="i">
            	<label><input type="radio" name="sphere" value="#VARIABLES.sort_words[i][1]#"> #VARIABLES.sort_words[i][2]#</label>
                <cfset VARIABLES.sort_id_list = ListAppend(VARIABLES.sort_id_list,VARIABLES.sort_words[i][1])>
              </cfloop>
            </cfif>
			<input type="hidden" id="serialize#HTMLEditFormat(val(ATTRIBUTES.sort_id))#" name="sort_serialized" value="#VARIABLES.sort_id_list#"/>
			<input type="hidden" name="orig_sort_order" value="#HTMLEditFormat(VARIABLES.sort_id_list)#"/> 
			<input type="hidden" name="assessment_id" value="#HTMLEditFormat(val(ATTRIBUTES.assessment_id))#"/>
			<input type="hidden" name="sort_id" value="#HTMLEditFormat(val(ATTRIBUTES.sort_id))#"/>
			<input type="hidden" name="type_id" value="#HTMLEditFormat(val(ATTRIBUTES.type_id))#"/>
            <input type="hidden" name="gift_type_id" value="#HTMLEditFormat(val(ATTRIBUTES.gift_type_id))#"/>
			<input type="hidden" name="user_id" value="#HTMLEditFormat(val(ATTRIBUTES.user_id))#"/>
			<input type="hidden" name="invite" value="#HTMLEditFormat(ATTRIBUTES.invite)#"/>
			<input type="hidden" name="item_result" value="#ATTRIBUTES.item_result#"/>
			<input type="hidden" name="qcount" value="#HTMLEditFormat(val(ATTRIBUTES.qcount))#"/>
            <cfif ATTRIBUTES.qcount EQ qItems.recordcount>
            	<input type="hidden" name="surveydone" value="1" />
            </cfif>
			<input type="hidden" name="page" value="#HTMLEditFormat(ATTRIBUTES.page)#" />
            
			<input style="margin:20px 0px 20px 250px;" type="image" src="/site_images/<cfif qcount LT qItems.recordcount>next<cfelse>show_results</cfif>_btn.jpg" name="submit" value="Submit"/>
		</form>
<br class="clear"/>
        <cfset progbar= (308 / qItems.recordcount) * (ATTRIBUTES.qcount - 1)>
        <div class="percent_complete_label">% of survey completed</div><div class="percent_completed"><img src="/site_images/progbar_pix.png" width="#HTMLEditFormat(val(progbar))#" height="21"></div>
        
		</div>
				<script type='text/javascript'>
				$(function() {
					$('##sortable#HTMLEditFormat(val(ATTRIBUTES.sort_id))#').sortable(
						{
						update: function(event, ui) 
							{					
								$('##serialize#HTMLEditFormat(val(ATTRIBUTES.sort_id))#').val($("##sortable#HTMLEditFormat(val(ATTRIBUTES.sort_id))#").sortable("serialize"));
							} 			
						});

					$('##sortable#HTMLEditFormat(val(ATTRIBUTES.sort_id))#').disableSelection();
				});
				
				$(function(){
					//AJAX submit
					$('##sort_form_#HTMLEditFormat(val(ATTRIBUTES.sort_id))#').submit(function() { 
						//alert('Submitted' + $(this).attr("id"));
						$(this).ajaxSubmit(submitOptions#HTMLEditFormat(val(ATTRIBUTES.sort_id))#);
						return false;
						});
				});
					
					//Parameters for ajaxSubmit
					var submitOptions#HTMLEditFormat(val(ATTRIBUTES.sort_id))# = {
					target: '##sort#HTMLEditFormat(val(ATTRIBUTES.sort_id))#_result',
					beforeSubmit:showProcessing#HTMLEditFormat(val(ATTRIBUTES.sort_id))#,
					success: hideProcessing#HTMLEditFormat(val(ATTRIBUTES.sort_id))#,
					type:'post',
					url: '/site_modules/assessment/act_word_sort.cfm'
					};
				
					function showProcessing#HTMLEditFormat(val(ATTRIBUTES.sort_id))#() {

						$(".sort#HTMLEditFormat(val(ATTRIBUTES.sort_id))#_wrapper").fadeOut(500);
					} 
				
					function hideProcessing#HTMLEditFormat(val(ATTRIBUTES.sort_id))#() {
					   $("##processingMessage").addClass("hideElement");
					   setTimeout(function() {
					   $("##sort#HTMLEditFormat(val(ATTRIBUTES.sort_id))#_result").fadeIn(500);
						}, 500); 
					}
					
					$('.retake#HTMLEditFormat(val(ATTRIBUTES.sort_id))#').click(
						function(){
							$(".retake#HTMLEditFormat(val(ATTRIBUTES.sort_id))#").hide();
							$(".sort#HTMLEditFormat(val(ATTRIBUTES.sort_id))#_wrapper").fadeIn(500);
						}
					);
			</script>

	
</cfif>
</cfoutput>