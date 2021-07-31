//TODO - Convert to cfscript
<cfcomponent extends="Controller" output="false">

	<cffunction name="config">
		<cfset usesLayout("/handbook/layout_handbook1")>
		<cfset filters(through="gotBasicHandbookRights")>
		<!--- <cfset filters(through="isSubscriberSession", only="index")> --->
	</cffunction>

	<!-------------------------->
	<!---------Filters---------->
	<!-------------------------->

<cfscript>
	function isSubscriberSession (){
		if ( gotBasicHandbookRights() ) {
			return true;			
		};
		if ( isDefined("session.handbook.isSubscriberSession" ) && session.handbook.isSubscriberSession) {
			return true;
		} else {
			renderText('you do not have permission to view this page');
		}
	}
</cfscript>

<!---------------------->
<!---------------------->
<!---View Controllers--->	
<!---------------------->

	<!--- handbook-updates/index --->
	<cffunction name="index">
	<cfset args = structNew()>
	<cfset args.showPeopleUpdates = true>
	<cfset args.showOrganizationUpdates = true>
	<cfset args.showPeopleDeletes = true>
	<cfset args.showPeopleCreates = true>
	<cfset args.showPositionUpdates = true>
	<cfset args.yesterday = dateformat(dateAdd("d",-1,now()),"yyyy-mm-dd")>
	<cfset args.today = dateformat(dateAdd("d",0,now()),"yyyy-mm-dd")>

		<cfif !isDefined("params.showyesterdayonly")>
			<cfset args.showOnlyYesterday = false>
		<cfelse>
			<cfset args.showOnlyYesterday = true>
		</cfif>

		<cfif !isDefined("params.showperson")>
			<cfset args.showperson = 0>
		<cfelse>
			<cfset args.showOrganizationUpdates = false>
			<cfset args.showDeletes = false>
			<cfset args.showPositionUpdates = false>
			<cfset args.showperson = params.showperson>
		</cfif>

		<cfif !isDefined("params.showtodayonly")>
			<cfset args.showOnlyToday = false>
		<cfelse>
			<cfset args.showOnlyToday = true>
		</cfif>

		<cfif isDefined("params.page")>
			<cfset args.page = params.page>
		</cfif>

		<cfif isDefined("params.showall")>
			  <cfset args.showMaxRows = 1000000>
		<cfelseif isDefined("params.show")>
			  <cfset args.showMaxRows = params.show>
		<cfelse>
			  <cfset args.showMaxRows = 50>
		</cfif>

		<cfif isDefined("params.perpage")>
			<cfset args.perpage = params.perpage>
		<cfelse>
			<cfset args.perpage = args.showMaxRows>
		</cfif>

		<!---people updates--->

		<cfset peopleUpdates = model("Handbookupdate").findPeopleUpdates(args)>

		<cfif !peopleUpdates.recordcount>
			<cfset args.showpeopleUpdates = false>
		</cfif>

	   	<!--- Organization Updates --->

		<cfset organizationUpdates = model("Handbookupdate").findOrganizationUpdates(args)>
		<cfif !organizationUpdates.recordcount>
			<cfset args.showorganizationUpdates = false>
		</cfif>

	   	<!--- Position Updates --->

		<cfset positionUpdates = model("Handbookupdate").findPositionUpdates(args)>
		<cfif !positionUpdates.recordcount>
			<cfset args.showPositionUpdates = false>
		</cfif>

		<!---Deletes--->

		<cfset peopledeletes = model("Handbookupdate").findPeopleDeletes(args)>
		<cfif !peopledeletes.recordcount>
			<cfset args.showPeopleDeletes = false>
		</cfif>

		<!---PeopleCreates--->

		<cfset peoplecreates = model("Handbookupdate").findpeoplecreates(args)>
		<cfif !peoplecreates.recordcount>
			<cfset args.showPeopleCreates = false>
		</cfif>
	</cffunction>

	<cffunction name="list">
		<cfset updates = model("Handbookupdate").findAll(include="Handbookperson(Handbookstate)", order="createdAt DESC", maxrows=100)>
	</cffunction>

	<!--- handbook-updates/show/key --->
	<cffunction name="show">

		<!--- Find the record --->
    	<cfset handbookupdate = model("Handbookupdate").findByKey(params.key)>

    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(handbookupdate)>
	        <cfset flashInsert(error="HandbookUpdate #params.key# was not found")>
	        <cfset redirectTo(action="index")>
	    </cfif>

	</cffunction>

<!------------------------>
<!--- Model Controllers--->
<!------------------------>


	<!--- handbook-updates/new --->
	<cffunction name="new">
		<cfset handbookupdate = model("Handbookupdate").new()>
		<cfset oldData = model(params.modelName).findByKey(params.key)>
<!---		<cfdump var="#olddata#"><cfabort>
--->	</cffunction>

	<!--- handbook-updates/edit/key --->
	<cffunction name="edit">

		<!--- Find the record --->
    	<cfset handbookupdate = model("Handbookupdate").findByKey(params.key)>

    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(handbookupdate)>
	        <cfset flashInsert(error="Handbookupdate #params.key# was not found")>
			<cfset redirectTo(action="index")>
	    </cfif>

	</cffunction>

	<!--- handbook-updates/create --->
	<cffunction name="create">
		<cfset handbookupdate = model("Handbookupdate").new(params.handbookupdate)>

		<!--- Verify that the handbookupdate creates successfully --->
		<cfif handbookupdate.save()>
			<cfset flashInsert(success="The handbookupdate was created successfully.")>
            <cfset redirectTo(action="index")>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error creating the handbookupdate.")>
			<cfset renderView(action="new")>
		</cfif>
	</cffunction>

	<!--- handbook-updates/update --->
	<cffunction name="update">
		<cfset handbookupdate = model("Handbookupdate").findByKey(params.key)>

		<!--- Verify that the handbookupdate updates successfully --->
		<cfif handbookupdate.update(params.handbookupdate)>
			<cfset flashInsert(success="The handbookupdate was updated successfully.")>
            <cfset redirectTo(action="index")>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error updating the handbookupdate.")>
			<cfset renderView(action="edit")>
		</cfif>
	</cffunction>

	<!--- handbook-updates/delete/key --->
	<cffunction name="delete">
		<cfset handbookupdate = model("Handbookupdate").findByKey(params.key)>

		<!--- Verify that the handbookupdate deletes successfully --->
		<cfif handbookupdate.delete()>
			<cfset flashInsert(success="The handbookupdate was deleted successfully.")>
            <cfset redirectTo(action="index")>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error deleting the handbookupdate.")>
			<cfset redirectTo(action="index")>
		</cfif>
	</cffunction>

	<cffunction name="logupdates">
		<cfdump var="#params#"><cfabort>
	</cffunction>

	<cffunction name="hits">
		<cfparam name="params.page" default="1">

		<cfif isDefined("params.email")>
			  <cfset wherestring = "controller LIKE 'Handbook%' AND email = '#params.email#'">
		<cfelse>
			  <cfset wherestring = "controller LIKE 'Handbook%'">
		</cfif>

		<cfset hits = model("Userview").findall(where=wherestring, order="createdAt DESC", page=params.page, perPage=25)>

	</cffunction>

	<cffunction name="removed">
		<cfset removed = model("Handbookupdates").findAll(where="columnName = 'p_sortorder' AND newData = 100")>
		<cfdump var="#removed#"><cfabort>
	</cffunction>

</cfcomponent>
