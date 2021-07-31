//TODO - Convert to cfscript
<cfcomponent extends="Controller" output="false">
	
	<cffunction name="config">
		<cfset useslayout('/focus/layoutadmin')>
		<cfset filters('checkOffice')>
		<cfset filters(through="setReturn", only="index,show,items")>
		<cfset filters(through="getRetreatRegions")>	
		<cfset filters(through="getDependencyItems", only="new,edit,copy")>
		<cfset filters(through="getActiveRetreats")>
	</cffunction>

<!---Filters--->
<cfscript>
	private function getDependencyItems(){
		if ( !isDefined('params.retreatid') && isDefined('params.key') ) {
			params.retreatid = getRetreatIdFromItemId(params.key)
		}
		dependencyItems = model("Focusitem").findAll(where="retreatid=#params.retreatid# AND price > 0", include="retreat")
	}

	private function getRetreatIdFromItemId(itemid){
		retreat = model("Focusitem").findOne(where="id = #itemid#")
		return retreat.retreatid
	}

	private function getActiveRetreats(){
		activeRetreats = model("Focusretreat").findall(where="active='yes'", order="startAt DESC")
	}
</cfscript>	

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

	<cfscript>
		public function new(){
			item = model("Focusitem").new()
			item.expiresAt = dateAdd("yyyy",1,now())
		}
	</cfscript>

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
    	
    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(item)>
	        <cfset flashInsert(error="Item #params.key# was not found")>
			<cfset redirectTo(action="index")>
	    </cfif>
		
	</cffunction>
	
	<!--- -items/create --->
	<cffunction name="create">
		<!--- <cfdump var="#params#"><cfabort> --->
		<cfset item = model("Focusitem").new(params.item)>
		
		<!--- Verify that the item creates successfully --->
		<cfif item.save()>
			<cfset flashInsert(success="The item was created successfully.")>
            <cfset returnBack()>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error creating the item.")>
			<cfset activeRetreats = model("Focusretreat").findall(where="active='yes'")>
			<cfset renderView(action="new")>
		</cfif>
	</cffunction>
	
	<!--- -items/update --->
	<cffunction name="update">
		<cfset item = model("Focusitem").findByKey(params.key)>
		<!--- <cfdump var="#params.item#"><cfabort> --->
		<!--- Verify that the item updates successfully --->
		<cfif item.update(params.item)>
			<cfset flashInsert(success="The item was updated successfully.")>	
      <cfset returnBack()>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error updating the item.")>
			<cfset renderView(action="edit")>
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

<cfscript>
	function getRetreatRegId(id) {
		return model("Focusretreat").findOne(where="id = #id#").regId
	}
</cfscript>	
	
</cfcomponent>
