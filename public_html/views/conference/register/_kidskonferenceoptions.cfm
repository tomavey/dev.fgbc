<cfoutput>

<cfif kidskonference.recordcount &&  childRegIsOpen() && !isRegType("couple") && !isRegType("single")  && !isRegType("family") && !isRegType("meal")  && !isRegType("options") >
	<fieldset id="kidskonference" class="selectoptions">

		<legend>
			<cfif isdefined("params.kidskonferenceTitle")>
				#params.kidskonferenceTitle#
			<cfelse>
				Select Grace Kids-Elementary Excursion for this child:
			</cfif>
		</legend>
            <cfif kidskonference.recordcount GT 1>
    			#checkBoxTag(label="Check All", name="checkall", value='1', class="checkall")#
    			<div style="clear:both"></div>
                <hr/>
            </cfif>

    		<cfloop query="kidskonference">
    			<div class="#name#">

        			<cftry>
        				#checkBoxTag(label=buttondescription, name=id, value=params[id], checked=true)#
        			<cfcatch>
        				#checkBoxTag(label=buttondescription, name=id, value='1')#
        			</cfcatch></cftry>

        				<span class="cost">
        					<cfif val(cost) is 0>
        						included
        					<cfelse>
        						#dollarformat(cost)##getDollarType()#
        					</cfif>
        				</span>

                    <br/>
                            <p class="desc">#description#</p>


        			<div style="clear:both" class="spacer"></div>
    			</div>
			<hr/>
    		</cfloop>

	</fieldset>
</cfif>
</cfoutput>