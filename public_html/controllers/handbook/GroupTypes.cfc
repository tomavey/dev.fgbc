//TODO - Convert to cfscript
<cfcomponent extends="Controller" output="false">
	
	<cffunction name="config">
		<cfset usesLayout("/handbooklayouts/layout_handbook1")>
		<cfset filters(through="gotBasicHandbookRights")>
	</cffunction>
	
	<!--- handbook-group-types/index --->
	<cffunction name="index">
		<cfset handbookgrouptypes = model("HandbookGroupType").findAll(order="title")>
	</cffunction>
	
	<!--- handbook-group-types/show/key --->
	<cffunction name="show">
		
		<!--- Find the record --->
    	<cfset handbookgrouptype = model("HandbookGroupType").findByKey(params.key)>
		<cfset people = model("handbookGroup").findAll(where="groupTypeId=#params.key#", include="handbookPerson(handbookState)", order="lname,fname")>
		<cfset allpeople = model("handbookPerson").findAll(include="handbookState", order="lname,fname")>
		<cfset handbookGroup = model("handbookGroup").new()>    	
		<cfset handbookGroup.grouptypeid = params.key>
		
    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(handbookgrouptype)>
	        <cfset flashInsert(error="HandbookGroupType #params.key# was not found")>
	        <cfset redirectTo(action="index")>
	    </cfif>
			
	</cffunction>
	
	<!--- handbook-group-types/new --->
	<cffunction name="new">
		<cfset handbookgrouptype = model("HandbookGroupType").new()>
	</cffunction>
	
	<!--- handbook-group-types/edit/key --->
	<cffunction name="edit">
	
		<!--- Find the record --->
    	<cfset handbookgrouptype = model("HandbookGroupType").findByKey(params.key)>
    	
    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(handbookgrouptype)>
	        <cfset flashInsert(error="HandbookGroupType #params.key# was not found")>
			<cfset redirectTo(action="index")>
	    </cfif>
		
	</cffunction>
	
	<!--- handbook-group-types/create --->
	<cffunction name="create">
		<cfset handbookgrouptype = model("HandbookGroupType").new(params.handbookgrouptype)>
		
		<!--- Verify that the handbookgrouptype creates successfully --->
		<cfif handbookgrouptype.save()>
			<cfset flashInsert(success="The handbookgrouptype was created successfully.")>
            <cfset redirectTo(action="index")>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error creating the handbookgrouptype.")>
			<cfset renderView(action="new")>
		</cfif>
	</cffunction>
	
	<!--- handbook-group-types/update --->
	<cffunction name="update">
		<cfset handbookgrouptype = model("HandbookGroupType").findByKey(params.key)>
		
		<!--- Verify that the handbookgrouptype updates successfully --->
		<cfif handbookgrouptype.update(params.handbookgrouptype)>
			<cfset flashInsert(success="The handbookgrouptype was updated successfully.")>	
            <cfset redirectTo(action="index")>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error updating the handbookgrouptype.")>
			<cfset renderView(action="edit")>
		</cfif>
	</cffunction>
	
	<!--- handbook-group-types/delete/key --->
	<cffunction name="delete">
		<cfset handbookgrouptype = model("HandbookGroupType").findByKey(params.key)>
		
		<!--- Verify that the handbookgrouptype deletes successfully --->
		<cfif handbookgrouptype.delete()>
			<cfset flashInsert(success="The handbookgrouptype was deleted successfully.")>	
            <cfset redirectTo(action="index")>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error deleting the handbookgrouptype.")>
			<cfset redirectTo(action="index")>
		</cfif>
	</cffunction>
	
</cfcomponent>
