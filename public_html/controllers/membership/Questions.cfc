<cfcomponent extends="Controller" output="false">

	<cffunction name="config">
		<cfset usesLayout("/membership/layout")>
		<cfset filters(through="getFieldNamesList")>
		<cfset filters(through="setReturn", only="index,show")>
	</cffunction>
	
	<!--- membershipappquestions/index --->
	<cffunction name="index">
		<cfset membershipappquestions = model("Membershipappquestion").findAll(order="field")>
	</cffunction>

	<cffunction name="getFieldNamesList">
		<cfset membershipapp = model("Membershipapplication").findOne()>
		<cfset fieldnames = membershipapp.properties()>
		<cfset fieldnames = structKeyList(fieldnames)>
		<cfset fieldnames = listSort(fieldnames,"text")>
		<cfset fieldnames = replace(fieldnames,",",", ","all")>
		<cfset fieldnames = replace(fieldnames,"ID, ","","one")>
	</cffunction>
	
	<!--- membershipappquestions/show/key --->
	<cffunction name="show">
		
		<!--- Find the record --->
    	<cfset membershipappquestion = model("Membershipappquestion").findByKey(params.key)>
    	
    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(membershipappquestion)>
	        <cfset flashInsert(error="membershipappquestion #params.key# was not found")>
	        <cfset redirectTo(action="index")>
	    </cfif>
			
	</cffunction>
	
	<!--- membershipappquestions/new --->
	<cffunction name="new">
		<cfset membershipappquestion = model("membershipappquestion").new()>
		<cfset membershipappquestion.language = "English">
	</cffunction>
	
	<!--- membershipappquestions/edit/key --->
	<cffunction name="edit">
		<cfif NOT isNumeric(params.key)>
			<cfset params.key = model("Membershipappquestion").findOne(where="field='#params.key#' AND language='#session.membershipapplication.language#'").id>		
		</cfif>

		<!--- Find the record --->
    	<cfset membershipappquestion = model("Membershipappquestion").findByKey(params.key)>
    	
    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(membershipappquestion)>
	        <cfset flashInsert(error="membershipappquestion #params.key# was not found")>
			<cfset redirectTo(action="index")>
	    </cfif>

		<cfif isDefined("params.ajax")>
			<cfset renderView(layout="/membershipapplayouts/layout_ajax")>
		</cfif>
		
	</cffunction>
	
	<!--- membershipappquestions/copy/key --->
	<cffunction name="copy">
	
		<!--- Find the record --->
    	<cfset membershipappquestion = model("Membershipappquestion").findByKey(params.key)>
    	
    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(membershipappquestion)>
	        <cfset flashInsert(error="membershipappquestion #params.key# was not found")>
			<cfset redirectTo(action="index")>
	    </cfif>
		
	</cffunction>
	
	<!--- membershipappquestions/create --->
	<cffunction name="create">
		<cfset membershipappquestion = model("Membershipappquestion").new(params.membershipappquestion)>
		
		<!--- Verify that the membershipappquestion creates successfully --->
		<cfif membershipappquestion.save()>
			<cfset flashInsert(success="The membershipappquestion was created successfully.")>
            <cfset redirectTo(action="index")>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error creating the membershipappquestion.")>
			<cfset renderView(action="new")>
		</cfif>
	</cffunction>
	
	<!--- membershipappquestions/update --->
	<cffunction name="update">
		<cfset membershipappquestion = model("Membershipappquestion").findByKey(params.key)>
		
		<!--- Verify that the membershipappquestion updates successfully --->
		<cfif membershipappquestion.update(params.membershipappquestion)>
			<cfset flashInsert(success="The membershipappquestion was updated successfully.")>	
            <cfset returnBack(anchor=membershipappquestion.field)>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error updating the membershipappquestion.")>
			<cfset renderView(action="edit")>
		</cfif>
	</cffunction>
	
	<!--- membershipappquestions/delete/key --->
	<cffunction name="delete">
		<cfset membershipappquestion = model("Membershipappquestion").findByKey(params.key)>
		
		<!--- Verify that the membershipappquestion deletes successfully --->
		<cfif membershipappquestion.delete()>
			<cfset flashInsert(success="The membershipappquestion was deleted successfully.")>	
            <cfset redirectTo(action="index")>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error deleting the membershipappquestion.")>
			<cfset redirectTo(action="index")>
		</cfif>
	</cffunction>
	
</cfcomponent>
