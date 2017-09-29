<div class="postbox" id="log">
<p>&nbsp;</p>

<cfif isDefined("emailedTo")>
	<cfoutput>
	<div class="well">
		<p>This was emailed to #emailedTo#</p>
		<p>You need to be logged into the online handbook in order for these links to work properly.</p>
	</div>
	</cfoutput>
</cfif>

	<div class="row offset1">	
	<cfoutput>

	<cfif gotrights("superadmin,office,handbook,handbookedit") AND params.controller is "handbook.updates">
		<div class="span2">#linkTo(text="Subscribe me", route="handbookSubscribeMe", class="tooltip2", title="Receive notices of updates to #session.auth.email#.", class="btn", onlyPath="false")#</div>
		<div class="span2">#linkTo(text="Un-Subscribe me", route="handbookUnSubscribeMe", key="updates", class="tooltip2", title="Stop receiving notices of updates via email.", class="btn", onlyPath="false")#</div>
	</cfif>
	<cfif params.controller is "handbook.updates">
		<div class="span2">#linkTo(text="Today's Updates", params="showTodayOnly", class="tooltip2", title="Stop receiving notices of updates via email.", class="btn", onlyPath="false")#</div>
		<div class="span2">#linkTo(text="Yesterday's Updates", params="showYesterdayOnly", class="tooltip2", title="Stop receiving notices of updates via email.", class="btn", onlyPath="false")#</div>
		<cfif isDefined("params.showYesterdayOnly") OR isDefined("params.showTodayOnly")>
		<div class="span2">#linkTo(text="Show Recent Updates", params="", class="tooltip2", title="Stop receiving notices of updates via email.", class="btn", onlyPath="false")#</div>
		</cfif>
		<p class="error-message">#flash("update")#</p></div>
	</cfif>
	</div>

	<p>&nbsp;</p>
	<cfif !isDefined("emailedTo")>
	<div class="row">
		<div class="well offset1">
			<cfif isDefined("params.showTodayOnly")>
				<h2>Today's Updates: </h2>
			<cfelseif isDefined("params.showYesterdayOnly") OR params.action is "sendyesterdaysupdates">
				<h2>Yesterday's Updates: </h2>
			<cfelseif isDefined("params.page") AND params.page NEQ 0>
				<h2>Page ###params.page# of Updates:</h2>
				#linkto(text="<< Previous page", params="page=#params.page-1#")#
				#linkto(text="Next page >>", params="page=#params.page+1#")#
			<cfelseif !isDefined("params.page") OR params.page is 0>
				<h2>The most recent #args.perpage# Updates (in each category): </h2>
				#linkto(text="Next page >>", params="page=2")#
			</cfif>
		</div>
	</div>
	</cfif>
	</cfoutput>

	<cfif args.showPeopleUpdates>

		<div id="" class="span8 well">
			<h3>People updates:</h3>
			<p>This lists each item changed separately so you can tell what has changed. Click on the name to see the complete listing.</p>
			<cfoutput query="peopleUpdates" group="recordid">
			<cfif olddata NEQ newdata>
				<p>
					<h4>#linkTo(text="#lname#,#fname#:#city#", controller="handbook.people", action="show", key=recordid, onlypath=false)#</h4>

					<cfoutput>
						<p>
						#includePartial("/handbook/updates/logreport")#
						</p>
					</cfoutput>
				</p>
			</cfif>
			</cfoutput>
		</div>

	</cfif>

	<cfif args.showOrganizationUpdates>

		<div id="" class="span8 well">
			<h3>Organization and Church updates:</h3>
			<p>This lists each item changed separately so you can tell what has changed. Click on the name to see the complete listing.</p>
			<cfoutput query="organizationUpdates">
			<cfif olddata NEQ newdata>
				<p>
					<h4>#linkTo(text="#name#:#org_city#", controller="handbook.organizations", action="show", key=recordid, onlypath=false)#</h4>
					#includePartial("/handbook/updates/logreport")#
				</p>
			</cfif>
			</cfoutput>
		</div>

	</cfif>

	<cfif args.showPeopleDeletes>

		<div id="" class="span8 well">
			<h3>Deletions:</h3>
			<cfoutput query="peopledeletes">
				#oldData#<br/>
			</cfoutput>
		</div>
	</cfif>

	<cfif args.showPeopleCreates>

		<div id="" class="span8 well">
			<h3>New People Added:</h3>
			<p>Note: Churches sometimes add new staff who are already in the handbook. In these cases the handbook coordinator will consolidate records to avoid duplication and the new record will be deleted. In this case, a link to the new listing may not work.</p>
			<cfoutput query="peoplecreates">
				#linkto(text=getPerson(recordId), controller="handbook.people", action="show", key=recordid)#<br/>
			</cfoutput>
		</div>
	</cfif>

	<cfif args.showPositionUpdates>

		<div id="" class="span8 well">
			<h3>Position changes:</h3>
			<cfoutput query="positionUpdates">
				<cfif olddata NEQ newdata>
					<p>
						<h4>#linkTo(text=selectName, controller="handbook.people", action="show", key=personid, onlypath=false)#</h4>
						#includePartial("/handbook/updates/logreport")#
					</p>
				</cfif>
			</cfoutput>
		</div>

	</cfif>

</div>