<cfcomponent extends="Controller" output="false">
	
	<cffunction name="init">
		<cfset useslayout('/focus/layoutadmin')>
		<cfset filters('checkOffice')>
		<cfset filters(through="setReturn", only="index,show,items")>
		<cfset filters(through="getRetreatRegions")>	
	</cffunction>

<!----------------------------------------------->	
<!-------------CCRUD------------------------------>	
<!----------------------------------------------->	
	
	<!--- -items/index --->
	<cffunction name="index">
	<cfset var orderByString = "createdAt DESC">
		<cfif isdefined("params.retreatid")>
			<cfset items = model("Focusitem").findAll(where="retreatid=#params.retreatid#", include="retreat")>
		<cfelse>
			<cfset items = model("Focusitem").findAll(include="retreat", order=orderByString)>
		</cfif>
	</cffunction>
	
	<!--- -items/show/key --->
	<cffunction name="show">
		
		<!--- Find the record --->
    	<cfset item = model("Focusitem").findByKey(key=params.key, include="retreat")>
    	
    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(item)>
	        <cfset flashInsert(error="Item #params.key# was not found")>
	        <cfset redirectTo(action="index")>
	    </cfif>
			
	</cffunction>
	
	<!--- -items/new --->
	<cffunction name="new">
		<cfset item = model("Focusitem").new()>
		<cfset item.expiresAt = dateAdd("yyyy",1,now())>
		<cfset activeRetreats = model("Focusretreat").findall(where="active='yes'", order="startAt DESC")>
		<cfdump var="#activeRetreats#"><cfabort>
	</cffunction>
	
	<!--- -items/edit/key --->
	<cffunction name="edit">
	
		<!--- Find the record --->
    	<cfset item = model("Focusitem").findByKey(params.key)>
		<cfset activeRetreats = model("Focusretreat").findall(where="active='yes'")>
    	
    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(item)>
	        <cfset flashInsert(error="Item #params.key# was not found")>
			<cfset redirectTo(action="index")>
	    </cfif>
		
	</cffunction>
	
	<cffunction name="copy">

		<!--- Find the record --->
    	<cfset item = model("Focusitem").findByKey(params.key)>
		<cfset activeRetreats = model("Focusretreat").findall(where="active='yes'")>
    	
    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(item)>
	        <cfset flashInsert(error="Item #params.key# was not found")>
			<cfset redirectTo(action="index")>
	    </cfif>
		
	</cffunction>
	
	<!--- -items/create --->
	<cffunction name="create">
		<cfset item = model("Focusitem").new(params.item)>
		
		<!--- Verify that the item creates successfully --->
		<cfif item.save()>
			<cfset flashInsert(success="The item was created successfully.")>
            <cfset returnBack()>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error creating the item.")>
			<cfset activeRetreats = model("Focusretreat").findall(where="active='yes'")>
			<cfset renderPage(action="new")>
		</cfif>
	</cffunction>
	
	<!--- -items/update --->
	<cffunction name="update">
		<cfset item = model("Focusitem").findByKey(params.key)>
		
		<!--- Verify that the item updates successfully --->
		<cfif item.update(params.item)>
			<cfset flashInsert(success="The item was updated successfully.")>	
            <cfset returnBack()>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error updating the item.")>
			<cfset renderPage(action="edit")>
		</cfif>
	</cffunction>
	
	<!--- -items/delete/key --->
	<cffunction name="delete">
		<cfset item = model("Focusitem").findByKey(params.key)>
		
		<!--- Verify that the item deletes successfully --->
		<cfif item.delete()>
			<cfset flashInsert(success="The item was deleted successfully.")>	
            <cfset redirectTo(action="index")>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error deleting the item.")>
			<cfset redirectTo(action="index")>
		</cfif>
	</cffunction>
	
</cfcomponent>
