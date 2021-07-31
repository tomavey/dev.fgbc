<cfcomponent extends="Controller" output="false">
	
	<!--- handbook-person-updates/index --->
	<cffunction name="index">
		<cfset handbookpersonupdates = model("HandbookPersonUpdate").findAll()>
	</cffunction>
	
	<!--- handbook-person-updates/show/key --->
	<cffunction name="show">
		
		<!--- Find the record --->
    	<cfset handbookpersonupdate = model("HandbookPersonUpdate").findByKey(params.key)>
    	
    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(handbookpersonupdate)>
	        <cfset flashInsert(error="HandbookPersonUpdate #params.key# was not found")>
	        <cfset redirectTo(action="index")>
	    </cfif>
			
	</cffunction>
	
	<!--- handbook-person-updates/new --->
	<cffunction name="new">
		<cfset handbookperson = model("HandbookPersonUpdate").new()>
		<cfset states = model("handbookState").findall(order="state")>
		<cfset churches = model("handbookOrganization").findall(include="handbookstatus,handbookstate", where="show_in_handbook = 'yes'", order="state,city,name")>
	</cffunction>
	
	<!--- handbook-person-updates/edit/key --->
	<cffunction name="edit">
	
		<!--- Find the record --->
    	<cfset handbookpersonupdate = model("HandbookPersonUpdate").findByKey(params.key)>
    	
    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(handbookpersonupdate)>
	        <cfset flashInsert(error="HandbookPersonUpdate #params.key# was not found")>
			<cfset redirectTo(action="index")>
	    </cfif>
		
	</cffunction>
	
	<!--- handbook-person-updates/create --->
	<cffunction name="create">
		<cfset handbookpersonupdate = model("HandbookPersonUpdate").new(params.handbookpersonupdate)>
		
		<!--- Verify that the handbookpersonupdate creates successfully --->
		<cfif handbookpersonupdate.save()>
			<cfset flashInsert(success="The handbookpersonupdate was created successfully.")>
            <cfset redirectTo(action="index")>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error creating the handbookpersonupdate.")>
			<cfset renderView(action="new")>
		</cfif>
	</cffunction>
	
	<!--- handbook-person-updates/update --->
	<cffunction name="update">
		<cfset handbookpersonupdate = model("HandbookPersonUpdate").findByKey(params.key)>
		
		<!--- Verify that the handbookpersonupdate updates successfully --->
		<cfif handbookpersonupdate.update(params.handbookpersonupdate)>
			<cfset flashInsert(success="The handbookpersonupdate was updated successfully.")>	
            <cfset redirectTo(action="index")>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error updating the handbookpersonupdate.")>
			<cfset renderView(action="edit")>
		</cfif>
	</cffunction>
	
	<!--- handbook-person-updates/delete/key --->
	<cffunction name="delete">
		<cfset handbookpersonupdate = model("HandbookPersonUpdate").findByKey(params.key)>
		
		<!--- Verify that the handbookpersonupdate deletes successfully --->
		<cfif handbookpersonupdate.delete()>
			<cfset flashInsert(success="The handbookpersonupdate was deleted successfully.")>	
            <cfset redirectTo(action="index")>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error deleting the handbookpersonupdate.")>
			<cfset redirectTo(action="index")>
		</cfif>
	</cffunction>
	
</cfcomponent>
