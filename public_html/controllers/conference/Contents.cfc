<cfcomponent extends="Controller" output="false">
	
	<cffunction name="init">
		<cfset usesLayout("/conference/adminlayout")>
		<cfset filters("officeOnly")>
	</cffunction>
		
	<!--- contents/index --->
	<cffunction name="index">
		<cfset contents = model("Conferencecontent").findAll()>
	</cffunction>
	
	<!--- contents/show/key --->
	<cffunction name="show">
		
		<!--- Find the record --->
    	<cfset content = model("Conferencecontent").findByKey(params.key)>
    	
    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(content)>
	        <cfset flashInsert(error="content #params.key# was not found")>
	        <cfset redirectTo(action="index")>
	    </cfif>
			
	</cffunction>
	
	<!--- contents/new --->
	<cffunction name="new">
		<cfset content = model("Conferencecontent").new()>
	</cffunction>
	
	<!--- contents/edit/key --->
	<cffunction name="edit">
	
		<!--- Find the record --->
    	<cfset content = model("Conferencecontent").findByKey(params.key)>
    	
    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(content)>
	        <cfset flashInsert(error="content #params.key# was not found")>
			<cfset redirectTo(action="index")>
	    </cfif>
		
	</cffunction>
	
	<!--- contents/create --->
	<cffunction name="create">
		<cfset content = model("Conferencecontent").new(params.content)>
		
		<!--- Verify that the content creates successfully --->
		<cfif content.save()>
			<cfset flashInsert(success="The content was created successfully.")>
            <cfset redirectTo(action="index")>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error creating the content.")>
			<cfset renderPage(action="new")>
		</cfif>
	</cffunction>
	
	<!--- contents/update --->
	<cffunction name="update">
		<cfset content = model("Conferencecontent").findByKey(params.key)>
		
		<!--- Verify that the content updates successfully --->
		<cfif content.update(params.content)>
			<cfset flashInsert(success="The content was updated successfully.")>	
            <cfset redirectTo(action="index")>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error updating the content.")>
			<cfset renderPage(action="edit")>
		</cfif>
	</cffunction>
	
	<!--- contents/delete/key --->
	<cffunction name="delete">
		<cfset content = model("Conferencecontent").findByKey(params.key)>
		
		<!--- Verify that the content deletes successfully --->
		<cfif content.delete()>
			<cfset flashInsert(success="The content was deleted successfully.")>	
            <cfset redirectTo(action="index")>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error deleting the content.")>
			<cfset redirectTo(action="index")>
		</cfif>
	</cffunction>
	
</cfcomponent>
