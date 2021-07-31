//TODO - Convert to cfscript
<cfcomponent extends="Controller" output="false">
	
	<cffunction name="config">
		<cfset filters(through="gotBasicHandbookRights")>
		<cfset filters(through="setreturn", only="show,index")>
		<cfset usesLayout(template="/handbook/layout_handbook2")>
		<cfset filters(through="logview", type="after")>
	</cffunction>
	
	<!--- handbook-notes/index --->
	<cffunction name="index">
		<cfset handbooknotes = model("Handbooknote").findAll(where="createdBy='#session.auth.email#'")>
		<cfset renderView(layout="/handbooklayouts/layout_handbook")>
	</cffunction>
	
	<!--- handbook-notes/show/key --->
	<cffunction name="show">
			
		<cfif isdefined("params.pid")>			
	    	<cfset handbooknotes = model("Handbooknote").findAll(where="personid='#params.pid#'")>
			<cfset thisperson = model("Handbookperson").findOne(where="id='#params.pid#'", include="Handbookstate")>
			<cfset thisentity = "#thisperson.selectname#">
		</cfif>    	
		<cfif isdefined("params.oid")>
	    	<cfset handbooknotes = model("Handbooknote").findAll(where="organizationid='#params.oid#")>
			<cfset thisorg = model("Handbookorganization").findOne(key=params.oid, include="Handbookstatus,Handbookstate")>
			<cfset thisentity = "#thisorg.selectname#">
		</cfif>

	</cffunction>
	
	<!--- handbook-notes/new --->
	<cffunction name="new">
		<cfset handbooknote = model("Handbooknote").new()>
		<cfif isdefined("params.pid")>
			<cfset handbookNote.personid = params.pid>
			<cfset thisperson = model("Handbookperson").findOne(key=params.pid, include="Handbookstate")>
			<cfset showSelect = false>
		</cfif>
		<cfif isdefined("params.oid")>
			<cfset handbookNote.organizationid = params.oid>
			<cfset thisorg = model("Handbookorganization").findOne(key=params.oid, include="Handbookstatus,Handbookstate")>
			<cfset showSelect = false>
		</cfif>
		<cfset people = model("Handbookperson").findAll(where="p_sortorder < 101", order="lname,fname", include="Handbookpositions,Handbookstate")>
		<cfset organizations = model("Handbookorganization").findAll(where="show_in_handbook = 1", order="state,org_city,name", include="Handbookstatus,Handbookstate")>
	</cffunction>
	
	<!--- handbook-notes/edit/key --->
	<cffunction name="edit">
	
		<!--- Find the record --->
    	<cfset handbooknote = model("Handbooknote").findByKey(params.key)>
		<cfset people = model("Handbookperson").findAll(where="p_sortorder < 101", order="lname,fname", include="Handbookpositions,Handbookstate")>
		<cfset organizations = model("Handbookorganization").findAll(where="show_in_handbook = 1", order="state,org_city,name", include="Handbookstatus,Handbookstate")>
		<cfset showSelect = false>
    	
    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(handbooknote)>
	        <cfset flashInsert(error="HandbookNote #params.key# was not found")>
			<cfset redirectTo(action="index")>
	    </cfif>
		
	</cffunction>
	
	<!--- handbook-notes/create --->
	<cffunction name="create">
		<cfset handbooknote = model("Handbooknote").new(params.handbooknote)>
		
		<!--- Verify that the handbooknote creates successfully --->
		<cfif handbooknote.save()>
			<cfset flashInsert(success="The handbooknote was created successfully.")>
            <cfset returnBack()>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error creating the handbooknote.")>
			<cfset renderView(action="new")>
		</cfif>
	</cffunction>
	
	<!--- handbook-notes/update --->
	<cffunction name="update">
		<cfset handbooknote = model("Handbooknote").findByKey(params.key)>
		
		<!--- Verify that the handbooknote updates successfully --->
		<cfif handbooknote.update(params.handbooknote)>
			<cfset flashInsert(success="The handbooknote was updated successfully.")>	
            <cfset returnBack()>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error updating the handbooknote.")>
			<cfset renderView(action="edit")>
		</cfif>
	</cffunction>
	
	<!--- handbook-notes/delete/key --->
	<cffunction name="delete">
		<cfset handbooknote = model("Handbooknote").findByKey(params.key)>
		
		<!--- Verify that the handbooknote deletes successfully --->
		<cfif handbooknote.delete()>
			<cfset flashInsert(success="The handbooknote was deleted successfully.")>	
            <cfset returnBack()>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error deleting the handbooknote.")>
            <cfset returnBack()>
		</cfif>
	</cffunction>
	
</cfcomponent>
