<h1>Use this page to set up individual retreats...</h1>
<cfoutput>#linkto(text="Show Inactive Retreats", params="showInactive")#</cfoutput>

<table class="table table-striped">
	<tr>
		<th>
			RetreatId
		</th>
		<th>
			Title
		</th>
		<th>
			Active?
		</th>
		<th>
			Show Regs?
		</th>
		<th>
			Begins
		</th>
		<th>
			End
		</th>
		<th>
			Discount Deadline
		</th>
		<th>
			&nbsp;
		</th>
	</tr>
	<cfoutput query="retreats">
		<tr>
			<td>
				#regid#
			</td>
			<td>
				#title#
			</td>
			<td>
				#active#
			</td>
			<td>
				#showregs#
			</td>
			<td>
				#dateformat(startAt)#
			</td>
			<td>
				#dateformat(endAt)#
			</td>
			<td>
				#dateformat(discountdeadline)#
			</td>
			<td>
				#showtag()# #editTag()# #deleteTag()# #copyTag()#
			</td>
		</tr>
	</cfoutput>

</table>
<cfoutput>
	<p>#linkTo(text="New retreat", action="new")#</p>
</cfoutput>
