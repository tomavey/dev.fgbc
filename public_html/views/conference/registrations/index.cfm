<cfset count = 0>
<div class="eachItemShown">

<h1>Registrations: </h1>

<cfoutput>

	<cfif isdefined("params.status")>
		#buttonTo(text="Show All", params="")#
	<cfelse>
		#buttonTo(text="Show temp only", params="status=temp")#
	</cfif>

	<p>#addTag()#</p>

</cfoutput>

<table class="table table-striped table-responsive">
	<thead>
	<tr>
		<th>
			Person
		</th>
		<th>
			Option
		</th>
		<th>
			Invoice	/ Status
		</th>
		<th>
			#
		</th>
		<th>
			$
		</th>
		<th>
			Date
		</th>
		<th>
			&nbsp;
		</th>
	</tr>
	</thead>
	<tbody>
	<cfoutput query="registrations">

		<tr>
			<td>
				#linkTo(text='#left(cleanname(fname),20)# #cleanname(lname)#', controller='conference.people', action='show', key=conferencepersonID)#
			</td>
			<td>
				#linkTo(text='#left(buttondescription,40)#', controller='conference.options', action='show', key=conferenceoptionID)#
			</td>
			<td>
				#linkTo(text='#ccorderid#', controller='conference.invoices', action='show', key=conferenceinvoiceID)# - #payStatus(ccstatus)#
			</td>
			<td>
				#quantity#
			</td>
			<td>
				#cost#
			</td>
			<td>
				#dateformat(createdat, "mm-dd-yy")#
			</td>
			<td>
				#showTag(controller="conference.registrations")#
				<cfif gotRights("superadmin,office")>
					#editTag()#
					#deleteTag()#
				</cfif>

			</td>
		</tr>
	<cfset count = count + 1>
	</cfoutput>
	</tbody>
</table>

<cfoutput>
	<p>#linkTo(text="#imageTag("add-icon.png")#", action="new", title="Add New")#</p>
	<p>Count = #count#</p>
</cfoutput>

</div>
