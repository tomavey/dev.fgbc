<cfcomponent extends="Controller" output="false">
	
	<cffunction name="init">
		<cfset usesLayout(template="/handbook/layout_handbook", except="download")>
		<cfset filters(through="gotBasicHandbookRights")>
	</cffunction>

	<!--- handbook-positions/index --->
	<cffunction name="index">
		<cfset handbookpositions = model("HandbookPosition").findAll()>
	</cffunction>
	
	<!--- handbook-positions/show/key --->
	<cffunction name="show">
		
		<!--- Find the record --->
    	<cfset handbookposition = model("HandbookPosition").findByKey(params.key)>
    	
    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(handbookposition)>
	        <cfset flashInsert(error="HandbookPosition #params.key# was not found")>
	        <cfset redirectTo(action="index")>
	    </cfif>
			
	</cffunction>
	
	<!--- handbook-positions/new --->
	<cffunction name="new">
		<cfset handbookposition = model("Handbookposition").new()>
		<cfset handbookposition.personid = params.key>
		<cfif isDefined("params.organizationid")>
			<cfset handbookposition.organizationid = params.organizationid>
			<cfset thisOrganization = model("Handbookorganization").findOne(where="id=#params.organizationid#", include="State")>
		</cfif>
		<cfif isDefined("params.position")>
			<cfset handbookposition.position = urlDecode(params.position)>
		</cfif>
		<cfif isDefined("params.sortorder")>
			<cfset handbookposition.p_sortorder = params.sortorder>
		</cfif>
		<cfif isDefined("params.positiontypeid")>
			<cfset handbookposition.positiontypeid = params.positiontypeid>
		</cfif>
		<cfset thisperson = model("Handbookperson").findByKey(key=params.key, include="Handbookstate")>
		<cfset organizations = model("Handbookorganization").findall(where="show_in_handbook = 'yes'", include="handbookstate,handbookstatus", order="selectNameCity")>
		<cfset positionTypes = model("HandbookpositionType").findall(order="position")>
	</cffunction>
	
	<!--- handbook-positions/edit/key --->
	<cffunction name="edit">

		<!--- Find the record --->
    	<cfset handbookposition = model("HandbookPosition").findByKey(params.key)>
    	
    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(handbookposition)>
	        <cfset flashInsert(error="HandbookPosition #params.key# was not found")>
			<cfset redirectTo(action="index")>
	    </cfif>
		
	</cffunction>
	
	<!--- handbook-positions/create --->
	<cffunction name="create">
		<cfset handbookposition = model("HandbookPosition").new(params.handbookposition)>
		
		<!--- Verify that the handbookposition creates successfully --->
		<cfif handbookposition.save()>
			<cfset flashInsert(success="The handbookposition was created successfully.")>
			<cfset returnBack()>
			<!---cfset redirectTo(controller="handbookpeople", action="show", key=handbookPosition.personid)--->
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error creating the handbookposition.")>
			<cfset renderPage(action="new")>
		</cfif>
	</cffunction>
	
	<!--- handbook-positions/update --->
	<cffunction name="update">
		<cfset handbookposition = model("HandbookPosition").findByKey(params.key)>
		
		<!--- Verify that the handbookposition updates successfully --->
		<cfif handbookposition.update(params.handbookposition)>
			<cfset flashInsert(success="The handbookposition was updated successfully.")>	
            <cfset redirectTo(action="index")>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error updating the handbookposition.")>
			<cfset renderPage(action="edit")>
		</cfif>
	</cffunction>
	
	<!--- handbook-positions/delete/key --->
	<cffunction name="delete">
		<cfset handbookposition = model("HandbookPosition").findByKey(params.key)>
		
		<!--- Verify that the handbookposition deletes successfully --->
		<cfif handbookposition.delete()>
			<cfset flashInsert(success="The handbookposition was deleted successfully.")>	
            <cfset returnback()>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error deleting the handbookposition.")>
            <cfset returnback()>
		</cfif>
	</cffunction>
	
	<cffunction name="listpeople">
	<cfset var whereString = "p_sortorder < 500 AND personid <> 1 AND fname <> 'No'">
	<cfif isDefined("params.positionTypeId") && params.positionTypeId>
		<cfset whereString = whereString & " AND id=#params.positionTypeId#">
	</cfif>
		<cfset positions = model("Handbookpositiontype").findall(where=whereString, include="Handbookpositions(Handbookperson(Handbookstate),Handbookorganization)", order="position,lname,fname")>
		<cfif isDefined("params.plain")>
			<cfset renderPage(layout="/layout_naked")>
		</cfif>
	</cffunction>



	
</cfcomponent>
