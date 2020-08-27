<cfset params.regTitle = "Select registration for this adult, couple or child:">
<cfif regType() is "single">
	<cfset params.regTitle = "Select a registration option:">
<cfelseif regType() is "group">
	<cfset params.regTitle = "How many registrations do you want in this group?:">
<cfelseif regType() is "couple">
	<cfset params.regTitle = "Select a registration for this couple:">
<cfelseif regType() is "family">
	<cfset params.regTitle = "Select a registration option: ">
<cfelseif regType() is "children">
	<cfset params.regTitle = "Select a registration for child:">
</cfif>

<cfoutput>
<cfif registrations.recordcount>
	<fieldset id="registrationOptions">
		<legend>
			#params.regTitle#
		</legend>
		<cfset previoustype = "">
		<cfloop query="registrations">
			<cfset showThisReg = true>
<!---
			<cfif not isAdmin() and NOT application.wheels.ccareregistrationIsOpen>
				<cfif name contains "CC" OR  name contains "KK" OR  name contains "GK">
					<cfset showThisReg = false>
				</cfif>
			</cfif>

			<cfif regType() is "single" or regtype() is "couple">
				<cfif name contains "CC" OR  name contains "KK" OR  name contains "GK">
					<cfset showThisReg = false>
				</cfif>
			</cfif>

			<cfif regType() is "single">
				<cfif name contains "couple">
					<cfset showThisReg = false>
				</cfif>
			</cfif>

			<cfif regType() is "couple">
				<cfif name contains "single">
					<cfset showThisReg = false>
				</cfif>
			</cfif>
--->
			<cfif showThisReg>

			<div class="#name#">

    			<cfif isAdmin() OR (buttondescription does not contain "Closed" AND buttondescription does not contain "Sold Out")>
					  <cfset disabledState = false>
				<cfelse>
					  <cfset disabledState = true>
				</cfif>

				<cfif buttondescription contains "Closed" and NOT isAdmin()>
					  <cfset disabledState = true>
				</cfif>

        			<!---insert a blank line when the type of reg changes--->
        			<cfif type NEQ previoustype and previoustype NEQ "">
        				<br/>
        			</cfif>

                                   <cfif buttontype is "count">
										<cfif regType() is "group">
											<cfset request.countavailable = getGroupCountAvailable()>	
                                         <cfelse>
                                            <cfset request.countAvailable = application.wheels.optionsCountAvailable>
                                         </cfif>
                                            <cftry>
                                                #selectTag(label=buttondescription, name=id, selected=params[id], options=request.countAvailable)#
                                            <cfcatch>
                                                #selectTag(label=buttondescription, name=id, selected=0, options=request.countAvailable)#
                                            </cfcatch>
                                            </cftry>
                                   <cfelse>

        			<cftry>
        			#radioButtonTag(label=buttondescription, name="registration", value=params[id], checked=true, class=type, disabled=disabledState)#
        			<cfcatch>
        			#radioButtonTag(label=buttondescription, name="registration", value=id, class=type, disabled=disabledState)#
        			</cfcatch></cftry>

                            </cfif>

					<cfif disabledState>
        				<span class="cost">FULL</span>
					<cfelse>
        				<span class="cost">#dollarformat(cost)##getDollarType()#</span>
					</cfif>
					<br/>
        					<p class="desc">#description#</p>

        			<div style="clear:both" class="spacer"></div>
    				<cfset previoustype = type>

			</div>
			<hr/>
			</cfif>

		</cfloop>
	</fieldset>
</cfif>
</cfoutput>