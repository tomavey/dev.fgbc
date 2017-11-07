<cfcomponent extends="Controller" output="false">

	<cffunction name="init">
		<cfset filters(through="isSuperadmin", only="index,edit,show,new,delete")>
		<cfset filters(through="setReturn", only="list,index,show")>
		<!---
		<cfset filters(through="logview")>
		--->
	</cffunction>

<!--------------------------------->
<!------------CRUD----------------->
<!--------------------------------->


	<!--- events/index --->
	<cffunction name="index">
		<cfif isDefined("params.sortby")>
			<cfswitch expression="#params.sortby#">
				<cfcase value="ascendingDates">
					<cfset orderString = "begin,end">
				</cfcase>
				<cfcase value="sponsor">
					<cfset orderString = "sponsor">
				</cfcase>
				<cfcase value="event">
					<cfset orderString = "event">
				</cfcase>
				<cfdefaultcase>
					<cfset orderString = "begin DESC,end">
				</cfdefaultcase>
			</cfswitch>
		<cfelse>
			<cfset orderString = "begin DESC,end">
		</cfif>
		<cfset events = model("Mainevent").findAll(order=orderString)>
		<cfset session.return = params.action>
	</cffunction>
	
	<!--- events/show/key --->
	<cffunction name="show">
		
		<cfif isdefined("params.key")>
			<!--- Find the record --->
	    	<cfset event = model("Mainevent").findAll(where="id=#params.key#")>
	    	
		<cfelse>
		
			<cfset event = model("Mainevent").findAll(order="begin,end")>
	
		</cfif>	
			
	</cffunction>
	
	<!--- events/new --->
	<cffunction name="new">
		<cfset event = model("Mainevent").new()>
	</cffunction>

	<!--- events/copy/key ---->
	<cffunction name="copy">
	
		<!--- Find the record --->
    	<cfset event = model("Mainevent").findByKey(params.key)>
    	
    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(event)>
	        <cfset flashInsert(error="Event #params.key# was not found")>
			<cfset redirectTo(action="index")>
	    </cfif>

	    <cfset renderPage(action="new")>
		
	</cffunction>
	
	<!--- events/edit/key --->
	<cffunction name="edit">
	
		<!--- Find the record --->
    	<cfset event = model("Mainevent").findByKey(params.key)>

    	<cfset event.begin = dateformat(event.begin,"yyyy-mm-dd")>
    	<cfset event.end = dateformat(event.end,"yyyy-mm-dd")>
    	
    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(event)>
	        <cfset flashInsert(error="event #params.key# was not found")>
			<cfset redirectTo(action="index")>
	    </cfif>
		
	</cffunction>
	
	<!--- events/create --->
	<cffunction name="create">
		<cfset event = model("Mainevent").new(params.event)>
		
		<!--- Verify that the event creates successfully --->
		<cfif event.save()>
			<cfset flashInsert(success="The FGBC event was created successfully.")>
            <cfset redirectTo(action="index")>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error creating the event.")>
			<cfset renderPage(action="new")>
		</cfif>
	</cffunction>
	
	<!--- events/update --->
	<cffunction name="update">
		<cfset var return="">
		<cfset event = model("Mainevent").findByKey(params.key)>

		<!--- Verify that the event updates successfully --->
		<cfif event.update(params.event)>
			<cfset eventnew = model("Mainevent").findByKey(params.key)>
			<cfset flashInsert(success="The FGBC event was updated successfully.")>	
            <cfset returnBack()>

		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error updating the event.")>
			<cfset renderPage(action="edit")>
		</cfif>
	</cffunction>
	
	<!--- events/delete/key --->
	<cffunction name="delete">
		<cfset event = model("Mainevent").findByKey(params.key)>
		
		<!--- Verify that the event deletes successfully --->
		<cfif event.delete()>
			<cfset flashInsert(success="The event was deleted successfully.")>	
            <cfset redirectTo(action="index")>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error deleting the event.")>
			<cfset redirectTo(action="index")>
		</cfif>
	</cffunction>
	
</cfcomponent>
