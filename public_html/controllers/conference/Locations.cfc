<cfcomponent extends="Controller" output="false">
	
	<cffunction name="config">
		<cfset usesLayout("/conference/adminlayout")>
		<cfset filters(through="officeOnly", except="index,list,summary,show,excel,json")>
		<cfset filters(through="setReturn", only="index,show,list")>
	</cffunction>
	
	<!--- locations/index --->
	<cffunction name="index">
		<cfset locations = model("Conferencelocation").findAll(where="event='#getEvent()#'", order="roomnumber")>
	</cffunction>
	
	<!--- locations/index --->
	<cffunction name="list">
		<cfset locations = model("Conferencelocation").findAll(where="event='#getEvent()#'", order="roomnumber")>
	</cffunction>

	<!--- locations/json --->
	<cffunction name="json">
		<cfset locations = model("Conferencelocation").findAll(where="event='#getEvent()#'", order="roomnumber")>
		<cfset data = queryToJson(locations)>
		<cfset renderJson()>
	</cffunction>

	<!--- locations/show/key --->
	<cffunction name="show">
		
		<!--- Find the record --->
    	<cfset location = model("Conferencelocation").findByKey(params.key)>
		<cfset events = model("Conferenceevent").findAll(where="locationid='#params.key#'", include="location", order="date,timebegin")>
    	
    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(location)>
	        <cfset flashInsert(error="Location #params.key# was not found")>
	        <cfset redirectTo(action="index")>
	    </cfif>
			
	</cffunction>
	
	<!--- locations/new --->
	<cffunction name="new">
		<cfset location = model("Conferencelocation").new()>
	</cffunction>
	
	<!--- locations/edit/key --->
	<cffunction name="edit">
	
		<!--- Find the record --->
    	<cfset location = model("Conferencelocation").findByKey(params.key)>
    	
    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(location)>
	        <cfset flashInsert(error="Location #params.key# was not found")>
			<cfset redirectTo(action="index")>
	    </cfif>
		
	</cffunction>
	
	<!--- locations/copy/key --->
	<cffunction name="copy">
	
		<!--- Find the record --->
    	<cfset location = model("Conferencelocation").findByKey(params.key)>
    	
    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(location)>
	        <cfset flashInsert(error="Location #params.key# was not found")>
			<cfset redirectTo(action="index")>
	    </cfif>
		
	</cffunction>

	<!--- Courses/copyAllToCurrentEvent --->

	<cfscript>
		public function copyAllToCurrentEvent(){
			super.copyAllToCurrentEvent( tableName = "Conferencelocation" );
			returnBack();
		}
	</cfscript>



	<!--- locations/create --->
	<cffunction name="create">
		<cfset location = model("Conferencelocation").new(params.location)>
		
		<!--- Verify that the location creates successfully --->
		<cfif location.save()>
			<cfset flashInsert(success="The location was created successfully.")>
            <cfset returnBack()>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error creating the location.")>
			<cfset renderView(action="new")>
		</cfif>
	</cffunction>
	
	<!--- locations/update --->
	<cffunction name="update">
		<cfif isDefined("params.keyy")>
			<cfset params.key = params.keyy>
		</cfif>
		<cfset location = model("Conferencelocation").findByKey(params.key)>
		
		<!--- Verify that the location updates successfully --->
		<cfif location.update(params.location)>
			<cfset flashInsert(success="The location was updated successfully.")>	
            <cfset returnBack()>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error updating the location.")>
			<cfset renderView(action="edit")>
		</cfif>
	</cffunction>
	
	<!--- locations/delete/key --->
	<cffunction name="delete">
		<cfset location = model("Conferencelocation").findByKey(params.key)>
		
		<!--- Verify that the location deletes successfully --->
		<cfif location.delete()>
			<cfset flashInsert(success="The location was deleted successfully.")>	
            <cfset redirectTo(action="index")>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error deleting the location.")>
			<cfset redirectTo(action="index")>
		</cfif>
	</cffunction>
	
</cfcomponent>
