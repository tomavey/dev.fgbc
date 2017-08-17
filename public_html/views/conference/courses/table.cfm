<cfparam name="firstcolumnname" default="Location">
<cfparam name="firstlevelgroup" default="room">
<cfparam name="params.orderby" default="">

<div id="coursestable" class="courses container">
<cfoutput>
<div id="buttons">
	<cfif params.orderby NEQ "track">
		#linkto(text="View by track", action="table", key="workshop", params="orderby=track", class="btn")#
	</cfif>
	<cfif params.orderby IS "track">
	#linkto(text="View by location", action="table", key="workshop", params="", class="btn")#
	</cfif>
	#linkto(text="View as a list", action="list", key="workshop", class="btn")#
</div>
<table>
<thead>
<tr>
<th class="col1">#firstcolumnname#</th>
<th class="col2">Saturday, 7/23<br>@11:15 a.m.</th>
<th class="col2">Sunday, 7/24<br>@11:15 a.m.</th>
<th class="col2">Monday, 7/25<br>@9:30 a.m.</th>
</tr>
<thead>
<tbody>
	<tr>
	<td colspan="4"><hr/></td>
	</tr>
</cfoutput>
<cfoutput query="courses" group="#firstlevelgroup#">

	<tr>
	<td>#evaluate(firstlevelgroup)#</td>
	<cfoutput group="date">
		<td>
		<cfoutput group="id">
			<cfif descriptionlong is "empty" or title is "empty">

			<cfelse>
				<p class="well well-#params.orderby#">
					#linkto(text=title, action="view", key=id)#
					<cfset instructorname = ""><cfif not len(descriptionlong)> **</a></cfif>
					<cfoutput>
						<cfset instructorname = instructorname & ", " & fname & " " & lname>
					</cfoutput>
					<cfset instructorname = replace(instructorname,", ","","one")>
					<br/>
					<span class="instructorname">#instructorname#</span><br/>
					<span class="locationtime">
						#locationtime#<br/>
					</span>
					<cfif params.orderby NEQ "track">
						<span class="workshoptrack">Track: #track#</span>
					</cfif>
				</p>
			</cfif>
		</cfoutput>
		</td>
	</cfoutput>
	</tr>
	<tr>
	<td colspan="4"><hr/></td>
	</tr>
</cfoutput>
</tbody>
</table>
<p>** = No description yet</p>
</div>
