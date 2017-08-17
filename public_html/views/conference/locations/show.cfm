<h1>Showing location</h1>

<cfoutput>
<div class="eachItemShown #params.action#">
					<p><span>Id: </span> 
						#location.id#</p>
				
					<p><span>Room: </span> 
						#location.roomnumber#</p>
				
					<p><span>Capacity: </span> 
						#location.capacity#</p>
				
					<p><span>Size: </span> 
						#location.size#</p>
				
					<p><span>Equipment: </span> 
						#location.equipment#</p>
				
					<p><span>Default Setup: </span> 
						#location.defaultsetup#</p>
				
					<p><span>Manager: </span> 
						#location.manager#</p>
				
					<p><span>Created: </span> 
						#dateformat(location.createdAt)#</p>
				
					<p><span>Updated: </span> 
						#dateformat(location.updatedAt)#</p>
				

#linkTo(text="Return to the listing", action="index")# 
<cfif isDefined("session.vision2020admin") and session.vision2020Admin>
	| #linkTo(text="Edit this event", action="edit", key=params.key)#
</cfif>
</div>

<cfif isdefined("session.wheels.datatables") and session.wheels.datatables>
	<cfset tableclass="dataTable">
<cfelse>
	<cfset tableclass="dataTableX">
</cfif>

	<table class="<cfoutput>#tableclass#</cfoutput> table">
		<thead>
			<tr>
				<th>Event [beo]</th>
				<th>Category</th>
				<th>Setup</th>
				<th>Updated</th>
				<th>Location</th>
				<th>Begins</th>
				<th>Ends</th>
				<th>Att</th>
				<th>&nbsp;</th>
			</tr>
		</thead>
		<tbody>
			<cfoutput query="events" group="date">
			<cftry>
			
					<tr>
						<td colspan="9"><hr/></td>
					</tr>
					<tr>
						<td colspan="9"><h1>#dateformat(date,"mmm-dd")# (#left(weekday(date),3)#)</h1></td>
					</tr>
					<cfoutput>

        			<cfif dateDiff("d",createdAt,now()) LT val(params.key) OR dateDiff("d",updatedAt,now()) LT val(params.key)>
        				  <cfset alertcolor = "##FFC1E0">
					<cfelse>	  
        				  <cfset alertcolor = "##FFFFFF">
        			</cfif>	   
			
					<tr style="background-color:#alertcolor#">
						<td>#linkTo(text='#left(description,50)#', action='show', key=id)# <cfif len(beo)>[#beo#]</cfif></td>
						<td>#left(category,15)#</td>
						<td>
							<cfif len(setup)>
								#left(setup,50)#</td>
							<cfelse>
								#left(defaultsetup,50)#*</td>
							</cfif>
						<td class="more">#dateformat(updatedAt)#</td>
						<td>#roomnumber#</td>
						<td>#timeformat(timebegin)#</td>
						<td>#timeformat(timeend)#</td>
						<td>#attending#</td>
						<td>
								#linkTo(text='#imageTag("view-icon.png")#', controller="conference.events", action='show', key=id, title="Add New")# &nbsp;
							<cfif gotRights("superadmin,office")>
								#linkTo(text='#imageTag("edit-icon.png")#', controller="conference.events",action='edit', key=id, title="Edit")# &nbsp;
								#linkTo(text='#imageTag("delete-icon.png")#', controller="conference.events", action='delete', key=id, confirm='Are you sure you want to delete this?', title="Delete")# &nbsp;
								#linkTo(text='#imageTag("copy-icon.png")#', controller="conference.events", action='copy', key=id, title="Duplicate")# 
							</cfif>
						</td>
					</tr>
					</cfoutput>
					<cfcatch></cfcatch></cftry>
			</cfoutput>
		</tbody>
	</table>
</cfoutput>
