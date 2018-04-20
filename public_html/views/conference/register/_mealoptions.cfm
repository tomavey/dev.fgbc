<cfset params.mealsTitle = "Select meals for this adult, couple or child:">
<cfif regType() is "single" OR regType() is "meal">
	<cfset params.mealsTitle = "Select your meals (read descriptions carefully):">
<cfelseif regType() is "couple">
	<cfset params.mealsTitle = "Select meals (read descriptions carefully):">
<cfelseif regType() is "family">
	<cfset params.mealsTitle = "Select meals (read descriptions carefully):">
<cfelseif regType() is "children">
	<cfset params.mealsTitle = "Select meals:">
</cfif>
<cfdump var="#meals#"><cfabort>

<cfoutput>
<cfif isDefined("meals") && meals.recordcount && mealsRegIsOpen() && !isRegType("options") && !isRegType("children")>
	<fieldset id="meals" class="selectoptions">

		<legend>
				#params.mealsTitle#
		</legend>

<!--- Script not working
			<div class="allmeals">
   				#selectTag(label="Select All Meals", name="allmeals", selected=0, options=application.wheels.optionsCountAvailable)#
			</div>
			<p class="desc">Use this to set all the meals quantities at once. You can change specific meal counts below.</p>
			<hr/>
--->

		<cfloop query="meals">
			<div class="#name#">

    			<cfif countSold LTE maxtosell or len(maxtosell) is 0>
					  <cfset disabledState = "false">
				<cfelse>
					  <cfset disabledState = "true">
					  <cfset meals.description = "#buttondescription# at this price is SOLD OUT. If you want to check on late openings, go to the Welcome Center when you arrive at the conference and ask about availability.">
				</cfif>


        			<cftry>
        				#selectTag(label=buttondescription, name=id, selected=params[id], options=application.wheels.optionsCountAvailable, disabled=disabledState)#
        			<cfcatch>
        				#selectTag(label=buttondescription, name=id, selected=0, options=application.wheels.optionsCountAvailable, disabled=disabledState)#
        			</cfcatch>
        			</cftry>

					<cfif disabledState>
        				<span class="cost">Sold Out</span>
        			<cfelse>
        				<span class="cost">#dollarformat(cost)##getDollarType()#</span>
					</cfif>

					<br/>
        					<p class="desc">#description#</p>



    			<div style="clear:both" class="spacer"></div>

			</div>
			<hr/>
		</cfloop>
	</fieldset>
</cfif>
</cfoutput>