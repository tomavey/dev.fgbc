<cfcomponent extends="Controller" output="false">
	
	<cffunction name="init">
		<cfset usesLayout("/handbooklayouts/layout_handbook")>
		<cfset filters(through="gotBasicHandbookRights")>
	</cffunction>
	
	<!--- handbook-group-types/index --->
	<cffunction name="index">
		<cfset handbookgroups = model("Handbookgroup").findAll()>
	</cffunction>
	
	<!--- handbook-group-types/show/key --->
	<cffunction name="show">
		
		<!--- Find the record --->
    	<cfset handbookgroup = model("Handbookgroup").findByKey(params.key)>
		<cfset people = model("handbookGroup").findAll(where="groupId=#params.key#", include="handbookPerson(handbookState)", order="lname,fname")>
    	
    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(handbookgroup)>
	        <cfset flashInsert(error="Handbookgroup #params.key# was not found")>
	        <cfset redirectTo(action="index")>
	    </cfif>
			
	</cffunction>
	
	<!--- handbook-group-types/new --->
	<cffunction name="new">
		<cfset handbookgroup = model("Handbookgroup").new()>
	</cffunction>
	
	<!--- handbook-group-types/edit/key --->
	<cffunction name="edit">
	
		<!--- Find the record --->
    	<cfset handbookgroup = model("Handbookgroup").findByKey(params.key)>
    	
    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(handbookgroup)>
	        <cfset flashInsert(error="Handbookgroup #params.key# was not found")>
			<cfset redirectTo(action="index")>
	    </cfif>
		
	</cffunction>
	
	<!--- handbook-group-types/create --->
	<cffunction name="create">
		
		<cftry>
			<cfset params.handbookgroup.groupTypeId = params.groupTypeId>
			<cfset params.handbookgroup.personid = params.personid>
		<cfcatch></cfcatch></cftry>

		<cfset checkexisting = model("handbookGroup").findAll(where="personid = #params.handbookgroup.personid# AND groupTypeid = #params.handbookgroup.grouptypeid#")>
		<cfif checkexisting.recordcount>
			<cfset redirectTo(back=true)>
		</cfif>

		<cfset handbookgroup = model("Handbookgroup").new(params.handbookgroup)>
		
		<!--- Verify that the handbookgroup creates successfully --->
		<cfif handbookgroup.save()>
			<cfset flashInsert(success="The handbookgroup was created successfully.")>
            <cfset redirectTo(back=true)>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error creating the handbookgroup.")>
			<cfset renderPage(action="new")>
		</cfif>
	</cffunction>
	
	<!--- handbook-group-types/update --->
	<cffunction name="update">
		<cfset handbookgroup = model("Handbookgroup").findByKey(params.key)>
		
		<!--- Verify that the handbookgroup updates successfully --->
		<cfif handbookgroup.update(params.handbookgroup)>
			<cfset flashInsert(success="The handbookgroup was updated successfully.")>	
            <cfset redirectTo(action="index")>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error updating the handbookgroup.")>
			<cfset renderPage(action="edit")>
		</cfif>
	</cffunction>
	
	<!--- handbook-group-types/delete/key --->
	<cffunction name="delete">

		<cfif structKeyExists(params,"key")>
			<cfset handbookgroup = model("Handbookgroup").findByKey(params.key)>
		<cfelse>
			<cfset handbookgroup = model("Handbookgroup").findOne(where="personid=#params.personid# AND groupTypeId=#params.groupTypeId#")>
		</cfif>	
		
		<!--- Verify that the handbookgroup deletes successfully --->
		<cfif handbookgroup.delete()>
			<cfset flashInsert(success="The handbookgroup was deleted successfully.")>	
            <cfset redirectTo(back=true)>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error deleting the handbookgroup.")>
			<cfset redirectTo(action="index")>
		</cfif>
	</cffunction>

	<cffunction name="putInGroup">
	<cfargument name="personid" required="true" type="numeric">
	<cfargument name="grouptypeid" required="true" type="numeric">
		<cfset check = model("Handbookgroup").findOne(where="personid = #arguments.personid# AND groupTypeId = #arguments.grouptypeid#")>

		<cfif isObject(check)>
			<cfreturn true>
		<cfelse>	
			<cfset group = model("Handbookgroup").new()>
			<cfif group.save(arguments)>
				<cfreturn true>	
			<cfelse>
				<cfreturn false>
			</cfif>
		</cfif>

	</cffunction>	

</cfcomponent>
