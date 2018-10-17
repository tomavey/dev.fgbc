<cfcomponent extends="Controller" output="false">

	<cffunction name="init">
		<cfset usesLayout("/membership/layout")>
		<cfset filters(through="isCheckedInOrAuthorized", except="index")>
	</cffunction>

	<cffunction name="isCheckedInOrAuthorized">

		<cfif isDefined("session.membershipapplication.id") OR 
			isFellowshipCouncil()>
		<cfelse>
			<cfset redirectTo(controller="membership.applications", action="checkin")>
		</cfif>

	</cffunction>

	
	<!--- membershipappresources/index --->
	<cffunction name="index">
		<cfif isDefined("params.showall")>
			<cfset wherestring = "">
		<cfelseif isDefined("params.key") AND len(params.key) GTE 25>
			<cfset wherestring = "applicationUUID = '#params.key#'">
		<cfelseif isDefined("params.key")>	
			<cfset wherestring = "applicationid = '#params.key#'">
		<cfelse>
			<cfset wherestring = "1=1">
		</cfif>	
	<cfdump var="#wherestring#"><cfabort>

		<cfset membershipappresources = model("Membershipappresource").findAll(where=wherestring)>
	</cffunction>
	
	<!--- membershipappresources/show/key --->
	<cffunction name="show">
		
		<!--- Find the record --->
    	<cfset membershipappresource = model("Membershipappresource").findByKey(params.key)>
    	
    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(membershipappresource)>
	        <cfset flashInsert(error="membershipappresource #params.key# was not found")>
	        <cfset redirectTo(action="index")>
	    </cfif>
			
	</cffunction>
	
	<!--- membershipappresources/new --->
	<cffunction name="new">
		<cfset membershipappresource = model("Membershipappresource").new()>
		<cfif isDefined("session.membershipapplication.uuid")>
			<cfset membershipappresource.applicationuuid = session.membershipapplication.uuid>
		</cfif>
		<cfif isDefined("session.membershipapplication.id")>
			<cfset membershipappresource.applicationid = session.membershipapplication.id>
		</cfif>
		<cfif !isDefined("session.membershipapplication.language")>
			<cfset session.membershipapplication.language = "English">
		</cfif>
		
		<cfset membershipapplications = model("Membershipapplication").findAll(order="name_of_church")>
	</cffunction>
	
	<!--- membershipappresources/edit/key --->
	<cffunction name="edit">
	
		<!--- Find the record --->
    	<cfset membershipappresource = model("Membershipappresource").findByKey(params.key)>
    	
    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(membershipappresource)>
	        <cfset flashInsert(error="membershipappresource #params.key# was not found")>
			<cfset redirectTo(action="index")>
	    </cfif>
		
	</cffunction>
	
	<cffunction name="getMembershipapplicationUUID">
	<cfargument name="MembershipapplicationId" required="true" type="numeric">
		<cfset var loc = arguments>
		<cfset loc.Membershipapplication = model("Membershipapplication").findOne(where="id = #loc.MembershipapplicationId#")>
		<cfif isObject(loc.Membershipapplication)>
			<cfreturn loc.Membershipapplication.uuid>
		<cfelse>
			<cfset renderText("oops something went wrong at membership.resourses.cfc line 81")>
		</cfif>				
	</cffunction>

	<!--- membershipappresources/create --->
	<cffunction name="create">
		<cfset membershipappresource = model("Membershipappresource").new(params.membershipappresource)>

		<cfset membershipappresource.applicationUUID = getMembershipapplicationUUID(params.membershipappresource.applicationid)>

		<!--- Verify that the membershipappresource creates successfully --->
		<cfif membershipappresource.save()>
			<cfset flashInsert(success="The uploaded resource was created successfully.")>
            <cfset redirectTo(route="membershipListAppResources", key=membershipappresource.applicationUUID)>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error creating the uploaded resource.")>
			<cfset renderPage(action="new")>
		</cfif>
	</cffunction>
	
	<!--- membershipappresources/update --->
	<cffunction name="update">
		<cfset membershipappresource = model("Membershipappresource").findByKey(params.key)>
		
		<!--- Verify that the membershipappresource updates successfully --->
		<cfif membershipappresource.update(params.membershipappresource)>
			<cfset flashInsert(success="The membershipappresource was updated successfully.")>	
            <cfset redirectTo(action="index")>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error updating the membershipappresource.")>
			<cfset renderPage(action="edit")>
		</cfif>
	</cffunction>
	
	<!--- membershipappresources/delete/key --->
	<cffunction name="delete">
		<cfset membershipappresource = model("Membershipappresource").findByKey(params.key)>
		
		<!--- Verify that the membershipappresource deletes successfully --->
		<cfif membershipappresource.delete()>
			<cfset flashInsert(success="The membershipappresource was deleted successfully.")>	
            <cfset redirectTo(route="membershipListAppResources", key=membershipappresource.applicationUUID)>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error deleting the membershipappresource.")>
            <cfset redirectTo(route="membershipListAppResources", key=membershipappresource.applicationUUID)>
		</cfif>
	</cffunction>
	
</cfcomponent>
