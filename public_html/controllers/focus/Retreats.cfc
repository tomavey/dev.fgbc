//TODO - Convert to cfscript
<cfcomponent extends="Controller" output="false">

	<cffunction name="config">
		<cfset useslayout('/focus/layoutadmin')>
		<cfset filters('checkOffice')>
		<cfset filters(through="getRetreatRegions")>
	</cffunction>

	<!--- -retreats/index --->
	<cffunction name="index">
	<cfargument name="orderBy" default="startAt DESC">
	<cfset var loc = arguments>
		<cfif isdefined("params.includeSoftDeletes")>
     		<cfset retreats = model("Focusretreat").findAll(includeSoftDeletes=true, order=loc.orderby)>
		<cfelseif isDefined("params.showInactive")>
		    <cfset retreats = model("Focusretreat").findAll(where="active='no'", order=loc.orderby)>
		<cfelse>
		    <cfset retreats = model("Focusretreat").findAll(where="active='yes'", order=loc.orderby)>
		</cfif>
		<cfset setReturn()>
	</cffunction>

	<!--- -retreats/show/key --->
	<cffunction name="show">

			<cfset retreat = model("Focusretreat").findByKey(params.key)>

    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(retreat)>
	        <cfset flashInsert(error="Retreat #params.key# was not found")>
	        <cfset redirectTo(action="index")>
	    </cfif>

		<cfset setReturn()>

	</cffunction>

	<!--- -retreats/new --->
	<cffunction name="new">
		<cfset retreat = model("Focusretreat").new()>
	</cffunction>

	<!--- -retreats/edit/key --->
	<cffunction name="edit">

		<!--- Find the record --->
    	<cfset retreat = model("Focusretreat").findByKey(params.key)>

    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(retreat)>
	        <cfset flashInsert(error="Retreat #params.key# was not found")>
			<cfset redirectTo(action="index")>
	    </cfif>
		
	</cffunction>

	<cffunction name="copy">

		<!--- Find the record --->
    	<cfset retreat = model("Focusretreat").findByKey(params.key)>

    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(retreat)>
	        <cfset flashInsert(error="Retreat #params.key# was not found")>
			<cfset redirectTo(action="index")>
	    </cfif>

	</cffunction>

	<!--- -retreats/create --->
	<cffunction name="create">
		<cfset retreat = model("Focusretreat").new(params.retreat)>

		<!--- Verify that the retreat creates successfully --->
		<cfif retreat.save()>
			<cfset flashInsert(success="The retreat was created successfully.")>
			<cfset returnBack()>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error creating the retreat.")>
			<cfset renderView(action="new")>
		</cfif>
	</cffunction>

	<!--- -retreats/update --->
	<cffunction name="update">
		<cfset retreat = model("Focusretreat").findByKey(params.key)>

		<!--- Verify that the retreat updates successfully --->
		<cfif retreat.update(params.retreat)>
			<cfset flashInsert(success="The retreat was updated successfully.")>
			<cfset returnBack()>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error updating the retreat.")>
			<cfset renderView(action="edit")>
		</cfif>
	</cffunction>

	<!--- -retreats/delete/key --->
	<cffunction name="delete">
		<cfset retreat = model("Focusretreat").findByKey(params.key)>

		<!--- Verify that the retreat deletes successfully --->
		<cfif retreat.delete()>
			<cfset flashInsert(success="The retreat was deleted successfully.")>
			<cfset returnBack()>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error deleting the retreat.")>
			<cfset redirectTo(action="index")>
		</cfif>
	</cffunction>

</cfcomponent>
