<cfset objAssessments = CreateObject("component","cfcs.assessment")>
<cfparam name="URL.assessment_id" default="1">
<cfparam name="ATTRIBUTES.assessment_id" default="#val(URL.assessment_id)#">
<cfparam name="URL.qcount" default="1">
<cfset qItems = objAssessments.retrieve_assessment_items(assessment_id="#ATTRIBUTES.assessment_id#")>
<cfset qAssessments = objAssessments.retrieve_assessments(assessment_id="#ATTRIBUTES.assessment_id#")>
<!---<cfset qGift_Type = objAssessments.retrieve_gift_type(assessment_id="#ATTRIBUTES.assessment_id#")>--->

<cfoutput query="qItems" startrow="#val(URL.qcount)#" maxrows="1">

<cfparam name="FORM.invite" default="" />
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


<!--- FRIEND CHECK - validate friend invite --->
<cfif REQUEST.user_id EQ 0>
	<cfset vIsInvite = true />
<cfelse>
	<cfset vIsInvite = Len(URL.invite) GT 0 OR Len(FORM.invite) GT 0 />
</cfif>

<!--- END FRIEND CHECK --->

<cfset qResults = objAssessments.retrieve_result(user_id="#HTMLEditFormat(val(ATTRIBUTES.user_id))#",assessment_id="#HTMLEditFormat(val(ATTRIBUTES.assessment_id))#",invite_uid="#HTMLEditFormat(ATTRIBUTES.invite)#")>

<cfif qResults.recordcount>
	<cfset VARIABLES.result_set = DeserializeJSON(qResults.result_set)>
<cfelse>
	<cfset VARIABLES.result_set = ArrayNew(1)>
</cfif>
    
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
        <cfif qcount EQ 1>
			<p>
            	<strong>Instructions:</strong><br />
                <cfif vIsInvite EQ 1>
                Rank the statements that complete the sentence by dragging the one that is most 
				true about your friend to the top, and arranging the rest in order with the least true 
				at the bottom. It’s easiest to do this by ranking the first two statements, 
				then rank the third statement with the first two, and so on.
				<cfelse>
                Rank the statements that complete the sentence by dragging the one that is most 
				true about you to the top, and arranging the rest in order with the least true 
				at the bottom. It’s easiest to do this by ranking the first two statements, 
				then rank the third statement with the first two, and so on.
				</cfif>
	            
            </p>
		</cfif>
        
        <h2>
			<cfif vIsInvite EQ 1>
				#HTMLEditFormat(qSort.sort_name_alt)#
			<cfelse>
				#HTMLEditFormat(qSort.sort_name)#
			</cfif>
		</h2>
		<form action="/site_modules/assessment/act_word_sort.cfm" method="post" id="sort_form_#HTMLEditFormat(val(ATTRIBUTES.sort_id))#">
			
             <!--- MANAGE CONVERSION OF SORTABLE CLICK AND DRAG QUESTIONS TO SIMPLE RADIO BUTTON FUNCTIONALITY AS NEEDED--->
        	<cfparam name="REQUEST.radio_convert" default="0">
			<cfif Find("MSIE 9.0",LCase(CGI.ALL_HTTP)) GT 0 OR Find("mobile",LCase(CGI.ALL_HTTP)) GT 0>
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
            <input class="btn primary" type="submit" name="submit" value="<cfif qcount LT qItems.recordcount>Next Step<cfelse>Show Results</cfif>" />
		</form>
<br class="clear"/>
		<cfset progbar = (ATTRIBUTES.qcount / qItems.recordcount) * 100>
        <div class="percent_complete_label">% of survey completed</div>
		<div class="progress progress-info progress-striped active">
		  <div class="bar" style="width: #progbar#%;"></div>
		</div>
        
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
				
					function showProcessing#HTMLEditFormat(val(ATTRIBUTES.sort_id))#() 
					{
						$(".sort#HTMLEditFormat(val(ATTRIBUTES.sort_id))#_wrapper").fadeOut(500);
					} 
				
					function hideProcessing#HTMLEditFormat(val(ATTRIBUTES.sort_id))#() {
							$('.assessment_item').append('<img src="/assets/images/loading.gif" id="loading-icon" />');
					   setTimeout(function() {
					   		$("##sort#HTMLEditFormat(val(ATTRIBUTES.sort_id))#_result").fadeIn(500);
							$("##loading-icon").remove();
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