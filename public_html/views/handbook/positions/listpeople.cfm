<cfparam name="positions" type="query">
<cfset countall = 0>
<cfset countcategories = 0>
<cfset previouspersonid = 0>

<div id="ajaxinfo">

<cfoutput>
	<cfif !isDefined("params.plain")>
		#linkto(text="Remove Formatting", action="listpeople", params="plain=", class="btn")#
	<cfelse>
		#linkto(text="Show Formatting", action="listpeople", params="")#
	</cfif>	
	<br/>
</cfoutput>
	<cfoutput query="positions" group="positiontypeid">
		<cfset countInCategory = 0>
		<div class="well">
			<cfif !isDefined("params.plain")>
				<h3>#linkto(text=position, action="listpeople", params="positionTypeId=#positionTypeid#")#</h3>
			<cfelse>
				<h3>#linkto(text=position, action="listpeople", params="plain=1&positionTypeId=#positionTypeid#")#</h3>
			</cfif>
			<p>#description#</p>
			<p>&nbsp;</p>
			<table class="table">
			<cfoutput>
				<cfif personid NEQ previouspersonid>
					<tr>
							<td>
								#linkTo(
									text=left('#lname#, #fname# - #handbookpositionposition#: #name#, #org_city# #state_mail_abbrev#',200), 
									controller="handbook.people",
									action="show", 
									key=personid, 
									id="ajaxclickable",
									class="tooltip2", 
									title="Click to show #fname# #lname# in the center panel.", 
									onlyPath=false
									)#
								</td>	
								<td>
									#mailto(email)#
								</td>		
						<cfset countInCategory = countInCategory + 1>
						<cfset countall = countall + 1>
						<cfset previouspersonid = personid>
					</tr>
				</cfif>
			</cfoutput>
			<table>	

			<p>Count = #countInCategory#</p>

			<div>&nbsp;</div>
		</div>

		<cfset countall = countall + 1>
		<cfset countcategories = countcategories + 1>
	</cfoutput>

		<cfoutput>
			<p>People Count = #countall#</p>
			<p>Category Count = #countcategories#</p>
		</cfoutput>
</div>
