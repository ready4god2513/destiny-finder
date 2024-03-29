<cfset objAssessments = CreateObject("component","cfcs.assessment")>

<cfparam name="ATTRIBUTES.agree_id" default="">
<cfparam name="ATTRIBUTES.item_result" default="">
<cfparam name="ATTRIBUTES.user_id" default="">
<cfparam name="ATTRIBUTES.assessment_id" default="">


<cfif isNumeric(ATTRIBUTES.agree_id)>
	<cfset qAgree = objAssessments.retrieve_agree(agree_id="#ATTRIBUTES.agree_id#")>

	<cfoutput>
		<div class="agree_question">#qAgree.agree_question#</div>
		<div id="agree#ATTRIBUTES.agree_id#_result" class="agree_result">
		
		</div>
		<cfif isStruct(ATTRIBUTES.item_result) GT 0>
			<input type="button" class="retake#ATTRIBUTES.agree_id#" value="Retake"/>
		</cfif>
		<div class="agree#ATTRIBUTES.agree_id#_wrapper" <cfif isStruct(ATTRIBUTES.item_result) GT 0>style="display:none;"</cfif>>
		<form action="/site_modules/assessment/act_agree.cfm" method="post" id="agree_form_#ATTRIBUTES.agree_id#">
			
			<div class="agree_rank">
				<ul>
					<li><input type="radio" value="5" name="rate">&nbsp;Strongly Agree</li>
					<li><input type="radio" value="4" name="rate">&nbsp;Agree</li>
					<li><input type="radio" value="3" name="rate">&nbsp;Neutral</li>
					<li><input type="radio" value="2" name="rate">&nbsp;Disagree</li>
					<li><input type="radio" value="1" name="rate">&nbsp;Strongly Disagree</li>
				</ul>
			
			</div>

			<input type="hidden" name="assessment_id" value="#ATTRIBUTES.assessment_id#"/>
			<input type="hidden" name="agree_id" value="#ATTRIBUTES.agree_id#"/>
			<input type="hidden" name="agree_gift" value="#qAgree.agree_gift#"/>
			<input type="hidden" name="type_id" value="#ATTRIBUTES.type_id#"/>
			<input type="hidden" name="user_id" value="#ATTRIBUTES.user_id#"/>
			<input type="submit" name="submit" value="Submit"/>
		</form>
		</div>
				<script type='text/javascript'>
		
				$(function(){
					//AJAX submit
					$('##agree_form_#ATTRIBUTES.agree_id#').submit(function() { 
						//alert('Submitted' + $(this).attr("id"));
						$(this).ajaxSubmit(submitOptions#ATTRIBUTES.agree_id#);
						return false;
						});
				});
					
					//Parameters for ajaxSubmit
					var submitOptions#ATTRIBUTES.agree_id# = {
					target: '##agree#ATTRIBUTES.agree_id#_result',
					beforeSubmit:showProcessing#ATTRIBUTES.agree_id#,
					success: hideProcessing#ATTRIBUTES.agree_id#,
					type:'post',
					url: '/site_modules/assessment/act_agree.cfm'
					};
				
					function showProcessing#ATTRIBUTES.agree_id#() {

						$(".agree#ATTRIBUTES.agree_id#_wrapper").fadeOut(1000);
					} 
				
					function hideProcessing#ATTRIBUTES.agree_id#() {
					   $("##processingMessage").addClass("hideElement");
					   setTimeout(function() {
					   $("##agree#ATTRIBUTES.agree_id#_result").fadeIn(1000);
						}, 1000); 
					}
					
					$('.retake#ATTRIBUTES.agree_id#').click(
						function(){
							$(".retake#ATTRIBUTES.agree_id#").hide();
							$(".agree#ATTRIBUTES.agree_id#_wrapper").fadeIn(1000);
						}
					);
				
			</script>

	</cfoutput>
</cfif>