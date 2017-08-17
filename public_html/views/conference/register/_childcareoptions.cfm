<cfoutput>


<cfif childcare.recordcount && childRegIsOpen() && !isRegType("couple") && !isRegType("single") && !isRegType("family") && !isRegType("meal")  && !isRegType("options")>

	<fieldset id="childcare" class="selectoptions">

		<legend>
			<cfif isdefined("params.childcareTitle")>
				#params.childcareTitle#
			<cfelse>
				Select Grace Kids options for this child:
			</cfif>
		</legend>

<!--- Not working
			#checkBoxTag(label="Check All", name="checkall", value='1', class="checkall")#
			<div style="clear:both"></div>
			<hr/>
--->

		<cfloop query="Childcare">
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

                    <p class="desc">#description#</p>

    			<div style="clear:both" class="spacer"></div>
			<hr/>
			</div>

		</cfloop>
	</fieldset>
</cfif>

</cfoutput>