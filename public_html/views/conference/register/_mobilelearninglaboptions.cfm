<cfoutput>
<cfif MobileLearningLabs.recordcount AND (application.wheels.optionsregistrationIsOpen or isAdmin())>
	<fieldset id="preconference" class="selectoptions">	

		<legend>
			<cfif isdefined("params.preconferenceTitle")>
				#params.preconferenceTitle#
			<cfelse>	
				Select Mobile Learning Labs for this person: 			
			</cfif>	
		</legend>

		<cfloop query="MobileLearningLabs">
    			<cfif countSold LTE maxtosell or len(maxtosell) is 0>
					  <cfset disabledState = "false">
				<cfelse>
					  <cfset disabledState = "true">
					  <cfset MobileLearningLabs.description = "#buttondescription# is SOLD OUT. If you want to check on late openings, go to the Welcome Center when you arrive at the conference and ask about availability.">
				</cfif>
							  
    
			<div class="#name#">
    			<cftry>	
    				#selectTag(label=buttondescription, name=id, selected=params[id], options=application.wheels.optionsCountAvailable, disabled=disabledState)# 
    			<cfcatch>
    				#selectTag(label=buttondescription, name=id, selected=0, options=application.wheels.optionsCountAvailable, disabled=disabledState)# 
    			</cfcatch>
    			</cftry>

					<cfif disabledState>
        				<span class="cost">Sold Out</span>
        			<cfelse>
        				<span class="cost">#dollarformat(cost)#</span>	 
					</cfif>
    
    				<cfif description is not "">
    					#linkTo(text=imageTag('info-icon.png'), action="showoption", controller="conference.options", key=id, title=description, class="tooltiplink", target="_new")#
    				</cfif>
    			<div style="clear:both" class="spacer"><hr/></div>
			</div>
			<hr/>
		</cfloop>

	</fieldset>
</cfif>
</cfoutput>