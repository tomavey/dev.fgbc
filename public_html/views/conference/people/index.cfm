<div class="eachItemShown">
	<h1>People</h1>
	<cfoutput>
	<p>Since #dateformat(datelimit,"medium")#</p>
		#addTag()#
	</cfoutput>
	<table class="table table-striped">
		<thead>
			<tr>
				<th>&nbsp;&nbsp;&nbsp;</th>
				<th>
					First Name
				</th>
				<th>
					Email
				</th>
				<th>
					Phone
				</th>
				<th>
					Created
				</th>
				<th>
					&nbsp;	
				</th>
			</tr>
		</thead>
		<tbody>
		<cfoutput query="people" group="conferencefamilyid">
			<tr>
				<td colspan="6">#linkTo(action="show", controller="conference.families", key="#conferencefamilyid#", text="#lname#")#</td>
			</tr>	  
			<cfoutput group="id">
			<tr>
				<th>&nbsp;&nbsp;&nbsp;</th>
				<td>
					#linkTo(action="show", controller="conference.people", key="#id#", text="#fname#")# [#gender#]
					<cfif application.wheels.environment is "development">
					#linkTo(text='M', action='Male', key=ID, title="M")#
					#linkTo(text='F', action='Female', key=ID, title="F")#
					</cfif>
				</td>
				<td>
					#mailTo(email)#	
				</td>
				<td>
					#phone#
				</td>
				<td>
					#dateformat(createdat, "medium")#
				</td>
				<td>
					#showTag()#
					#editTag()#
					#deleteTag(class="notajax")#
				</td>
			</tr>
		</cfoutput>
		</cfoutput>
		</tbody>
	</table>
	<cfoutput>
		#addTag()#
	</cfoutput>
</div>
