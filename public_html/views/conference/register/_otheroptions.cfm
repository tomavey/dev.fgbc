<cfoutput>
<cfif options.recordcount && optionsRegIsOpen() && !isRegType("meal") && !isRegType("children")>
	<fieldset id="otheroptions" class="selectoptions">

		<legend>Other Options:</legend>

		<cfloop query="options">
			<div class="#name#">
			<cftry>
				#selectTag(label=buttondescription, name=id, selected=params[id], options=application.wheels.optionsCountAvailable)#
			<cfcatch>
				#selectTag(label=buttondescription, name=id, selected=0, options=application.wheels.optionsCountAvailable)#
			</cfcatch>
			</cftry>

				<span class="cost">#dollarformat(cost)##getDollarType()#</span>

					<br/>
        					<p class="desc">#description#</p>


			<div style="clear:both" class="spacer"></div>
			</div>
			<hr/>
		</cfloop>
	</fieldset>
</cfif>
</cfoutput>